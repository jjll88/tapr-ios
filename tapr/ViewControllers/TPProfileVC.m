//
//  TPProfileVC.m
//  tapr
//
//  Created by David Regatos on 17/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPProfileVC.h"
#import "TPProfileCell.h"
#import "TPUserProfile.h"

@interface TPProfileVC () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *joinedLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// Local variables
@property (nonatomic, strong) TPUserProfile *user;
@property (nonatomic, strong) NSArray *profileInfoArr;  //arr of dictionarios with keys (categories' type and value) got from user profile info

@end

@implementation TPProfileVC

- (TPUserProfile *)user  {
    if  (!_user) _user = [TPProfileManager sharedManager].user;
    return _user;
}

- (NSArray *)profileInfoArr  {
    
    _profileInfoArr = @[@{@"type": @"Name",@"value": self.user.name},
                        @{@"type": @"Birthday",@"value": self.user.birthday},
                        @{@"type": @"Height",@"value": [self userHeigthString:self.user]},
                        @{@"type": @"Weight",@"value": [self userWeigthString:self.user]},
                        @{@"type": @"Gender",@"value": (self.user.gender == gender_female ? @"Female" : @"Male")}];
    
    return _profileInfoArr;
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
    
    // register your notification in the init-setup
    [self registerForKVO];
    
    [self setupUI];
}

#pragma mark - KVOs
- (void) registerForKVO {
    
    TPProfileManager *observedObj = [TPProfileManager sharedManager];
    
    [observedObj addObserver:self forKeyPath:@"user" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"user"]) {
        // Do something after observed_obj's observed_property was changed
        
        // update user local variable
        _user = [TPProfileManager sharedManager].user;
        
        // reload table view
        [self.tableView reloadData];
    }
}

- (void) dealloc {
    [[TPProfileManager sharedManager] removeObserver:self forKeyPath:@"user"];
}

#pragma mark - Set up UI
- (void) setupUI {
    
    // Nav bar Title
    [self setupNavBarTitle:profileTitle];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                   target:self action:@selector(editBarButtonPressed)];
    self.navigationController.navigationBar.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_DarkBlueTintColor];
    [self.navigationItem setRightBarButtonItem:customBarItem];
    
    // tableview
    self.tableView.allowsSelection = NO;
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightBlueTintColor];
    self.tableView.scrollEnabled = NO;
    
    //avatar
    self.avatar.layer.cornerRadius = self.avatar.bounds.size.width/2;
    self.avatar.image = self.user.avatar;
    self.avatar.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1.0];
    
    //joined
    self.joinedLbl.text = [NSString stringWithFormat:@"Joined %@",self.user.joinedDateStr];
    self.joinedLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_TurquoiseTintColor];
    self.joinedLbl.font = [UIFont fontWithName:@"Lato-Regular" size:15];
}

# pragma mark - TableView datasource & delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.profileInfoArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Custom Cell
    static NSString *CellIdentifier = @"ProfileCell";
    TPProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[TPProfileCell alloc] init];
    }
    
    // Configure the cell...
    NSDictionary *categoryInfo = [self.profileInfoArr objectAtIndex:indexPath.row];
    
    cell.categoryNameLbl.text = [categoryInfo objectForKey:@"type"];
    cell.categoryValueLbl.text = [categoryInfo objectForKey:@"value"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

#pragma mark - Helpers
- (NSString *) userHeigthString: (TPUserProfile *) user {
    NSString *heightStr;
    
    if (user.heightUnits == heightUnits_cm) {
        heightStr = [NSString stringWithFormat:@"%@ cm", user.height];
    } else if (user.heightUnits == heightUnits_ft) {
        #pragma mark - TO DO / Handle feet-inches
    }
    
    return heightStr;
}

- (NSString *) userWeigthString: (TPUserProfile *) user {
    NSString *units = user.weightUnits == weightUnits_kg ? @"kg" : @"lb";
    
    return [NSString stringWithFormat:@"%@ %@", user.weight, units];
}

#pragma mark - Others
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void) editBarButtonPressed {    
    [self performSegueWithIdentifier:@"segueEditProfileVC" sender:nil];
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
