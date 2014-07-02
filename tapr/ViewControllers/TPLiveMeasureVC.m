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

#import "WZBluetoothManager.h"

@interface TPLiveMeasureVC () <TPMeasureInputDelegate>

@property (weak, nonatomic) IBOutlet UILabel *liveLbl;
@property (weak, nonatomic) IBOutlet UIButton *measureBtn;
@property (weak, nonatomic) IBOutlet UILabel *capturedLbl;
@property (weak, nonatomic) IBOutlet UILabel *measureUnits;
@property (weak, nonatomic) IBOutlet UILabel *bluetoothStatusLbl;

// ** To present a VC that allows manual entry. FOR TESTING */
@property (weak, nonatomic) IBOutlet UIButton *manualEntryBtn;

//Local variables
@property (nonatomic, strong) NSDate *measureDate;

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
    
    [self setupNotificationObserver];
    
    [self setupUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self resetValues];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserverForName:BMNotification_PeripheralHaveUpdate object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSData *data = note.userInfo[BMNotificationKey_PeripheralUpdateKey];
        NSString *dataStr = [NSString stringWithUTF8String:(char *)(data.bytes)];
        self.liveLbl.text = dataStr;
    }];
}

#pragma mark - Set up UI
- (void) setupUI {
    
    [self resetValues];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-bluetooth-active"]
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(bluetoothBarButtonPressed)];
    
    self.navigationController.navigationBar.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_DarkBlueTintColor];
    [self.navigationItem setRightBarButtonItem:customBarItem];
    
    // Displays ****
    self.measureUnits.text = [TPDataManager sharedManager].unitsStr;
    self.measureUnits.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];
    self.measureUnits.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_MeasureUnit];
    
    self.capturedLbl.text = @"";
    self.capturedLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];
    self.capturedLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_MeasureValue];
    self.capturedLbl.adjustsFontSizeToFitWidth = YES;

    self.liveLbl.text = @"";
    self.liveLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];
    self.liveLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_MeasureValue];
    self.liveLbl.adjustsFontSizeToFitWidth = YES;
    
    self.bluetoothStatusLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Message];
    self.bluetoothStatusLbl.adjustsFontSizeToFitWidth = YES;
    
    // Measure Btn ****
    self.measureBtn.tintColor = [UIColor clearColor];
    self.measureBtn.backgroundColor = [UIColor clearColor];
    self.measureBtn.adjustsImageWhenHighlighted = NO;
    self.measureBtn.tag = self.index;
    
    UIColor *selectedColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_DarkBlueTintColor];
    UIColor *highlightedColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightBlueTintColor];
    UIColor *normalColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];
    
    [self.measureBtn setBackgroundColor:normalColor forState:UIControlStateNormal];
    [self.measureBtn setBackgroundColor:highlightedColor forState:UIControlStateHighlighted];
    [self.measureBtn setBackgroundColor:selectedColor forState:UIControlStateSelected];
    
    [self.measureBtn setTitle:@"Capture" forState:UIControlStateNormal];
    [self.measureBtn setTitle:@"Save" forState:UIControlStateSelected];
    
    if (!DEBUG) {
        self.manualEntryBtn.hidden = YES;
    }
}

#pragma mark - IBActions
- (IBAction)measureBtnPressed:(UIButton *)sender {
    if (!self.measureBtn.selected) {
        self.measureBtn.selected = YES;
        self.liveLbl.hidden = YES;
        self.capturedLbl.hidden = NO;
        self.capturedLbl.text = self.liveLbl.text;
    } else {
        [self saveMeasurement];
    }
}
- (IBAction)manualEntryBtnPressed:(UIButton *)sender {
    if (!self.measureBtn.selected) {
        [self performSegueWithIdentifier:@"segueMeasureInputVC" sender:sender];
    } else {
        [self saveMeasurement];
    }
}

- (IBAction)editInputValue:(UITapGestureRecognizer *)sender {
    if (![NSString isEmpty:self.capturedLbl.text]) {
        [self performSegueWithIdentifier:@"segueMeasureInputVC" sender:sender];
    }
}

- (void) bluetoothBarButtonPressed {
    [self toastMessage:@"Under construction"];
}

#pragma mark - TPMeasureInput Delegates
- (void)TPMeasureInputVC:(TPMeasureInputVC *)controller didFinishEnteringMeasure:(NSString *)measureValue atDate:(NSDate *)measureDate {
    self.liveLbl.hidden = YES;
    self.capturedLbl.hidden = NO;
    self.measureBtn.selected = YES;
    self.capturedLbl.text = measureValue;
    self.measureDate = measureDate;
}

#pragma mark - Helpers
- (void) resetValues {
    self.measureBtn.selected = NO;
    self.capturedLbl.text = @"";
    self.measureDate = nil;
    self.liveLbl.hidden = NO;
    self.capturedLbl.hidden = YES;
}

- (void) saveMeasurement {
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *enterValue = [f numberFromString:self.capturedLbl.text];
    NSNumber *convertedValue = [NSNumber numberWithFloat:[enterValue floatValue]/[[[TPDataManager sharedManager] unitConversionFactor] floatValue]];
    if (enterValue) {
        // Save data
        self.measureDate = [NSDate date];
        NSDictionary *dataInfo = @{@"value":convertedValue,@"date":self.measureDate};
        [[TPDataManager sharedManager] addMeasure:dataInfo toCategory:self.index];
        
        [self performSegueWithIdentifier:@"segueSummaryVC" sender:nil];

    } else {
        self.measureBtn.selected = NO;
        [self showAlert:@"Unable to save this value. Try again."];
    }
    
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
        summaryVC.index = self.index;
        summaryVC.showNewMeasure = YES;
    } else if ([segue.identifier isEqualToString:@"segueMeasureInputVC"]) {
        TPMeasureInputVC *measureInputVC = segue.destinationViewController;
        measureInputVC.delegate = self;
    }
}


@end
