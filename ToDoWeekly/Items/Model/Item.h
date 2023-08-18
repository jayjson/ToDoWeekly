@interface Item : NSObject

@property NSNumber *userId;
@property NSNumber *id;
@property NSString *title;
@property BOOL completed;

- (instancetype)initWithNameAndId:(NSString *)name id:(NSNumber *)id;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
