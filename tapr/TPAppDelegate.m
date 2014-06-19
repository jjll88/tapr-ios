//
//  TPAppDelegate.m
//  tapr
//
//  Created by David Regatos on 12/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPAppDelegate.h"
#import "WZBluetoothManager.h"

@interface TPAppDelegate ()

@property (nonatomic, strong) WZBluetoothManager *btManager;

@end

@implementation TPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // initiate the Bluetooth manager
    self.btManager = [WZBluetoothManager sharedManager];
    [self setupNotificationObserver];
    // Override point for customization after application launch.
    
    // Load stored User Profile
    [[TPProfileManager sharedManager] loadProfile];
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    BOOL success = [[TPProfileManager sharedManager] saveProfile];
    if (success) {
        DMLog(@"User profile succesfully saved");
    } else {
        DMLog(@"Could not save User profile");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserverForName:BMNotification_CentralManagerStateChange object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSLog(@"Bluetooth state update");
        CBCentralManagerState state = [note.userInfo[BMNotificationKey_CentralManagerState] integerValue];
        if (state == CBCentralManagerStatePoweredOn) {
            NSLog(@"Bluetooth scanning peripherals");
            [self.btManager startScanning];
        }
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:BMNotification_PeripheralDiscovered object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSLog(@"Peripheral discovered, connect to it");
        [self.btManager connectPeripheral:note.userInfo[BMNotificationKey_Peripheral]];
        
    }];
    
}

@end
