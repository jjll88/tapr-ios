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
@property (weak, nonatomic) IBOutlet UILabel *quoteText;
@property (weak, nonatomic) IBOutlet UILabel *quoteAuthor;

// Autolayout
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightMessageLblConstrain;


// Local variables
@property (nonatomic, strong) NSArray *menuItemTitlesArr;

@end

@implementation TPMeasureVC

- (NSArray *) menuItemTitlesArr { // Order is important.
    if (!_menuItemTitlesArr) _menuItemTitlesArr = @[@"Chest",@"Arm",@"Waist",@"Legs"];
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
    
    // Message view ****
    self.quoteAuthor.text = @"H. James Harrington";
    self.quoteAuthor.textColor = [UIColor darkGrayColor];
    self.quoteAuthor.textAlignment = NSTextAlignmentJustified;
    self.quoteAuthor.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_QuoteAuthor];
    
    NSString *quote = @"\"Measurement is the first step that leads to control and eventually to improvement. If you can't measure something, you can't understand it. If you can't understand it, you can't control it. If you can't control it, you can't improve it.\"";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: quote];
    NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    //[paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSFontAttributeName
                             value:[[TPThemeManager sharedManager] fontOfType:ThemeFontType_QuoteText]
                             range:NSMakeRange(1, [attributedString length]-2)];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor]
                             range:NSMakeRange(1, [@"Measurement" length])];
    // NOTE - XCode bug: we need to set a stroke if we want to justify the text
    [attributedString addAttribute:NSStrokeColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, [attributedString length])];
    [attributedString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:0.0] range:NSMakeRange(0, [attributedString length])];
    // ------
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
    
    [self.quoteText setAttributedText:attributedString];
    
    

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
    
    // Autolayout ****
    self.heightMessageLblConstrain.constant = self.view.bounds.size.height/2-50;
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
    
//    TPMeasureCell *cell = (TPMeasureCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"segueLiveMeasureVC" sender:indexPath];
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
