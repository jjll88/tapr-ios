//
//  WZBluetoothManager.m
//
//  Created by Wei Zhang on 5/30/14.
//

#import "WZBluetoothManager.h"

#define BCBluetoothCentralManagerQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)

#define RunBlockOnMainQueue(block)  dispatch_async(dispatch_get_main_queue(), block)

@interface WZBluetoothManager () <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) NSNotificationCenter *notificationCenter;

@property (nonatomic, strong) CBCharacteristic *alertCharacteristic;

@end

static NSString *PeripheralServiceUUID = @"2220";
static NSString *PeripheralCharacteristicUUID = @"2221";

@implementation WZBluetoothManager

#pragma mark - internal methods
- (NSNotificationCenter *)notificationCenter {
    if (!_notificationCenter) {
        _notificationCenter = [NSNotificationCenter defaultCenter];
    }
    return _notificationCenter;
}

#pragma mark - internal helping methods
- (void)postNotification:(NSString *)notificationName userInfo:(NSDictionary *)userInfo {
    RunBlockOnMainQueue(^{
        [self.notificationCenter postNotificationName:notificationName object:nil userInfo:userInfo];
        
        UIApplicationState appState = [[UIApplication sharedApplication] applicationState];
        if (appState == UIApplicationStateBackground) {
            NSLog(@"got background notification");
            UILocalNotification *localNote = [[UILocalNotification alloc] init];
            localNote.alertBody = notificationName;
            localNote.soundName = UILocalNotificationDefaultSoundName;
            localNote.applicationIconBadgeNumber = 1;
            [[UIApplication sharedApplication] presentLocalNotificationNow:localNote];
        }
    });
}

#pragma mark - interface methods
+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static WZBluetoothManager *shared;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
        shared.centralManager = [[CBCentralManager alloc] initWithDelegate:shared queue:BCBluetoothCentralManagerQueue options:nil];
    });
    
    return shared;
}

- (void)startScanning {
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:PeripheralServiceUUID]] options:nil]; //
}

- (void)stopScanning {
    [self.centralManager stopScan];
}

- (void)connectPeripheral:(CBPeripheral *)peripheral {
    self.peripheral = peripheral;
    peripheral.delegate = self;
    [self.centralManager connectPeripheral:peripheral options:nil];
}


- (void)disconnectPeripheral {
//    [self.peripheral setNotifyValue:NO forCharacteristic:self.messageCharacteristic];
    [self.centralManager cancelPeripheralConnection:self.peripheral];
    self.peripheral = nil;
    self.alertCharacteristic = nil;
}

#pragma mark - Bluetooth CentralManager Delegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    CBCentralManagerState state = central.state;
    NSDictionary *userInfo = @{BMNotificationKey_CentralManagerState: @(state)};
    [self postNotification:BMNotification_CentralManagerStateChange userInfo:userInfo];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"peripheral discovered, advertisement data: %@", advertisementData);
    
    RunBlockOnMainQueue((^{
        NSDictionary *userInfo = @{BMNotificationKey_Peripheral: peripheral,
                                   BMNotificationKey_PeripheralAdvertisementData: advertisementData,
                                   BMNotificationKey_PeripheralRSSI: RSSI};
        [self postNotification:BMNotification_PeripheralDiscovered userInfo:userInfo];
    }));
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"connected to peripheral");
    
    
    RunBlockOnMainQueue((^{
        NSDictionary *userInfo = @{BMNotificationKey_Peripheral: peripheral};
        [self postNotification:BMNotification_PeripheralConnected userInfo:userInfo];
    }));
    [peripheral discoverServices:@[[CBUUID UUIDWithString:PeripheralServiceUUID]]];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    self.peripheral = nil;
    RunBlockOnMainQueue((^{
        NSDictionary *userInfo = @{BMNotificationKey_Peripheral: peripheral};
        [self postNotification:BMNotification_PeripheralFailToConnected userInfo:userInfo];
    }));
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    self.peripheral = nil;
    RunBlockOnMainQueue((^{
        NSDictionary *userInfo = @{BMNotificationKey_Peripheral: peripheral};
        [self postNotification:BMNotification_PeripheralDisconnected userInfo:userInfo];
    }));
}

#pragma mark - Bluetooth Peripheral Delegate
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    for (CBService *srvc in peripheral.services) {
        NSLog(@"peripheral discovered service, uuid: %@", srvc.UUID.UUIDString);
        NSString *serviceUUiD = srvc.UUID.UUIDString;
        if ([serviceUUiD isEqualToString:PeripheralServiceUUID]) {
            [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:PeripheralCharacteristicUUID]] forService:srvc];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"peripheral discovered service - Characteristic: %@ - %@, %@", characteristic.service.UUID.UUIDString, characteristic.UUID.UUIDString, characteristic.descriptors);
        if ([characteristic.UUID.UUIDString isEqualToString:PeripheralCharacteristicUUID]) {
            NSLog(@"central subscribed to peripheral's Characteristic");
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error changing notification state: %@", [error localizedDescription]);
    } else {
        if (characteristic.isNotifying) {
            NSLog(@"subscribed to characteristic: %@", characteristic.UUID.UUIDString);
        }
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    if (error) {
        NSLog(@"Error receiving update from peripheral");
        return;
    }
    NSLog(@"Got update from peripheral");
    if ([characteristic.UUID.UUIDString isEqualToString:PeripheralCharacteristicUUID]) {
        NSData *data = characteristic.value;
        if (data) {
            RunBlockOnMainQueue((^{
                NSDictionary *userInfo = @{BMNotificationKey_PeripheralUpdateKey: data};
                [self postNotification:BMNotification_PeripheralHaveUpdate userInfo:userInfo];
            }));
        }
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    // write peer characteristic response
//    NSLog(@"wrote characteristic");
//    if (error) {
//        NSLog(@"write characteristic error: %@", error.localizedDescription);
//        //TODO: do something with the write error?
//    }
//    else {
//        if ([characteristic.UUID.UUIDString isEqualToString:BCCharacteristicMessageUUID]) {
//            if (!characteristic.isNotifying)
//                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//            
//        }
//    }
}

- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray *)invalidatedServices {
    NSLog(@"service modified");
}



@end
