//
//  WZBluetoothManager.h
//
//  Created by Wei Zhang on 5/30/14.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

// Notification Names
#define BMNotification_CentralManagerStateChange                @"BMNotification_CentralMangerStateChange"
#define BMNotification_PeripheralDiscovered                     @"BMNotification_PeripheralDiscovered"
#define BMNotification_PeripheralConnected                      @"BMNotification_PeripheralConnected"
#define BMNotification_PeripheralFailToConnected                @"BMNotification_PeripheralFailToConnected"
#define BMNotification_PeripheralDisconnected                   @"BMNotification_PeripheralDisconnected"
#define BMNotification_PeripheralHaveUpdate                     @"BMNotification_PeripheralHaveUpdate"

// Notification Keys
#define BMNotificationKey_CentralManagerState                   @"BMNK_CentralManagerState"
#define BMNotificationKey_Peripheral                            @"BMNK_Peripheral"
#define BMNotificationKey_PeripheralAdvertisementData           @"BMNK_PeripheralAdvertisementData"
#define BMNotificationKey_PeripheralRSSI                        @"BMNK_PeripheralRSSI"
#define BMNotificationKey_PeripheralUpdateKey                   @"BMNotificationKey_PeripheralUpdateKey"




@interface WZBluetoothManager : NSObject

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *peripheral;

+ (instancetype)sharedManager;

- (void)startScanning;

- (void)stopScanning;

- (void)connectPeripheral:(CBPeripheral *)peripheral;

- (void)disconnectPeripheral;

@end

