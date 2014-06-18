//
//  Constants.h
//  tapr
//
//  Created by David Regatos on 12/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#ifndef tapr_Constants_h
#define tapr_Constants_h

//Left Menu Navigator Cells ***
#define CellProfile         100
#define CellBluetooth       101
#define CellProgress        102
#define CellAbout           103
#define CellSettings        104
#define CellLogOut          105

//Archived Data Paths
#define TPUserProfilePathKey @"user_profile_data"

#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

#endif
