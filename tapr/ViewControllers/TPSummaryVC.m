//
//  TPSummaryVC.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPSummaryVC.h"
#import "TPSummaryCell.h"
#import "JBBarChartView.h"
#import "JBLineChartView.h"
#import "JBChartTooltipView.h"
#import "JBChartTooltipTipView.h"
#import "JBLineChartFooterView.h"

#define dateFormat @"MMMM dd, yyyy\nhh:mm a"

// Numerics
CGFloat const kJBLineChartViewControllerChartPadding = 10.0f;
CGFloat const kJBLineChartViewControllerChartFooterHeight = 20.0f;

@interface TPSummaryVC () <JBLineChartViewDataSource, JBLineChartViewDelegate,UITableViewDataSource, UITableViewDelegate>

// Header
@property (weak, nonatomic) IBOutlet UIView *subHeaderContainer;
@property (weak, nonatomic) IBOutlet UILabel *summaryTitleLbl;
// Chart view
@property (weak, nonatomic) IBOutlet UIView *chartContainerView;
@property (weak, nonatomic) IBOutlet JBLineChartView *lineChartView;
@property (weak, nonatomic) IBOutlet RotatedUILabel *axisYLbl;
@property (weak, nonatomic) IBOutlet UILabel *axisXLbl;

@property (nonatomic, strong) JBChartTooltipView *tooltipView;
@property (nonatomic, strong) JBChartTooltipTipView *tooltipTipView;
// Table view
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// Flags
@property (nonatomic, assign) BOOL tooltipVisible;

// Local variables
@property (nonatomic, strong) TPUserProfile *user;
@property (nonatomic, strong) NSArray *bodyPartCategories;
@property (nonatomic, strong) NSArray *bodyPartData;            // For the table view (news to olds)
@property (nonatomic, strong) NSArray *reverseBodyPartData;     // For the chart view (olds to news)

@end

@implementation TPSummaryVC

- (NSArray *)bodyPartData  {  // data model
    if  (!_bodyPartData) {
        if (self.index <= [[[TPDataManager sharedManager] dummyBodyPartData] count]) {
            _bodyPartData = [[TPDataManager sharedManager] dummyBodyPartData][self.index];
        }
    }
    return _bodyPartData;
}

- (NSArray *)reverseBodyPartData  {
    return[self.bodyPartData reversedArray];
}

- (TPUserProfile *)user  {
    return [[TPProfileManager sharedManager] user];
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
    self.bodyPartCategories = [[TPDataManager sharedManager] dummyBodyPartCategories];
}

#pragma mark - view events
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - Set up UI
- (void) setupUI {
    // Nav bar Title
    [self setupNavBarTitle:@"Summary"];
    
    // tableview
    self.tableView.allowsSelection = YES;
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightBlueTintColor];
    
    //Subheader Lbl
    self.subHeaderContainer.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];
    self.summaryTitleLbl.backgroundColor = [UIColor clearColor];
    self.summaryTitleLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Subheader];
    self.summaryTitleLbl.textColor = [UIColor whiteColor];
    if (self.index <= [self.bodyPartCategories count]) {
        self.summaryTitleLbl.text = self.bodyPartCategories[self.index];
    } else {
        self.summaryTitleLbl.text = @"";
    }
    
    // Right button
    if (self.shouldShowNewMeasure) {
        UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                       target:self action:@selector(doneBarButtonPressed)];
        self.navigationController.navigationBar.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_DarkBlueTintColor];
        [self.navigationItem setRightBarButtonItem:customBarItem];
    }
    
    //JBLineCharView ***
    self.lineChartView.delegate = self;
    self.lineChartView.dataSource = self;
    self.chartContainerView.backgroundColor = [UIColor colorWithWhite:1. alpha:1.];
    self.lineChartView.backgroundColor = [UIColor colorWithWhite:1. alpha:1.];
    // X axis
    self.axisXLbl.hidden = YES;         /** axis Label is HIDDEN */
//    self.axisXLbl.text = @"Date";
//    self.axisXLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_QuoteAuthor];
//    self.axisXLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];
    JBLineChartFooterView *footerView = [[JBLineChartFooterView alloc] initWithFrame:CGRectMake(kJBLineChartViewControllerChartPadding, ceil(self.view.bounds.size.height * 0.5) - ceil(kJBLineChartViewControllerChartFooterHeight * 0.5), self.view.bounds.size.width - (kJBLineChartViewControllerChartPadding * 2), kJBLineChartViewControllerChartFooterHeight)];
    footerView.backgroundColor = [UIColor clearColor];
    footerView.leftLabel.text = [NSString Date:[[self.reverseBodyPartData firstObject] objectForKey:@"date"] toStringWithFormat:dateFormat];
    footerView.leftLabel.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];
    footerView.rightLabel.text = [NSString Date:[[self.reverseBodyPartData lastObject] objectForKey:@"date"] toStringWithFormat:dateFormat];
    footerView.rightLabel.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];
    footerView.sectionCount = [self.reverseBodyPartData count];
    footerView.footerSeparatorColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];
    self.lineChartView.footerView = footerView;
    // Y axis
    self.axisYLbl.text = @"Measurement";
    self.axisYLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_QuoteAuthor];
    self.axisYLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];
    UIView *yAxis = [[UIView alloc] initWithFrame:CGRectMake(self.lineChartView.frame.origin.x-3, self.lineChartView.frame.origin.y, 0.5, self.lineChartView.frame.size.height-20)];
    yAxis.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];
    [self.chartContainerView addSubview:yAxis];
    
    [self.lineChartView reloadData];
}

#pragma mark - LineChartView datasource
- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView {
    return 1; // number of lines in chart
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex {
    return [self.reverseBodyPartData count]; // number of values for a line
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    CGFloat yValue = [[self.reverseBodyPartData[horizontalIndex] objectForKey:@"value"] floatValue]*[[[TPDataManager sharedManager] unitConversionFactor] floatValue];
    return yValue; // y-position (y-axis) of point at horizontalIndex (x-axis)
}

#pragma mark - LineChartView delegate
// Handle touch
- (void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex touchPoint:(CGPoint)touchPoint {
    NSDictionary *obj = (NSDictionary *) self.reverseBodyPartData[horizontalIndex];
    CGFloat value = [[obj objectForKey:@"value"] floatValue]*[[[TPDataManager sharedManager] unitConversionFactor] floatValue];
    NSString *yValueStr = [NSString stringWithFormat:@"%@ %@",[NSString numberToStringWithSeparator:@(value) andDecimals:1], [TPDataManager sharedManager].unitsStr];
    NSString *dateValueStr = [NSString Date:[self.reverseBodyPartData[horizontalIndex] objectForKey:@"date"] toStringWithFormat:dateFormat];
    
    // Update view
    self.summaryTitleLbl.text = [NSString stringWithFormat:@"%@ - %@",self.bodyPartCategories[self.index],dateValueStr];
    self.chartContainerView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.];
    self.lineChartView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.];
    
    [self setTooltipVisible:YES animated:YES atTouchPoint:touchPoint];
    [self.tooltipView setText:yValueStr];
//    [self.tooltipView setText:[NSString stringWithFormat:@"%@ (%@)",yValueStr,dateValueStr]];
}

- (void)didUnselectLineInLineChartView:(JBLineChartView *)lineChartView {
    // Update view
    self.summaryTitleLbl.text = self.bodyPartCategories[self.index];
    self.chartContainerView.backgroundColor = [UIColor colorWithWhite:1. alpha:1.];
    self.lineChartView.backgroundColor = [UIColor colorWithWhite:1. alpha:1.];
    
    [self setTooltipVisible:NO animated:YES];
}

//Custom
- (BOOL)lineChartView:(JBLineChartView *)lineChartView showsDotsForLineAtLineIndex:(NSUInteger)lineIndex {
    return YES;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView dotRadiusForLineAtLineIndex:(NSUInteger)lineIndex {
    return 11.;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    return [[TPThemeManager sharedManager] colorOfType:ThemeColorType_OrangeTintColor]; // color of line in chart
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex {
    return 3; // width of line in chart
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex {
    return [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor]; // color of line in chart
}

- (JBLineChartViewLineStyle)lineChartView:(JBLineChartView *)lineChartView lineStyleForLineAtLineIndex:(NSUInteger)lineIndex {
    return JBLineChartViewLineStyleDashed; // style of line in chart
}

- (UIColor *)verticalSelectionColorForLineChartView:(JBLineChartView *)lineChartView {
    return [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];;
}


# pragma mark - TableView datasource & delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.bodyPartData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Custom Cell
    static NSString *CellIdentifier = @"SummaryCell";
    TPSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[TPSummaryCell alloc] init];
    }
    
    // Configure the cell...
    NSDictionary *obj = (NSDictionary *) self.bodyPartData[indexPath.row];

    // Custom Cell
    CGFloat value = [[obj objectForKey:@"value"] floatValue]*[[[TPDataManager sharedManager] unitConversionFactor] floatValue];
    cell.titleLbl.text = [NSString stringWithFormat:@"%@ %@",[NSString numberToStringWithSeparator:@(value) andDecimals:1], [TPDataManager sharedManager].unitsStr];
    cell.dateLbl.text = [NSString Date:[obj objectForKey:@"date"] toStringWithFormat:dateFormat];;
    
    if (indexPath.row == 0 && self.shouldShowNewMeasure) {  // Highlight new added measure
        self.showNewMeasure = NO;
        
        cell.titleLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_DarkBlueTintColor];
        cell.dateLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_DarkBlueTintColor];
    }
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Update data model
        [[TPDataManager sharedManager] removeMeasure:self.bodyPartData[indexPath.row] atIndex:(int)indexPath.row ofCategory:self.index];
        // Force data model loading
        _bodyPartData = nil; // [[TPDataManager sharedManager] dummyBodyPartData][self.index];
        
        // Update table view
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
        
        //Update chart view
        [self.lineChartView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete";
}

#pragma mark - tooltipView Controller
- (void)setTooltipVisible:(BOOL)tooltipVisible animated:(BOOL)animated atTouchPoint:(CGPoint)touchPoint {
    _tooltipVisible = tooltipVisible;
    
    JBChartView *chartView = self.lineChartView;
    
    if (!chartView) {
        return;
    }
    
    if (!self.tooltipView) {
        self.tooltipView = [[JBChartTooltipView alloc] init];
        self.tooltipView.alpha = 0.0;
        [self.chartContainerView addSubview:self.tooltipView];
    }
    
    if (!self.tooltipTipView) {
        self.tooltipTipView = [[JBChartTooltipTipView alloc] init];
        self.tooltipTipView.alpha = 0.0;
        [self.chartContainerView addSubview:self.tooltipTipView];
    }
    
    dispatch_block_t adjustTooltipPosition = ^{
        CGPoint originalTouchPoint = [self.view convertPoint:touchPoint fromView:chartView];
        CGPoint convertedTouchPoint = originalTouchPoint;       // modified
        JBChartView *chartView = self.lineChartView;
        if (chartView) {
            CGFloat minChartX = (chartView.frame.origin.x + ceil(self.tooltipView.frame.size.width * 0.5));
            if (convertedTouchPoint.x < minChartX) {
                convertedTouchPoint.x = minChartX;
            }
            CGFloat maxChartX = (chartView.frame.origin.x + chartView.frame.size.width - ceil(self.tooltipView.frame.size.width * 0.5));
            if (convertedTouchPoint.x > maxChartX) {
                convertedTouchPoint.x = maxChartX;
            }
            self.tooltipView.frame = CGRectMake(convertedTouchPoint.x - ceil(self.tooltipView.frame.size.width * 0.5),
                                                CGRectGetMaxY(chartView.headerView.frame)+5,
                                                self.tooltipView.frame.size.width,
                                                self.tooltipView.frame.size.height);
            
            CGFloat minTipX = (chartView.frame.origin.x + self.tooltipTipView.frame.size.width);
            if (originalTouchPoint.x < minTipX) {
                originalTouchPoint.x = minTipX;
            }
            CGFloat maxTipX = (chartView.frame.origin.x + chartView.frame.size.width - self.tooltipTipView.frame.size.width);
            if (originalTouchPoint.x > maxTipX) {
                originalTouchPoint.x = maxTipX;
            }
            self.tooltipTipView.frame = CGRectMake(originalTouchPoint.x - ceil(self.tooltipTipView.frame.size.width * 0.5),
                                                   CGRectGetMaxY(self.tooltipView.frame)+5,
                                                   self.tooltipTipView.frame.size.width,
                                                   self.tooltipTipView.frame.size.height);
        }
    };
    
    dispatch_block_t adjustTooltipVisibility = ^{
        self.tooltipView.alpha = _tooltipVisible ? 1.0 : 0.0;
        self.tooltipTipView.alpha = _tooltipVisible ? 1.0 : 0.0;
	};
    
    if (tooltipVisible) {
        adjustTooltipPosition();
    }
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            adjustTooltipVisibility();
        } completion:^(BOOL finished) {
            if (!tooltipVisible) {
                adjustTooltipPosition();
            }
        }];
    }
    else {
        adjustTooltipVisibility();
    }
}

- (void)setTooltipVisible:(BOOL)tooltipVisible animated:(BOOL)animated {
    [self setTooltipVisible:tooltipVisible animated:animated atTouchPoint:CGPointZero];
}

- (void)setTooltipVisible:(BOOL)tooltipVisible {
    [self setTooltipVisible:tooltipVisible animated:NO];
}

#pragma mark - Others
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void) doneBarButtonPressed {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
