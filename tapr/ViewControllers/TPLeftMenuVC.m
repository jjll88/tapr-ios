//
//  TPLeftMenuVC.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPLeftMenuVC.h"
#import "TPMenuCell.h"

#define initialSelectedRow 0

@interface TPLeftMenuVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *logOutBtn;

// Local variables
@property (nonatomic) int selectedRow;
@property (nonatomic, strong) NSArray *menuItemArr;   //arr of dictionaries

@end

@implementation TPLeftMenuVC

- (NSArray *) menuItemArr { // Ordered elements of left menu
    if (!_menuItemArr) _menuItemArr = @[@{@"title":profileTitle,@"index":@profileCellIndex},
                                        @{@"title":progressTitle,@"index":@progressCellIndex},
                                        @{@"title":aboutTitle,@"index":@aboutCellIndex},
                                        @{@"title":settingsTitle,@"index":@settingsCellIndex},];
    return _menuItemArr;
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
    
    self.selectedRow = initialSelectedRow; // Initial value
}

#pragma mark - view events
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ( self.selectedRow < [self.menuItemArr count]) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedRow inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}

#pragma mark - Set up UI
- (void) setupUI {
    // tableview ****
    self.tableView.allowsSelection = YES;
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuBackground];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // table header view
    CGFloat lineThickness = 1.;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 64)];
    header.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuBackground];
    UIView *bottomSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, header.bounds.size.height-lineThickness, header.bounds.size.width, lineThickness)];
    bottomSeparatorLine.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuCellSeparator];
    [header addSubview:bottomSeparatorLine];
    self.tableView.tableHeaderView = header;
    
    // log out Btn
    self.logOutBtn.backgroundColor = [UIColor clearColor];
    self.logOutBtn.tintColor = [UIColor clearColor];
    [self.logOutBtn setTitle:logoutTitle forState:UIControlStateNormal];
    self.logOutBtn.titleLabel.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_LeftMenu_Cell];
    [self.logOutBtn setBackgroundColor:[[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuBackground] forState:UIControlStateHighlighted];
    [self.logOutBtn setBackgroundColor:[[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuHighLigthedCell] forState:UIControlStateNormal];
    UIView *topSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, header.bounds.size.width, lineThickness)];
    topSeparatorLine.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuCellSeparator];
    [self.logOutBtn addSubview:topSeparatorLine];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuItemArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MenuCell";
    TPMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[TPMenuCell alloc] init];
    }
    // Configure the cell...
    cell.titleLbl.text = [self.menuItemArr[indexPath.row] objectForKey:@"title"];
    cell.tag = [[self.menuItemArr[indexPath.row] objectForKey:@"index"] integerValue];
    
    return cell;
}

#pragma mark - Table view delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedRow = (int)indexPath.row;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.tag == progressCellIndex) {
        [self performSegueWithIdentifier:@"segueProgressVC" sender:cell];
    } else if (cell.tag == profileCellIndex){
        [self performSegueWithIdentifier:@"segueProfileVC" sender:cell];
    } else if (cell.tag == settingsCellIndex){
        [self performSegueWithIdentifier:@"segueSettingsVC" sender:cell];
    } else {
        [self performSegueWithIdentifier:@"segueTestVC" sender:cell];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return menuCellHeight;
}

#pragma mark - IBActions
- (IBAction)logoutBtnPressed:(UIButton *)sender {
    [self toastMessage:@"Under construction"];
}


#pragma mark - Navigation
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender {
    
    if ([segue.identifier isEqualToString:@"segueTestVC"]) {            //DEBUG: set up TestVC
        // Set the title of navigation bar by using the menu items
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
        [(TPBaseVC *)destViewController setupNavBarTitle:[self.menuItemArr[indexPath.row] objectForKey:@"title"]];
    }
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
    }
}

#pragma mark - Others
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
