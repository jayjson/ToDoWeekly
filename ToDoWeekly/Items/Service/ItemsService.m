#import <Foundation/Foundation.h>

#import "ItemsService.h"
#import "Item.h"

@implementation ItemsService

- (instancetype)init {
    if (self = [super init]) {
        self.lastIdUsed = @200; // Based on the expected API data
    }
    return self;
}

- (void)fetchItems:(void (^)(NSArray *, NSError *))completionBlock {
    NSString *endpointURL = @"https://jsonplaceholder.typicode.com/todos";
    NSURL *url = [[NSURL alloc] initWithString:endpointURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            completionBlock(nil, error);
        } else {
            NSError *error;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (!jsonArray) {
                completionBlock(nil, error);
            } else {
                NSMutableArray *toDoItems = [[NSMutableArray alloc] init];
                for (NSDictionary *toDoDict in jsonArray) {
                    Item *item = [[Item alloc] initWithDictionary:toDoDict];
                    [toDoItems addObject:item];
                }
                toDoItems = [[toDoItems sortedArrayUsingComparator:^NSComparisonResult(Item *item1, Item *item2) {
                    return [item2.id compare:item1.id];
                }] mutableCopy];
                completionBlock(toDoItems, nil);
            }
        }
    }];
    [task resume];
}

@end
