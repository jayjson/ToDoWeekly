@interface ItemsService : NSObject

@property (nonatomic, strong) NSNumber *lastIdUsed;

- (void)fetchItems :(void (^)(NSArray *, NSError *))completionBlock;

@end
