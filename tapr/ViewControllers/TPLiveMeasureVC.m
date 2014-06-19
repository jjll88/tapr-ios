//
//  TPLiveMeasureVC.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPLiveMeasureVC.h"
#import "TPSummaryVC.h"
#import "TPMeasureInputVC.h"

@interface TPLiveMeasureVC () <TPMeasureInputDelegate>

@property (weak, nonatomic) IBOutlet UIButton *measureBtn;
@property (weak, nonatomic) IBOutlet UILabel *measureDisplay;
@property (weak, nonatomic) IBOutlet UILabel *measureUnits;

//Local variables
@property (nonatomic, strong) NSString *measureDate;

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
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self resetValues];
}

#pragma mark - Set up UI
- (void) setupUI {
    
    [self resetValues];
    
    // Displays ****
    self.measureUnits.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_BlueTintColor];
    self.measureUnits.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_MeasureUnit];
    
    self.measureDisplay.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_BlueTintColor];
    self.measureDisplay.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_MeasureValue];

    CGFloat lineThickness = 1.;
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.measureDisplay.bounds.size.height-lineThickness, self.measureDisplay.bounds.size.width, lineThickness)];
    separatorLine.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_BlueTintColor];
    [self.measureDisplay addSubview:separatorLine];
    
    // Measure Btn ****
    self.measureBtn.tintColor = [UIColor clearColor];
    self.measureBtn.backgroundColor = [UIColor clearColor];
    self.measureBtn.adjustsImageWhenHighlighted = NO;
    self.measureBtn.tag = self.index;
    
    UIColor *selectedColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightOrange];
    UIColor *highlightedColor = [[[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightOrange] colorWithAlphaComponent:0.75];
    UIColor *normalColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightOrange];
    
    [self.measureBtn setBackgroundColor:normalColor forState:UIControlStateNormal];
    [self.measureBtn setBackgroundColor:highlightedColor forState:UIControlStateHighlighted];
    [self.measureBtn setBackgroundColor:selectedColor forState:UIControlStateSelected];
    
    [self.measureBtn setTitle:@"Capture" forState:UIControlStateNormal];
    [self.measureBtn setTitle:@"Save" forState:UIControlStateSelected];
}

#pragma mark - IBActions
- (IBAction)measureBtnPressed:(UIButton *)sender {
    if (!self.measureBtn.selected) {
        [self performSegueWithIdentifier:@"segueMeasureInputVC" sender:sender];
    } else {
        
        // Save data
        NSDictionary *dataInfo = @{@"value":self.measureDisplay.text,@"date":self.measureDate};
        [[TPDataManager sharedManager] addMeasure:dataInfo toCategory:self.index];
        
        [self performSegueWithIdentifier:@"segueSummaryVC" sender:sender];
    }
}

- (IBAction)editInputValue:(UITapGestureRecognizer *)sender {
    if (![NSString isEmpty:self.measureDisplay.text]) {
        [self performSegueWithIdentifier:@"segueMeasureInputVC" sender:sender];
    }
}

#pragma mark - TPMeasureInput Delegates
- (void)TPMeasureInputVC:(TPMeasureInputVC *)controller didFinishEnteringMeasure:(NSString *)measureValue atDate:(NSString *)measureDate {
    self.measureBtn.selected = YES;
    self.measureDisplay.text = measureValue;
    self.measureDate = measureDate;
}

#pragma mark - Helpers
- (void) resetValues {
    self.measureBtn.selected = NO;
    self.measureDisplay.text = @"";
    self.measureDate = nil;
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
    } else if ([segue.identifier isEqualToString:@"segueMeasureInputVC"]) {
        TPMeasureInputVC *measureInputVC = segue.destinationViewController;
        measureInputVC.delegate = self;
    }
}


@end
