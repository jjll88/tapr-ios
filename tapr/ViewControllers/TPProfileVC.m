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

#define vcTitle @"Profile"

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
    if  (!_user) _user = [TPUserManager sharedManager].user;
    return _user;
}

- (NSArray *)profileInfoArr  {
    if  (!_profileInfoArr) {
        _profileInfoArr = @[@{@"type": @"Name",@"value": self.user.name},
                            @{@"type": @"Birthday",@"value": self.user.birthday},
                            @{@"type": @"Height",@"value": self.user.height},
                            @{@"type": @"Weight",@"value": self.user.weight},
                            @{@"type": @"Gender",@"value": self.user.gender}];
    }
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
    
    // Init User
    [[TPUserManager sharedManager] initWithDummyUserProfile];
}

#pragma mark - view events
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - Set up UI
- (void) setupUI {
    // Nav bar Title
    [self setupNavBarTitle:vcTitle];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                   target:self action:@selector(editBarButtonPressed)];
    self.navigationController.navigationBar.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_OrangeTintColor];
    [self.navigationItem setRightBarButtonItem:customBarItem];
    
    // tableview
    self.tableView.allowsSelection = YES;
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //avatar
    self.avatar.layer.cornerRadius = self.avatar.bounds.size.width/2;
    self.avatar.image = self.user.avatar;
    self.avatar.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1.0];
    
    //joined
    self.joinedLbl.text = [NSString stringWithFormat:@"Joined %@",self.user.joinedDateStr];
    self.joinedLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_BlueTintColor];
    self.joinedLbl.font = [UIFont fontWithName:@"Lato-Regular" size:15];
}

# pragma mark - TableView datasource

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
    
    if (indexPath.row < [self.profileInfoArr count]-1) {
        //separator line
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, cell.bounds.size.height-1, cell.bounds.size.width, 1)];
        separatorLineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        [cell.contentView addSubview:separatorLineView];
    }
    
    return cell;
}

#pragma mark - Others
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void) editBarButtonPressed {
    [self toastMessage:@"Under construction"];
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
