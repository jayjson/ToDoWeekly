#import "ItemsViewController.h"

#import "Item.h"
#import "ItemsService.h"

@interface ItemsViewController () <UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property NSMutableArray *items;
@property ItemsService *service;

@end

@implementation ItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.service = [[ItemsService alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                                  style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self configureNavBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.service fetchItems:^(NSArray *fetchedItems, NSError *error) {
        if (error) {
            NSLog(@"Failed to fetch items... Detail: %@", error);
        } else if (fetchedItems) {
            NSMutableArray *startingItems = (NSMutableArray *)fetchedItems;
            self.items = startingItems;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"Both fetchedItems and error are nil.");
        }
    }];
}

- (void)configureNavBar {
    self.navigationItem.title = @"Remaining Tasks";
    UIImage *image = [UIImage systemImageNamed:@"plus"];
    UIBarButtonItem *plusBarButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(handleTapOnPlusButton)];
    self.navigationItem.rightBarButtonItem = plusBarButton;
}

- (void)handleTapOnPlusButton {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add a new to do item" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Describe the new task";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *name = alertController.textFields[0].text;
        NSInteger lastIdUsed = [self.service.lastIdUsed integerValue];
        NSNumber *newId = @(lastIdUsed + 1);
        self.service.lastIdUsed = newId;
        Item *newItem = [[Item alloc] initWithNameAndId:name id:newId];
        [self.items insertObject:newItem atIndex:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemCell"];
    }
    Item *item = self.items[indexPath.row];
    NSString *title = [NSString stringWithFormat:@"Task No. %@: %@", item.id, item.title];
    cell.textLabel.text = title;
    
    if (item.completed == true) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

@end
