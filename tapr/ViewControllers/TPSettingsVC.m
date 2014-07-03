//
//  TPSettingsVC.m
//  tapr
//
//  Created by David Regatos on 18/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPSettingsVC.h"

#define footerLineThickness 1.

@interface TPSettingsVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// Local variables
@property (nonatomic, strong) TPUserProfile *user;

@end

@implementation TPSettingsVC

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
    self.addMenuBarBtn = YES;
    self.addMenuPanGesture = YES;
    self.addPlusBarBtn = NO;
}

#pragma mark - view events
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - Set up UI
- (void) setupUI {
    // Nav bar Title
    [self setupNavBarTitle:settingsTitle];
    
    // tableview
    self.tableView.allowsSelection = YES;
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightBlueTintColor];
    self.tableView.scrollEnabled = NO;
}

# pragma mark - TableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Regular Cell
    static NSString *CellIdentifier;
    if (indexPath.row == 0) {
        CellIdentifier = @"Settings_Units";
    } else if (indexPath.row == 1) {
        CellIdentifier = @"Settings_Chart";
    } else {
        CellIdentifier = @"";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Custom Cell
//    static NSString *CellIdentifier = @"myCustomCell";
//    myCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if(cell == nil) {
//        cell = [[myCustomCell alloc] init];
//    }
    
    // Configure the cell...
    NSArray *arr = @[@"Units",@"Chart display"];
    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Cell_LightTitle];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Table view delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [self toastMessage:@"Under construction"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return footerLineThickness;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    //separator line
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, footerLineThickness)];
    separatorLineView.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightBlueTintColor];
    
    return separatorLineView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
