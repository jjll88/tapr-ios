//
//  TPMeasureVC.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPMeasureVC.h"
#import "TPMeasureCell.h"
#import "TPLiveMeasureVC.h"

@interface TPMeasureVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// Local variables
@property (nonatomic, strong) NSArray *menuItemTitlesArr;

@end

@implementation TPMeasureVC

- (NSArray *) menuItemTitlesArr { // Order is important.
    if (!_menuItemTitlesArr) _menuItemTitlesArr = [[TPDataManager sharedManager] dummyBodyPartCategories];
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
    self.addMenuBarBtn = YES;
    self.addMenuPanGesture = YES;
    self.addPlusBarBtn = NO;
}

#pragma mark - view events
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Set up UI
- (void) setupUI {
    // Nav bar Title ****
    [self setupNavBarTitle:measureTitle];

    // tableview ****
    self.tableView.allowsSelection = YES;
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // table header view
    CGFloat lineThickness = 1.;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, lineThickness)];
    header.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightBlueTintColor];
    self.tableView.tableHeaderView = header;
}

# pragma mark - TableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuItemTitlesArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Custom Cell
    static NSString *CellIdentifier = @"MeasureCell";
    TPMeasureCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[TPMeasureCell alloc] init];
    }
    
    // Configure the cell...
    cell.titleLbl.text = self.menuItemTitlesArr[indexPath.row];
    
    return cell;
}

#pragma mark - TableView Delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![self isLeftMenuVisible]) {  //avoid push if left menu is visible
        [self performSegueWithIdentifier:@"segueLiveMeasureVC" sender:indexPath];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - IBActions
- (void) closeBarButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Others
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSIndexPath *)sender {
    if ([segue.identifier isEqualToString:@"segueLiveMeasureVC"]) {
        TPLiveMeasureVC *liveMeasureVC = segue.destinationViewController;
        liveMeasureVC.index = (int)sender.row;
        [liveMeasureVC setupNavBarTitle:self.menuItemTitlesArr[sender.row]];
    }
}

@end
