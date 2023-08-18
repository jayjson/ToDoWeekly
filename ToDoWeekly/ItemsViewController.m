#import "ItemsViewController.h"

@interface ItemsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                                  style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self configureNavBar];
}

- (void)configureNavBar {
    self.navigationItem.title = @"My To Do's";
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
        // TODO: Handle save request
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemCell"];
    }
    cell.textLabel.text = @"Hell world";
    return cell;
}

@end
