#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

extern NSString * const __kHashDefaultValue;
extern NSString * const __contact;
extern NSString * const __Confirm;
extern NSString * const __Input;
extern NSString * const __kBaseURL;

@interface Unitoreios : NSObject

+ (void)paid:(void (^)(void))execute; 
+ (NSString *)getCurrentKey;
+ (NSString *)getRemainingTime;
@end