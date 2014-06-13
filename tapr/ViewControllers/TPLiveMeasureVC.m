//
//  TPLiveMeasureVC.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPLiveMeasureVC.h"
#import "TPSummaryVC.h"

@interface TPLiveMeasureVC ()

@property (weak, nonatomic) IBOutlet UIButton *measureBtn;
@property (weak, nonatomic) IBOutlet UILabel *measureDisplay;
@property (weak, nonatomic) IBOutlet UILabel *measureUnits;

@end

@implementation TPLiveMeasureVC

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
}

#pragma mark - view events
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.measureBtn.selected = NO;
    self.measureDisplay.text = @"";
}

#pragma mark - Set up UI
- (void) setupUI {
    // Displays
    self.measureUnits.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_BlueTintColor];
    self.measureUnits.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_MeasureUnit];
    
    self.measureDisplay.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_BlueTintColor];
    self.measureDisplay.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_MeasureValue];

    CGFloat lineThickness = 1.;
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.measureDisplay.bounds.size.height-lineThickness, self.measureDisplay.bounds.size.width, lineThickness)];
    separatorLine.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_BlueTintColor];
    [self.measureDisplay addSubview:separatorLine];

    
    // Measure Btn
    self.measureBtn.tag = self.index;
    
    UIColor *normalColor = [[[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightOrange] colorWithAlphaComponent:0.16];
    UIColor *highlightedColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightOrange];
    UIColor *selectedColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightOrange];
    
    self.measureBtn.tintColor = [UIColor clearColor];
    [self.measureBtn setBackgroundColor:normalColor forState:UIControlStateNormal];
    [self.measureBtn setBackgroundColor:highlightedColor forState:UIControlStateHighlighted];
    [self.measureBtn setBackgroundColor:selectedColor forState:UIControlStateSelected];
    
    [self.measureBtn setTitle:@"Start" forState:UIControlStateNormal];
    [self.measureBtn setTitle:@"Save" forState:UIControlStateSelected];
}

#pragma mark - IBActions
- (IBAction)measureBtnPressed:(UIButton *)sender {
    if (!self.measureBtn.selected) {
        self.measureBtn.selected = YES;
        self.measureDisplay.text = [self createDummyMeasure];
    } else {
        [self performSegueWithIdentifier:@"segueSummaryVC" sender:sender];
    }
}

#pragma mark - Helpers
- (NSString *) createDummyMeasure {
    NSString *dummy = @"23.5";
    
    NSDictionary *dataInfo = @{@"value":dummy,@"date":@"June 13, 2014\n6:15am"};
    [[TPDataManager sharedManager] addMeasure:dataInfo intoIndex:self.index];
    
    return dummy;
}

#pragma mark - Others
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender {
    if ([segue.identifier isEqualToString:@"segueSummaryVC"]) {
        TPSummaryVC *summaryVC = segue.destinationViewController;
        summaryVC.index = (int)sender.tag;
        summaryVC.showNewMeasure = YES;
    }
}


@end
