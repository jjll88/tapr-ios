//
//  TPToolsVC.m
//  tapr
//
//  Created by David Regatos on 01/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPToolsVC.h"

#define footerLineThickness 1.

@interface TPToolsVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TPToolsVC

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
    [self setupNavBarTitle:toolsTitle];
    
    // tableview
    self.tableView.allowsSelection = YES;
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightBlueTintColor];
    self.tableView.scrollEnabled = NO;
}

- (void) updateUI {
    
}

# pragma mark - TableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Regular Cell
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"Tool #%i",indexPath.row];
    cell.textLabel.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Cell_LightTitle];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self toastMessage:@"Under construction"];
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
