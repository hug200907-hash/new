#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

extern bool FakeiOS;
NSString *const kFakeVersionKey = @"kFakeiOSVersion";
NSString *const kFakeBuildKey = @"kFakeiOSBuild";
NSString *const kFakeiOSStatusKey = @"kFakeiOSStatus";

// Hàm helper để lấy giá trị hiện tại
static NSString* getFakeVersion() {
    NSString *v = [[NSUserDefaults standardUserDefaults] stringForKey:kFakeVersionKey];
    return v ? v : @"18.0.0"; // Giá trị mặc định nếu chưa set
}

static NSString* getFakeBuild() {
    NSString *b = [[NSUserDefaults standardUserDefaults] stringForKey:kFakeBuildKey];
    return b ? b : @"22A100";
}

// Swizzling implementations
static NSString *rep_operatingSystemVersionString(id self, SEL _cmd) {
    return [NSString stringWithFormat:@"Version %@ (Build %@)", getFakeVersion(), getFakeBuild()];
}

static NSOperatingSystemVersion rep_operatingSystemVersion(id self, SEL _cmd) {
    NSArray *parts = [getFakeVersion() componentsSeparatedByString:@"."];
    NSOperatingSystemVersion v;
    v.majorVersion = parts.count > 0 ? [parts[0] integerValue] : 18;
    v.minorVersion = parts.count > 1 ? [parts[1] integerValue] : 0;
    v.patchVersion = parts.count > 2 ? [parts[2] integerValue] : 0;
    return v;
}

static NSString *rep_systemVersion(id self, SEL _cmd) {
    return getFakeVersion();
}

__attribute__((constructor)) static void init() {
if ([[NSUserDefaults standardUserDefaults] boolForKey:kFakeiOSStatusKey]) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class process = objc_getClass("NSProcessInfo");
        if (process) {
            method_setImplementation(class_getInstanceMethod(process, @selector(operatingSystemVersionString)), (IMP)rep_operatingSystemVersionString);
            method_setImplementation(class_getInstanceMethod(process, @selector(operatingSystemVersion)), (IMP)rep_operatingSystemVersion);
        }
        
        Class device = objc_getClass("UIDevice");
        if (device) {
            method_setImplementation(class_getInstanceMethod(device, @selector(systemVersion)), (IMP)rep_systemVersion);
        }
    });
}
}