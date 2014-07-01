//
//  TPAboutVC.m
//  tapr
//
//  Created by David Regatos on 01/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPAboutVC.h"

@interface TPAboutVC ()

@property (weak, nonatomic) IBOutlet UILabel *aboutDescription;

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
    
    NSString *mssg = @"Welcome to the Tapr app, this app will allow users to measure any part of their body while charting out the measurements.";
    UIFont *font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Message];
    
    // For regular string **
//    self.aboutDescription.textColor = [UIColor darkGrayColor];
//    self.aboutDescription.textAlignment = NSTextAlignmentJustified;
//    self.aboutDescription.lineBreakMode = NSLineBreakByCharWrapping;
//    self.aboutDescription.font = font;
    
    // For attributed string **
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:mssg];
    NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentJustified];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [attributedString length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, [attributedString length])];
    // NOTE - XCode bug: we need to set a stroke if we want to justify the text
    [attributedString addAttribute:NSStrokeColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, [attributedString length])];
    [attributedString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:0.0] range:NSMakeRange(0, [attributedString length])];
    // ------
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
    
    [self.aboutDescription setAttributedText:attributedString];
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
