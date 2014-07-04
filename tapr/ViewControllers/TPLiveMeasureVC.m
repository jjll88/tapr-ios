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
#import "TPButton.h"
#import "TPLabel.h"

@interface TPLiveMeasureVC () <TPMeasureInputDelegate>

@property (weak, nonatomic) IBOutlet TPLabel *measureUnits;
@property (weak, nonatomic) IBOutlet TPLabel *liveLbl;
@property (weak, nonatomic) IBOutlet TPButton *saveBtn;

// ** To present a VC that allows manual entry. FOR TESTING */
@property (weak, nonatomic) IBOutlet UIButton *manualEntryBtn;

//Local variables
@property (weak, nonatomic) NSString *capturedStr;
@property (nonatomic, strong) NSDate *measureDate;

@end

@implementation TPLiveMeasureVC

- (void)setCapturedStr:(NSString *)capturedStr {
    _capturedStr = capturedStr;
}

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
        // convert to one decimal point number
        NSNumber *value = [NSNumber numberWithDouble:[dataStr doubleValue]];
        self.liveLbl.text = [NSString numberToStringWithSeparator:value andDecimals:1];
        
        /** SET Button and Labels STATUS */
        self.saveBtn.enabled = YES;
        self.liveLbl.status = Status_HighLighted;
        self.measureUnits.status = Status_HighLighted;
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
    [self.measureUnits setTextColor:[UIColor lightGrayColor] forState:Status_Normal];
    [self.measureUnits setTextColor:[[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor] forState:Status_HighLighted];
    self.measureUnits.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_MeasureUnit];
    self.measureUnits.addUnderline = NO;
    self.measureUnits.status = Status_Normal;  // disabled by default


    self.liveLbl.text = @"0.0";
    [self.liveLbl setTextColor:[UIColor lightGrayColor] forState:Status_Normal];
    [self.liveLbl setTextColor:[[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor] forState:Status_HighLighted];
    self.liveLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_MeasureValue];
    self.liveLbl.addUnderline = YES;
    self.liveLbl.status = Status_Normal;  // disabled by default
    
    // Measure Btn ****
    self.saveBtn.enabled = NO;              // disabled by default
    [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
    self.saveBtn.inactiveColor = [UIColor lightGrayColor];
    self.saveBtn.activeColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];
    
    if (!DEBUG) {
        self.manualEntryBtn.hidden = YES;
    }
}

#pragma mark - IBActions
- (IBAction)saveBtnPressed:(UIButton *)sender {
    /** Before saving the measure you must enabled the saveBtn */
    self.capturedStr = self.liveLbl.text;
    [self saveMeasurement];
}
- (IBAction)manualEntryBtnPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueMeasureInputVC" sender:sender];
}

- (IBAction)editInputValue:(UITapGestureRecognizer *)sender {
    if (![NSString isEmpty:self.capturedStr]) {
        [self performSegueWithIdentifier:@"segueMeasureInputVC" sender:sender];
    }
}

- (void) bluetoothBarButtonPressed {
    [self toastMessage:@"Under construction"];
}

#pragma mark - TPMeasureInput Delegates
- (void)TPMeasureInputVC:(TPMeasureInputVC *)controller didFinishEnteringMeasure:(NSString *)measureValue atDate:(NSDate *)measureDate {
    self.saveBtn.enabled = YES;
    self.measureUnits.status = Status_HighLighted;
    self.liveLbl.status = Status_HighLighted;
    self.capturedStr = measureValue;
    self.liveLbl.text = self.capturedStr;
    self.measureDate = measureDate;
}

#pragma mark - Helpers
- (void) resetValues {
    self.capturedStr = @"";
    self.liveLbl.text = self.capturedStr;
    self.measureDate = nil;
}

- (void) saveMeasurement {
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *enterValue = [f numberFromString:self.capturedStr];
    NSNumber *convertedValue = [NSNumber numberWithFloat:[enterValue floatValue]/[[[TPDataManager sharedManager] unitConversionFactor] floatValue]];
    if (enterValue && ![enterValue isEqualToNumber:@0]) {
        // Save data
        self.measureDate = [NSDate date];
        NSDictionary *dataInfo = @{@"value":convertedValue,@"date":self.measureDate};
        [[TPDataManager sharedManager] addMeasure:dataInfo toCategory:self.index];
        
        [self performSegueWithIdentifier:@"segueSummaryVC" sender:nil];

    } else {
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
