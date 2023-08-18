#import <Foundation/Foundation.h>

#import "Item.h"

@implementation Item

- (instancetype)initWithNameAndId:(NSString *)name id:(NSNumber *)id {
    if (self = [super init]) {
        self.title = name;
        self.userId = @1;
        self.id = id;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self.userId = dict[@"userId"];
    self.id = dict[@"id"];
    self.title = dict[@"title"];
    NSNumber *completedNumber = dict[@"completed"];
    self.completed = [completedNumber boolValue];
    return self;
}

@end
