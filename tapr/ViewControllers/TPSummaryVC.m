//
//  TPSummaryVC.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPSummaryVC.h"
#import "TPSummaryCell.h"

@interface TPSummaryVC ()

@property (weak, nonatomic) IBOutlet UILabel *summaryTitleLbl;
@property (weak, nonatomic) IBOutlet UIView *subHeaderContainer;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// Local variables
@property (nonatomic, strong) NSArray *bodyPartCategories;
@property (nonatomic, strong) NSArray *bodyPartData;

@end

@implementation TPSummaryVC

- (NSArray *)bodyPartData  {
    if  (!_bodyPartData) {
        if (self.index <= [[[TPDataManager sharedManager] dummyBodyPartData] count]) {
            _bodyPartData = [[TPDataManager sharedManager] dummyBodyPartData][self.index];
        }
    }
    return _bodyPartData;
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
    
    //Subheader Lbl
    self.summaryTitleLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Subheader];
    self.summaryTitleLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_BlueTintColor];
    if (self.index <= [self.bodyPartCategories count]) {
        self.summaryTitleLbl.text = self.bodyPartCategories[self.index];
    } else {
        self.summaryTitleLbl.text = @"";
    }
}

# pragma mark - TableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
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
    cell.titleLbl.text = [NSString stringWithFormat:@"%@ inch",[obj objectForKey:@"value"]];
    cell.dateLbl.text = [obj objectForKey:@"date"];
    
    if (indexPath.row == 0 && self.shouldShowNewMeasure) {
        self.showNewMeasure = NO;
        
        cell.titleLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_OrangeTintColor];
        cell.dateLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_OrangeTintColor];
    }
    
    return cell;
}

#pragma mark - Others
- (void)didReceiveMemoryWarning {
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
