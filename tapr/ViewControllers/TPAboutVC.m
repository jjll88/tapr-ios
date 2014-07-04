//
//  TPAboutVC.m
//  tapr
//
//  Created by David Regatos on 01/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPAboutVC.h"

@interface TPAboutVC ()

@property (weak, nonatomic) IBOutlet UILabel *aboutMessage;
@property (weak, nonatomic) IBOutlet UILabel *buildNumberLbl;
@property (weak, nonatomic) IBOutlet UILabel *buildDateLbl;

@end

@implementation TPAboutVC

#pragma mark - init
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if	(self) [self setup];
    return self;
}

- (void) awakeFromNib {
    [self setup];
}

- (void) setup {
    // Initialization that can't wait until viewDidLoad
    self.addMenuBarBtn = YES;
    self.addMenuPanGesture = YES;
    self.addPlusBarBtn = NO;
}

#pragma mark - view events
- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateUI];
}

#pragma mark - Set up UI
- (void) setupUI {
    // Nav bar Title
    [self setupNavBarTitle:aboutTitle];
    
    UIFont *font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Message];
    
    // Lbls **
    self.aboutMessage.text = @"Welcome to Tapr!";
    self.aboutMessage.textColor = [UIColor darkGrayColor];
    self.aboutMessage.textAlignment = NSTextAlignmentCenter;
    self.aboutMessage.font = font;
    
    NSString *buildNum = @"11"; // [UIApplication versionBuild];
    self.buildNumberLbl.text = [NSString stringWithFormat:@"Build #: %@", buildNum];
    self.buildNumberLbl.textColor = [UIColor darkGrayColor];
    self.buildNumberLbl.textAlignment = NSTextAlignmentCenter;
    self.buildNumberLbl.font = font;
    

    NSString *buildDateStr = [UIApplication buildDate];
    self.buildDateLbl.text = [NSString stringWithFormat:@"Date: %@", buildDateStr];
    self.buildDateLbl.textColor = [UIColor darkGrayColor];
    self.buildDateLbl.textAlignment = NSTextAlignmentCenter;
    self.buildDateLbl.font = font;
    
}

- (void) updateUI {
    
}

#pragma mark - Others
- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
