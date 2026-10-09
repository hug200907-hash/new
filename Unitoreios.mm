#import "Unitoreios.h"
#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import <SafariServices/SafariServices.h>
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonCrypto.h>
#import <SystemConfiguration/SystemConfiguration.h>
#include <sys/utsname.h>
#import <Security/Security.h>
#import <UserNotifications/UserNotifications.h> 
 
#import "encrypt.h"
#include <sys/sysctl.h>
#include <sys/types.h>
#include <unistd.h>
// Sử dụng __kBaseURL từ hash.mm
NSString * const __kCheckKeyURLFormat = NSSENCRYPT("%@/Cheack.php?key=%@&uuid=%@&hash=%@");
NSString * const __kCheckKeyUDIDURLFormat = NSSENCRYPT("%@/Cheack2.php?key=%@&udid=%@&hash=%@&uuid=%@");
NSString * const __kContactURLFormat = NSSENCRYPT("%@/debcontact.php?hash=%@");
NSString * const __kUDIDURLFormat = NSSENCRYPT("%@/UDID.php?uuid=%@");
NSString * const __kCheckUDIDURLFormat = NSSENCRYPT("%@/REQ.php?uuid=%@&hash=%@");

// *** Mã hóa Key và IV (thay thế bằng key và IV của bạn) ***
NSString * const kKeyEncoded = NSSENCRYPT("dW5pdG9yZWlvc19hcGlfa2V5XzIwMjZfdW5pdG9yZWk=");
NSString * const kIVEncoded = NSSENCRYPT("VW5pdG9yZWlvc0lWMjAyNg==");

NSString * const encodestring = NSSENCRYPT("odsugddhwxbc==");
NSString *encodedcode;

// Unitoreios API crypto (must match vipp/layouts/unitoreios_crypto.php)
static NSString * const UNITOREIOS_AES_KEY = NSSENCRYPT("unitoreios_api_key_2026_unitorei");
static NSString * const UNITOREIOS_AES_IV  = NSSENCRYPT("UnitoreiosIV2026");

// -------------------- Unitoreios sync helpers --------------------
static NSString *UnitoreiosReadPref(NSString *key) {
    CFPropertyListRef value = CFPreferencesCopyAppValue((__bridge CFStringRef)key, CFSTR("com.unitoreios.key"));
    if (!value) return nil;
    id obj = CFBridgingRelease(value);
    if ([obj isKindOfClass:[NSString class]]) return (NSString *)obj;
    return [obj description];
}

static NSString *UnitoreiosTrim(NSString *s) {
    if (!s) return nil;
    NSString *t = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return (t.length > 0) ? t : nil;
}

static NSString *UnitoreiosNormalizeBaseURL(NSString *baseURL) {
    NSString *u = UnitoreiosTrim(baseURL);
    if (!u) return nil;

    // Nếu người dùng nhập thiếu scheme -> mặc định https
    if (![u hasPrefix:@"http://"] && ![u hasPrefix:@"https://"]) {
        u = [@"https://" stringByAppendingString:u];
    }

    // Bỏ dấu / cuối để tránh //Cheack.php
    while ([u hasSuffix:@"/"] && u.length > 8) {
        u = [u substringToIndex:u.length - 1];
    }
    return u;
}

static NSString *UnitoreiosExtractURLFromString(NSString *s) {
    NSString *t = UnitoreiosTrim(s);
    if (!t) return nil;
    // Cho phép người dùng nhét URL vào DebHash dạng: "<hash>|https://apiunitoreios.site/"
    NSRange r1 = [t rangeOfString:@"http://" options:NSCaseInsensitiveSearch];
    NSRange r2 = [t rangeOfString:@"https://" options:NSCaseInsensitiveSearch];
    NSRange r = (r1.location == NSNotFound) ? r2 : ((r2.location == NSNotFound) ? r1 : ((r1.location < r2.location) ? r1 : r2));
    if (r.location == NSNotFound) return nil;
    NSString *urlPart = [t substringFromIndex:r.location];
    // cắt tới khoảng trắng nếu có
    NSRange ws = [urlPart rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (ws.location != NSNotFound) urlPart = [urlPart substringToIndex:ws.location];
    return UnitoreiosNormalizeBaseURL(urlPart);
}

static NSString *UnitoreiosExtractHashFromString(NSString *s) {
    NSString *t = UnitoreiosTrim(s);
    if (!t) return nil;
    // Nếu có URL, hash là phần trước URL (cắt theo | hoặc khoảng trắng)
    NSString *url = UnitoreiosExtractURLFromString(t);
    if (!url) return t;

    // Ưu tiên split theo |
    NSArray<NSString *> *parts = [t componentsSeparatedByString:@"|"];
    for (NSString *p in parts) {
        NSString *pp = UnitoreiosTrim(p);
        if (!pp) continue;
        if ([pp rangeOfString:@"http" options:NSCaseInsensitiveSearch].location == NSNotFound) {
            return pp;
        }
    }
    // Fallback: lấy token đầu tiên
    NSRange sp = [t rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (sp.location != NSNotFound) return UnitoreiosTrim([t substringToIndex:sp.location]);
    return t;
}

static NSString *UnitoreiosURLEncode(NSString *s) {
    if (!s) return @"";
    NSCharacterSet *allowed = [NSCharacterSet URLQueryAllowedCharacterSet];
    return [s stringByAddingPercentEncodingWithAllowedCharacters:allowed] ?: @"";
}
// ----------------------------------------------------------------

NSString * decodeKeyOrIV(NSString *encodedString) {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:encodedString options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];

    NSMutableArray *asciiValues = [NSMutableArray array];
    for (NSInteger i = 0; i < decodedString.length; i++) {
        unichar character = [decodedString characterAtIndex:i];
        [asciiValues addObject:@((int)character)];
    }

    for (NSInteger i = 0; i < asciiValues.count; i++) {
        int asciiValue = [asciiValues[i] intValue];
        asciiValues[i] = @(asciiValue - 2306); 
    }

    NSMutableString *resultString = [NSMutableString string];
    for (NSNumber *asciiValue in asciiValues) {
        [resultString appendFormat:@"%c", [asciiValue intValue]];
    }

    NSMutableString *shiftedString = [NSMutableString string];
    for (NSInteger i = 0; i < resultString.length; i++) {
        unichar character = [resultString characterAtIndex:i];
        unichar shiftedChar = character - 1; 
        [shiftedString appendFormat:@"%c", shiftedChar];
    }

    return shiftedString;
}

// Giải mã kKey và kIV để lấy giá trị gốc
NSString * const kKey = decodeKeyOrIV(kKeyEncoded);
NSString * const kIV = decodeKeyOrIV(kIVEncoded);

// Function to decrypt AES-CBC-PKCS7 encrypted string
NSString * decryptAES(NSString *encryptedString, NSString *key, NSString *iv) {
    NSData *encryptedData = [[NSData alloc] initWithBase64EncodedString:encryptedString options:0];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivData = [iv dataUsingEncoding:NSUTF8StringEncoding];

    size_t dataOutAvailable = [encryptedData length] + kCCBlockSizeAES128;
    void *dataOut = malloc(dataOutAvailable);
    size_t dataOutMoved = 0;

    CCCryptorStatus result = CCCrypt(kCCDecrypt,
                                     kCCAlgorithmAES,
                                     kCCOptionPKCS7Padding,
                                     [keyData bytes],
                                     kCCKeySizeAES256,
                                     [ivData bytes],
                                     [encryptedData bytes],
                                     [encryptedData length],
                                     dataOut,
                                     dataOutAvailable,
                                     &dataOutMoved);

    if (result == kCCSuccess) {
        NSData *decryptedData = [NSData dataWithBytesNoCopy:dataOut length:dataOutMoved];
        return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    }

    free(dataOut);
    return nil;
}

@interface Unitoreios () <SFSafariViewControllerDelegate, UNUserNotificationCenterDelegate>
@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, assign) NSInteger countdownSeconds;
@property (nonatomic, strong) NSTimer *countdownTimer;
@property (nonatomic, assign) NSInteger failedKeyAttempts;
@property (nonatomic, assign) BOOL hasShownSuccessAlert;
@property (nonatomic, strong) NSString *previousNetworkStatus;
@property (nonatomic, strong) NSString *savedUDID;
@property (nonatomic, assign) BOOL hasUDID;
@property (nonatomic, assign) BOOL isUDIDModeEnabled;
@property (nonatomic, strong) NSTimer *updateTimer;
@property (nonatomic, strong) NSString *lastRemainingTime; // Lưu thời gian còn lại cuối cùng
@property (nonatomic, assign) NSInteger remainingSeconds;

- (void)checkUDIDExistence:(NSString *)udid completion:(void (^)(BOOL valid))completion;
@end

@implementation Unitoreios

- (NSString *)effectiveBaseURL {
    // Hỗ trợ nhiều key để tránh mismatch khi user cấu hình
    NSArray<NSString *> *keys = @[
        NSSENCRYPT("BaseURL"),
        NSSENCRYPT("baseURL"),
        NSSENCRYPT("base_url"),
        NSSENCRYPT("server"),
        NSSENCRYPT("Server"),
        NSSENCRYPT("ServerURL")
    ];
    for (NSString *k in keys) {
        NSString *v = UnitoreiosNormalizeBaseURL(UnitoreiosReadPref(k));
        if (v) return v;
    }

    // Nếu người dùng chỉ set DebHash nhưng nhét kèm URL: "hash|https://apiunitoreios.site/"
    NSString *debRaw = UnitoreiosReadPref(NSSENCRYPT("DebHash"));
    NSString *urlFromDeb = UnitoreiosExtractURLFromString(debRaw);
    if (urlFromDeb) return urlFromDeb;

    return UnitoreiosNormalizeBaseURL(__kBaseURL) ?: __kBaseURL;
}

- (NSString *)effectiveDebHash {
    NSArray<NSString *> *keys = @[
        NSSENCRYPT("DebHash"),
        NSSENCRYPT("debhash"),
        NSSENCRYPT("hash"),
        NSSENCRYPT("PackageHash")
    ];
    for (NSString *k in keys) {
        NSString *v = UnitoreiosTrim(UnitoreiosReadPref(k));
        if (v) return UnitoreiosExtractHashFromString(v);
    }
    return UnitoreiosExtractHashFromString(__kHashDefaultValue) ?: __kHashDefaultValue;
}

- (BOOL)isBaseURLConfigured:(NSString *)baseURL {
    if (!baseURL || baseURL.length == 0) return NO;
    NSString *u = [baseURL lowercaseString];
    if ([u containsString:@"example.com"]) return NO;
    if ([u containsString:@"your_domain"]) return NO;
    return ([u hasPrefix:@"http://"] || [u hasPrefix:@"https://"]);
}

- (NSString *)fallbackHTTPBaseURLIfNeeded:(NSString *)baseURL {
    if (!baseURL) return nil;
    if ([baseURL hasPrefix:@"https://"]) {
        return [@"http://" stringByAppendingString:[baseURL substringFromIndex:8]];
    }
    return nil;
}

static Unitoreios *extraInfo;

NSString *keyValidationStatus; 
NSString *iskey;

NSInteger timeCD = 60;
NSInteger remainingSeconds1;
+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        extraInfo = [Unitoreios new];
        [[NSNotificationCenter defaultCenter] addObserver:extraInfo
                                                 selector:@selector(applicationWillEnterForeground)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];

        // Kiểm tra kết nối và request UDID
        [extraInfo checkAndRequestUDIDIfNeeded];
    });
}
void detectDebugger() {

    int mib[4];
    struct kinfo_proc info;
    size_t size = sizeof(info);

    mib[0] = CTL_KERN;
    mib[1] = KERN_PROC;
    mib[2] = KERN_PROC_PID;
    mib[3] = getpid();

    info.kp_proc.p_flag = 0;
    sysctl(mib, 4, &info, &size, NULL, 0);

    if (info.kp_proc.p_flag & P_TRACED) {
    NSLog(@"Debugger detected. Exiting.");
    exit(0);
    }

}
- (void)applicationWillEnterForeground {
    if (self.hasShownSuccessAlert) {
        return;
    }
    detectDebugger();
    [self checkAndRequestUDIDIfNeeded];
    [self checkKey];
}

- (void)sendNotificationWithTitle:(NSString *)title body:(NSString *)body {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.body = body;
    content.sound = [UNNotificationSound defaultSound];

    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.1 repeats:NO];

    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:NSSENCRYPT("MyNotification") content:content trigger:trigger];

    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error sending notification: %@", error.localizedDescription);
        }
    }];
}

- (void)checkAndRequestUDIDIfNeeded {
    NSString *savedUDID = [[NSUserDefaults standardUserDefaults] objectForKey:NSSENCRYPT("savedUDID")];
    self.savedUDID = savedUDID;

    [self checkUDIDStatusFromServer:^(NSInteger statusUDID) {
        if (statusUDID == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showGetUDIDAlert];
            });
        } else if (statusUDID == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.hasUDID = NO;
                self.isUDIDModeEnabled = false;
                [self checkKey];
            });
        } else if (statusUDID == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.hasUDID = YES;
                self.isUDIDModeEnabled = true;
                [self checkKey];
            });
        }
    }];
}

- (void)checkUDIDStatusFromServer:(void (^)(NSInteger statusUDID))completion {
    NSString *uuid = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    NSString *hash = [self effectiveDebHash];
    NSString *baseURL = [self effectiveBaseURL];

    // Nếu chưa cấu hình BaseURL/DebHash thì báo rõ (tránh báo "không kết nối" mơ hồ)
    if (![self isBaseURLConfigured:baseURL] || !hash || hash.length == 0 || [hash containsString:@"CHANGE_ME"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlertWithTitle:NSSENCRYPT("Lỗi cấu hình")
                            message:NSSENCRYPT("Chưa cấu hình BaseURL/DebHash cho API Unitoreios.\n\nCách set nhanh:\n- Tạo /var/mobile/Library/Preferences/com.unitoreios.key.plist\n- BaseURL = https://apiunitoreios.site/")
                         shouldExit:YES];
        });
        completion(-1);
        return;
    }

    NSString *urlString = [NSString stringWithFormat:__kCheckUDIDURLFormat, baseURL, UnitoreiosURLEncode(uuid), UnitoreiosURLEncode(hash)];
    NSURL *url = [NSURL URLWithString:urlString];

    NSString *savedKey = [[NSUserDefaults standardUserDefaults] objectForKey:NSSENCRYPT("savedKey")];

    __block BOOL didRetry = NO;
    __block void (^runRequest)(NSURL *u) = nil;
    __weak __block void (^weakRunRequest)(NSURL *u) = nil;
    runRequest = ^(NSURL *u) {
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:u
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                // Fallback: nếu server chỉ hỗ trợ http (không SSL), tự retry 1 lần
                if (!didRetry) {
                    NSString *httpBase = [self fallbackHTTPBaseURLIfNeeded:baseURL];
                    if (httpBase) {
                        didRetry = YES;
                        NSString *retryURLString = [NSString stringWithFormat:__kCheckUDIDURLFormat, httpBase, UnitoreiosURLEncode(uuid), UnitoreiosURLEncode(hash)];
                        NSURL *retryURL = [NSURL URLWithString:retryURLString];
                        if (retryURL) { if (weakRunRequest) weakRunRequest(retryURL); return; }
                    }
                }
                [self showAlertWithTitle:NSSENCRYPT("Lỗi") message:NSSENCRYPT("Không thể kết nối đến server. Vui lòng thử lại sau.") shouldExit:YES];
                completion(-1);
                return;
            }

        // REQ.php response is AES-256-CBC encrypted (base64 string)
        NSString *decrypted = [self decryptAESData:data key:UNITOREIOS_AES_KEY iv:UNITOREIOS_AES_IV];
        if (!decrypted || decrypted.length == 0) {
            [self showAlertWithTitle:NSSENCRYPT("Lỗi") message:NSSENCRYPT("Phản hồi server không hợp lệ.") shouldExit:YES];
            completion(-1);
            return;
        }

        NSError *jsonError = nil;
        NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:[decrypted dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:0
                                                              error:&jsonError];
        if (jsonError || ![resp isKindOfClass:[NSDictionary class]]) {
            [self showAlertWithTitle:NSSENCRYPT("Lỗi") message:NSSENCRYPT("Không đọc được dữ liệu (decrypt/JSON).") shouldExit:YES];
            completion(-1);
            return;
        }

        NSDictionary *dataObj = resp[NSSENCRYPT("data")];
        NSInteger statusUDID = [dataObj[NSSENCRYPT("statusUDID")] integerValue];
        NSString *udid = dataObj[NSSENCRYPT("udid")];
        NSString *keyUDID = dataObj[NSSENCRYPT("keyUDID")];

        // statusUDID:
        // 0 = package không yêu cầu UDID
        // 1 = package yêu cầu UDID
        if (statusUDID == 0) {
            self.hasUDID = NO;
            self.isUDIDModeEnabled = NO;
            completion(0);
            return;
        }

        // statusUDID == 1
        self.isUDIDModeEnabled = YES;
        if (udid && udid.length > 0) {
            // Đã có UDID
            [[NSUserDefaults standardUserDefaults] setObject:udid forKey:NSSENCRYPT("savedUDID")];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.savedUDID = udid;
            self.hasUDID = YES;

            // Nếu server trả keyUDID và máy chưa lưu key, auto lưu
            if (!savedKey && keyUDID && keyUDID.length > 0) {
                [[NSUserDefaults standardUserDefaults] setObject:keyUDID forKey:NSSENCRYPT("savedKey")];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }

            completion(2);
        } else {
            // Chưa có UDID -> cần lấy UDID
            self.hasUDID = NO;
            completion(1);
        }
        }];
        [task resume];
    };

    weakRunRequest = runRequest;
    runRequest(url);
}

- (void)checkUDIDExistence:(NSString *)udid completion:(void (^)(BOOL valid))completion {
    // Với server Unitoreios: chỉ cần gọi REQ.php (uuid+hash) để biết đã có UDID hay chưa.
    NSString *uuid = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    NSString *hash = [self effectiveDebHash];
    NSString *baseURL = [self effectiveBaseURL];

    NSString *urlString = [NSString stringWithFormat:__kCheckUDIDURLFormat, baseURL, UnitoreiosURLEncode(uuid), UnitoreiosURLEncode(hash)];
    NSURL *url = [NSURL URLWithString:urlString];

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(NO);
            return;
        }

        NSString *decrypted = [self decryptAESData:data key:UNITOREIOS_AES_KEY iv:UNITOREIOS_AES_IV];
        if (!decrypted || decrypted.length == 0) {
            completion(NO);
            return;
        }

        NSError *jsonError = nil;
        NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:[decrypted dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:0
                                                              error:&jsonError];
        if (jsonError || ![resp isKindOfClass:[NSDictionary class]]) {
            completion(NO);
            return;
        }

        NSDictionary *dataObj = resp[NSSENCRYPT("data")];
        NSString *udidFromServer = dataObj[NSSENCRYPT("udid")];
        completion(udidFromServer && udidFromServer.length > 0);
    }];

    [task resume];
}

- (void)showGetUDIDAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSSENCRYPT("Get UDID")
                                                                             message:NSSENCRYPT("Vui lòng lấy UDID để tiếp tục.")
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *guideAction = [UIAlertAction actionWithTitle:NSSENCRYPT("Hướng Dẫn")
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
        [self openHelpURL];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            exit(0);
        });
    }];

    UIAlertAction *getUDIDAction = [UIAlertAction actionWithTitle:NSSENCRYPT("Lấy UDID")
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        [self openGetUDIDURL];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            exit(0);
        });
    }];

    [alertController addAction:guideAction];
    [alertController addAction:getUDIDAction];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)openHelpURL {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: NSSENCRYPT("https://t.me/APIserie")]];
    });
}

- (void)openGetUDIDURL {
    NSString *uuid = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    NSString *baseURL = [self effectiveBaseURL];
    NSString *urlString = [NSString stringWithFormat:__kUDIDURLFormat, baseURL, UnitoreiosURLEncode(uuid)];
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)checkKey {
    NSString *savedKey = [[NSUserDefaults standardUserDefaults] objectForKey:NSSENCRYPT("savedKey")];

    if (savedKey) {
        if (!self.hasShownSuccessAlert) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                

                if (self.isUDIDModeEnabled) {
                    [self checkKeyExistenceUDID:savedKey];
                } else {
                    [self checkKeyExistence:savedKey];
                }
            });
        }
    } else {
        [self presentKeyInputAlert];
    }
}

- (void)presentKeyInputAlert {
    if (self.alertController.presentingViewController) {
        return;
    }

    NSString *hash = [self effectiveDebHash];
    NSString *baseURL = [self effectiveBaseURL];
    NSString *urlString = [NSString stringWithFormat:__kContactURLFormat, baseURL, UnitoreiosURLEncode(hash)];
    NSURL *contactURL = [NSURL URLWithString:urlString];

    if (contactURL) {
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:contactURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                [self showAlertWithTitle:NSSENCRYPT("ERROR") message:NSSENCRYPT("Vui lòng kết nối lại mạng") shouldExit:YES];
                return;
            }

            NSError *jsonError;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (jsonError) {
                [self showAlertWithTitle:NSSENCRYPT("ERROR") message:NSSENCRYPT("JSON ERROR") shouldExit:YES];
                return;
            }

            NSString *title = responseDict[NSSENCRYPT("nolicaftions")];
            NSInteger colorCode = [responseDict[NSSENCRYPT("colorcode")] integerValue];
            UIColor *titleColor = [self colorFromCode:colorCode];

            dispatch_async(dispatch_get_main_queue(), ^{
                UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;

                self.alertController = [UIAlertController alertControllerWithTitle:nil
                                                                           message:nil
                                                                    preferredStyle:UIAlertControllerStyleAlert];

                if (titleColor) {
                    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:title];
                    [attributedTitle addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0, attributedTitle.length)];
                    [attributedTitle addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:24] range:NSMakeRange(0, attributedTitle.length)];
                    [self.alertController setValue:attributedTitle forKey:NSSENCRYPT("attributedTitle")];
                }

                self.alertController.message = NSSENCRYPT("Vui lòng nhập key trong vòng 1 phút để tiếp tục sử dụng dịch vụ");

                [self.alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    textField.placeholder = __Input;
                    textField.secureTextEntry = YES;
                }];

                UIAlertAction *contactAction = [UIAlertAction actionWithTitle:__contact style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSString *hash = [self effectiveDebHash];
                    NSString *baseURL = [self effectiveBaseURL];
                    NSString *urlString = [NSString stringWithFormat:__kContactURLFormat, baseURL, UnitoreiosURLEncode(hash)];
                    NSURL *contactURL = [NSURL URLWithString:urlString];

                    if (contactURL) {
                        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:contactURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            if (error) {
                                NSLog(@"Error: %@", error.localizedDescription);
                                return;
                            }

                            NSError *jsonError;
                            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                            if (jsonError) {
                                NSLog(@"JSON Error: %@", jsonError.localizedDescription);
                                return;
                            }

                            NSString *contactURLString = responseDict[NSSENCRYPT("contact")];
                            NSURL *contactURL = [NSURL URLWithString:contactURLString];
                            if (contactURL) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:contactURL];
                                    safariViewController.delegate = self;
                                    [rootViewController presentViewController:safariViewController animated:YES completion:nil];
                                });
                            } else {
                                NSLog(@"Invalid contact URL");
                            }
                        }];
                        [task resume];
                    } else {
                        NSLog(@"Invalid URL");
                    }
                }];

                // Thay đổi màu chữ của nút Liên hệ thành màu đỏ
                [contactAction setValue:[UIColor redColor] forKey:@"titleTextColor"]; 

                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:__Confirm style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self stopCountdownTimer];
                    UITextField *textField = self.alertController.textFields.firstObject;
                    NSString *key = textField.text;

                    if (self.hasUDID && self.savedUDID) {
                        [self checkKeyExistenceUDID:key];
                    } else {
                        [self checkKeyExistence:key];
                    }
                }];

                [self.alertController addAction:contactAction];
                [self.alertController addAction:confirmAction];

                [rootViewController presentViewController:self.alertController animated:YES completion:nil];

                self.countdownSeconds = 60;
                self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats:YES];
            });
        }];
        [task resume];
    } else {
        NSLog(@"Invalid URL");
    }
}

- (void)updateCountdown {
    self.countdownSeconds--;
    if (self.countdownSeconds <= 0) {
        [self stopCountdownTimer];
        [self.alertController dismissViewControllerAnimated:YES completion:^{
            exit(0);
        }];
    } else {
        NSInteger minutes = (self.countdownSeconds % (60 * 60)) / 60;
        NSInteger seconds = self.countdownSeconds % 60;

        NSString *message = [NSString stringWithFormat:NSSENCRYPT("Ứng dụng thoát sau %ld phút %ld giây, Nhập key để tiếp tục"), (long)minutes, (long)seconds];
        self.alertController.message = message;
    }
}

- (void)stopCountdownTimer {
    [self.countdownTimer invalidate];
    self.countdownTimer = nil;
}

- (void)checkKeyExistence:(NSString *)key {

    NSString *uuid = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    NSString *hash = [self effectiveDebHash];
    NSString *baseURL = [self effectiveBaseURL];

    if (![self isBaseURLConfigured:baseURL] || !hash || hash.length == 0 || [hash containsString:@"CHANGE_ME"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlertWithTitle:NSSENCRYPT("Lỗi cấu hình")
                            message:NSSENCRYPT("Chưa cấu hình BaseURL/DebHash cho API Unitoreios.\n\nCách set nhanh:\n- Tạo /var/mobile/Library/Preferences/com.unitoreios.key.plist\n- BaseURL = https://apiunitoreios.site/")
                         shouldExit:YES];
        });
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSSENCRYPT("savedKey")];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }

    __block BOOL didRetry = NO;

    __block void (^runRequest)(NSString *baseURLToUse) = nil;
    __weak __block void (^weakRunRequest)(NSString *baseURLToUse) = nil;
    runRequest = ^(NSString *baseURLToUse) {
        NSString *urlString = [NSString stringWithFormat:__kCheckKeyURLFormat,
                               baseURLToUse,
                               UnitoreiosURLEncode(key),
                               UnitoreiosURLEncode(uuid),
                               UnitoreiosURLEncode(hash)];
        NSURL *url = [NSURL URLWithString:urlString];
        if (!url) {
            [self showAlertWithTitle:NSSENCRYPT("ERROR") message:NSSENCRYPT("BaseURL không hợp lệ.") shouldExit:NO];
            return;
        }

        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

            if (error) {
                if (!didRetry) {
                    NSString *httpBase = [self fallbackHTTPBaseURLIfNeeded:baseURLToUse];
                    if (httpBase) {
                        didRetry = YES;
                        if (weakRunRequest) weakRunRequest(httpBase);
                        return;
                    }
                }

                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:NSSENCRYPT("ERROR")
                                    message:NSSENCRYPT("Không thể kết nối đến server. Kiểm tra BaseURL/SSL (http/https) rồi thử lại.")
                                 shouldExit:NO];
                });
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSSENCRYPT("savedKey")];
                [[NSUserDefaults standardUserDefaults] synchronize];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    exit(0);
                });
                return;
            }

            NSString *decryptedData = [self decryptAESData:data key:UNITOREIOS_AES_KEY iv:UNITOREIOS_AES_IV];

            if (!decryptedData) {
                [self showAlertWithTitle:NSSENCRYPT("ERROR") message:NSSENCRYPT("Key đã hết hạn hoặc sai") shouldExit:NO];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSSENCRYPT("savedKey")];
                [[NSUserDefaults standardUserDefaults] synchronize];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self presentKeyInputAlert];
                });
                return;
            }

            NSError *jsonError;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:[decryptedData dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&jsonError];

            if (jsonError) {
                [self showAlertWithTitle:NSSENCRYPT("ERROR") message:NSSENCRYPT("Key đã hết hạn hoặc sai") shouldExit:NO];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSSENCRYPT("savedKey")];
                [[NSUserDefaults standardUserDefaults] synchronize];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self presentKeyInputAlert];
                });
                return;
            }

            NSString *status = responseDict[NSSENCRYPT("trangthaikey")];
            if ([status isEqualToString:NSSENCRYPT("successfully")]) {
                NSString *serverTimeString = responseDict[NSSENCRYPT("timer")];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = NSSENCRYPT("yyyy-MM-dd HH:mm:ss");
                NSDate *serverTime = [dateFormatter dateFromString:serverTimeString];

                if (serverTime) {
                    NSDate *currentTime = [NSDate date];
                    NSTimeInterval timeDifference = [currentTime timeIntervalSinceDate:serverTime];

                    if (fabs(timeDifference) > 5) {
                        [self showAlertWithTitle:NSSENCRYPT("Lỗi") message:NSSENCRYPT("Thời gian không đồng bộ với server. Vui lòng thử lại") shouldExit:YES];
                        return;
                    }

                    NSInteger remainingSeconds = [responseDict[NSSENCRYPT("encypttimerkey")] integerValue];
                    if (remainingSeconds == 0) {
                        NSString *errorMessage = responseDict[NSSENCRYPT("messenger")] ?: NSSENCRYPT("Key đã hết hạn! Vui lòng liên hệ với quản trị viên để nhận mã khóa mới!");
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSSENCRYPT("savedKey")];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self showAlertWithTitle:errorMessage message:nil shouldExit:YES];
                        });
                    } else {
                        extraInfo.remainingSeconds = remainingSeconds;
                        NSInteger days = remainingSeconds / (60 * 60 * 24);
                        remainingSeconds %= (60 * 60 * 24);
                        NSInteger hours = remainingSeconds / (60 * 60);
                        remainingSeconds %= (60 * 60);
                        NSInteger minutes = remainingSeconds / 60;
                        remainingSeconds %= 60;
                        NSString *message1 = [NSString stringWithFormat:NSSENCRYPT("\nDevice: Iphone %@"), [self deviceType]];
                        NSString *message2 = [NSString stringWithFormat:NSSENCRYPT("Thời hạn sử dụng: %ld ngày, %ld giờ, %ld phút, %ld giây"), (long)days, (long)hours, (long)minutes, (long)remainingSeconds];

                        [[NSUserDefaults standardUserDefaults] setObject:key forKey:NSSENCRYPT("savedKey")];
                        [[NSUserDefaults standardUserDefaults] synchronize];

                        [self startUpdateTimer];

                        keyValidationStatus = NSSENCRYPT("validated");
                        encodedcode = encodestring;
                        iskey = key;

                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self showSuccessAlertWithMessage:message1 message2:message2];
                            self.failedKeyAttempts = 0;
                            self.hasShownSuccessAlert = YES;
                        });
                    }
                }
            } else {
                NSString *errorMessage = responseDict[NSSENCRYPT("messenger")] ?: NSSENCRYPT("Key đã hết hạn hoặc sai");
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSSENCRYPT("savedKey")];
                [[NSUserDefaults standardUserDefaults] synchronize];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:NSSENCRYPT("ERROR") message:errorMessage shouldExit:NO];
                });
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self presentKeyInputAlert];
                });
            }
        }];

        [task resume];
    };

    weakRunRequest = runRequest;
    runRequest(baseURL);
}


- (void)checkKeyExistenceUDID:(NSString *)key {

    NSString *uuid = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    NSString *udid = self.savedUDID;
    NSString *hash = [self effectiveDebHash];
    NSString *baseURL = [self effectiveBaseURL];

    if (![self isBaseURLConfigured:baseURL] || !hash || hash.length == 0 || [hash containsString:@"CHANGE_ME"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlertWithTitle:NSSENCRYPT("Lỗi cấu hình")
                            message:NSSENCRYPT("Chưa cấu hình BaseURL/DebHash cho API Unitoreios.\n\nCách set nhanh:\n- Tạo /var/mobile/Library/Preferences/com.unitoreios.key.plist\n- BaseURL = https://apiunitoreios.site/")
                         shouldExit:YES];
        });
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSSENCRYPT("savedKey")];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }

    __block BOOL didRetry = NO;

    __block void (^runRequest)(NSString *baseURLToUse) = nil;
    __weak __block void (^weakRunRequest)(NSString *baseURLToUse) = nil;
    runRequest = ^(NSString *baseURLToUse) {
        NSString *urlString = [NSString stringWithFormat:__kCheckKeyUDIDURLFormat,
                               baseURLToUse,
                               UnitoreiosURLEncode(key),
                               UnitoreiosURLEncode(udid ?: @""),
                               UnitoreiosURLEncode(hash),
                               UnitoreiosURLEncode(uuid)];
        NSURL *url = [NSURL URLWithString:urlString];
        if (!url) {
            [self showAlertWithTitle:NSSENCRYPT("ERROR") message:NSSENCRYPT("BaseURL không hợp lệ.") shouldExit:NO];
            return;
        }

        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

            if (error) {
                if (!didRetry) {
                    NSString *httpBase = [self fallbackHTTPBaseURLIfNeeded:baseURLToUse];
                    if (httpBase) {
                        didRetry = YES;
                        if (weakRunRequest) weakRunRequest(httpBase);
                        return;
                    }
                }

                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:NSSENCRYPT("ERROR")
                                    message:NSSENCRYPT("Không thể kết nối đến server. Kiểm tra BaseURL/SSL (http/https) rồi thử lại.")
                                 shouldExit:NO];
                });
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSSENCRYPT("savedKey")];
                [[NSUserDefaults standardUserDefaults] synchronize];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    exit(0);
                });
                return;
            }

            NSString *decryptedData = [self decryptAESData:data key:UNITOREIOS_AES_KEY iv:UNITOREIOS_AES_IV];

            if (!decryptedData) {
                [self showAlertWithTitle:NSSENCRYPT("ERROR") message:NSSENCRYPT("Key đã hết hạn hoặc sai") shouldExit:NO];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSSENCRYPT("savedKey")];
                [[NSUserDefaults standardUserDefaults] synchronize];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self presentKeyInputAlert];
                });
                return;
            }

            NSError *jsonError;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:[decryptedData dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&jsonError];

            if (jsonError) {
                [self showAlertWithTitle:NSSENCRYPT("ERROR") message:NSSENCRYPT("Key đã hết hạn hoặc sai") shouldExit:NO];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSSENCRYPT("savedKey")];
                [[NSUserDefaults standardUserDefaults] synchronize];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self presentKeyInputAlert];
                });
                return;
            }

            NSString *status = responseDict[NSSENCRYPT("trangthaikey")];
            if ([status isEqualToString:NSSENCRYPT("successfully")]) {
                NSString *serverTimeString = responseDict[NSSENCRYPT("timer")];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = NSSENCRYPT("yyyy-MM-dd HH:mm:ss");
                NSDate *serverTime = [dateFormatter dateFromString:serverTimeString];

                if (serverTime) {
                    NSDate *currentTime = [NSDate date];
                    NSTimeInterval timeDifference = [currentTime timeIntervalSinceDate:serverTime];

                    if (fabs(timeDifference) > 5) {
                        [self showAlertWithTitle:NSSENCRYPT("Lỗi") message:NSSENCRYPT("Thời gian không đồng bộ với server. Vui lòng thử lại") shouldExit:YES];
                        return;
                    }

                    NSInteger remainingSeconds = [responseDict[NSSENCRYPT("encypttimerkey")] integerValue];
                    if (remainingSeconds == 0) {
                        NSString *errorMessage = responseDict[NSSENCRYPT("messenger")] ?: NSSENCRYPT("Key đã hết hạn! Vui lòng liên hệ với quản trị viên để nhận mã khóa mới!");
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSSENCRYPT("savedKey")];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self showAlertWithTitle:errorMessage message:nil shouldExit:YES];
                        });
                    } else {
                        extraInfo.remainingSeconds = remainingSeconds;
                        NSInteger days = remainingSeconds / (60 * 60 * 24);
                        remainingSeconds %= (60 * 60 * 24);
                        NSInteger hours = remainingSeconds / (60 * 60);
                        remainingSeconds %= (60 * 60);
                        NSInteger minutes = remainingSeconds / 60;
                        remainingSeconds %= 60;
                        NSString *message1 = [NSString stringWithFormat:NSSENCRYPT("\nDevice: Iphone %@"), [self deviceType]];
                        NSString *message2 = [NSString stringWithFormat:NSSENCRYPT("Thời hạn sử dụng: %ld ngày, %ld giờ, %ld phút, %ld giây"), (long)days, (long)hours, (long)minutes, (long)remainingSeconds];

                        [[NSUserDefaults standardUserDefaults] setObject:key forKey:NSSENCRYPT("savedKey")];
                        [[NSUserDefaults standardUserDefaults] synchronize];

                        [self startUpdateTimer];

                        keyValidationStatus = NSSENCRYPT("validated");
                        encodedcode = encodestring;
                        iskey = key;

                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self showSuccessAlertWithMessage:message1 message2:message2];
                            self.failedKeyAttempts = 0;
                            self.hasShownSuccessAlert = YES;
                        });
                    }
                }
            } else {
                NSString *errorMessage = responseDict[NSSENCRYPT("messenger")] ?: NSSENCRYPT("Key đã hết hạn hoặc sai");
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSSENCRYPT("savedKey")];
                [[NSUserDefaults standardUserDefaults] synchronize];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle:NSSENCRYPT("ERROR") message:errorMessage shouldExit:NO];
                });
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self presentKeyInputAlert];
                });
            }
        }];

        [task resume];
    };

    weakRunRequest = runRequest;
    runRequest(baseURL);
}


- (void)showSuccessAlertWithMessage:(NSString *)message1 message2:(NSString *)message2 {
    

    if (!self.hasShownSuccessAlert && extraInfo.remainingSeconds <= 0 && iskey == nil && ![iskey isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:NSSENCRYPT("savedKey")]]) {
        [self showAlertWithTitle:NSSENCRYPT("Lỗi") message:NSSENCRYPT("Lại định crack à") shouldExit:YES];
        return;
    }
    detectDebugger();

    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;

   
    UIView *overlayView = [[UIView alloc] initWithFrame:rootViewController.view.bounds];
    overlayView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [rootViewController.view addSubview:overlayView];

   
    CGFloat alertWidth = 240;
    CGFloat alertHeight = 115; 
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertWidth, alertHeight)];
    alertView.center = rootViewController.view.center;
    alertView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
    alertView.layer.cornerRadius = 8;
    alertView.clipsToBounds = YES;
    [overlayView addSubview:alertView];

    
    UILabel *successLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, alertView.frame.size.width, 30)];
    successLabel.text = @"SUCCESS"; 
    successLabel.textAlignment = NSTextAlignmentCenter;
    successLabel.font = [UIFont boldSystemFontOfSize:24];
    successLabel.textColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:1.0];
    successLabel.alpha = 0.0;
    [alertView addSubview:successLabel];

    
    CGFloat circleSize = 60;
    UIView *circleContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, circleSize, circleSize)];
    circleContainer.center = CGPointMake(alertView.bounds.size.width/2, alertView.bounds.size.height/2);
    [alertView addSubview:circleContainer];

    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(circleSize/2, circleSize/2)
                                                            radius:circleSize/2 - 2
                                                        startAngle:-M_PI_2
                                                          endAngle:3 * M_PI_2 - M_PI/6
                                                         clockwise:YES];
    circleLayer.path = circlePath.CGPath;
    circleLayer.strokeColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:1.0].CGColor;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.lineWidth = 4;
    circleLayer.lineCap = kCALineCapRound;
    [circleContainer.layer addSublayer:circleLayer];

    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @0;
    rotationAnimation.toValue = @(2 * M_PI);
    rotationAnimation.duration = 1.5;
    rotationAnimation.repeatCount = INFINITY;
    [circleContainer.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

    UIView *checkMarkAndCircleContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, circleSize, circleSize)];
    checkMarkAndCircleContainer.center = circleContainer.center;
    checkMarkAndCircleContainer.alpha = 0;
    [alertView addSubview:checkMarkAndCircleContainer];

    CAShapeLayer *completedCircleLayer = [CAShapeLayer layer];
    UIBezierPath *completedCirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circleSize, circleSize)];
    completedCircleLayer.path = completedCirclePath.CGPath;
    completedCircleLayer.strokeColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:1.0].CGColor;
    completedCircleLayer.fillColor = [UIColor clearColor].CGColor;
    completedCircleLayer.lineWidth = 4;
    [checkMarkAndCircleContainer.layer addSublayer:completedCircleLayer];

    CAShapeLayer *checkmarkLayer = [CAShapeLayer layer];
    UIBezierPath *checkmarkPath = [UIBezierPath bezierPath];
    [checkmarkPath moveToPoint:CGPointMake(circleSize * 0.25, circleSize * 0.5)];
    [checkmarkPath addLineToPoint:CGPointMake(circleSize * 0.45, circleSize * 0.65)];
    [checkmarkPath addLineToPoint:CGPointMake(circleSize * 0.75, circleSize * 0.35)];
    checkmarkLayer.path = checkmarkPath.CGPath;
    checkmarkLayer.strokeColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:1.0].CGColor;
    checkmarkLayer.fillColor = [UIColor clearColor].CGColor;
    checkmarkLayer.lineWidth = 4;
    checkmarkLayer.strokeEnd = 0;
    checkmarkLayer.lineCap = kCALineCapRound;
    checkmarkLayer.lineJoin = kCALineJoinRound;
    [checkMarkAndCircleContainer.layer addSublayer:checkmarkLayer];

    alertView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        alertView.alpha = 1.0;
        alertView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [circleContainer.layer removeAnimationForKey:@"rotationAnimation"];
            circleContainer.alpha = 0;
            checkMarkAndCircleContainer.alpha = 1;

            [UIView animateWithDuration:0.3 animations:^{

                [UIView animateWithDuration:0.7 animations:^{
                    successLabel.alpha = 1.0; 
                }];
                
                
            } completion:^(BOOL finished) {
                CABasicAnimation *checkmarkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
                checkmarkAnimation.duration = 0.5;
                checkmarkAnimation.fromValue = @0;
                checkmarkAnimation.toValue = @1;
                checkmarkAnimation.removedOnCompletion = NO;
                checkmarkAnimation.fillMode = kCAFillModeForwards;
                [checkmarkLayer addAnimation:checkmarkAnimation forKey:@"checkmarkAnimation"];

                

                [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    CGRect frame = alertView.frame;
                    frame.size.height = 140;
                    alertView.frame = frame;
                    alertView.center = rootViewController.view.center;

                    checkMarkAndCircleContainer.center = CGPointMake(alertView.bounds.size.width/2, alertView.bounds.size.height/2 + 15);
                    

                } completion:nil];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:0.2 animations:^{
                        alertView.transform = CGAffineTransformMakeScale(0.01, 0.01);
                        overlayView.alpha = 0.0;
                    } completion:^(BOOL finished) {
                        [overlayView removeFromSuperview];
                        
                    }];
                });
            }];
        });
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Giả sử đã decrypt các chuỗi
       [self activehack:@"Key đã được kích hoạt thành công" message:message2 font:[UIFont fontWithName:@"AvenirNext-Bold" size:13]];
    });
}
- (void)activehack:(NSString *)title message:(NSString *)message font:(UIFont *)font {
    static BOOL isShowingNotification = NO; // Biến cờ để theo dõi trạng thái thông báo
    
    if (isShowingNotification) { // Nếu đang hiển thị thông báo
        // Loại bỏ thông báo hiện tại
        [self hideCurrentNotification];
        isShowingNotification = NO;
    }

    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // Tính toán chiều rộng tối đa của thông báo
    CGFloat maxWidth = screenWidth * 0.75;
    
    // Tạo UILabel cho tiêu đề
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxWidth, 0)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = font;
    titleLabel.textColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:1.0];
    titleLabel.numberOfLines = 0;
    [titleLabel sizeToFit];
    
    // Tạo UILabel cho nội dung
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxWidth, 0)];
    messageLabel.text = message;
    messageLabel.textAlignment = NSTextAlignmentLeft;
    messageLabel.font = [UIFont fontWithName:@"AvenirNext-Bold" size:10];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.numberOfLines = 0;
    [messageLabel sizeToFit];
    
    // Tính toán kích thước và vị trí của thông báo
    CGFloat rectWidth = MAX(titleLabel.frame.size.width, messageLabel.frame.size.width) + 60;
    CGFloat rectHeight = titleLabel.frame.size.height + messageLabel.frame.size.height + 16;
    CGFloat rectX = screenWidth;
    CGFloat rectY = screenHeight * 0.10;

    // Tạo UIView cho nền thông báo
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];

    // Thêm khung đen vào cửa sổ chính trước
    UIView *rect2 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY, 0, rectHeight)];
    rect2.backgroundColor = [UIColor blackColor];
    [mainWindow addSubview:rect2];

    // Thêm khung đỏ vào cửa sổ chính sau
    UIView *rect1 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY, 0, rectHeight)];
    rect1.backgroundColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:1.0];
    [mainWindow addSubview:rect1];

    // Hoạt hình hiển thị thông báo
    [UIView animateWithDuration:0.5 animations:^{
        rect1.frame = CGRectMake(rectX - rectWidth + 0.5, rectY, rectWidth, rectHeight);
        rect2.frame = CGRectMake(rectX - rectWidth + 0.5, rectY, rectWidth, rectHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0.0 options:0 animations:^{
            rect1.frame = CGRectMake(rectX - rectWidth + 0.5, rectY, screenWidth * 0.005, rectHeight);
        } completion:^(BOOL finished) {
            // Hiển thị nội dung thông báo
            titleLabel.alpha = 1;
            messageLabel.alpha = 1;
            [mainWindow addSubview:titleLabel];
            [mainWindow addSubview:messageLabel];
            titleLabel.center = CGPointMake(rectX - rectWidth / 2 + 12, rectY + rectHeight / 2 - messageLabel.frame.size.height / 2 - 2);
            messageLabel.center = CGPointMake(rectX - rectWidth / 2 + 12, rectY + rectHeight / 2 + titleLabel.frame.size.height / 2 + 2);

            isShowingNotification = YES; // Đánh dấu là đang hiển thị thông báo

            // Hoạt hình ẩn thông báo sau 5 giây
            [UIView animateWithDuration:0.5 delay:5.0 options:0 animations:^{
                // **Thay đổi**: Di chuyển cả khung đỏ và label sang phải để che chữ
                rect1.frame = CGRectMake(rectX - rectWidth + 0.5, rectY, rectWidth, rectHeight); 
                titleLabel.center = CGPointMake(rectX + rectWidth / 2 + 12, rectY + rectHeight / 2 - messageLabel.frame.size.height / 2 - 2);
                messageLabel.center = CGPointMake(rectX + rectWidth / 2 + 12, rectY + rectHeight / 2 + titleLabel.frame.size.height / 2 + 2);
            } completion:^(BOOL finished) {
                // Loại bỏ các khung hình khỏi cửa sổ chính
                [UIView animateWithDuration:0.15 delay:0.0 options:0 animations:^{
                    rect1.frame = CGRectMake(rectX, rectY, 0, rectHeight);
                    rect2.frame = CGRectMake(rectX, rectY, 0, rectHeight);
                    titleLabel.alpha = 0;
                    messageLabel.alpha = 0;
                } completion:^(BOOL finished) {
                    [rect1 removeFromSuperview];
                    [rect2 removeFromSuperview];
                    [titleLabel removeFromSuperview];
                    [messageLabel removeFromSuperview];
                }];
            }];
        }];
    }];
}

- (void)hideCurrentNotification {
    // Lấy cửa sổ chính
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];

    // Tìm các khung hình và label đang hiển thị
    for (UIView *view in mainWindow.subviews) {
        if ([view isKindOfClass:[UIView class]] && view.backgroundColor) {
            // Ẩn thông báo hiện tại
            [UIView animateWithDuration:0.15 animations:^{
                view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, 0, view.frame.size.height);
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
            }];
        }
    }

    // Tìm các label đang hiển thị
    for (UIView *view in mainWindow.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            // Ẩn label hiện tại
            [UIView animateWithDuration:0.15 animations:^{
                view.alpha = 0;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
            }];
        }
    }
}

+ (void)paid:(void (^)(void))execute {
    detectDebugger();
    dispatch_async(dispatch_get_main_queue(), ^{

            if (iskey != nil && [keyValidationStatus isEqualToString:NSSENCRYPT("validated")] && [encodedcode isEqualToString:encodestring] && [iskey isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:NSSENCRYPT("savedKey")]] && extraInfo.remainingSeconds > 0) {
                execute();
            } else {
                [Unitoreios paid:execute];
            }

            });

}

- (void)startUpdateTimer {
    if (!self.updateTimer) {
        self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    }
}

- (void)stopUpdateTimer {
    [self.updateTimer invalidate];
    self.updateTimer = nil;
}

- (void)updateTime {
    if (extraInfo.remainingSeconds > 0) { // Sử dụng self.remainingSeconds
        extraInfo.remainingSeconds--; // Giảm self.remainingSeconds
        NSString *remainingTime = [Unitoreios getRemainingTime];
        if (![remainingTime isEqualToString:self.lastRemainingTime]) {
            self.lastRemainingTime = remainingTime;
            // Không cần gọi hàm trong Menu.mm. ImGui sẽ tự động render lại.
        }

    } else {
        [self stopUpdateTimer];

    }
}

+ (NSString *)getCurrentKey {
    if ([keyValidationStatus isEqualToString:NSSENCRYPT("validated")] && [encodedcode isEqualToString:encodestring] && [iskey isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:NSSENCRYPT("savedKey")]]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:NSSENCRYPT("savedKey")];
    } else {
        return NSSENCRYPT("Lỗi nhận key");
    }
}

+ (NSString *)getRemainingTime {
    if ([keyValidationStatus isEqualToString:NSSENCRYPT("validated")] && [encodedcode isEqualToString:encodestring] && [iskey isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:NSSENCRYPT("savedKey")]]) {
        if (extraInfo.remainingSeconds > 0) { // Kiểm tra extraInfo.remainingSeconds
            NSInteger remainingSeconds = extraInfo.remainingSeconds; // Sử dụng giá trị đã lưu
            NSInteger days = remainingSeconds / (60 * 60 * 24);
            remainingSeconds %= (60 * 60 * 24);
            NSInteger hours = remainingSeconds / (60 * 60);
            remainingSeconds %= (60 * 60);
            NSInteger minutes = remainingSeconds / 60;
            remainingSeconds %= 60;

            return [NSString stringWithFormat:NSSENCRYPT("%ld ngày, %ld giờ, %ld phút, %ld giây"), (long)days, (long)hours, (long)minutes, (long)remainingSeconds];
        } else {
            return NSSENCRYPT("Đã hết hạn");
        }
    } else {
        return NSSENCRYPT("Key chưa được xác thực");
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message shouldExit:(BOOL)shouldExit {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

        if ([title isEqualToString:NSSENCRYPT("ERROR")]) {
            NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:title];
            [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, attributedTitle.length)];
            [attributedTitle addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:24] range:NSMakeRange(0, attributedTitle.length)];
            [alertController setValue:attributedTitle forKey:@"attributedTitle"];
        }

        if (message) {
            NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc] initWithString:message];
            [attributedMessage addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, attributedMessage.length)];
            [alertController setValue:attributedMessage forKey:@"attributedMessage"];
        }

        [rootViewController presentViewController:alertController animated:YES completion:nil];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertController dismissViewControllerAnimated:YES completion:^{
                if (shouldExit) {
                    exit(0);
                }
            }];
        });
    });
}

- (UIColor *)colorFromCode:(NSInteger)code {
    switch (code) {
        case 1:
            return [UIColor redColor];
        case 2:
            return [UIColor orangeColor];
        case 3:
            return [UIColor yellowColor];
        case 4:
            return [UIColor greenColor];
        case 5:
            return [UIColor blueColor];
        case 6:
            return [UIColor purpleColor];
        case 7:
            return [UIColor whiteColor];
        default:
            return nil;
    }
}

#pragma mark - SFSafariViewControllerDelegate
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [self checkAndRequestUDIDIfNeeded];
}

- (NSString *)decryptAESData:(NSData *)data key:(NSString *)key iv:(NSString *)iv {
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];

    NSData *encryptedData = [[NSData alloc] initWithBase64EncodedString:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] options:0];

    if (!encryptedData) {
        NSLog(@"Lỗi chuyển đổi dữ liệu mã hóa từ Base64 sang NSData.");
        return nil;
    }

    NSUInteger dataLength = encryptedData.length;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCKeySizeAES256, ivPtr, [encryptedData bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);

    if (cryptStatus == kCCSuccess) {
        NSData *decryptedData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    } else {
        free(buffer);
        return nil;
    }
}

- (NSString *)deviceType {
    struct utsname systemInfo;
    uname(&systemInfo);

    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

if ([deviceString isEqualToString:@"iPhone1,1"])    return @"1";
if ([deviceString isEqualToString:@"iPhone1,2"])    return @"3G";
if ([deviceString isEqualToString:@"iPhone2,1"])    return @"3GS";
if ([deviceString isEqualToString:@"iPhone3,1"] ||
    [deviceString isEqualToString:@"iPhone3,2"] ||
    [deviceString isEqualToString:@"iPhone3,3"])    return @"4";
if ([deviceString isEqualToString:@"iPhone4,1"])    return @"4S";
if ([deviceString isEqualToString:@"iPhone5,1"] ||
    [deviceString isEqualToString:@"iPhone5,2"])    return @"5";
if ([deviceString isEqualToString:@"iPhone5,3"] ||
    [deviceString isEqualToString:@"iPhone5,4"])    return @"5C";
if ([deviceString isEqualToString:@"iPhone6,1"] ||
    [deviceString isEqualToString:@"iPhone6,2"])    return @"5S";
if ([deviceString isEqualToString:@"iPhone7,2"])    return @"6";
if ([deviceString isEqualToString:@"iPhone7,1"])    return @"6 Plus";
if ([deviceString isEqualToString:@"iPhone8,1"])    return @"6S";
if ([deviceString isEqualToString:@"iPhone8,2"])    return @"6S Plus";
if ([deviceString isEqualToString:@"iPhone8,4"])    return @"SE";
if ([deviceString isEqualToString:@"iPhone9,1"] ||
    [deviceString isEqualToString:@"iPhone9,3"])    return @"7";
if ([deviceString isEqualToString:@"iPhone9,2"] ||
    [deviceString isEqualToString:@"iPhone9,4"])    return @"7 Plus";
if ([deviceString isEqualToString:@"iPhone10,1"] ||
    [deviceString isEqualToString:@"iPhone10,4"])   return @"8";
if ([deviceString isEqualToString:@"iPhone10,2"] ||
    [deviceString isEqualToString:@"iPhone10,5"])   return @"8 Plus";
if ([deviceString isEqualToString:@"iPhone10,3"] ||
    [deviceString isEqualToString:@"iPhone10,6"])   return @"X";
if ([deviceString isEqualToString:@"iPhone11,2"])   return @"XS";
if ([deviceString isEqualToString:@"iPhone11,4"] ||
    [deviceString isEqualToString:@"iPhone11,6"])   return @"XS Max";
if ([deviceString isEqualToString:@"iPhone11,8"])   return @"XR";
if ([deviceString isEqualToString:@"iPhone12,1"])   return @"11";
if ([deviceString isEqualToString:@"iPhone12,3"])   return @"11 Pro";
if ([deviceString isEqualToString:@"iPhone12,5"])   return @"11 Pro Max";
if ([deviceString isEqualToString:@"iPhone12,8"])   return @"SE (2nd generation)";
if ([deviceString isEqualToString:@"iPhone13,1"])   return @"12 mini";
if ([deviceString isEqualToString:@"iPhone13,2"])   return @"12";
if ([deviceString isEqualToString:@"iPhone13,3"])   return @"12 Pro";
if ([deviceString isEqualToString:@"iPhone13,4"])   return @"12 Pro Max";
if ([deviceString isEqualToString:@"iPhone14,4"])   return @"13 mini";
if ([deviceString isEqualToString:@"iPhone14,5"])   return @"13";
if ([deviceString isEqualToString:@"iPhone14,2"])   return @"13 Pro";
if ([deviceString isEqualToString:@"iPhone14,3"])   return @"13 Pro Max";
if ([deviceString isEqualToString:@"iPhone14,6"])   return @"SE (3rd generation)";
if ([deviceString isEqualToString:@"iPhone14,7"])   return @"14";
if ([deviceString isEqualToString:@"iPhone14,8"])   return @"14 Plus";
if ([deviceString isEqualToString:@"iPhone15,2"])   return @"14 Pro";
if ([deviceString isEqualToString:@"iPhone15,3"])   return @"14 Pro Max";
if ([deviceString isEqualToString:@"iPhone15,4"])   return @"15";
if ([deviceString isEqualToString:@"iPhone15,5"])   return @"15 Plus";
if ([deviceString isEqualToString:@"iPhone16,1"])   return @"15 Pro";
if ([deviceString isEqualToString:@"iPhone16,2"])   return @"15 Pro Max";
if ([deviceString isEqualToString:@"iPhone17,1"])   return @"16 Pro";
if ([deviceString isEqualToString:@"iPhone17,2"])   return @"16 Pro Max";
if ([deviceString isEqualToString:@"iPhone17,3"])   return @"16";
if ([deviceString isEqualToString:@"iPhone17,4"])   return @"16 Plus";

/* === BỔ SUNG 17 SERIES === */
if ([deviceString isEqualToString:@"iPhone18,1"])   return @"17";
if ([deviceString isEqualToString:@"iPhone18,2"])   return @"17 Plus";
if ([deviceString isEqualToString:@"iPhone18,3"])   return @"17 Pro";
if ([deviceString isEqualToString:@"iPhone18,4"])   return @"17 Pro Max";

return @"iPhone (Unknown)";

}

@end