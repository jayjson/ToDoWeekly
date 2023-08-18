#import <Foundation/Foundation.h>

#import "Item.h"

@implementation Item

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}

+ (NSArray *)fetchItems {
    return @[
        [[Item alloc] initWithName:@"Meditate"],
        [[Item alloc] initWithName:@"Exercise"],
        [[Item alloc] initWithName:@"Eat supplements"]
    ];
}

@end
