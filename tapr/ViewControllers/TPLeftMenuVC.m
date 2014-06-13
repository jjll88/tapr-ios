//
//  TPLeftMenuVC.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPLeftMenuVC.h"
#import "TPMenuCell.h"

@interface TPLeftMenuVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

// Local variables
@property (nonatomic) int selectedRow;
@property (nonatomic, strong) NSArray *menuItemTitlesArr;

@end

@implementation TPLeftMenuVC

- (NSArray *) menuItemTitlesArr { // Order is important.
    if (!_menuItemTitlesArr) _menuItemTitlesArr = @[@"Profile",@"Bluetooth",@"Progress",@"About",@"Settings",@"Log out"];
    return _menuItemTitlesArr;
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
    
    self.selectedRow = 2; // Initial value
}

#pragma mark - view events
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.tableView reloadData];
    
    if ( self.selectedRow < [self.menuItemTitlesArr count]) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedRow inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}

#pragma mark - Set up UI
- (void) setupUI {
    // tableview
    self.tableView.allowsSelection = YES;
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuBackground];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.menuItemTitlesArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MenuCell";
    TPMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[TPMenuCell alloc] init];
    }
    // Configure the cell...
    cell.titleLbl.text = self.menuItemTitlesArr[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.tag = CellProfile;
    } else if (indexPath.row == 1) {
        cell.tag = CellBluetooth;
    } else if (indexPath.row == 2) {
        cell.tag = CellProgress;
    } else if (indexPath.row == 3) {
        cell.tag = CellAbout;
    } else if (indexPath.row == 4) {
        cell.tag = CellSettings;
    } else if (indexPath.row == 5) {
        cell.tag = CellLogOut;
    }
    
    return cell;
}

#pragma mark - Table view delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedRow = (int)indexPath.row;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.tag == CellProgress) {
        [self performSegueWithIdentifier:@"segueProgressVC" sender:cell];
    } else if (cell.tag != CellLogOut){
        [self performSegueWithIdentifier:@"segueTestVC" sender:cell];
    } else {
        [self toastMessage:@"Under construction"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64.;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat lineThickness = 1.;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 64)];
    header.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuBackground];
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, header.bounds.size.height-lineThickness, header.bounds.size.width, lineThickness)];
    separatorLine.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuCellSeparator];
    [header addSubview:separatorLine];
    
    return header;
}


#pragma mark - Navigation
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender {
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[self.menuItemTitlesArr objectAtIndex:indexPath.row] capitalizedString];
    [(TPBaseVC *)destViewController setupNavBarTitle:[[self.menuItemTitlesArr objectAtIndex:indexPath.row] capitalizedString]];

    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"showPhoto"]) {
//        PhotoViewController *photoController = (PhotoViewController*)segue.destinationViewController;
//        NSString *photoFilename = [NSString stringWithFormat:@"%@_photo.jpg", [menuItems objectAtIndex:indexPath.row]];
//        photoController.photoFilename = photoFilename;
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
