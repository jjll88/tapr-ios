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

- (NSArray *)bodyPartData  {  // data model
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
    
    // Right button
    if (self.shouldShowNewMeasure) {
        UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                       target:self action:@selector(doneBarButtonPressed)];
        self.navigationController.navigationBar.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_OrangeTintColor];
        [self.navigationItem setRightBarButtonItem:customBarItem];
    }
}

# pragma mark - TableView datasource
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
    cell.titleLbl.text = [NSString stringWithFormat:@"%@ inch",[obj objectForKey:@"value"]];
    cell.dateLbl.text = [obj objectForKey:@"date"];
    
    if (indexPath.row == 0 && self.shouldShowNewMeasure) {  // Highlight new added measure
        self.showNewMeasure = NO;
        
        cell.titleLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_OrangeTintColor];
        cell.dateLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_OrangeTintColor];
    }
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete";
}

#pragma mark - Others
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void) doneBarButtonPressed {
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
