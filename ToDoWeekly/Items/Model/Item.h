@interface Item : NSObject

@property NSString *name;

- (instancetype)initWithName: (NSString *)name;

+ (NSArray *)fetchItems;

@end
