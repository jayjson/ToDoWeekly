#import "ItemsViewController.h"

#import "Item.h"

@interface ItemsViewController () <UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property NSMutableArray *items;

@end

@implementation ItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *startingItems = [Item fetchItems];
    self.items = [[NSMutableArray alloc] initWithArray:startingItems];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                                  style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self configureNavBar];
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
        Item *newItem = [[Item alloc] initWithName:name];
        [self.items addObject:newItem];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.items.count-1 inSection:0];
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
    NSString *title = item.name;
    cell.textLabel.text = title;
    return cell;
}

@end
