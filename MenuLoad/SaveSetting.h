
#import <Foundation/Foundation.h>

@interface SaveSetting : NSObject

+ (instancetype)shared;

- (void)saveBool:(BOOL)value forKey:(NSString *)key;
- (BOOL)loadBoolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;

- (void)saveInt:(NSInteger)value forKey:(NSString *)key;
- (NSInteger)loadIntForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;

- (void)saveFloat:(float)value forKey:(NSString *)key;
- (float)loadFloatForKey:(NSString *)key defaultValue:(float)defaultValue;

@end
