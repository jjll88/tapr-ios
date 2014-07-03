//
//  TPLeftMenuVC.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPLeftMenuVC.h"
#import "TPMenuCell.h"

#define initialSelectedRow 1

@interface TPLeftMenuVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *logOutBtn;

// Local variables
@property (nonatomic) int selectedRow;
@property (nonatomic, strong) NSArray *menuItemArr;   //arr of dictionaries

@end

@implementation TPLeftMenuVC

// ** Ordered elements of the left menu. Array of dictionaries. Keys: title, index, segue. */
- (NSArray *) menuItemArr {
    if (!_menuItemArr) _menuItemArr = @[@{@"title":profileTitle,@"index":@profileCellIndex,@"segue":@"segueProfileVC"},
                                        @{@"title":measureTitle,@"index":@measureCellIndex,@"segue":@"segueMeasureVC"},
                                        @{@"title":progressTitle,@"index":@progressCellIndex,@"segue":@"segueProgressVC"},
                                        @{@"title":aboutTitle,@"index":@aboutCellIndex,@"segue":@"segueAboutVC"},
                                        @{@"title":privacyTitle,@"index":@privacyCellIndex,@"segue":@"seguePrivacyVC"},
                                        @{@"title":toolsTitle,@"index":@toolsCellIndex,@"segue":@"segueToolsVC"},
                                        @{@"title":settingsTitle,@"index":@settingsCellIndex,@"segue":@"segueSettingsVC"}];
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
    
    self.view.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuBackground];

    // tableview ****
    self.tableView.allowsSelection = YES;
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor clearColor]; //[[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuBackground];
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
    [self.logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.logOutBtn setTitleColor:[[TPThemeManager sharedManager] colorOfType:ThemeColorType_TurquoiseTintColor] forState:UIControlStateHighlighted];
    [self.logOutBtn setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self.logOutBtn setBackgroundColor:[[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuHighLigthedCell] forState:UIControlStateHighlighted];
    UIView *topSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, header.bounds.size.width, lineThickness)];
    topSeparatorLine.backgroundColor = [UIColor whiteColor];
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
    NSString *segueStr = [self.menuItemArr[indexPath.row] objectForKey:@"segue"];
    
    if (![NSString isEmpty:segueStr] && segueStr) {
        [self performSegueWithIdentifier:segueStr sender:cell];
    } else {
        DMLog(@"Bad ERROR. Unknown destination VC");;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return menuCellHeight;
}

#pragma mark - IBActions
- (IBAction)logoutBtnPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueLoginVC" sender:nil];
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
