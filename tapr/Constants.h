//
//  Constants.h
//  tapr
//
//  Created by David Regatos on 12/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#ifndef tapr_Constants_h
#define tapr_Constants_h

//Left Menu Navigator ***
#define profileTitle        @"Profile"
#define progressTitle       @"Progress"
#define bluetoothTitle      @"Bluetooth"
#define settingsTitle       @"Settings"
#define aboutTitle          @"About"
#define logoutTitle         @"Log out"

#define profileCellIndex         100
#define bluetoothCellIndex       101
#define progressCellIndex        102
#define aboutCellIndex           103
#define settingsCellIndex        104
#define logoutCellIndex          105

//Archived Data Paths
#define TPUserProfilePathKey @"user_profile_data"

#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

#endif
