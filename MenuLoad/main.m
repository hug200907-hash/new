#import <SafariServices/SafariServices.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <mach/mach.h>
#include <sys/mount.h>
#include <sys/param.h>
#include <sys/sysctl.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "main.h"
#import <Cephei/HBPreferences.h>  // Nếu bạn sử dụng CepheiPrefs
#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <sys/utsname.h>
#import "lib.h"
#import "SSZipArchive/SSZipArchive.h"
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreServices/CoreServices.h>
#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#include <stdlib.h>                            

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface maintool () <UIGestureRecognizerDelegate,
                    UIImagePickerControllerDelegate,
                    UINavigationControllerDelegate,
                    UITextFieldDelegate,
                    UNUserNotificationCenterDelegate>

@property(strong, nonatomic) UILabel *displayLabel;
@property(strong, nonatomic) UILabel *bottomLabel;
@property(nonatomic, strong) NSString *previousJsonContent;
@property(strong, nonatomic) UILabel *centerLabel;
// @property (strong, nonatomic) UISwitch *outToggle;
@property(strong, nonatomic) UIAlertController *crashAlert;
@property(strong, nonatomic) UIAlertController *tripleTapAlert;
@property(nonatomic, assign) BOOL isAlertVisible;
@property(strong, nonatomic) UIButton *modButton;
@property(strong, nonatomic) UIAlertController *moddingAlert;
@property(nonatomic, strong) NSString *cachedPassword;
@property(nonatomic, strong) NSTimer *hideLabelTimer;
@property(nonatomic, strong) UITextField *urlTextField;
@property(nonatomic, strong) UIButton *generateButton;
@property(nonatomic, strong) UIDocumentPickerViewController *documentPicker;
@property(strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UISwitch *toggleSwitch;

@property (nonatomic, strong) NSString *profileDirectory;
@property (nonatomic, strong) NSMutableArray *profileNames;
@property (nonatomic, strong) UILabel *statusLabel; // Thêm label để hiển thị text

// @property (strong, nonatomic) UIButton *modButton;
// @property (strong, nonatomic) UIAlertController *moddingAlert;

@end

@implementation maintool {
  UIDocumentPickerViewController *_documentPicker;
  UIDocumentPickerViewController *_documentPicker2;
  
}

UIWindow *mainWindow;
UISwitch *nuttaiho,*nuthome,*nutlog;
UIButton *BBone;
UIView* hideRecordView1;

int a;
#define kNotificationStateKey @"NotificationState"

static maintool *extraInfo;

+ (instancetype)sharemain {
  static maintool *sharemain;
  static dispatch_once_t onceToken;

  dispatch_once(&onceToken, ^{
    sharemain = [[maintool alloc] init];
            // _profileNames = [NSMutableArray array];
  });

  return sharemain;
}

+ (void)load {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
                   [maintool sharemain];
                 });
}

- (void)activehack {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat rectWidth = screenWidth * 0.26;
    CGFloat rectHeight = screenHeight * 0.15;
    CGFloat rectX = screenWidth * 1.0;
    CGFloat rectY1 = screenHeight * 0.10;
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];

    UIView *rect2 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY1, 0, rectHeight)];
    rect2.backgroundColor = [UIColor blackColor];
    [mainWindow addSubview:rect2];

    UIView *rect1 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY1, 0, rectHeight)];
    rect1.backgroundColor = [UIColor colorWithRed:81.0 / 255.0 green:108.0 / 255.0 blue:243.0 / 255.0 alpha:1.0];
    [mainWindow addSubview:rect1];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
    label1.text = @"LQMB HACK VIP";
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont fontWithName:@"AvenirNext-Bold" size:13];
    label1.textColor = [UIColor colorWithRed:81.0 / 255.0 green:108.0 / 255.0 blue:243.0 / 255.0 alpha:1.0];
    label1.alpha = 0;
    label1.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 - 15);
    [mainWindow addSubview:label1];

    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
    label2.text = @"THÔNG BÁO TỪ HỆ THỐNG";
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont fontWithName:@"AvenirNext-Bold" size:8];
    label2.textColor = [UIColor colorWithRed:180.0 / 255.0 green:180.0 / 255.0 blue:180.0 / 255.0 alpha:1.0];
    label2.alpha = 0;
    label2.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 - 5);
    [mainWindow addSubview:label2];

    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 40)];
    label3.text = @"WELCOME BACK";
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont fontWithName:@"AvenirNext-Bold" size:18];
    label3.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]; // Đảm bảo màu sắc
    label3.alpha = 0;
    label3.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 + 13);
    [mainWindow addSubview:label3];

    [UIView animateWithDuration:0.5 animations:^{
        rect1.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
        rect2.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            rect1.frame = CGRectMake(rectX - rectWidth, rectY1, screenWidth * 0.005, rectHeight);
        } completion:^(BOOL finished) {
            label1.alpha = 1;
            label2.alpha = 1;
            label3.alpha = 1;
            [UIView animateWithDuration:0.5 delay:5.0 options:0 animations:^{
                rect1.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 animations:^{
                    rect1.frame = CGRectMake(rectX, rectY1, 0, rectHeight);
                    rect2.frame = CGRectMake(rectX, rectY1, 0, rectHeight);
                    label1.alpha = 0;
                    label2.alpha = 0;
                    label3.alpha = 0;
                } completion:nil];
            }];
        }];
    }];
}

- (void)ChangeAccount {
  self.profileDirectory = [self Checksubfolder:@"ListAcc-131Cheats"];
  [self Createifnotappear];

}

- (void)alertchangeacc {

    NSString *message = [NSString stringWithFormat:@"Đang Có %lu Acc Được Lưu", (unsigned long)self.profileNames.count];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"DANH SÁCH SAVE ACC"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [self addProfileActionsToAlert1:alert];

  UIAlertAction *createProfileAction = [UIAlertAction actionWithTitle:@"Thêm Acc Hiện Tại"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                [self PromtAccount];
                                                              }];

  UIAlertAction *XoaAccAction = [UIAlertAction actionWithTitle:@"Xóa Acc Trong Danh Sách"
                                                                style:UIAlertActionStyleDestructive
                                                              handler:^(UIAlertAction *action) {
                                                                [self thongbaoxoaacc];
                                                              }];
  UIAlertAction *logout = [UIAlertAction actionWithTitle:@"Đăng Xuất Acc ( để log acc mới )"
                                                                style:UIAlertActionStyleDestructive
                                                              handler:^(UIAlertAction *action) {
                                                                [self openAppDirectory];
                                                              }];
  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *_Nonnull action) {
    
                                                       }];

  [alert addAction:createProfileAction];
  [alert addAction:XoaAccAction];
  [alert addAction:logout];
  [alert addAction:cancelAction];

  UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
  [rootVC presentViewController:alert animated:YES completion:nil];
}

- (void)thongbaoxoaacc {
  if ([self.profileNames count] == 0) {
    [self showalertAcc:@"Không Có Acc"];
    return;
  }

  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Xóa Acc" message:@"Chọn Acc bạn muốn xóa" preferredStyle:UIAlertControllerStyleAlert];

  for (NSString *profileName in self.profileNames) {
    [alert addAction:[UIAlertAction actionWithTitle:profileName
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction *_Nonnull action) {
                                              [self XoaAcc:profileName];
                                            }]];
  }

  [alert addAction:[UIAlertAction actionWithTitle:@"Xóa tất cả"
                                            style:UIAlertActionStyleDestructive
                                          handler:^(UIAlertAction *_Nonnull action) {
                                            [self confirmdeleteacc];
                                          }]];

  [alert addAction:[UIAlertAction actionWithTitle:@"Hủy" style:UIAlertActionStyleCancel handler:nil]];

  UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
  [rootVC presentViewController:alert animated:YES completion:nil];
}

- (void)confirmdeleteacc {
  UIAlertController *confirmAlert = [UIAlertController alertControllerWithTitle:@"Xoá Tất Cả ?" message:@"" preferredStyle:UIAlertControllerStyleAlert];

  [confirmAlert addAction:[UIAlertAction actionWithTitle:@"Xóa tất cả"
                                                   style:UIAlertActionStyleDestructive
                                                 handler:^(UIAlertAction *_Nonnull action) {
                                                   [self xoaallacc];
                                                 }]];

  [confirmAlert addAction:[UIAlertAction actionWithTitle:@"Hủy" style:UIAlertActionStyleCancel handler:nil]];

  UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
  [rootVC presentViewController:confirmAlert animated:YES completion:nil];
}
- (void)xoaallacc {
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSError *error;

  for (NSString *profileName in self.profileNames) {
    NSString *profilePath = [self.profileDirectory stringByAppendingPathComponent:profileName];
    [fileManager removeItemAtPath:profilePath error:&error];
    if (error) {
      error = nil; // Reset error for next iteration
    }
  }

  [self.profileNames removeAllObjects];
  [self LuuAcc];

  [self showalertAcc:@"Đã xóa tất cả profile"];
  [self alertchangeacc];
}

- (void)addProfileActionsToAlert1:(UIAlertController *)alert {
  for (NSString *profileName in self.profileNames) {
    UIAlertAction *profileAction = [UIAlertAction actionWithTitle:profileName
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                            [self ApdungAcc:profileName];
                                                          }];

    [alert addAction:profileAction];
  }
}

- (void)PromtAccount {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nhập Tên Acc" message:nil preferredStyle:UIAlertControllerStyleAlert];

  [alert addTextFieldWithConfigurationHandler:nil];

  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
                                                     NSString *inputName = alert.textFields.firstObject.text;
                                                     if (inputName.length > 0) {
                                                       [self TaoAcc:inputName];
                                                     } else {
                                                       [self showalertAcc:@"Tên không hợp lệ"];
                                                     }
                                                   }];

  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Hủy" style:UIAlertActionStyleCancel handler:nil];

  [alert addAction:okAction];
  [alert addAction:cancelAction];

  UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
  [rootVC presentViewController:alert animated:YES completion:nil];
}

- (void)XoaAcc:(NSString *)profileName {
  NSString *profilePath = [self.profileDirectory stringByAppendingPathComponent:profileName];
  NSError *error;
  [[NSFileManager defaultManager] removeItemAtPath:profilePath error:&error];
  if (error) {
    NSLog(@"Lỗi khi xóa profile %@: %@", profileName, error.localizedDescription);
    [self showalertAcc:@"Lỗi :D"];
  } else {
    [self.profileNames removeObject:profileName];
    [self LuuAcc];
    [self showalertAcc:[NSString stringWithFormat:@"Đã xóa Acc %@", profileName]];
    [self alertchangeacc];
  }
}

- (void)LoadAcc {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSArray *savedProfiles = [defaults objectForKey:@"SavedProfiles"];
  self.profileNames = savedProfiles ? [savedProfiles mutableCopy] : [NSMutableArray array];
}

- (void)LuuAcc {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:self.profileNames forKey:@"SavedProfiles"];
  [defaults synchronize];
}

- (void)showalertAcc:(NSString *)message {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:message preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *_Nonnull action) {
                                            // BOOL isMenuShowing = [ImGuiDrawView isMenuShowing];
                                            // [ImGuiDrawView showChange:!isMenuShowing];
                                          }]];
  UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
  [rootVC presentViewController:alert animated:YES completion:nil];
}

- (void)showalertAcccrash:(NSString *)message {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:message preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *_Nonnull action) {
                                           exit(0);
                                          }]];
  UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
  [rootVC presentViewController:alert animated:YES completion:nil];
}


- (NSString *)Checksubfolder:(NSString *)subfolder {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *profilePath = [documentsDirectory stringByAppendingPathComponent:subfolder];
    return profilePath;
}

- (void)Createifnotappear {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:self.profileDirectory]) {
        NSError *error;
        BOOL success = [fileManager createDirectoryAtPath:self.profileDirectory 
                             withIntermediateDirectories:YES 
                                            attributes:nil 
                                                 error:&error];
        
        if (success) {
            NSLog(@"Thư mục ProfileModSkin-131Cheats đã được tạo thành công.");
        } else {
            NSLog(@"Lỗi khi tạo thư mục ProfileModSkin-131Cheats: %@", error.localizedDescription);
        }
    }
    [self alertchangeacc];
}

// Helper method to check if path is directory
- (BOOL)isDirectory:(NSString *)path {
    BOOL isDirectory = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    return isDirectory;
}

- (void)TaoAcc:(NSString *)profileName {
    if ([self.profileNames containsObject:profileName]) {
        [self showalertAcc:@"đã tồn tại"];
        return;
    }

    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *newProfilePath = [self.profileDirectory stringByAppendingPathComponent:profileName];
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (![fileManager createDirectoryAtPath:newProfilePath withIntermediateDirectories:YES attributes:nil error:&error]) {
        NSLog(@"Lỗi khi tạo thư mục: %@", error.localizedDescription);
        [self showalertAcc:@"Lỗi khi tạo thư mục"];
        return;
    }

    NSArray *itemsToCopy = @[@"beetalk_session.db", @"com.beetalk.sdk.config", @"ano_tmp", @"SGameLog", @"records",@"tdm_track.dat",@"GVoiceTQos"];
    BOOL success = YES;

    for (NSString *itemName in itemsToCopy) {
        NSString *sourcePath = [documentsDirectory stringByAppendingPathComponent:itemName];
        NSString *destinationPath = [newProfilePath stringByAppendingPathComponent:itemName];

        if ([fileManager fileExistsAtPath:sourcePath]) {
            if ([self isDirectory:sourcePath]) {
                // Đối với thư mục, sử dụng copyItemAtPath
                success = [fileManager copyItemAtPath:sourcePath toPath:destinationPath error:&error];
            } else {
                // Đối với file, sử dụng copyItemAtPath như trước
                success = [fileManager copyItemAtPath:sourcePath toPath:destinationPath error:&error];
            }
            if (!success) {
                NSLog(@"Lỗi khi sao chép %@: %@", itemName, error.localizedDescription);
                break;
            }
        }
    }

    if (success) {
        [self.profileNames addObject:profileName];
        [self LuuAcc];
        [self showalertAcc:[NSString stringWithFormat:@"Đã tạo acc %@", profileName]];
        [self alertchangeacc];
    } else {
        [self showalertAcc:@"Lỗi khi tạo acc"];
    }
}

- (void)ApdungAcc:(NSString *)profileName {
    NSString *profilePath = [self.profileDirectory stringByAppendingPathComponent:profileName];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;

    if (![fileManager fileExistsAtPath:profilePath]) {
        [self showalertAcc:@"Profile không tồn tại"];
        return;
    }

    NSArray *itemsToManage = @[@"beetalk_session.db", @"com.beetalk.sdk.config", @"ano_tmp", @"SGameLog", @"records",@"tdm_track.dat",@"GVoiceTQos"];
    NSArray *itemsToCopy = @[@"beetalk_session.db", @"com.beetalk.sdk.config", @"ano_tmp", @"SGameLog", @"records",@"tdm_track.dat",@"GVoiceTQos"];
    BOOL success = YES;

    for (NSString *itemName in itemsToManage) {
        NSString *itemPath = [documentsDirectory stringByAppendingPathComponent:itemName];
        if ([fileManager fileExistsAtPath:itemPath]) {
            success = [fileManager removeItemAtPath:itemPath error:&error];
            if (!success) {
                NSLog(@"Lỗi khi xóa mục %@: %@", itemName, error.localizedDescription);
                break;
            }
        }
    }

    if (success) {
        for (NSString *itemName in itemsToCopy) {
            NSString *sourcePath = [profilePath stringByAppendingPathComponent:itemName];
            NSString *destinationPath = [documentsDirectory stringByAppendingPathComponent:itemName];

            if ([fileManager fileExistsAtPath:sourcePath]) {
                if ([self isDirectory:sourcePath]) {
                    success = [fileManager copyItemAtPath:sourcePath toPath:destinationPath error:&error];
                } else {
                    success = [fileManager copyItemAtPath:sourcePath toPath:destinationPath error:&error];
                }
                if (!success) {
                    NSLog(@"Lỗi sao chép %@ từ profile: %@", itemName, error.localizedDescription);
                    break;
                }
            }
        }
    }

    if (success) {
        [self showalertAcccrash:[NSString stringWithFormat:@"Đã Chuyển Sang Acc %@", profileName]];
    } else {
        [self showalertAcc:@"Lỗi khi chuyển acc"];
    }
}
// - (void)setupProfileModSkin {
//     self.profileDirectory = [self applicationDocumentsDirectoryWithSubfolder:@"ProfileModSkin-131Cheats"];
//     [self checkAndCreateProfileDirectory];
// }

// - (NSString *)applicationDocumentsDirectoryWithSubfolder:(NSString *)subfolder {
//     NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//     NSString *profilePath = [documentsDirectory stringByAppendingPathComponent:subfolder];
//     return profilePath;
// }

// - (void)checkAndCreateProfileDirectory {
//     NSFileManager *fileManager = [NSFileManager defaultManager];
    
//     if (![fileManager fileExistsAtPath:self.profileDirectory]) {
//         NSError *error;
//         BOOL success = [fileManager createDirectoryAtPath:self.profileDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        
//         if (success) {
//             NSLog(@"Thư mục ProfileModSkin-131Cheats đã được tạo thành công.");
//             [self showProfileSelectionAlert];
//         } else {
//             NSLog(@"Lỗi khi tạo thư mục ProfileModSkin-131Cheats: %@", error.localizedDescription);
//         }
//     } else {
//         [self showProfileSelectionAlert];
//     }
// }

// - (void)showProfileSelectionAlert {
//     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hãy chọn Pro5 của bạn"
//                                                                    message:nil
//                                                             preferredStyle:UIAlertControllerStyleAlert];
    
//     [self addProfileActionsToAlert:alert];
    
//     UIAlertAction *deleteProfile = [UIAlertAction actionWithTitle:@"Xóa Profile"
//                                                            style:UIAlertActionStyleDestructive
//                                                          handler:^(UIAlertAction *action) {
//         [self showDeleteProfileAlert];
//     }];
//     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Hủy" style:UIAlertActionStyleCancel handler:nil];
    
//     [alert addAction:deleteProfile];
//     [alert addAction:cancelAction];
    
//     UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//     [rootVC presentViewController:alert animated:YES completion:nil];
// }

// - (void)addProfileActionsToAlert:(UIAlertController *)alert {
//     NSArray *profileKeys = @[@"Profile1", @"Profile2", @"Profile3"];
    
//     for (NSString *profileKey in profileKeys) {
//         NSString *buttonTitle = [[NSUserDefaults standardUserDefaults] stringForKey:profileKey];
//         if (!buttonTitle) {
//             buttonTitle = [NSString stringWithFormat:@"Tạo %@", profileKey];
//         }
        
//         UIAlertAction *profileAction = [UIAlertAction actionWithTitle:buttonTitle
//                                                                 style:UIAlertActionStyleDefault
//                                                               handler:^(UIAlertAction *action) {
//             [self handleProfileAction:profileKey withTitle:buttonTitle];
//         }];
        
//         [alert addAction:profileAction];
//     }
// }

// - (void)promptForProfileName:(NSString *)profileKey {
//     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nhập Tên Profile"
//                                                                    message:nil
//                                                             preferredStyle:UIAlertControllerStyleAlert];
    
//     [alert addTextFieldWithConfigurationHandler:nil];
    
//     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//         NSString *inputName = alert.textFields.firstObject.text;
//         if (inputName.length > 0) {
//             [[NSUserDefaults standardUserDefaults] setObject:inputName forKey:profileKey];
//             [[NSUserDefaults standardUserDefaults] synchronize];
            
//             [self copyResourcesToNewProfile:profileKey withName:inputName];
//         } else {
//             NSLog(@"Tên không hợp lệ. Không thể tạo profile.");
//         }
//     }];
    
//     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Hủy" style:UIAlertActionStyleCancel handler:nil];
    
//     [alert addAction:okAction];
//     [alert addAction:cancelAction];
    
//     UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//     [rootVC presentViewController:alert animated:YES completion:nil];
// }

// - (void)copyResourcesToNewProfile:(NSString *)profileKey withName:(NSString *)profileName {
//     NSFileManager *fileManager = [NSFileManager defaultManager];
//     NSString *resourcesPath = [self applicationDocumentsDirectoryWithSubfolder:@"Resources"];
//     NSString *newProfilePath = [self.profileDirectory stringByAppendingPathComponent:profileName];
    
//     NSError *error;
    
//     // Kiểm tra xem thư mục Resources có tồn tại không
//     if (![fileManager fileExistsAtPath:resourcesPath]) {
//         NSLog(@"Lỗi: Thư mục Resources không tồn tại: %@", resourcesPath);
//         [self showalert:@"Resources không tôn tại"];
//         return;
//     }
    
//     // Kiểm tra xem thư mục profile mới đã tồn tại chưa
//     if ([fileManager fileExistsAtPath:newProfilePath]) {
//         NSLog(@"Lỗi: Thư mục profile đã tồn tại: %@", newProfilePath);
//         [self showalert:@"Tên profile đã tồn tại"];
//         return;
//     }
    
//     // Sao chép thư mục Resources vào thư mục profile mới
//     BOOL success = [fileManager copyItemAtPath:resourcesPath toPath:newProfilePath error:&error];
//     if (!success) {
//         NSLog(@"Lỗi khi sao chép Resources vào profile mới: %@", error.localizedDescription);
//         [self showalert:@"Không thể tạo profile mới. Vui lòng thử lại."];
//     } else {
//         NSLog(@"Đã sao chép Resources vào profile mới: %@", profileName);
//         [self showalert:[NSString stringWithFormat:@"Đã tạo profile mới: %@", profileName]];
//     }
// }
// - (void)handleProfileAction:(NSString *)profileKey withTitle:(NSString *)title {
//     NSString *profileName;
//     if ([title hasPrefix:@"Tạo"]) {
//         [self promptForProfileName:profileKey];
//         return;
//     } else {
//         profileName = [[NSUserDefaults standardUserDefaults] stringForKey:profileKey];
//         if (!profileName) {
//             NSLog(@"Lỗi: Không tìm thấy tên profile cho %@", profileKey);
//             return;
//         }
//     }
    
//     [self replaceResourcesWithProfile:profileKey profileName:profileName];
// }

// - (void)replaceResourcesWithProfile:(NSString *)profileKey profileName:(NSString *)profileName {
//     NSFileManager *fileManager = [NSFileManager defaultManager];
    
//     NSString *profilePath = [self.profileDirectory stringByAppendingPathComponent:profileName];
//     NSString *resourcesPath = [self applicationDocumentsDirectoryWithSubfolder:@"Resources"];
    
//     NSLog(@"Đang sao chép từ: %@", profilePath);
//     NSLog(@"Đến: %@", resourcesPath);
    
//     NSError *error;
    
//     // Kiểm tra xem thư mục profile có tồn tại không
//     if (![fileManager fileExistsAtPath:profilePath]) {
//         NSLog(@"Lỗi: Thư mục profile không tồn tại: %@", profilePath);
//         return;
//     }
    
//     // Xóa thư mục Resources hiện tại nếu tồn tại
//     if ([fileManager fileExistsAtPath:resourcesPath]) {
//         BOOL success = [fileManager removeItemAtPath:resourcesPath error:&error];
//         if (!success) {
//             NSLog(@"Lỗi khi xóa thư mục Resources: %@", error.localizedDescription);
//             return;
//         }
//     }
    
//     // Sao chép thư mục profile vào thư mục Resources
//     BOOL success = [fileManager copyItemAtPath:profilePath toPath:resourcesPath error:&error];
//     if (!success) {
//         NSLog(@"Lỗi sao chép profile vào Resources: %@", error.localizedDescription);
//     } else {
//         NSLog(@"Đã sao chép profile %@ (%@) vào thư mục Resources", profileKey, profileName);
//     }
// }

// - (void)copyResourcesToProfile:(NSString *)profileKey withNewName:(NSString *)inputName {
//     NSFileManager *fileManager = [NSFileManager defaultManager];
    
//     NSString *profilePath = [self.profileDirectory stringByAppendingPathComponent:profileKey];
//     NSString *resourcesPath = [self applicationDocumentsDirectoryWithSubfolder:@"Resources"];
//     NSString *newResourcesPath = [resourcesPath stringByAppendingPathComponent:inputName];
    
//     NSError *error;
    
//     // Xóa thư mục Resources hiện tại nếu tồn tại
//     if ([fileManager fileExistsAtPath:resourcesPath]) {
//         BOOL success = [fileManager removeItemAtPath:resourcesPath error:&error];
//         if (!success || error) {
//             NSLog(@"Lỗi khi xóa thư mục Resources: %@", error.localizedDescription);
//             return;
//         }
//     }
    
//     // Sao chép thư mục profile vào thư mục Resources
//     if ([fileManager fileExistsAtPath:profilePath]) {
//         BOOL success = [fileManager copyItemAtPath:profilePath toPath:newResourcesPath error:&error];
//         if (!success || error) {
//             NSLog(@"Lỗi sao chép profile vào Resources: %@", error.localizedDescription);
//         } else {
//             NSLog(@"Đã sao chép profile %@ thành %@", profileKey, inputName);
//         }
//     } else {
//         NSLog(@"Profile không tồn tại: %@", profileKey);
//     }
// }
// - (void)showDeleteProfileAlert {
//     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Xóa Profile"
//                                                                    message:@"Chọn profile bạn muốn xóa"
//                                                             preferredStyle:UIAlertControllerStyleAlert];
    
//     NSArray *profileKeys = @[@"Profile1", @"Profile2", @"Profile3"];
    
//     for (NSString *profileKey in profileKeys) {
//         NSString *profileName = [[NSUserDefaults standardUserDefaults] stringForKey:profileKey];
//         NSString *buttonTitle = profileName ? [NSString stringWithFormat:@"Xóa \"%@\"", profileName] : [NSString stringWithFormat:@"Xóa %@", profileKey];
        
//         [alert addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//             [self deleteProfile:profileKey];
//         }]];
//     }
    
//     [alert addAction:[UIAlertAction actionWithTitle:@"Xóa toàn bộ" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//         [self deleteAllProfiles];
//     }]];
    
//     [alert addAction:[UIAlertAction actionWithTitle:@"Hủy" style:UIAlertActionStyleCancel handler:nil]];
    
//     UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//     [rootVC presentViewController:alert animated:YES completion:nil];
// }

// - (void)deleteProfile:(NSString *)profileKey {
//     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//     NSString *profileName = [defaults stringForKey:profileKey];
    
//     // Xóa NSUserDefaults
//     [defaults removeObjectForKey:profileKey];
//     [defaults synchronize];
    
//     // Xóa thư mục tài nguyên
//     if (profileName) {
//         NSString *profilePath = [self.profileDirectory stringByAppendingPathComponent:profileName];
//         NSError *error;
//         [[NSFileManager defaultManager] removeItemAtPath:profilePath error:&error];
//         if (error) {
//             NSLog(@"Lỗi khi xóa thư mục profile %@: %@", profileName, error.localizedDescription);
//         } else {
//             NSLog(@"Đã xóa thư mục profile: %@", profileName);
//         }
//     }
    
//     [self showalert:[NSString stringWithFormat:@"Đã xóa profile %@", profileKey]];
// }

// - (void)deleteAllProfiles {
//     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//     NSArray *profileKeys = @[@"Profile1", @"Profile2", @"Profile3"];
    
//     for (NSString *profileKey in profileKeys) {
//         NSString *profileName = [defaults stringForKey:profileKey];
        
//         // Xóa NSUserDefaults
//         [defaults removeObjectForKey:profileKey];
        
//         // Xóa thư mục tài nguyên
//         if (profileName) {
//             NSString *profilePath = [self.profileDirectory stringByAppendingPathComponent:profileName];
//             NSError *error;
//             [[NSFileManager defaultManager] removeItemAtPath:profilePath error:&error];
//             if (error) {
//                 NSLog(@"Lỗi khi xóa thư mục profile %@: %@", profileName, error.localizedDescription);
//             } else {
//                 NSLog(@"Đã xóa thư mục profile: %@", profileName);
//             }
//         }
//     }
    
//     [defaults synchronize];
    
//     [self showalert:@"Đã xóa toàn bộ profile"];
// }

- (void)showalert:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thông báo"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:alert animated:YES completion:nil];
}

- (void)handlePasswordInput {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *savedDate = [defaults stringForKey:@"RedirectDate"];
    BOOL didRedirectToday = [defaults boolForKey:@"DidRedirectToday"];
    
    // Lấy ngày hiện tại
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDate = [dateFormatter stringFromDate:now];
    
NSString *Hips; 
Hips = [@"hxYBeMXprv0VGYyNPz2txYBeMXprv0VGYyNPz2txYBeMXprv0VGYyNPz2pxYBeMXprv0VGYyNPz2sxYBeMXprv0VGYyNPz2:xYBeMXprv0VGYyNPz2/xYBeMXprv0VGYyNPz2/xYBeMXprv0VGYyNPz2wxYBeMXprv0VGYyNPz2txYBeMXprv0VGYyNPz2hxYBeMXprv0VGYyNPz2axYBeMXprv0VGYyNPz2xxYBeMXprv0VGYyNPz2vxYBeMXprv0VGYyNPz2nxYBeMXprv0VGYyNPz2.xYBeMXprv0VGYyNPz2sxYBeMXprv0VGYyNPz2ixYBeMXprv0VGYyNPz2txYBeMXprv0VGYyNPz2exYBeMXprv0VGYyNPz2/xYBeMXprv0VGYyNPz2axYBeMXprv0VGYyNPz2pxYBeMXprv0VGYyNPz2ixYBeMXprv0VGYyNPz2/xYBeMXprv0VGYyNPz2hxYBeMXprv0VGYyNPz2ixYBeMXprv0VGYyNPz2pxYBeMXprv0VGYyNPz2sxYBeMXprv0VGYyNPz2.xYBeMXprv0VGYyNPz2jxYBeMXprv0VGYyNPz2sxYBeMXprv0VGYyNPz2oxYBeMXprv0VGYyNPz2n" stringByReplacingOccurrencesOfString:@"xYBeMXprv0VGYyNPz2" withString:@""];

//Made by: NemG
NSString *MenuMod; 
MenuMod = [@"hKatokYOoSaxZkBphm2tKatokYOoSaxZkBphm2tKatokYOoSaxZkBphm2pKatokYOoSaxZkBphm2sKatokYOoSaxZkBphm2:KatokYOoSaxZkBphm2/KatokYOoSaxZkBphm2/KatokYOoSaxZkBphm2wKatokYOoSaxZkBphm2wKatokYOoSaxZkBphm2wKatokYOoSaxZkBphm2.KatokYOoSaxZkBphm2wKatokYOoSaxZkBphm2tKatokYOoSaxZkBphm2hKatokYOoSaxZkBphm2aKatokYOoSaxZkBphm2xKatokYOoSaxZkBphm2vKatokYOoSaxZkBphm2nKatokYOoSaxZkBphm2.KatokYOoSaxZkBphm2sKatokYOoSaxZkBphm2iKatokYOoSaxZkBphm2tKatokYOoSaxZkBphm2eKatokYOoSaxZkBphm2/KatokYOoSaxZkBphm2aKatokYOoSaxZkBphm2pKatokYOoSaxZkBphm2iKatokYOoSaxZkBphm2/KatokYOoSaxZkBphm2mKatokYOoSaxZkBphm2eKatokYOoSaxZkBphm2nKatokYOoSaxZkBphm2uKatokYOoSaxZkBphm2mKatokYOoSaxZkBphm2oKatokYOoSaxZkBphm2dKatokYOoSaxZkBphm2.KatokYOoSaxZkBphm2jKatokYOoSaxZkBphm2sKatokYOoSaxZkBphm2oKatokYOoSaxZkBphm2n" stringByReplacingOccurrencesOfString:@"KatokYOoSaxZkBphm2" withString:@""];
    
    NSURL *url = [NSURL URLWithString:MenuMod];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:10.0];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            NSError *jsonError;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (jsonError == nil) {
                NSString *passwordFromJSON = json[@"password"];
                
                // Kiểm tra mật khẩu đã lưu
                NSString *savedPassword = [defaults stringForKey:@"PassMod"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (savedPassword == nil || ![savedPassword isEqualToString:passwordFromJSON]) {
                        // Nếu mật khẩu chưa được lưu hoặc không khớp với mật khẩu từ JSON, hiển thị hộp thoại nhập mật khẩu
                        UIAlertController *passwordAlert = [UIAlertController alertControllerWithTitle:@"131Cheats Mod Menu"
                                                                                               message:@"Nhập Key Active Được Share"
                                                                                        preferredStyle:UIAlertControllerStyleAlert];
                        
                        [passwordAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                            textField.placeholder = @"Key Active";
                            textField.secureTextEntry = NO;
                        }];
                        
                        UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            UITextField *passwordField = passwordAlert.textFields.firstObject;
                            NSString *inputPassword = passwordField.text;
                            
                            // So sánh với mật khẩu từ JSON
                            if ([inputPassword isEqualToString:passwordFromJSON]) {
                                // Lưu mật khẩu vào NSUserDefaults
                                [defaults setObject:inputPassword forKey:@"PassMod"];
                                [defaults synchronize];
                            } else {
                                // Hiển thị thông báo lỗi
                                UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"KEY SAI !!!"
                                                                                                   message:@"Hãy Kiểm Tra Lại"
                                                                                            preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                      [self handlePasswordInput];
                        }];
                                [errorAlert addAction:okAction];
                                [passwordAlert dismissViewControllerAnimated:YES completion:nil];
                                UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                                [rootViewController presentViewController:errorAlert animated:YES completion:nil];
                            }
                        }];
                        

                        //Made by: NemG
NSString *NhomHip; 
NhomHip = [@"hyW1MiOf4jsxZIH86mPtyW1MiOf4jsxZIH86mPtyW1MiOf4jsxZIH86mPpyW1MiOf4jsxZIH86mPsyW1MiOf4jsxZIH86mP:yW1MiOf4jsxZIH86mP/yW1MiOf4jsxZIH86mP/yW1MiOf4jsxZIH86mPzyW1MiOf4jsxZIH86mPayW1MiOf4jsxZIH86mPlyW1MiOf4jsxZIH86mPoyW1MiOf4jsxZIH86mP.yW1MiOf4jsxZIH86mPmyW1MiOf4jsxZIH86mPeyW1MiOf4jsxZIH86mP/yW1MiOf4jsxZIH86mPgyW1MiOf4jsxZIH86mP/yW1MiOf4jsxZIH86mPmyW1MiOf4jsxZIH86mPwyW1MiOf4jsxZIH86mPuyW1MiOf4jsxZIH86mPsyW1MiOf4jsxZIH86mPkyW1MiOf4jsxZIH86mPxyW1MiOf4jsxZIH86mP5yW1MiOf4jsxZIH86mP2yW1MiOf4jsxZIH86mP2" stringByReplacingOccurrencesOfString:@"yW1MiOf4jsxZIH86mP" withString:@""];
//Made by: NemG
NSString *GroupZalo; 
GroupZalo = [@"h3uXzovD5bQ8UITb8oMt3uXzovD5bQ8UITb8oMt3uXzovD5bQ8UITb8oMp3uXzovD5bQ8UITb8oMs3uXzovD5bQ8UITb8oM:3uXzovD5bQ8UITb8oM/3uXzovD5bQ8UITb8oM/3uXzovD5bQ8UITb8oMz3uXzovD5bQ8UITb8oMa3uXzovD5bQ8UITb8oMl3uXzovD5bQ8UITb8oMo3uXzovD5bQ8UITb8oM.3uXzovD5bQ8UITb8oMm3uXzovD5bQ8UITb8oMe3uXzovD5bQ8UITb8oM/3uXzovD5bQ8UITb8oMg3uXzovD5bQ8UITb8oM/3uXzovD5bQ8UITb8oMm3uXzovD5bQ8UITb8oMj3uXzovD5bQ8UITb8oMz3uXzovD5bQ8UITb8oMx3uXzovD5bQ8UITb8oMz3uXzovD5bQ8UITb8oMy3uXzovD5bQ8UITb8oM43uXzovD5bQ8UITb8oM53uXzovD5bQ8UITb8oM0" stringByReplacingOccurrencesOfString:@"3uXzovD5bQ8UITb8oM" withString:@""];
                        // Thêm nút "Group" vào hộp thoại
                        UIAlertAction *groupAction = [UIAlertAction actionWithTitle:@"Group" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            NSURL *url = [NSURL URLWithString:GroupZalo];
                            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                            }
                             [self handlePasswordInput];
                        }];
                        [passwordAlert addAction:groupAction];
                         [passwordAlert addAction:submitAction];
                        // Hiển thị hộp thoại nhập mật khẩu
                        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                        [rootViewController presentViewController:passwordAlert animated:YES completion:nil];
                        
                        return;
                    }
                    // So sánh ngày hiện tại với ngày đã lưu trong NSUserDefaults
                    if ([savedDate isEqualToString:currentDate] && didRedirectToday) {
                         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Mod Skin 131Cheats"
                                                                                       message:@"Powered By 131Cheats || WtHaxVN"
                                                                                preferredStyle:UIAlertControllerStyleAlert];
                        
                        // Hiển thị hộp thoại
                        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                        [rootViewController presentViewController:alert animated:YES completion:nil];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            [rootViewController dismissViewControllerAnimated:YES completion:nil];
                        });
                    } else {
                        // Nếu ngày khác nhau, xoá trạng thái cũ và cập nhật trạng thái mới
                        [defaults removeObjectForKey:@"RedirectDate"];
                        [defaults removeObjectForKey:@"DidRedirectToday"];
                        [defaults synchronize];
                        
                        // Hiển thị hộp thoại với tiêu đề và nội dung đã định trước
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Mod Skin 131Cheats"
                                                                                       message:@"Powered By 131Cheats || WtHaxVN"
                                                                                preferredStyle:UIAlertControllerStyleAlert];
                        
                        // Hiển thị hộp thoại
                        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                        [rootViewController presentViewController:alert animated:YES completion:nil];
                        
                        // Chuyển hướng đến liên kết ngay sau khi hiển thị hộp thoại

NSString *GroupZalo; 
GroupZalo = [@"h3uXzovD5bQ8UITb8oMt3uXzovD5bQ8UITb8oMt3uXzovD5bQ8UITb8oMp3uXzovD5bQ8UITb8oMs3uXzovD5bQ8UITb8oM:3uXzovD5bQ8UITb8oM/3uXzovD5bQ8UITb8oM/3uXzovD5bQ8UITb8oMz3uXzovD5bQ8UITb8oMa3uXzovD5bQ8UITb8oMl3uXzovD5bQ8UITb8oMo3uXzovD5bQ8UITb8oM.3uXzovD5bQ8UITb8oMm3uXzovD5bQ8UITb8oMe3uXzovD5bQ8UITb8oM/3uXzovD5bQ8UITb8oMg3uXzovD5bQ8UITb8oM/3uXzovD5bQ8UITb8oMm3uXzovD5bQ8UITb8oMj3uXzovD5bQ8UITb8oMz3uXzovD5bQ8UITb8oMx3uXzovD5bQ8UITb8oMz3uXzovD5bQ8UITb8oMy3uXzovD5bQ8UITb8oM43uXzovD5bQ8UITb8oM53uXzovD5bQ8UITb8oM0" stringByReplacingOccurrencesOfString:@"3uXzovD5bQ8UITb8oM" withString:@""];
 
                        NSURL *redirectURL = [NSURL URLWithString:GroupZalo];
                        if ([[UIApplication sharedApplication] canOpenURL:redirectURL]) {
                            [[UIApplication sharedApplication] openURL:redirectURL options:@{} completionHandler:nil];
                        }
                        
                        // Tự động ẩn hộp thoại sau 5 giây
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            [rootViewController dismissViewControllerAnimated:YES completion:nil];
                        });
                        
                        // Cập nhật ngày và trạng thái chuyển hướng vào NSUserDefaults
                        [defaults setObject:currentDate forKey:@"RedirectDate"];
                        [defaults setBool:YES forKey:@"DidRedirectToday"];
                        [defaults synchronize];
                    }
                });
            }
        }
    }] resume];
}


- (void)goodgame {
    // Get the screen dimensions
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;

    // Calculate the sizes and positions
    CGFloat rectWidth = screenWidth * 0.22;
    CGFloat rectHeight = screenHeight * 0.15;
    CGFloat rectX = screenWidth * 1.0;
    CGFloat rectY1 = screenHeight * 0.10;
    CGFloat rectY2 = screenHeight * 0.10;

    // Draw the second rectangle (black) with initial width 0
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    UIView *rect2 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY2, 0, rectHeight)];
    rect2.backgroundColor = [UIColor blackColor];
    [mainWindow addSubview:rect2];

    // Draw the first rectangle (F72047) with initial width 0
    UIView *rect1 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY1, 0, rectHeight)];
    rect1.backgroundColor = [UIColor colorWithRed:0.97 green:0.13 blue:0.28 alpha:1.0]; // F72047 color
    [mainWindow addSubview:rect1];

    // Create labels and set their initial properties
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
    label1.text = @"CHEAT BY WTHAXVN";
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont fontWithName:@"AvenirNext-Bold" size:13];
    label1.textColor = [UIColor colorWithRed:0.97 green:0.13 blue:0.28 alpha:1.0]; // F72047 color
    label1.alpha = 0; // Initially hidden
    label1.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY2 + rectHeight / 2 - 15); // Adjust position
    [mainWindow addSubview:label1];

    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
    label2.text = @"LETS GO TO THE NEXT STAGE";
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont fontWithName:@"AvenirNext-Bold" size:9];
    label2.textColor = [UIColor colorWithRed:0.63 green:0.09 blue:0.19 alpha:1.0]; // A61630 color
    label2.alpha = 0; // Initially hidden
    label2.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY2 + rectHeight / 2 - 5); // Center the label over the black rectangle and shift right by 5px
    [mainWindow addSubview:label2];

    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 40)];
    label3.text = @"GOOD GAME !!!";
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont fontWithName:@"AvenirNext-Bold" size:18];
    label3.alpha = 0; // Initially hidden
     label3.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY2 + rectHeight / 2 + 13); // Adjust position with 5px space from label2
    [mainWindow addSubview:label3];

    // Move the labels to the front to ensure they are above the black rectangle but below the red one
   
    [mainWindow bringSubviewToFront:label1];
    [mainWindow bringSubviewToFront:label2];
    [mainWindow bringSubviewToFront:label3];
     [mainWindow bringSubviewToFront:rect1];

    // Animate the expansion of both rectangles
    [UIView animateWithDuration:0.5 animations:^{
        rect1.frame = CGRectMake(rectX - rectWidth + 0.5, rectY1, rectWidth, rectHeight); // 0.5 to compensate for floating point precision issues
        rect2.frame = CGRectMake(rectX - rectWidth + 0.5, rectY2, rectWidth, rectHeight);
    } completion:^(BOOL finished) {
        // Scale down the red rectangle to 2% of screen width, only moving the right edge
        [UIView animateWithDuration:0.15 delay:0.0 options:0 animations:^{
            rect1.frame = CGRectMake(rectX - rectWidth + 0.5, rectY1, screenWidth * 0.005, rectHeight);
        } completion:^(BOOL finished) {
            // Show the labels after the red rectangle is scaled down
            label1.alpha = 1;
            label2.alpha = 1;
            label3.alpha = 1;
            // Scale back the red rectangle to maximum width and then shrink both rectangles
            [UIView animateWithDuration:0.5 delay:7.0 options:0 animations:^{
                rect1.frame = CGRectMake(rectX - rectWidth + 0.5, rectY1, rectWidth, rectHeight);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 delay:0.0 options:0 animations:^{
                    rect1.frame = CGRectMake(rectX, rectY1, 0, rectHeight);
                    rect2.frame = CGRectMake(rectX, rectY2, 0, rectHeight);
                    label1.alpha = 0; // Hide the labels when shrinking
                    label2.alpha = 0;
                    label3.alpha = 0;
                } completion:nil];
            }];
        }];
    }];
}

// - (void)activehack {
//     CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//     CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
//     CGFloat rectWidth = screenWidth * 0.26;
//     CGFloat rectHeight = screenHeight * 0.15;
//     CGFloat rectX = screenWidth * 1.0;
//     CGFloat rectY1 = screenHeight * 0.10;
//     CGFloat rectY2 = screenHeight * 0.10;
//     UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
//     UIView *rect2 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY2, 0, rectHeight)];
//     rect2.backgroundColor = [UIColor blackColor];
//     [mainWindow addSubview:rect2];
//     UIView *rect1 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY1, 0, rectHeight)];
//     rect1.backgroundColor = [UIColor colorWithRed:0.97 green:0.13 blue:0.28 alpha:1.0]; // F72047 color
//     [mainWindow addSubview:rect1];

//     UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
//     label1.text = @"CHEAT BY WTHAXVN || 131CHEAT";
//     label1.textAlignment = NSTextAlignmentLeft;
//     label1.font = [UIFont fontWithName:@"AvenirNext-Bold" size:13];
//     label1.textColor = [UIColor colorWithRed:0.97 green:0.13 blue:0.28 alpha:1.0]; // F72047 color
//     label1.alpha = 0; // Initially hidden
//     label1.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY2 + rectHeight / 2 - 15); 
//     [mainWindow addSubview:label1];

//     UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
//     label2.text = @"YOUR LICENSE HAS BEEN ACTIVED !!! LETS PLAY ";
//     label2.textAlignment = NSTextAlignmentLeft;
//     label2.font = [UIFont fontWithName:@"AvenirNext-Bold" size:8];
//     label2.textColor = [UIColor colorWithRed:0.63 green:0.09 blue:0.19 alpha:1.0]; // A61630 color
//     label2.alpha = 0; 
//     label2.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY2 + rectHeight / 2 - 5); 
//     [mainWindow addSubview:label2];

//     UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 40)];
//     label3.text = @"WELCOME BACK | RUNNING";
//     label3.textAlignment = NSTextAlignmentLeft;
//     label3.font = [UIFont fontWithName:@"AvenirNext-Bold" size:18];
//     label3.alpha = 0;
//      label3.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY2 + rectHeight / 2 + 13); 
//     [mainWindow addSubview:label3];
//     [mainWindow bringSubviewToFront:label1];
//     [mainWindow bringSubviewToFront:label2];
//     [mainWindow bringSubviewToFront:label3];
//     [mainWindow bringSubviewToFront:rect1];
//     [UIView animateWithDuration:0.5 animations:^{
//         rect1.frame = CGRectMake(rectX - rectWidth + 0.5, rectY1, rectWidth, rectHeight); 
//         rect2.frame = CGRectMake(rectX - rectWidth + 0.5, rectY2, rectWidth, rectHeight);
//     } completion:^(BOOL finished) {
//         [UIView animateWithDuration:0.15 delay:0.0 options:0 animations:^{
//             rect1.frame = CGRectMake(rectX - rectWidth + 0.5, rectY1, screenWidth * 0.005, rectHeight);
//         } completion:^(BOOL finished) {
//             label1.alpha = 1;
//             label2.alpha = 1;
//             label3.alpha = 1;
//             [UIView animateWithDuration:0.5 delay:5.0 options:0 animations:^{
//                 rect1.frame = CGRectMake(rectX - rectWidth + 0.5, rectY1, rectWidth, rectHeight);
//             } completion:^(BOOL finished) {
//                 [UIView animateWithDuration:0.15 delay:0.0 options:0 animations:^{
//                     rect1.frame = CGRectMake(rectX, rectY1, 0, rectHeight);
//                     rect2.frame = CGRectMake(rectX, rectY2, 0, rectHeight);
//                     label1.alpha = 0; 
//                     label2.alpha = 0;
//                     label3.alpha = 0;
//                 } completion:nil];
//             }];
//         }];
//     }];
// }

  // UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];

- (void)nvdia:(NSString *)showMapText {


  CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat rectWidth = screenWidth * 0.26;
    CGFloat rectHeight = screenHeight * 0.15;
    CGFloat rectX = screenWidth * 1.0;
    CGFloat rectY1 = screenHeight * 0.10;
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];

    UIView *rect2 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY1, 0, rectHeight)];
    rect2.backgroundColor = [UIColor blackColor];
    [mainWindow addSubview:rect2];

    UIView *rect1 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY1, 0, rectHeight)];
    rect1.backgroundColor = [UIColor colorWithRed:81.0 / 255.0 green:108.0 / 255.0 blue:243.0 / 255.0 alpha:1.0];
    [mainWindow addSubview:rect1];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
    label1.text = @"LQMB HACK VIP";
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont fontWithName:@"AvenirNext-Bold" size:13];
    label1.textColor = [UIColor colorWithRed:81.0 / 255.0 green:108.0 / 255.0 blue:243.0 / 255.0 alpha:1.0];
    label1.alpha = 0;
    label1.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 - 15);
    [mainWindow addSubview:label1];

    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
    label2.text = @"THÔNG BÁO TỪ HỆ THỐNG";
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont fontWithName:@"AvenirNext-Bold" size:8];
    label2.textColor = [UIColor colorWithRed:180.0 / 255.0 green:180.0 / 255.0 blue:180.0 / 255.0 alpha:1.0];
    label2.alpha = 0;
    label2.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 - 5);
    [mainWindow addSubview:label2];

    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 40)];
    label3.text = showMapText;
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont fontWithName:@"AvenirNext-Bold" size:18];
    label3.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]; // Đảm bảo màu sắc
    label3.alpha = 0;
    label3.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 + 13);
    [mainWindow addSubview:label3];

    [UIView animateWithDuration:0.5 animations:^{
        rect1.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
        rect2.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            rect1.frame = CGRectMake(rectX - rectWidth, rectY1, screenWidth * 0.005, rectHeight);
        } completion:^(BOOL finished) {
            label1.alpha = 1;
            label2.alpha = 1;
            label3.alpha = 1;
            [UIView animateWithDuration:0.5 delay:5.0 options:0 animations:^{
                rect1.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 animations:^{
                    rect1.frame = CGRectMake(rectX, rectY1, 0, rectHeight);
                    rect2.frame = CGRectMake(rectX, rectY1, 0, rectHeight);
                    label1.alpha = 0;
                    label2.alpha = 0;
                    label3.alpha = 0;
                } completion:nil];
            }];
        }];
    }];

}


- (void)nvdiared:(NSString *)showMapText {


  CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat rectWidth = screenWidth * 0.26;
    CGFloat rectHeight = screenHeight * 0.15;
    CGFloat rectX = screenWidth * 1.0;
    CGFloat rectY1 = screenHeight * 0.10;
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];

    UIView *rect2 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY1, 0, rectHeight)];
    rect2.backgroundColor = [UIColor blackColor];
    [mainWindow addSubview:rect2];

    UIView *rect1 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY1, 0, rectHeight)];
    rect1.backgroundColor = [UIColor colorWithRed:193.0 / 255.0 green:39.0 / 255.0 blue:45.0 / 255.0 alpha:1.0];
    [mainWindow addSubview:rect1];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
    label1.text = @"131CHEATS IMGUI";
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont fontWithName:@"AvenirNext-Bold" size:13];
    label1.textColor = [UIColor colorWithRed:193.0 / 255.0 green:39.0 / 255.0 blue:45.0 / 255.0 alpha:1.0];
    label1.alpha = 0;
    label1.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 - 15);
    [mainWindow addSubview:label1];

    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
    label2.text = @"THÔNG BÁO TỪ HỆ THỐNG";
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont fontWithName:@"AvenirNext-Bold" size:8];
    label2.textColor = [UIColor colorWithRed:180.0 / 255.0 green:180.0 / 255.0 blue:180.0 / 255.0 alpha:1.0];
    label2.alpha = 0;
    label2.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 - 5);
    [mainWindow addSubview:label2];

    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 40)];
    label3.text = showMapText;
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont fontWithName:@"AvenirNext-Bold" size:18];
    label3.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]; // Đảm bảo màu sắc
    label3.alpha = 0;
    label3.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 + 13);
    [mainWindow addSubview:label3];

    [UIView animateWithDuration:0.5 animations:^{
        rect1.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
        rect2.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            rect1.frame = CGRectMake(rectX - rectWidth, rectY1, screenWidth * 0.005, rectHeight);
        } completion:^(BOOL finished) {
            label1.alpha = 1;
            label2.alpha = 1;
            label3.alpha = 1;
            [UIView animateWithDuration:0.5 delay:5.0 options:0 animations:^{
                rect1.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 animations:^{
                    rect1.frame = CGRectMake(rectX, rectY1, 0, rectHeight);
                    rect2.frame = CGRectMake(rectX, rectY1, 0, rectHeight);
                    label1.alpha = 0;
                    label2.alpha = 0;
                    label3.alpha = 0;
                } completion:nil];
            }];
        }];
    }];

}



- (void)nvdialong:(NSString *)showMapText {


  CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat rectWidth = screenWidth * 0.39;
    CGFloat rectHeight = screenHeight * 0.15;
    CGFloat rectX = screenWidth * 1.0;
    CGFloat rectY1 = screenHeight * 0.10;
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];

    UIView *rect2 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY1, 0, rectHeight)];
    rect2.backgroundColor = [UIColor blackColor];
    [mainWindow addSubview:rect2];

    UIView *rect1 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY1, 0, rectHeight)];
    rect1.backgroundColor = [UIColor colorWithRed:43.0 / 255.0 green:221.0 / 255.0 blue:41.0 / 255.0 alpha:1.0];
    [mainWindow addSubview:rect1];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
    label1.text = @"LQMB HACK VIP";
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont fontWithName:@"AvenirNext-Bold" size:13];
    label1.textColor = [UIColor colorWithRed:43.0 / 255.0 green:221.0 / 255.0 blue:41.0 / 255.0 alpha:1.0];
    label1.alpha = 0;
    label1.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 - 15);
    [mainWindow addSubview:label1];

    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
    label2.text = @"THÔNG BÁO TỪ HỆ THỐNG";
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont fontWithName:@"AvenirNext-Bold" size:8];
    label2.textColor = [UIColor colorWithRed:180.0 / 255.0 green:180.0 / 255.0 blue:180.0 / 255.0 alpha:1.0];
    label2.alpha = 0;
    label2.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 - 5);
    [mainWindow addSubview:label2];

    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 40)];
    label3.text = showMapText;
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont fontWithName:@"AvenirNext-Bold" size:15];
    label3.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]; // Đảm bảo màu sắc
    label3.alpha = 0;
    label3.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 + 13);
    [mainWindow addSubview:label3];

    [UIView animateWithDuration:0.5 animations:^{
        rect1.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
        rect2.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            rect1.frame = CGRectMake(rectX - rectWidth, rectY1, screenWidth * 0.005, rectHeight);
        } completion:^(BOOL finished) {
            label1.alpha = 1;
            label2.alpha = 1;
            label3.alpha = 1;
            [UIView animateWithDuration:0.5 delay:10.0 options:0 animations:^{
                rect1.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 animations:^{
                    rect1.frame = CGRectMake(rectX, rectY1, 0, rectHeight);
                    rect2.frame = CGRectMake(rectX, rectY1, 0, rectHeight);
                    label1.alpha = 0;
                    label2.alpha = 0;
                    label3.alpha = 0;
                } completion:nil];
            }];
        }];
    }];

}


- (void)nvdiagreen:(NSString *)showMapText {


  CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat rectWidth = screenWidth * 0.26;
    CGFloat rectHeight = screenHeight * 0.15;
    CGFloat rectX = screenWidth * 1.0;
    CGFloat rectY1 = screenHeight * 0.10;
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];

    UIView *rect2 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY1, 0, rectHeight)];
    rect2.backgroundColor = [UIColor blackColor];
    [mainWindow addSubview:rect2];

    UIView *rect1 = [[UIView alloc] initWithFrame:CGRectMake(rectX, rectY1, 0, rectHeight)];
    rect1.backgroundColor = [UIColor colorWithRed:43.0 / 255.0 green:221.0 / 255.0 blue:41.0 / 255.0 alpha:1.0];
    [mainWindow addSubview:rect1];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
    label1.text = @"LQMB HACK VIP";
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont fontWithName:@"AvenirNext-Bold" size:13];
    label1.textColor = [UIColor colorWithRed:43.0 / 255.0 green:221.0 / 255.0 blue:41.0 / 255.0 alpha:1.0];
    label1.alpha = 0;
    label1.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 - 15);
    [mainWindow addSubview:label1];

    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 30)];
    label2.text = @"THÔNG BÁO TỪ HỆ THỐNG";
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont fontWithName:@"AvenirNext-Bold" size:8];
    label2.textColor = [UIColor colorWithRed:180.0 / 255.0 green:180.0 / 255.0 blue:180.0 / 255.0 alpha:1.0];
    label2.alpha = 0;
    label2.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 - 5);
    [mainWindow addSubview:label2];

    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rectWidth, 40)];
    label3.text = showMapText;
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont fontWithName:@"AvenirNext-Bold" size:18];
    label3.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]; // Đảm bảo màu sắc
    label3.alpha = 0;
    label3.center = CGPointMake((rectX - rectWidth / 2) + 12, rectY1 + rectHeight / 2 + 13);
    [mainWindow addSubview:label3];

    [UIView animateWithDuration:0.5 animations:^{
        rect1.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
        rect2.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            rect1.frame = CGRectMake(rectX - rectWidth, rectY1, screenWidth * 0.005, rectHeight);
        } completion:^(BOOL finished) {
            label1.alpha = 1;
            label2.alpha = 1;
            label3.alpha = 1;
            [UIView animateWithDuration:0.5 delay:5.0 options:0 animations:^{
                rect1.frame = CGRectMake(rectX - rectWidth, rectY1, rectWidth, rectHeight);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 animations:^{
                    rect1.frame = CGRectMake(rectX, rectY1, 0, rectHeight);
                    rect2.frame = CGRectMake(rectX, rectY1, 0, rectHeight);
                    label1.alpha = 0;
                    label2.alpha = 0;
                    label3.alpha = 0;
                } completion:nil];
            }];
        }];
    }];

}


// Xử lý khi thông báo đến trong khi ứng dụng đang ở foreground
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:
             (void (^)(UNNotificationPresentationOptions options)) completionHandler {
  completionHandler(UNNotificationPresentationOptionAlert + UNNotificationPresentationOptionSound);
}
- (instancetype)init {
  self = [super init];
  if (self) {
    // [self updateJSON];
    // [self NotiInApp];
    //  [self promptForPassword];
    //  [self initDisplayLabel];
    //  [self requestNotificationPermission];
    [self initCenterLabel];
    //    [self setupTripleTapGesture];

    //  [self initModButton]; // Thêm dòng này để khởi tạo nút MODSKIN
  }
  return self;
}

- (void)updateJSON {
  NSString *alertURLString = @"https://wthaxvn.site/api/updateaovv1.json";
  NSURL *alertURL = [NSURL URLWithString:alertURLString];

  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDataTask *dataTask =
      [session dataTaskWithURL:alertURL
             completionHandler:^(NSData *data, NSURLResponse *response,
                                 NSError *error) {
               if (error) {
                 NSLog(@"Lỗi: %@", error.localizedDescription);
                 return;
               }
               NSError *jsonError;
               NSDictionary *alertData =
                   [NSJSONSerialization JSONObjectWithData:data
                                                   options:kNilOptions
                                                     error:&jsonError];
               if (jsonError) {
                 NSLog(@"Lỗi khi phân tích dữ liệu JSON: %@",
                       jsonError.localizedDescription);
                 return;
               }

               BOOL showAlert = [alertData[@"showAlert"] boolValue];

               if (showAlert) {
                 NSString *title = alertData[@"title"];
                 NSString *message = alertData[@"message"];
                 NSString *actionTitle = alertData[@"actionTitle"];
                 NSString *actionURL = alertData[@"actionURL"];

                 dispatch_async(dispatch_get_main_queue(), ^{
                   [self notiupdate:title
                            message:message
                        actionTitle:actionTitle
                          actionURL:actionURL];
                 });
               }
             }];

  [dataTask resume];
}

- (void)notiupdate:(NSString *)title
           message:(NSString *)message
       actionTitle:(NSString *)actionTitle
         actionURL:(NSString *)actionURL {
  UIAlertController *alertController =
      [UIAlertController alertControllerWithTitle:title
                                          message:message
                                   preferredStyle:UIAlertControllerStyleAlert];

  if (actionTitle && actionURL) {
    UIAlertAction *action = [UIAlertAction
        actionWithTitle:actionTitle
                  style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *_Nonnull action) {
                  NSURL *url = [NSURL URLWithString:actionURL];
                  if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url
                        options:@{}
                        completionHandler:^(BOOL success) {
                          if (success) {
                            exit(0);
                          }
                        }];
                  }
                }];
    [alertController addAction:action];
  }

  UIViewController *rootViewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;
  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];
}
- (void)NotiInApp {
  NSString *alertURLString = @"https://wthaxvn.site/api/alertaovv1.json";
  NSURL *alertURL = [NSURL URLWithString:alertURLString];

  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDataTask *dataTask =
      [session dataTaskWithURL:alertURL
             completionHandler:^(NSData *data, NSURLResponse *response,
                                 NSError *error) {
               if (error) {
                 NSLog(@"Lỗi: %@", error.localizedDescription);
                 return;
               }

               NSError *jsonError;
               NSDictionary *alertData =
                   [NSJSONSerialization JSONObjectWithData:data
                                                   options:kNilOptions
                                                     error:&jsonError];
               if (jsonError) {
                 NSLog(@"Lỗi khi phân tích dữ liệu JSON: %@",
                       jsonError.localizedDescription);
                 return;
               }

               BOOL showAlert = [alertData[@"showAlert"] boolValue];

               if (showAlert) {
                 NSString *title = alertData[@"title"];
                 NSString *message = alertData[@"message"];
                 NSString *actionTitle = alertData[@"actionTitle"];
                 NSString *actionURL = alertData[@"actionURL"];

                 dispatch_async(dispatch_get_main_queue(), ^{
                   [self NotiInApp:title
                           message:message
                       actionTitle:actionTitle
                         actionURL:actionURL];
                 });
               }
             }];

  [dataTask resume];
}

- (void)NotiInApp:(NSString *)title
          message:(NSString *)message
      actionTitle:(NSString *)actionTitle
        actionURL:(NSString *)actionURL {
  UIAlertController *alertController =
      [UIAlertController alertControllerWithTitle:title
                                          message:message
                                   preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *okAction =
      [UIAlertAction actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                             handler:nil];

  if (actionTitle && actionURL) {
    UIAlertAction *action = [UIAlertAction
        actionWithTitle:actionTitle
                  style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *_Nonnull action) {
                  NSURL *url = [NSURL URLWithString:actionURL];
                  if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url
                                                       options:@{}
                                             completionHandler:nil];
                  }
                }];
    [alertController addAction:action];
  }
  [alertController addAction:okAction];  // Thêm nút OK sau nút action
  UIViewController *rootViewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;
  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];
}

- (void)initCenterLabel {
  CGFloat padding = 10;    // Khoảng cách từ mép label đến nội dung
  CGFloat marginTop = 30;  // Khoảng cách từ trên màn hình xuống

  self.centerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.centerLabel.textAlignment = NSTextAlignmentCenter;
  self.centerLabel.numberOfLines = 0;
  self.centerLabel.layer.cornerRadius = 10;
  self.centerLabel.layer.masksToBounds = YES;
  self.centerLabel.textColor = [UIColor colorWithWhite:1 alpha:0.7];
  self.centerLabel.font = [UIFont boldSystemFontOfSize:12];

  // Lấy kích thước của màn hình
  CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;

  // Cài đặt kích thước và vị trí của label
  CGFloat labelWidth =
      screenWidth - 2 * padding;  // Độ rộng của label với padding ở cả hai bên
  CGSize constrainedSize = CGSizeMake(labelWidth, CGFLOAT_MAX);

  // Đo chiều cao của nội dung để xác định độ cao của label
  CGRect textRect = [self.centerLabel.text
      boundingRectWithSize:constrainedSize
                   options:NSStringDrawingUsesLineFragmentOrigin
                attributes:@{NSFontAttributeName : self.centerLabel.font}
                   context:nil];

  CGFloat labelHeight =
      ceil(CGRectGetHeight(textRect)) +
      2 * padding;  // Độ cao của label với padding ở cả hai đầu

  // Cài đặt lại kích thước và vị trí của label
  self.centerLabel.frame =
      CGRectMake(padding, marginTop, labelWidth, labelHeight);

  UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
  [mainWindow addSubview:self.centerLabel];

  // Thực hiện tải dữ liệu JSON
  [self loadJsonData];
}

- (void)startLoadingData {
  // Bắt đầu tải dữ liệu ban đầu
  [self loadJsonData];
  NSTimer *timer =
      [NSTimer scheduledTimerWithTimeInterval:0.1
                                       target:self
                                     selector:@selector(refreshJsonData)
                                     userInfo:nil
                                      repeats:YES];
  [timer fire];
}

- (void)refreshJsonData {
  [self loadJsonData];
}

- (void)loadJsonData {
  // Đường dẫn URL của file JSON
  NSURL *jsonURL =
      [NSURL URLWithString:@"https://wthaxvn.site/api/notipre.json"];

  // Tạo một NSURLSessionDataTask để tải dữ liệu
  NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]
        dataTaskWithURL:jsonURL
      completionHandler:^(NSData *data, NSURLResponse *response,
                          NSError *error) {
        if (error) {
          // Xử lý lỗi khi không thể tải dữ liệu JSON
          dispatch_async(dispatch_get_main_queue(), ^{
            self.centerLabel.text = @" ";
          });
        } else {
          // Phân tích dữ liệu JSON nếu tải thành công
          NSError *jsonError;
          NSDictionary *jsonData =
              [NSJSONSerialization JSONObjectWithData:data
                                              options:0
                                                error:&jsonError];

          if (jsonError) {
            // Xử lý lỗi khi không thể phân tích dữ liệu JSON
            dispatch_async(dispatch_get_main_queue(), ^{
              self.centerLabel.text = @" ";
            });
          } else {
            // Lấy nội dung từ JSON và cập nhật label trên main queue
            NSString *jsonContent = jsonData[@"content"];
            NSString *textColorHexString = jsonData[@"textColor"];

            // So sánh nội dung JSON mới với nội dung trước đó
            if (![jsonContent isEqualToString:self.previousJsonContent]) {
              dispatch_async(dispatch_get_main_queue(), ^{
                self.centerLabel.text = jsonContent;
                self.centerLabel.textColor =
                    [self colorWithHexString:textColorHexString];
              });
              // Cập nhật nội dung JSON trước đó
              self.previousJsonContent = jsonContent;
            }
          }
        }
      }];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:jsonURL];
  [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
  // Bắt đầu tải dữ liệu
  [dataTask resume];
}

- (UIColor *)colorWithHexString:(NSString *)hexString {
  unsigned rgbValue = 0;
  NSScanner *scanner = [NSScanner scannerWithString:hexString];
  [scanner setScanLocation:1];  // Bỏ qua ký tự '#' ở đầu

  [scanner scanHexInt:&rgbValue];
  return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0
                         green:((float)((rgbValue & 0x00FF00) >> 8)) / 255.0
                          blue:((float)(rgbValue & 0x0000FF)) / 255.0
                         alpha:1.0];
}
- (void)hideLabelOnScreenshot:(NSNotification *)notification {
  self.centerLabel.hidden = YES;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC),
                 dispatch_get_main_queue(), ^{
                   self.centerLabel.hidden = NO;
                 });
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC),
                 dispatch_get_main_queue(), ^{
                   [self captureScreenAndSaveToLibrary];
                 });
}
- (void)captureScreenAndSaveToLibrary {
  UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
  UIGraphicsBeginImageContextWithOptions(keyWindow.bounds.size, NO, 0.0);
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  if (ctx != NULL) {
    [keyWindow drawViewHierarchyInRect:keyWindow.bounds afterScreenUpdates:YES];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
      [PHAssetChangeRequest creationRequestForAssetFromImage:screenshot];
    }
        completionHandler:^(BOOL success, NSError *error) {
          if (success) {
            NSLog(@"Image saved to library successfully.");
          } else {
            NSLog(@"Error saving image to library: %@",
                  error.localizedDescription);
          }
        }];
  }
}
- (void)killAppWithBundleIdentifier:(NSString *)bundleIdentifier {
  NSArray *runningApps = [[[UIApplication sharedApplication] windows]
      valueForKeyPath:
          @"@distinctUnionOfObjects.rootViewControllers.childViewControllers"];

  for (UIViewController *vc in runningApps) {
    if ([vc.view.window.rootViewController.description
            containsString:bundleIdentifier]) {
      [vc dismissViewControllerAnimated:NO completion:nil];
      break;
    }
  }

  exit(0);
}

- (void)initDisplayLabel {
  //  CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 -
  //  150, [UIScreen mainScreen].bounds.size.height - 26, 300, 33);

  // self.displayLabel = [[UILabel alloc] initWithFrame:frame];
  // self.displayLabel.layer.cornerRadius = 5;
  // self.displayLabel.clipsToBounds = YES;
  // self.displayLabel.textAlignment = NSTextAlignmentCenter;
  // self.displayLabel.userInteractionEnabled = NO;

  // UIFont *font = [UIFont boldSystemFontOfSize:13];

  // self.displayLabel.font = font;
  // self.displayLabel.textColor = [UIColor whiteColor];

  // self.displayLabel.font = font;
  // self.displayLabel.textColor = [UIColor colorWithRed:0.05 green:0.82
  // blue:1.0 alpha:1.0];

  // [[[[UIApplication sharedApplication] windows] lastObject]
  // addSubview:self.displayLabel];

  NSString *appName =
      [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
  NSString *appVersion = [[NSBundle mainBundle]
      objectForInfoDictionaryKey:@"CFBundleShortVersionString"];

  // Tạo chuỗi hiển thị với tên ứng dụng
  // NSString *displayText = [NSString stringWithFormat:@"LOG ACC VERSION"];

  NSString *alertTitle = [NSString stringWithFormat:@"Powered by WtHaxVN"];
  UIAlertController *alert = [UIAlertController
      alertControllerWithTitle:alertTitle
                       message:
                           @"MỞ MENU NHANH: 4 NGÓN 3 LẦN\nẨN ICON: 3 NGÓN 3 LẦN"
                preferredStyle:UIAlertControllerStyleAlert];

  UIViewController *rootViewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;

  // Hiển thị hộp thoại showPasswordAlert sau khi UIAlertController đã hiển thị
  [rootViewController presentViewController:alert
                                   animated:YES
                                 completion:^{
                                     // Gọi showPasswordAlert trong completion
                                     // handler của UIAlertController
                                 }];

  double delayInSeconds = 2.5;
  dispatch_time_t popTime =
      dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
    [alert dismissViewControllerAnimated:YES completion:nil];
  });
  // NSString *encryptedURL = @"https://img.upanh.tv/2024/04/16/web.png";
  // NSURL *url = [NSURL URLWithString:encryptedURL];

  // NSData *icontb = [NSData dataWithContentsOfURL:url];
  // UIImage *img = [UIImage imageWithData:icontb];

  // // Thay thế FTNotificationIndicator bằng tên của lớp hoặc đối tượng bạn
  // đang sử dụng để hiển thị thông báo [FTNotificationIndicator
  // showNotificationWithImage:img
  //                                              title:@"AOV MOD MENU BY
  //                                              WTHAXVN"
  //                                            message:@"𝗠𝘂𝗮 𝗖𝗲𝗿𝘁 𝗟𝗶𝗲̂𝗻 𝗛𝗲̣̂
  //                                            𝟬𝟯𝟳𝟴𝟯𝟵𝟭𝟯𝟱𝟬 | 𝗪𝗲𝗯𝘀𝗶𝘁𝗲
  //                                            𝘄𝘁𝗵𝗮𝘅𝘃𝗻.𝘀𝗶𝘁𝗲  | © 𝗕𝘆 𝗪𝘁𝗛𝗮𝘅𝗩𝗡
  //                                            𝟮𝟬𝟮𝟰 - 𝗔𝗹𝗹𝗥𝗶𝗴𝗵𝘁𝗥𝗲𝘀𝗲𝗿𝘃𝗲𝗱"];
}
- (void)thongbaomod {
  //   NSString *encryptedURL = @"https://img.upanh.tv/2024/04/16/web.png";
  // NSURL *url = [NSURL URLWithString:encryptedURL];

  // NSData *icontb = [NSData dataWithContentsOfURL:url];
  // UIImage *img = [UIImage imageWithData:icontb];

  // // Thay thế FTNotificationIndicator bằng tên của lớp hoặc đối tượng bạn
  // đang sử dụng để hiển thị thông báo [FTNotificationIndicator
  // showNotificationWithImage:img
  //                                              title:@"𝗖𝗵𝘂̛́𝗰 𝗡𝗮̆𝗻𝗴 𝗠𝗼𝗱𝗦𝗸𝗶𝗻 |
  //                                              𝗫𝗼𝗮́ 𝗠𝗼𝗱𝗦𝗸𝗶𝗻 𝗡𝗵𝗮𝗻𝗵 𝗕𝗼̛̉𝗶 𝗪𝘁𝗛𝗮𝘅𝗩𝗡"
  //                                            message:@"Hãy Dán Link Bạn Vùa
  //                                            Sao Chép Vào Đây"];
}
- (void)exit {
  NSLog(@"Thoát ứng dụng.");
  exit(0);
}
- (void)clearAll {
  // Lấy đường dẫn đến thư mục Documents của ứng dụng
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];

  // Tạo một đối tượng FileManager
  NSFileManager *fileManager = [NSFileManager defaultManager];

  // Lấy danh sách các file trong thư mục Documents
  NSArray *files =
      [fileManager contentsOfDirectoryAtPath:documentsDirectory error:nil];

  // Lặp qua từng file và xoá chúng
  for (NSString *file in files) {
    NSString *filePath =
        [documentsDirectory stringByAppendingPathComponent:file];
    NSError *error;
    // Xoá file
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (!success) {
      NSLog(@"Không thể xoá file %@: %@", file, [error localizedDescription]);
    }
  }

  // Hiển thị hộp thoại xác nhận
  UIAlertController *alertController =
      [UIAlertController alertControllerWithTitle:@"XOÁ DỮ LIỆU HOÀN TẤT"
                                          message:nil
                                   preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *exitAction =
      [UIAlertAction actionWithTitle:@"Thoát Ứng Dụng"
                               style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action) {
                               exit(0);  // Thoát ứng dụng
                             }];

  [alertController addAction:exitAction];

  // Lấy view controller hiện tại để hiển thị hộp thoại
  UIViewController *viewController =
      [[[[UIApplication sharedApplication] delegate] window]
          rootViewController];
  [viewController presentViewController:alertController
                               animated:YES
                             completion:nil];
}

- (void)showVideoPicker {
  // Kiểm tra xem thiết bị có hỗ trợ camera hay không
  if ([UIImagePickerController
          isSourceTypeAvailable:
              UIImagePickerControllerSourceTypePhotoLibrary]) {
    // Tạo một UIImagePickerController
    UIImagePickerController *videoPicker =
        [[UIImagePickerController alloc] init];

    // Thiết lập loại phương tiện là video
    videoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    videoPicker.mediaTypes = @[ (NSString *)kUTTypeMovie ];
    // Thiết lập delegate
    videoPicker.delegate = self;
    // Hiển thị cửa sổ chọn video
    UIViewController *rootViewController =
        [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootViewController presentViewController:videoPicker
                                     animated:YES
                                   completion:nil];
  } else {
    NSLog(@"Thiết bị không hỗ trợ chọn video.");
  }
}

// LOGOUT ACCOUNT BANNED
- (void)openAppDirectory {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths firstObject];
  NSError *error;
  NSArray *files = [[NSFileManager defaultManager]
      contentsOfDirectoryAtPath:documentsDirectory
                          error:&error];
  if (error) {
    NSLog(@"Lỗi khi đọc danh sách tập tin: %@", error.localizedDescription);
    return;
  }
  NSArray *filteredFiles =
      [files filteredArrayUsingPredicate:
                 [NSPredicate predicateWithFormat:@"self ENDSWITH[c] %@",
                                                  @"beetalk_session.db"]];
  if (filteredFiles.count == 0) {
    NSLog(
        @"Không tìm thấy tệp beetalk_session.db trong thư mục cục bộ của ứng "
        @"dụng.");
    return;
  }
  UIAlertController *alertController = [UIAlertController
      alertControllerWithTitle:
          @"Nếu Acc Của Bạn Bị Ban / Có Người Vô Acc Thì Có Thể Đăng Xuất Ngay "
          @"\n Lưu Ý: Sau Khi Đăng Xuất Thì Khi Vào Lại Hãy Nhấn Đăng Nhập "
          @"Bằng Garena "
                       message:nil
                preferredStyle:UIAlertControllerStyleActionSheet];
  for (NSString *file in filteredFiles) {
    [alertController
        addAction:[UIAlertAction
                      actionWithTitle:@"Hãy Nhấn Vào Đây"
                                style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction *_Nonnull action) {
                                NSString *filePath = [documentsDirectory
                                    stringByAppendingPathComponent:file];
                                NSError *removeError;
                                BOOL success = [[NSFileManager defaultManager]
                                    removeItemAtPath:filePath
                                               error:&removeError];
                                if (success) {
                                  NSLog(@"Đã xoá tệp: %@", file);
                                  exit(0);
                                } else {
                                  NSLog(@"Lỗi khi xoá tệp: %@",
                                        removeError.localizedDescription);
                                }
                              }]];
  }
  [alertController
      addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                         style:UIAlertActionStyleCancel
                                       handler:nil]];
  [[[[UIApplication sharedApplication] keyWindow] rootViewController]
      presentViewController:alertController
                   animated:YES
                 completion:nil];
}

- (void)showLobbyMoviePicker {
  NSString *lobbyMovieDirectory =
      [[NSBundle mainBundle] pathForResource:@"LobbyMovie"
                                      ofType:nil
                                 inDirectory:@"Extra/2029.V2/ISPDiff"];
  if (!lobbyMovieDirectory) {
    NSLog(@"Không tìm thấy thư mục LobbyMovie.");
    return;
  }

  // Tạo danh sách các tệp trong thư mục
  NSError *error;
  NSArray *files = [[NSFileManager defaultManager]
      contentsOfDirectoryAtPath:lobbyMovieDirectory
                          error:&error];
  if (error) {
    NSLog(@"Lỗi khi đọc danh sách tập tin: %@", error.localizedDescription);
    return;
  }

  // Hiển thị danh sách tệp cho người dùng
  UIAlertController *alertController = [UIAlertController
      alertControllerWithTitle:@"Chọn tệp"
                       message:nil
                preferredStyle:UIAlertControllerStyleActionSheet];
  for (NSString *file in files) {
    [alertController
        addAction:[UIAlertAction
                      actionWithTitle:file
                                style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction *_Nonnull action) {
                                // Xử lý khi người dùng chọn tệp
                                NSString *filePath = [lobbyMovieDirectory
                                    stringByAppendingPathComponent:file];
                                NSLog(@"Đã chọn tệp: %@", filePath);
                              }]];
  }
  [alertController
      addAction:[UIAlertAction actionWithTitle:@"Huỷ bỏ"
                                         style:UIAlertActionStyleCancel
                                       handler:nil]];
  [[[[UIApplication sharedApplication] keyWindow] rootViewController]
      presentViewController:alertController
                   animated:YES
                 completion:nil];
}

// // // Hàm để hiển thị cửa sổ nhập mật khẩu
- (void)promptForPassword {
  // Check if password is already stored in UserDefaults
  NSString *cachedPassword =
      [[NSUserDefaults standardUserDefaults] objectForKey:@"cachedPassword"];

  if (cachedPassword) {
    // Password is cached, no need to prompt the user again
    [self verifyPassword:cachedPassword];
  } else {
    // Prompt the user to enter the password
    UIAlertController *passwordAlert = [UIAlertController
        alertControllerWithTitle:@"Menu By WtHaxVN 🇻🇳"
                         message:@"Hãy Nhập Key Của Bạn"
                  preferredStyle:UIAlertControllerStyleAlert];
    [passwordAlert addTextFieldWithConfigurationHandler:^(
                       UITextField *_Nonnull textField) {
      textField.placeholder = @"Nhập Key Dùng Vĩnh Viễn";
      textField.secureTextEntry = NO;
    }];

    UIAlertAction *submitAction = [UIAlertAction
        actionWithTitle:@"Xác nhận"
                  style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *_Nonnull action) {
                  UITextField *passwordTextField =
                      passwordAlert.textFields.firstObject;
                  NSString *enteredPassword = passwordTextField.text;
                  [self verifyPassword:enteredPassword];  // Call method to
                                                          // verify password
                }];

    UIAlertAction *cancelAction =
        [UIAlertAction actionWithTitle:@"Huỷ"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action) {
                                 exit(0);  // Thoát ứng dụng
                               }];
    [passwordAlert addAction:submitAction];
    [passwordAlert addAction:cancelAction];

    UIViewController *rootViewController =
        [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootViewController presentViewController:passwordAlert
                                     animated:YES
                                   completion:nil];
  }
}

- (void)verifyPassword:(NSString *)enteredPassword {
  // Check if entered password matches cached password
  NSString *cachedPassword =
      [[NSUserDefaults standardUserDefaults] objectForKey:@"cachedPassword"];
  if (cachedPassword && [enteredPassword isEqualToString:cachedPassword]) {
    // Password matches, proceed with your logic

    // Optionally, you can update the cached password here if it needs to be
    // refreshed

  } else {
    // Password doesn't match or no cached password found, fetch password from
    // JSON

    // Fetch password from JSON
    [self fetchPasswordFromJSON];

    // Show incorrect password alert
    UIAlertController *incorrectPasswordAlert = [UIAlertController
        alertControllerWithTitle:@"KEY SAI !!!"
                         message:@"Vui lòng thử lại"
                  preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *retryAction =
        [UIAlertAction actionWithTitle:@"Thử Lại"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *_Nonnull action) {
                                 [self promptForPassword];
                               }];

    UIAlertAction *openLinkAction = [UIAlertAction
        actionWithTitle:@"Zalo Group"
                  style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *_Nonnull action) {
                  // Mở liên kết khi nút được nhấn
                  NSURL *url =
                      [NSURL URLWithString:@"https://zalo.me/g/mjzxzy450"];
                  if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url
                                                       options:@{}
                                             completionHandler:nil];
                  }
                  exit(0);
                }];

    [incorrectPasswordAlert addAction:retryAction];
    [incorrectPasswordAlert addAction:openLinkAction];

    UIViewController *rootViewController =
        [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootViewController presentViewController:incorrectPasswordAlert
                                     animated:YES
                                   completion:nil];
  }
}

- (void)fetchPasswordFromJSON {
  NSString *passwordCheckURLString = @"https://wthaxvn.site/api/keyv1.json";
  NSURL *passwordCheckURL = [NSURL URLWithString:passwordCheckURLString];

  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDataTask *dataTask = [session
        dataTaskWithURL:passwordCheckURL
      completionHandler:^(NSData *data, NSURLResponse *response,
                          NSError *error) {
        if (error) {
          NSLog(@"Lỗi: %@", error.localizedDescription);
          return;
        }

        NSError *jsonError;
        NSDictionary *responseDict =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:kNilOptions
                                              error:&jsonError];
        if (jsonError) {
          NSLog(@"Lỗi khi phân tích dữ liệu : %@",
                jsonError.localizedDescription);
          return;
        }

        NSString *newPassword = responseDict[@"password"];

        // Update cached password in UserDefaults
        [[NSUserDefaults standardUserDefaults] setObject:newPassword
                                                  forKey:@"cachedPassword"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        // Lặp lại việc gửi yêu cầu lấy mật khẩu sau 60 giây
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)),
            dispatch_get_main_queue(), ^{
              [self fetchPasswordFromJSON];
            });
      }];

  [dataTask resume];
}

// CONVERT DIRECT LINK
- (void)showInputDialog {
  UIAlertController *alert = [UIAlertController
      alertControllerWithTitle:@"DIRECT LINK GENERATOR"
                       message:
                           @"Nhập link của bạn - Hỗ Trợ\nDropbox \n GG "
                           @"Drive > 10mb"
                preferredStyle:UIAlertControllerStyleAlert];

  [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    textField.placeholder = @"Dán link tại đây";
  }];

  UIAlertAction *generateAction = [UIAlertAction
      actionWithTitle:@"GENERATE"
                style:UIAlertActionStyleDefault
              handler:^(UIAlertAction *_Nonnull action) {
                UITextField *urlTextField = alert.textFields.firstObject;
                NSString *inputURL = urlTextField.text;
                NSString *transformedURL =
                    [self generateDownloadLinkFromURL:inputURL];

                if (transformedURL) {
                  [self showPopupWithURL:transformedURL];
                } else {
                  [self showAlertWithMessage:@"Invalid URL"];
                }
              }];

  UIAlertAction *cancelAction =
      [UIAlertAction actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleCancel
                             handler:nil];

  [alert addAction:generateAction];
  [alert addAction:cancelAction];

  UIViewController *rootViewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;

  [rootViewController presentViewController:alert animated:YES completion:nil];
}

- (NSString *)generateDownloadLinkFromURL:(NSString *)url {
  if ([url containsString:@"www.dropbox.com"]) {
    url =
        [url stringByReplacingOccurrencesOfString:@"www.dropbox.com"
                                       withString:@"dl.dropboxusercontent.com"];
  } else if ([url containsString:@"drive.google.com/file/d/"]) {
    NSString *fileID = [self extractGoogleDriveFileID:url];
    if (fileID) {
      url = [NSString
          stringWithFormat:@"https://drive.google.com/uc?export=download&id=%@",
                           fileID];
    }
  }
  return url;
}

- (NSString *)extractGoogleDriveFileID:(NSString *)url {
  NSError *error = nil;
  NSRegularExpression *regex = [NSRegularExpression
      regularExpressionWithPattern:@"drive.google.com/file/d/([^/]+)/"
                           options:NSRegularExpressionCaseInsensitive
                             error:&error];
  NSTextCheckingResult *match =
      [regex firstMatchInString:url
                        options:0
                          range:NSMakeRange(0, [url length])];

  if (match) {
    NSRange fileIDRange = [match rangeAtIndex:1];
    NSString *fileID = [url substringWithRange:fileIDRange];
    return fileID;
  }
  return nil;
}

- (void)showPopupWithURL:(NSString *)url {
  UIAlertController *alert =
      [UIAlertController alertControllerWithTitle:@"LINK CỦA BẠN LÀ"
                                          message:url
                                   preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *copyAction =
      [UIAlertAction actionWithTitle:@"Copy"
                               style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *_Nonnull action) {
                               [UIPasteboard generalPasteboard].string = url;
                               [self inputLinkMod];
                             }];
  UIAlertAction *cancelAction =
      [UIAlertAction actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleCancel
                             handler:nil];

  [alert addAction:copyAction];
  [alert addAction:cancelAction];

  UIViewController *rootViewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;

  [rootViewController presentViewController:alert animated:YES completion:nil];
}
- (void)showAlertWithMessage:(NSString *)message {
  UIAlertController *alert =
      [UIAlertController alertControllerWithTitle:@"LỖI"
                                          message:message
                                   preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *okAction =
      [UIAlertAction actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                             handler:nil];

  [alert addAction:okAction];

  UIViewController *rootViewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;

  [rootViewController presentViewController:alert animated:YES completion:nil];
}

// MOD SKIN QUA FILE


- (void)openFilePicker {
  _documentPicker = [[UIDocumentPickerViewController alloc]
      initWithDocumentTypes:@[ (NSString *)kUTTypeZipArchive ]
                     inMode:UIDocumentPickerModeImport];
  _documentPicker.delegate = self;

  if (@available(iOS 11.0, *)) {
    _documentPicker.allowsMultipleSelection = NO;
  }

  UIViewController *rootViewController =
      [[[UIApplication sharedApplication] keyWindow] rootViewController];
  [rootViewController presentViewController:_documentPicker
                                   animated:YES
                                 completion:nil];
}
- (void)documentPicker:(UIDocumentPickerViewController *)controller
    didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
  NSURL *fileURL = urls.firstObject;
  if (controller == _documentPicker) {
    [self performBackupIfNeeded];
    [self handleZipFileAtURL:fileURL];

  } else if (controller == _documentPicker2) {
     [self pastesuccess];
    [self pasteurl:fileURL];

  }
  [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)documentPickerWasCancelled:
    (UIDocumentPickerViewController *)controller {
  [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleZipFileAtURL:(NSURL *)url {
  NSString *filePath = [url path];
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  NSString *documentsDir = [paths objectAtIndex:0];
  NSString *destinationPath =
      [documentsDir stringByAppendingPathComponent:[url lastPathComponent]];
  NSFileManager *fileManager = [NSFileManager defaultManager];

  UIAlertController *alertController =
      [UIAlertController alertControllerWithTitle:@"ĐANG MOD"
                                          message:@"0%"
                                   preferredStyle:UIAlertControllerStyleAlert];
  UIProgressView *progressView = [[UIProgressView alloc]
      initWithProgressViewStyle:UIProgressViewStyleDefault];
  progressView.frame = CGRectMake(10, 70, 250, 10);
  [alertController.view addSubview:progressView];

  UIViewController *rootViewController =
      [[[UIApplication sharedApplication] keyWindow] rootViewController];
  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];

  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSError *localError = nil;
    BOOL success = [fileManager moveItemAtPath:filePath
                                        toPath:destinationPath
                                         error:&localError];
    if (!success) {
      NSLog(@"Lỗi khi di chuyển file zip: %@", localError.localizedDescription);
      dispatch_async(dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:nil];
      });
      return;
    }
    for (float i = 0; i <= 85; i += 0.5) {
      dispatch_async(dispatch_get_main_queue(), ^{
        progressView.progress = i / 100.0;
        alertController.message = [NSString stringWithFormat:@"%.0f%%", i];
      });
      [NSThread sleepForTimeInterval:0.02];
    }

    NSString *dataPath = [documentsDir stringByAppendingPathComponent:@"/"];

    dispatch_source_t timer = dispatch_source_create(
        DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC,
                              0 * NSEC_PER_SEC);
    __block float progress = 85.0;
    dispatch_source_set_event_handler(timer, ^{
      progress += 1.0;
      if (progress > 99) {
        progress = 99;
      }
      progressView.progress = progress / 100.0;
      alertController.message = [NSString stringWithFormat:@"%.0f%%", progress];
    });
    dispatch_resume(timer);
    BOOL unzipSuccess =
        [SSZipArchive unzipFileAtPath:destinationPath toDestination:dataPath];
    dispatch_source_cancel(timer);
    dispatch_async(dispatch_get_main_queue(), ^{
      [UIView animateWithDuration:1.0
          animations:^{
            progressView.progress = 1.0;
          }
          completion:^(BOOL finished) {
            alertController.message = @"100%";
            dispatch_after(
                dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),
                dispatch_get_main_queue(), ^{
                  [alertController
                      dismissViewControllerAnimated:YES
                                         completion:^{
                                           if (unzipSuccess) {
                                             [self modsuccess];
                                            
                                             NSError *removeError;
                                             [fileManager
                                                 removeItemAtPath:
                                                     destinationPath
                                                            error:&removeError];
                                             if (removeError) {
                                               NSLog(
                                                   @"Lỗi khi xóa file zip: %@",
                                                   removeError
                                                       .localizedDescription);
                                             }
                                           } else {
                                             NSLog(@"Lỗi khi giải nén");
                                           }
                                         }];
                });
          }];
    });
  });
}

// Phương thức backupMod
- (BOOL)checkBackupExists {
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSString *documentDir = [NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  NSString *backupPath =
      [documentDir stringByAppendingPathComponent:@"Resources.backup"];

  return [fileManager fileExistsAtPath:backupPath];
}

- (void)performBackupIfNeeded {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *resourcesPath = [documentDir stringByAppendingPathComponent:@"Resources"];
    NSString *backupPath = [documentDir stringByAppendingPathComponent:@"Resources.backup"];

    // Kiểm tra nếu tồn tại Resources.backup
    if ([fileManager fileExistsAtPath:backupPath]) {
        // Xóa thư mục Resources hiện tại nếu nó tồn tại
        if ([fileManager fileExistsAtPath:resourcesPath]) {
            NSError *removeError;
            if (![fileManager removeItemAtPath:resourcesPath error:&removeError]) {
                NSLog(@"Lỗi khi xóa thư mục Resources: %@", removeError.localizedDescription);
                return;
            }
        }

        // Sao chép Resources.backup thành Resources
        NSError *copyError;
        if (![fileManager copyItemAtPath:backupPath toPath:resourcesPath error:&copyError]) {
            NSLog(@"Lỗi khi nhân bản Resources.backup: %@", copyError.localizedDescription);
            return;
        }
        NSLog(@"Đã khôi phục từ bản sao lưu Resources.backup");
    } else {
        // Nếu không có backup thì tạo mới một bản sao lưu
        [self modbackup];
    }
}

- (void)modbackup {
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSString *documentDir = [NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  NSString *dataPath = [documentDir stringByAppendingPathComponent:@"/"];
  NSString *backupPath =
      [documentDir stringByAppendingPathComponent:@"Resources.backup"];
  NSString *resourcesPath =
      [dataPath stringByAppendingPathComponent:@"Resources"];

  if ([fileManager fileExistsAtPath:resourcesPath]) {
    if (![fileManager fileExistsAtPath:backupPath]) {
      NSError *backupError;
      if (![fileManager copyItemAtPath:resourcesPath
                                toPath:backupPath
                                 error:&backupError]) {
        NSLog(@"Lỗi khi tạo backup: %@", backupError.localizedDescription);
      } else {
        NSLog(@"Backup thành công");
      }
    }
  } else {
    NSLog(@"Không tìm thấy thư mục Resources để backup");
  }
}

- (void)modsuccess {
  UIAlertController *alertController = [UIAlertController
      alertControllerWithTitle:@"Mod Thành Công"
                       message:
                           @"Hãy thoát ra vào lại để thấy thay "
                           @"đổi\nPowered by WtHaxVN"
                preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *okAction =
      [UIAlertAction actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                             handler:nil];
  UIAlertAction *exitAction = [UIAlertAction actionWithTitle:@"Exit Game"
  style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
      exit(0);
  }];
  [alertController addAction:okAction];
   [alertController addAction:exitAction];

  UIViewController *rootViewController =
      [[[UIApplication sharedApplication] keyWindow] rootViewController];
  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];
}

- (void)xoamod {
  // Lấy đường dẫn đến thư mục Documents
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  NSString *documentsDir = [paths objectAtIndex:0];

  // Đường dẫn đầy đủ đến thư mục Resources
  NSString *resourcePath = @"Resources";
  NSString *fullResourcePath =
      [documentsDir stringByAppendingPathComponent:resourcePath];

  // Đường dẫn đầy đủ đến thư mục Resources.backup
  NSString *backupResourcePath =
      [documentsDir stringByAppendingPathComponent:@"Resources.backup"];

  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSError *error;

  // Kiểm tra thư mục Resources có tồn tại không và xóa nó
  if ([fileManager fileExistsAtPath:fullResourcePath]) {
    BOOL success = [fileManager removeItemAtPath:fullResourcePath error:&error];
    if (success) {
      NSLog(@"Xóa thư mục Resources thành công");
      [self clearmodsuccess];
    } else {
      NSLog(@"Lỗi khi xóa thư mục Resources: %@", error.localizedDescription);
    }
  } else {
    NSLog(@"Thư mục Resources không tồn tại");
  }

  // Kiểm tra thư mục Resources.backup có tồn tại không và xóa nó
  if ([fileManager fileExistsAtPath:backupResourcePath]) {
    BOOL success =
        [fileManager removeItemAtPath:backupResourcePath error:&error];
    if (success) {
      NSLog(@"Xóa thư mục Resources.backup thành công");
    } else {
      NSLog(@"Lỗi khi xóa thư mục Resources.backup: %@",
            error.localizedDescription);
    }
  } else {
    NSLog(@"Thư mục Resources.backup không tồn tại");
  }
}

- (void)clearmodsuccess {
  UIAlertController *alertController =
      [UIAlertController alertControllerWithTitle:@"Thông báo"
                                          message:@"Xoá Mod Thành Công"
                                   preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *okAction =
      [UIAlertAction actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                             handler:nil];
  [alertController addAction:okAction];

  UIViewController *rootViewController =
      [[[UIApplication sharedApplication] keyWindow] rootViewController];
  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];
}

- (void)inputLinkMod {
  UIAlertController *alertController =
      [UIAlertController alertControllerWithTitle:@"NHẬP LINK FILE MOD"
                                          message:
                                              @"YÊU CẦU LINK CÓ CHỨA THƯ "
                                              @"MỤC RESOURCES Ở THƯ MỤC CON"
                                   preferredStyle:UIAlertControllerStyleAlert];

  [alertController
      addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
        textField.placeholder = @"DÁN LINK TẠI ĐÂY";

        // Tự động dán nội dung từ clipboard vào textField
        NSString *pasteboardString = [UIPasteboard generalPasteboard].string;
        if (pasteboardString) {
          textField.text = pasteboardString;
        }
      }];

  UIAlertAction *cancelAction =
      [UIAlertAction actionWithTitle:@"CANCEL"
                               style:UIAlertActionStyleCancel
                             handler:nil];
  [alertController addAction:cancelAction];

  UIAlertAction *okAction = [UIAlertAction
      actionWithTitle:@"TIẾP TỤC"
                style:UIAlertActionStyleDefault
              handler:^(UIAlertAction *_Nonnull action) {
                NSString *linkURL = alertController.textFields.firstObject.text;
                [self downloadZipFromLink:linkURL];
              }];
  [alertController addAction:okAction];

  UIViewController *rootViewController =
      [[[UIApplication sharedApplication] keyWindow] rootViewController];
  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];
}

- (void)downloadZipFromLink:(NSString *)linkURL {
  NSURL *url = [NSURL URLWithString:linkURL];
  NSURLSessionConfiguration *configuration =
      [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

  // Tạo và hiển thị alertController với thanh tiến trình
  UIAlertController *progressAlert =
      [UIAlertController alertControllerWithTitle:@"ĐANG MOD"
                                          message:@"0%"
                                   preferredStyle:UIAlertControllerStyleAlert];
  UIProgressView *progressView = [[UIProgressView alloc]
      initWithProgressViewStyle:UIProgressViewStyleDefault];
  progressView.frame = CGRectMake(10, 70, 250, 10);
  [progressAlert.view addSubview:progressView];

  UIViewController *rootViewController =
      [[[UIApplication sharedApplication] keyWindow] rootViewController];
  [rootViewController presentViewController:progressAlert
                                   animated:YES
                                 completion:nil];

  NSURLSessionDownloadTask *downloadTask = [session
      downloadTaskWithURL:url
        completionHandler:^(NSURL *temporaryFileURL, NSURLResponse *response,
                            NSError *error) {
          if (error) {
            NSLog(@"Lỗi khi tải tệp zip: %@", error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
              [progressAlert dismissViewControllerAnimated:YES completion:nil];
            });
            return;
          }
          NSURL *fileURL = temporaryFileURL;
          [self handleZipFile:fileURL
              withProgressAlert:progressAlert
                andProgressView:progressView];
        }];

  [downloadTask resume];

  // Cập nhật tiến trình tải xuống
  [session
      getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks,
                                      NSArray *downloadTasks) {
        NSURLSessionDownloadTask *task = downloadTasks.firstObject;
        [task addObserver:self
               forKeyPath:@"countOfBytesReceived"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
      }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if ([keyPath isEqualToString:@"countOfBytesReceived"]) {
    NSURLSessionDownloadTask *task = (NSURLSessionDownloadTask *)object;
    float downloadProgress = (float)task.countOfBytesReceived /
                             (float)task.countOfBytesExpectedToReceive;

    // Điều chỉnh tiến trình để 100% tải file tương ứng với 85% của thanh tiến
    // trình
    float adjustedProgress = downloadProgress * 0.85;

    dispatch_async(dispatch_get_main_queue(), ^{
      UIAlertController *progressAlert =
          [UIApplication sharedApplication]
              .keyWindow.rootViewController.presentedViewController;
      if ([progressAlert isKindOfClass:[UIAlertController class]]) {
        UIProgressView *progressView = progressAlert.view.subviews.lastObject;
        progressView.progress = adjustedProgress;

        // Hiển thị phần trăm đã điều chỉnh
        progressAlert.message =
            [NSString stringWithFormat:@"%.0f%%", adjustedProgress * 100];
      }
    });
  }
}

- (void)handleZipFile:(NSURL *)url
    withProgressAlert:(UIAlertController *)progressAlert
      andProgressView:(UIProgressView *)progressView {
  // Tạo bản sao lưu của thư mục "Resources" trước khi giải nén
  [self performBackupIfNeeded];

  NSString *filePath = [url path];
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  NSString *documentsDir = [paths objectAtIndex:0];
  NSString *dataPath = [documentsDir stringByAppendingPathComponent:@"/"];

  dispatch_async(
      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Chạy tiến trình từ tiến độ hiện tại đến 100%
        float currentProgress = progressView.progress;
        for (float i = currentProgress; i <= 1.0; i += 0.01) {
          dispatch_async(dispatch_get_main_queue(), ^{
            progressView.progress = i;
            progressAlert.message =
                [NSString stringWithFormat:@"%.1f%%", i * 100];
          });
          [NSThread sleepForTimeInterval:0.05];
        }

        // Giải nén tệp zip
        BOOL success =
            [SSZipArchive unzipFileAtPath:filePath toDestination:dataPath];

        dispatch_async(dispatch_get_main_queue(), ^{
          if (success) {
            [progressAlert
                dismissViewControllerAnimated:YES
                                   completion:^{
                                     NSLog(
                                         @"Giải nén thành công vào thư mục "
                                         @"Resources");
                                     // Xóa file zip sau khi giải nén thành công
                                     NSFileManager *fileManager =
                                         [NSFileManager defaultManager];
                                     NSError *error;
                                     [fileManager removeItemAtPath:filePath
                                                             error:&error];
                                     if (error) {
                                       NSLog(@"Lỗi khi xóa file zip: %@",
                                             error.localizedDescription);
                                     }
                                     // Gọi modsuccess sau khi thanh tiến trình
                                     // biến mất
                                     [self modsuccess];
                                   }];
          } else {
            [progressAlert dismissViewControllerAnimated:YES
                                              completion:^{
                                                NSLog(@"Lỗi khi giải nén");
                                                // Hiển thị thông báo lỗi nếu
                                                // cần
                                              }];
          }
        });
      });
}

- (void)playMusicFromURL:(NSString *)urlString {
  // Chuyển đổi chuỗi URL thành NSURL
  NSURL *url = [NSURL URLWithString:urlString];

  // Tạo một AVPlayerItem từ URL
  AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];

  // Tạo AVPlayer với playerItem
  AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];

  // Thêm observer để bắt sự kiện khi phát xong
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(playerItemDidReachEnd:)
             name:AVPlayerItemDidPlayToEndTimeNotification
           object:playerItem];

  // Phát nhạc
  [player play];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
  // Xử lý khi phát xong
  AVPlayerItem *playerItem = [notification object];
  [playerItem seekToTime:kCMTimeZero
       completionHandler:nil];  // Lặp lại nhạc nếu cần
}
- (void)music1 {
  [self playMusicFromURL:@"http://wthaxvn.site/music.mp4"];
}

- (void)restore {
  NSString *linkURL = @"https://wthaxvn.site/api/restore.zip";
  NSURL *url = [NSURL URLWithString:linkURL];
  NSURLSessionConfiguration *configuration =
      [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

  NSURLSessionDownloadTask *downloadTask = [session
      downloadTaskWithURL:url
        completionHandler:^(NSURL *temporaryFileURL, NSURLResponse *response,
                            NSError *error) {
          if (error) {
            NSLog(@"Lỗi khi tải tệp zip: %@", error.localizedDescription);
            return;
          }

          NSURL *fileURL = temporaryFileURL;
          [self handleZipFileRestore:fileURL];
        }];

  [downloadTask resume];
}

- (void)handleZipFileRestore:(NSURL *)url {
  NSString *filePath = [url path];

  // Di chuyển file zip đến thư mục của ứng dụng
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  NSString *documentsDir = [paths objectAtIndex:0];
  NSString *destinationPath =
      [documentsDir stringByAppendingPathComponent:[url lastPathComponent]];

  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSError *error;

  BOOL success =
      [fileManager moveItemAtPath:filePath toPath:destinationPath error:&error];

  if (!success) {
    NSLog(@"Lỗi khi di chuyển file zip: %@", error.localizedDescription);
    return;
  }

  // Giải nén tệp zip vào thư mục "Resources" hiện tại
  NSString *dataPath = [documentsDir stringByAppendingPathComponent:@"/"];
  success =
      [SSZipArchive unzipFileAtPath:destinationPath toDestination:dataPath];

  if (success) {
    NSLog(@"Giải nén thành công vào thư mục Resources");

    // Xóa file zip sau khi giải nén thành công
    [fileManager removeItemAtPath:destinationPath error:&error];
    if (error) {
      NSLog(@"Lỗi khi xóa file zip: %@", error.localizedDescription);
    }

    // Hiển thị thông báo thành công
    [self restoresuccess];
  } else {
    NSLog(@"Lỗi khi giải nén: %@", error.localizedDescription);
  }
}
- (void)restoresuccess {
  UIAlertController *alertController =
      [UIAlertController alertControllerWithTitle:@"Thông báo"
                                          message:@"Restore Thành Công"
                                   preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *okAction =
      [UIAlertAction actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                             handler:nil];
  [alertController addAction:okAction];

  UIViewController *rootViewController =
      [[[UIApplication sharedApplication] keyWindow] rootViewController];
  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];
}

- (void)paste {
  _documentPicker2 = [[UIDocumentPickerViewController alloc]
      initWithDocumentTypes:@[ (NSString *)kUTTypeZipArchive ]
                     inMode:UIDocumentPickerModeImport];
  _documentPicker2.delegate = self;

  if (@available(iOS 11.0, *)) {
    _documentPicker2.allowsMultipleSelection = NO;
  }

  UIViewController *rootViewController =
      [[[UIApplication sharedApplication] keyWindow] rootViewController];
  [rootViewController presentViewController:_documentPicker2
                                   animated:YES
                                 completion:nil];
}

// - (void)documentPicker:(UIDocumentPickerViewController *)controller
// didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
//     NSURL *fileURL = urls.firstObject;
//     [self pasteurl:fileURL];
//     [self pastesuccess];
//     [controller dismissViewControllerAnimated:YES completion:nil];
// }

- (void)pasteurl:(NSURL *)url {
  NSString *filePath = [url path];

  // Di chuyển file zip đến thư mục của ứng dụng
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  NSString *documentsDir = [paths objectAtIndex:0];
  NSString *destinationPath =
      [documentsDir stringByAppendingPathComponent:[url lastPathComponent]];

  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSError *error;

  BOOL success =
      [fileManager moveItemAtPath:filePath toPath:destinationPath error:&error];

  if (!success) {
    NSLog(@"Lỗi khi di chuyển file zip: %@", error.localizedDescription);
    return;
  }

  // Giải nén tệp zip vào thư mục "Resources" hiện tại
  NSString *dataPath = [documentsDir stringByAppendingPathComponent:@"/"];
  success =
      [SSZipArchive unzipFileAtPath:destinationPath toDestination:dataPath];

  if (success) {
    NSLog(@"Giải nén thành công vào thư mục Resources");

    // Xóa file zip sau khi giải nén thành công
    [fileManager removeItemAtPath:destinationPath error:&error];
    if (error) {
      NSLog(@"Lỗi khi xóa file zip: %@", error.localizedDescription);
    }

    // Hiển thị thông báo thành công
    exit(0);
  } else {
    NSLog(@"Lỗi khi giải nén: %@", error.localizedDescription);
  }
}

- (void)pastesuccess {
  UIAlertController *alertController = [UIAlertController
      alertControllerWithTitle:@"Thông báo"
                       message:
                           @"Đang Thực Hiện Paste Extra\nTự Động Văng Sau "
                           @"Khi Hoàn Thành"
                preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *okAction =
      [UIAlertAction actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                             handler:nil];
  [alertController addAction:okAction];

  UIViewController *rootViewController =
      [[[UIApplication sharedApplication] keyWindow] rootViewController];
  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];
  dispatch_after(
      dispatch_time(DISPATCH_TIME_NOW, (int64_t)(100 * NSEC_PER_SEC)),
      dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:nil];
      });
}

- (void)udid {
  UIAlertController *alertController = [UIAlertController
      alertControllerWithTitle:@"Nhập UID Muốn Đổi"
                       message:@"Powered By WtHaxVN\nLưu Ý: Không Được Quá Dài"
                preferredStyle:UIAlertControllerStyleAlert];

  [alertController
      addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"UID";
      }];

  UIAlertAction *confirmAction = [UIAlertAction
      actionWithTitle:@"OK"
                style:UIAlertActionStyleDefault
              handler:^(UIAlertAction *action) {
                UITextField *textField = alertController.textFields.firstObject;
                NSString *userInput = textField.text;
                [self pending];
                [self createTextFileWithUserInput:userInput];
              }];

  UIAlertAction *cancelAction =
      [UIAlertAction actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleCancel
                             handler:nil];

  [alertController addAction:confirmAction];
  [alertController addAction:cancelAction];

  UIViewController *rootViewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;

  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];
}
- (void)createTextFileWithUserInput:(NSString *)userInput {
  NSURL *url = [NSURL URLWithString:@"https://wthaxvn.site/api/uidgame.txt"];

  NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
        dataTaskWithURL:url
      completionHandler:^(NSData *data, NSURLResponse *response,
                          NSError *error) {
        if (error) {
          NSLog(@"Failed to download file: %@", error);
          return;
        }

        NSString *fileContent =
            [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        // Replace "inputtextuid" with user input
        fileContent =
            [fileContent stringByReplacingOccurrencesOfString:@"inputtextuid"
                                                   withString:userInput];

        // Create directories
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(
            NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *directoryPath =
            [documentsDirectory stringByAppendingPathComponent:
                                    @"Resources/1.54.1/Languages/VN_Garena_VN"];

        NSError *createDirectoryError = nil;
        [fileManager createDirectoryAtPath:directoryPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&createDirectoryError];

        if (createDirectoryError) {
          NSLog(@"Failed to create directory: %@", createDirectoryError);
          return;
        }

        // Create file path
        NSString *filePath =
            [directoryPath stringByAppendingPathComponent:@"languageMap.txt"];

        NSError *writeError = nil;
        [fileContent writeToFile:filePath
                      atomically:YES
                        encoding:NSUTF8StringEncoding
                           error:&writeError];

        if (writeError) {
          NSLog(@"Failed to write file: %@", writeError);
        } else {
          NSLog(@"File created at %@", filePath);
          [self zipDirectoryAtPath:directoryPath];
        }
      }];

  [downloadTask resume];
}

- (void)zipDirectoryAtPath:(NSString *)directoryPath {
  NSString *zipFilePath =
      [NSTemporaryDirectory() stringByAppendingPathComponent:@"Resources.zip"];

  BOOL success = [SSZipArchive createZipFileAtPath:zipFilePath
                           withContentsOfDirectory:directoryPath];

  if (success) {
    NSLog(@"Directory %@ successfully zipped to %@", directoryPath,
          zipFilePath);

    // Handle zip file
    [self changeuid:zipFilePath];
  } else {
    NSLog(@"Failed to zip directory %@", directoryPath);
  }
}

- (void)changeuid:(NSString *)zipFilePath {
  // Giải nén tệp zip vào thư mục "Resources" hiện tại
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  NSString *documentsDir = [paths objectAtIndex:0];
  NSString *dataPath =
      [documentsDir stringByAppendingPathComponent:@"/Resources"];
  BOOL success =
      [SSZipArchive unzipFileAtPath:zipFilePath toDestination:dataPath];

  if (success) {
    NSLog(@"Successfully extracted files to %@", dataPath);

    // Xóa file zip sau khi giải nén thành công
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    [fileManager removeItemAtPath:zipFilePath error:&error];
    [self deleteFilesFromResourcesDirectory];
    if (error) {
      NSLog(@"Error deleting zip file: %@", error.localizedDescription);
    }
  } else {
    NSLog(@"Failed to extract files");
  }
}
- (void)deleteFilesFromResourcesDirectory {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  NSString *documentsDir = [paths objectAtIndex:0];
  NSString *resourcesPath =
      [documentsDir stringByAppendingPathComponent:@"Resources"];

  NSFileManager *fileManager = [NSFileManager defaultManager];

  NSArray *filesToDelete = @[
    @"languageMap.txt", @"lanMapCfg.txt", @"lanMapIncremental.txt",
    @"languageMap_Xls.txt", @"languageMap_Newbie.txt",
    @"languageMap_WorldConcept.txt"
  ];

  for (NSString *fileName in filesToDelete) {
    NSString *filePath =
        [resourcesPath stringByAppendingPathComponent:fileName];

    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (success) {
      NSLog(@"Deleted file %@", fileName);
      //    [self recall];
      dispatch_after(
          dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)),
          dispatch_get_main_queue(), ^{
            [self uidsuccess];
          });
    } else {
      NSLog(@"Failed to delete file %@ with error: %@", fileName,
            error.localizedDescription);
    }
  }
}

- (void)uidsuccess {
  UIAlertController *alertController = [UIAlertController
      alertControllerWithTitle:@"Thành Công"
                       message:@"Đổi Thành Công Bạn Hãy Out Game Vào Lại"
                preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *okAction =
      [UIAlertAction actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                             handler:nil];
  UIAlertAction *exitAction =
      [UIAlertAction actionWithTitle:@"Thoát Game"
                               style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action) {
                               exit(0);  // Thoát ứng dụng
                             }];

  [alertController addAction:okAction];
  [alertController addAction:exitAction];

  UIViewController *rootViewController =
      [[[UIApplication sharedApplication] keyWindow] rootViewController];
  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];
}
- (void)pending {
  UIAlertController *alertController =
      [UIAlertController alertControllerWithTitle:@"PENDING"
                                          message:@"Đang Ghi Dữ Liệu Vào Game"
                                   preferredStyle:UIAlertControllerStyleAlert];

  UIViewController *rootViewController =
      [[[UIApplication sharedApplication] keyWindow] rootViewController];
  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];

  // Tự động tắt thông báo sau 1 giây
  dispatch_after(
      dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)),
      dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:nil];
      });
}

- (void)recall {
  UIAlertController *alertController = [UIAlertController
      alertControllerWithTitle:@"Nhập Text Biến Về"
                       message:@"Powered By WtHaxVN\nLưu Ý: Không Được Quá Dài"
                preferredStyle:UIAlertControllerStyleAlert];

  [alertController
      addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Biến Về Text";
      }];

  UIAlertAction *confirmAction = [UIAlertAction
      actionWithTitle:@"OK"
                style:UIAlertActionStyleDefault
              handler:^(UIAlertAction *action) {
                UITextField *textField = alertController.textFields.firstObject;
                NSString *userInput = textField.text;
                [self pending];
                [self createTextFileWithUserInput1:userInput];
              }];

  UIAlertAction *cancelAction =
      [UIAlertAction actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleCancel
                             handler:nil];

  [alertController addAction:confirmAction];
  [alertController addAction:cancelAction];

  UIViewController *rootViewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;

  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];
}
- (void)createTextFileWithUserInput1:(NSString *)userInput {
  NSURL *url = [NSURL URLWithString:@"https://wthaxvn.site/api/recal.txt"];

  NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
        dataTaskWithURL:url
      completionHandler:^(NSData *data, NSURLResponse *response,
                          NSError *error) {
        if (error) {
          NSLog(@"Failed to download file: %@", error);
          return;
        }

        NSString *fileContent =
            [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        // Replace "inputtextuid" with user input
        fileContent =
            [fileContent stringByReplacingOccurrencesOfString:@"recalltext"
                                                   withString:userInput];

        // Create directories
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(
            NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *directoryPath =
            [documentsDirectory stringByAppendingPathComponent:
                                    @"Resources/1.54.1/Languages/VN_Garena_VN"];

        NSError *createDirectoryError = nil;
        [fileManager createDirectoryAtPath:directoryPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&createDirectoryError];

        if (createDirectoryError) {
          NSLog(@"Failed to create directory: %@", createDirectoryError);
          return;
        }

        // Create file path
        NSString *filePath = [directoryPath
            stringByAppendingPathComponent:@"languageMap_Newbie.txt"];

        NSError *writeError = nil;
        [fileContent writeToFile:filePath
                      atomically:YES
                        encoding:NSUTF8StringEncoding
                           error:&writeError];

        if (writeError) {
          NSLog(@"Failed to write file: %@", writeError);
        } else {
          NSLog(@"File created at %@", filePath);
          [self zipDirectoryAtPath:directoryPath];
          dispatch_after(
              dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)),
              dispatch_get_main_queue(), ^{
                [self uidsuccess];
              });
        }
      }];

  [downloadTask resume];
}

- (void)showInputFields {
  UIAlertController *alertController =
      [UIAlertController alertControllerWithTitle:@"Nhập Tex Bạn Muốn Đổi"
                                          message:@"Powered By WtHaxVN"
                                   preferredStyle:UIAlertControllerStyleAlert];

  NSArray *labels = @[
    @"Chiến công đầu", @"Hạ gục", @"Mạng 2", @"Mạng 3", @"Mạng 4", @"Mạng 5",
    @"Mạng 6", @"Thần thánh", @"Double Kill", @"Triple Kill", @"Quadkill",
    @"Megakill", @"Chấm dứt", @"Quét Sạch", @"Recall"
  ];

  for (int i = 0; i < labels.count; i++) {
    [alertController
        addTextFieldWithConfigurationHandler:^(UITextField *textField) {
          textField.placeholder = labels[i];
        }];
  }

  UIAlertAction *confirmAction = [UIAlertAction
      actionWithTitle:@"OK"
                style:UIAlertActionStyleDefault
              handler:^(UIAlertAction *action) {
                NSMutableArray *userInputs = [NSMutableArray array];
                for (UITextField *textField in alertController.textFields) {
                  [userInputs addObject:textField.text];
                }
                [self pending];
                [self createTextFileWithUserInputs:userInputs];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                             (int64_t)(1.5 * NSEC_PER_SEC)),
                               dispatch_get_main_queue(), ^{
                                 [self uidsuccess];
                               });
              }];

  UIAlertAction *cancelAction =
      [UIAlertAction actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleCancel
                             handler:nil];

  [alertController addAction:confirmAction];
  [alertController addAction:cancelAction];

  UIViewController *rootViewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;
  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];
}

- (void)createTextFileWithUserInputs:(NSArray *)userInputs {
  NSURL *url = [NSURL URLWithString:@"https://wthaxvn.site/api/textlq.txt"];
  NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
        dataTaskWithURL:url
      completionHandler:^(NSData *data, NSURLResponse *response,
                          NSError *error) {
        if (error) {
          NSLog(@"Failed to download file: %@", error);
          return;
        }

        NSString *fileContent =
            [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        // Replace placeholders with user inputs
        NSArray *placeholders = @[
          @"chiencongdau", @"gietnguoi", @"mang2", @"mang3", @"mang4", @"mang5",
          @"mang6", @"thanthanh", @"doublenkill", @"triplenkill", @"quadnkill",
          @"pentankill", @"chamdut", @"quetsach", @"recall"
        ];

        for (int i = 0; i < placeholders.count; i++) {
          fileContent =
              [fileContent stringByReplacingOccurrencesOfString:placeholders[i]
                                                     withString:userInputs[i]];
        }

        // Create directories
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(
            NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *directoryPath =
            [documentsDirectory stringByAppendingPathComponent:
                                    @"Resources/1.54.1/Languages/VN_Garena_VN"];
        NSError *createDirectoryError = nil;
        [fileManager createDirectoryAtPath:directoryPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&createDirectoryError];

        if (createDirectoryError) {
          NSLog(@"Failed to create directory: %@", createDirectoryError);
          return;
        }

        // Create file
        NSString *filePath = [directoryPath
            stringByAppendingPathComponent:@"languageMap_Newbie.txt"];
        NSError *writeError = nil;
        [fileContent writeToFile:filePath
                      atomically:YES
                        encoding:NSUTF8StringEncoding
                           error:&writeError];

        if (writeError) {
          NSLog(@"Failed to write file: %@", writeError);
        } else {
          NSLog(@"File created at %@", filePath);
          [self zipDirectoryAtPath:directoryPath];
        }
      }];

  [downloadTask resume];
}

- (void)restartApplicationgame {
  NSString *appDomainName = [[NSBundle mainBundle] bundleIdentifier];
  [[NSUserDefaults standardUserDefaults] synchronize];
  NSURL *url = [NSURL
      URLWithString:[NSString stringWithFormat:@"ngame113://", appDomainName]];
  if ([[UIApplication sharedApplication] canOpenURL:url]) {
    [[NSUserDefaults standardUserDefaults] setBool:YES
                                            forKey:@"ApplicationIsRestarting"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[UIApplication sharedApplication] openURL:url
                                       options:@{}
                             completionHandler:nil];
    exit(0);
  }
}

- (void)modsanhless {
  if ([UIImagePickerController
          isSourceTypeAvailable:
              UIImagePickerControllerSourceTypePhotoLibrary]) {
    UIImagePickerController *videoPicker =
        [[UIImagePickerController alloc] init];
    videoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    videoPicker.mediaTypes = @[ (NSString *)kUTTypeMovie ];
    videoPicker.delegate = self;
    UIViewController *rootViewController =
        [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootViewController presentViewController:videoPicker
                                     animated:YES
                                   completion:nil];
  } else {
    NSLog(@"Thiết bị không hỗ trợ chọn video.");
  }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:
        (NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
  NSURL *videoURL = info[UIImagePickerControllerMediaURL];
  [picker dismissViewControllerAnimated:YES
                             completion:^{
                               [self demsanh];
                               [self resetsanh];
                               [self processAndDuplicateVideo:videoURL];
                             }];
}
- (void)modsanhfull {
  PHPickerConfiguration *config = [[PHPickerConfiguration alloc] init];
  config.filter = [PHPickerFilter videosFilter];
  config.selectionLimit = 1;

  PHPickerViewController *picker =
      [[PHPickerViewController alloc] initWithConfiguration:config];
  picker.delegate = self;

  UIViewController *rootViewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;
  [rootViewController presentViewController:picker animated:YES completion:nil];
}

#pragma mark - PHPickerViewControllerDelegate

- (void)picker:(PHPickerViewController *)picker
    didFinishPicking:(NSArray<PHPickerResult *> *)results {
  [picker dismissViewControllerAnimated:YES completion:nil];

  if (results.count == 0) {
    NSLog(@"No media selected");
    return;
  }

  PHPickerResult *result = results.firstObject;

  if ([result.itemProvider
          hasItemConformingToTypeIdentifier:(NSString *)kUTTypeMovie]) {
    [result.itemProvider
        loadFileRepresentationForTypeIdentifier:(NSString *)kUTTypeMovie
                              completionHandler:^(NSURL *_Nullable url,
                                                  NSError *_Nullable error) {
                                if (url) {
                                  NSURL *destinationURL =
                                      [self copyVideoToDocumentsDirectory:url];
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                    if (destinationURL) {
                                      [self demsanh];
                                      [self resetsanh];
                                      [self processAndDuplicateVideo:
                                                destinationURL];
                                    } else {
                                      NSLog(
                                          @"Failed to copy video to "
                                          @"documents directory");
                                    }
                                  });
                                } else {
                                  NSLog(@"Error loading video: %@",
                                        error.localizedDescription);
                                }
                              }];
  } else {
    NSLog(@"Selected item is not a video");
  }
}

- (NSURL *)copyVideoToDocumentsDirectory:(NSURL *)url {
  NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
  NSString *destinationPath = [documentsDirectory
      stringByAppendingPathComponent:[url lastPathComponent]];
  NSURL *destinationURL = [NSURL fileURLWithPath:destinationPath];

  NSError *error;
  NSFileManager *fileManager = [NSFileManager defaultManager];

  if ([fileManager fileExistsAtPath:destinationPath]) {
    [fileManager removeItemAtPath:destinationPath error:&error];
    if (error) {
      NSLog(@"Error removing existing file: %@", error.localizedDescription);
      return nil;
    }
  }

  [fileManager copyItemAtURL:url toURL:destinationURL error:&error];
  if (error) {
    NSLog(@"Error copying video to documents directory: %@",
          error.localizedDescription);
    return nil;
  }

  return destinationURL;
}

- (void)processAndDuplicateVideo:(NSURL *)videoURL {
  NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
  NSString *sanhFilePath =
      [documentsDirectory stringByAppendingPathComponent:@"sanh.txt"];

  NSString *parentDirectory = [documentsDirectory
      stringByAppendingPathComponent:@"Extra/2019.V2/ISPDiff/LobbyMovie"];

  NSError *error;
  NSString *sanhContent =
      [NSString stringWithContentsOfFile:sanhFilePath
                                encoding:NSUTF8StringEncoding
                                   error:&error];

  if (error) {
    NSLog(@"Lỗi khi đọc file sanh.txt: %@", error.localizedDescription);
    return;
  }

  NSArray *fileNames = [sanhContent
      componentsSeparatedByCharactersInSet:[NSCharacterSet
                                               newlineCharacterSet]];
  fileNames = [fileNames
      filteredArrayUsingPredicate:[NSPredicate
                                      predicateWithFormat:@"length > 0"]];

  NSFileManager *fileManager = [NSFileManager defaultManager];

  if (![fileManager fileExistsAtPath:parentDirectory]) {
    NSError *createDirError;
    [fileManager createDirectoryAtPath:parentDirectory
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:&createDirError];
    if (createDirError) {
      NSLog(@"Lỗi khi tạo thư mục cha: %@",
            createDirError.localizedDescription);
      return;
    }
  }

  for (NSInteger i = 0; i < fileNames.count; i++) {
    NSString *newFileName = fileNames[i];
    NSString *newFilePath =
        [parentDirectory stringByAppendingPathComponent:newFileName];

    NSError *copyError;
    [fileManager copyItemAtURL:videoURL
                         toURL:[NSURL fileURLWithPath:newFilePath]
                         error:&copyError];

    if (copyError) {
      NSLog(@"Lỗi khi sao chép video %@: %@", newFileName,
            copyError.localizedDescription);
    } else {
      NSLog(@"Đã sao chép và đổi tên video thành: %@", newFileName);
      [self deleteSanhFile];
    }
  }

  [self deleteOriginalVideo:videoURL];

  NSLog(@"Đã hoàn thành việc nhân bản và đổi tên video trong thư mục %@",
        parentDirectory);
}

- (void)deleteOriginalVideo:(NSURL *)videoURL {
  NSError *error;
  NSFileManager *fileManager = [NSFileManager defaultManager];

  if ([fileManager fileExistsAtPath:videoURL.path]) {
    BOOL success = [fileManager removeItemAtURL:videoURL error:&error];
    if (success) {
      NSLog(@"Đã xóa video gốc thành công");
    } else {
      NSLog(@"Lỗi khi xóa video gốc: %@", error.localizedDescription);
    }
  } else {
    NSLog(@"Video gốc không tồn tại");
  }
}

- (void)demsanh {
  NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
  NSString *lobbyMoviePath = [documentsDirectory
      stringByAppendingPathComponent:@"Extra/2019.V2/ISPDiff/LobbyMovie"];
  NSString *outputFilePath =
      [documentsDirectory stringByAppendingPathComponent:@"sanh.txt"];

  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSError *error = nil;
  NSArray *fileArray =
      [fileManager contentsOfDirectoryAtPath:lobbyMoviePath error:&error];

  if (error) {
    NSLog(@"Lỗi khi truy cập thư mục LobbyMovie: %@",
          error.localizedDescription);
    return;
  }

  NSMutableString *fileNamesString = [[NSMutableString alloc] init];
  for (NSString *fileName in fileArray) {
    [fileNamesString appendFormat:@"%@\n", fileName];
  }

  NSError *writeError = nil;
  BOOL success = [fileNamesString writeToFile:outputFilePath
                                   atomically:YES
                                     encoding:NSUTF8StringEncoding
                                        error:&writeError];

  if (success) {
    NSLog(@"Đã ghi tên các file vào sanh.txt:\n%@", fileNamesString);
  } else {
    NSLog(@"Lỗi khi ghi vào file sanh.txt: %@",
          writeError.localizedDescription);
  }
}

- (void)deleteSanhFile {
  NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
  NSString *sanhFilePath =
      [documentsDirectory stringByAppendingPathComponent:@"sanh.txt"];

  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSError *error;

  if ([fileManager fileExistsAtPath:sanhFilePath]) {
    BOOL success = [fileManager removeItemAtPath:sanhFilePath error:&error];
    if (success) {
      NSLog(@"Đã xóa file sanh.txt thành công");
      [self modsuccess];
    } else {
      NSLog(@"Lỗi khi xóa file sanh.txt: %@", error.localizedDescription);
    }
  } else {
    NSLog(@"File sanh.txt không tồn tại");
  }
}
// - (void)modsanh {
//     // Kiểm tra xem thiết bị có hỗ trợ chọn video từ thư viện hay không
//     if ([UIImagePickerController
//     isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//         // Tạo một UIImagePickerController
//         UIImagePickerController *videoPicker = [[UIImagePickerController
//         alloc] init];
//         // Thiết lập loại phương tiện là video
//         videoPicker.sourceType =
//         UIImagePickerControllerSourceTypePhotoLibrary; videoPicker.mediaTypes
//         = @[(NSString *)kUTTypeMovie];
//         // Thiết lập delegate
//         videoPicker.delegate = self;
//         // Hiển thị cửa sổ chọn video
//         UIViewController *rootViewController = [UIApplication
//         sharedApplication].delegate.window.rootViewController;
//         [rootViewController presentViewController:videoPicker animated:YES
//         completion:nil];
//     } else {
//         NSLog(@"Thiết bị không hỗ trợ chọn video.");
//     }
// }

// #pragma mark - UIImagePickerControllerDelegate

// - (void)imagePickerController:(UIImagePickerController *)picker
// didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id>
// *)info {
//     NSURL *videoURL = info[UIImagePickerControllerMediaURL];
//     [picker dismissViewControllerAnimated:YES completion:^{
//         [self moveVideoToAppDirectoryAndRename:videoURL];
//     }];
// }

// - (void)moveVideoToAppDirectoryAndRename:(NSURL *)videoURL {
//      NSString *documentsDirectory =
//      [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//      NSUserDomainMask, YES) firstObject];
//     NSString *extraPath = [documentsDirectory
//     stringByAppendingPathComponent:@"Extra/2019.V2/ISPDiff"];

//     NSError *error;
//     [[NSFileManager defaultManager] createDirectoryAtPath:extraPath
//     withIntermediateDirectories:YES attributes:nil error:&error];

//     if (error) {
//         NSLog(@"Lỗi khi tạo thư mục: %@", error.localizedDescription);
//         return;
//     }

//     // Tải dữ liệu từ file JSON
//     NSURL *jsonURL = [NSURL
//     URLWithString:@"https://wthaxvn.site/api/modsanh.json"]; NSData *jsonData
//     = [NSData dataWithContentsOfURL:jsonURL];

//     if (!jsonData) {
//         NSLog(@"Không thể tải dữ liệu từ URL JSON");
//         return;
//     }

//     NSError *jsonError;
//     NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
//     options:0 error:&jsonError];

//     if (jsonError) {
//         NSLog(@"Lỗi khi phân tích JSON: %@", jsonError.localizedDescription);
//         return;
//     }

//     NSString *idFromJson = jsonDict[@"id"];
//     NSString *idNowFromJson = jsonDict[@"idnow"];

//     if (!idFromJson || !idNowFromJson) {
//         NSLog(@"Không tìm thấy trường 'id' hoặc 'idnow' trong JSON");
//         return;
//     }

//     // Lấy thời gian hiện tại và định dạng
//     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//     [dateFormatter setDateFormat:@"dd/MM"];
//     NSString *currentDateTime = [dateFormatter stringFromDate:[NSDate date]];

//     // Tạo message cho hộp thoại input
//     NSString *message = [NSString stringWithFormat:@"%@", idFromJson];

//     UIAlertController *alertController = [UIAlertController
//     alertControllerWithTitle:@"Nhập ID Sảnh" message:message
//     preferredStyle:UIAlertControllerStyleAlert];

//     [alertController addTextFieldWithConfigurationHandler:^(UITextField *
//     _Nonnull textField) {
//         textField.placeholder = @"Số ID";
//     }];

//     UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Xác nhận"
//     style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull
//     action) {
//         NSString *userInput = alertController.textFields.firstObject.text;
//         NSString *newFileName = [NSString
//         stringWithFormat:@"PvpBtnDynamic%@.mp4", userInput]; NSString
//         *newFilePath = [extraPath
//         stringByAppendingPathComponent:newFileName];

//         NSError *readError;
//         NSData *videoData = [NSData dataWithContentsOfURL:videoURL
//         options:NSDataReadingMappedIfSafe error:&readError];

//         if (readError) {
//             NSLog(@"Lỗi khi đọc dữ liệu video: %@",
//             readError.localizedDescription); return;
//         }

//         NSError *writeError;
//         BOOL success = [videoData writeToFile:newFilePath
//         options:NSDataWritingAtomic error:&writeError];

//         if (!success) {
//             NSLog(@"Lỗi khi lưu video: %@", writeError.localizedDescription);
//         } else {
//             NSLog(@"Video đã được di chuyển và đổi tên thành: %@",
//             newFileName); NSLog(@"Đường dẫn đầy đủ: %@", newFilePath);

//             // Xóa file tạm thời nếu cần
//             [[NSFileManager defaultManager] removeItemAtURL:videoURL
//             error:nil];

//             // Nén file video
//             NSString *zipFileName = [newFileName
//             stringByAppendingString:@".zip"]; NSString *zipFilePath =
//             [extraPath stringByAppendingPathComponent:zipFileName];

//             BOOL zipSuccess = [SSZipArchive createZipFileAtPath:zipFilePath
//             withFilesAtPaths:@[newFilePath]];

//             if (zipSuccess) {
//                 NSLog(@"File video đã được nén thành công: %@", zipFilePath);

//                 // Xóa file video gốc sau khi nén
//                 [[NSFileManager defaultManager] removeItemAtPath:newFilePath
//                 error:nil];

//                 // Giải nén file zip
//                 NSString *unzipPath = [extraPath
//                 stringByAppendingPathComponent:@"LobbyMovie"]; BOOL
//                 unzipSuccess = [SSZipArchive unzipFileAtPath:zipFilePath
//                 toDestination:unzipPath];

//                 if (unzipSuccess) {
//                     NSLog(@"File zip đã được giải nén thành công vào: %@",
//                     unzipPath);

//                     // Kiểm tra xem file video đã được giải nén chưa
//                     NSString *unzippedVideoPath = [unzipPath
//                     stringByAppendingPathComponent:newFileName]; if
//                     ([[NSFileManager defaultManager]
//                     fileExistsAtPath:unzippedVideoPath]) {
//                         NSLog(@"File video đã được giải nén: %@",
//                         unzippedVideoPath);

//                         // Xóa file zip sau khi giải nén thành công
//                         NSError *deleteError;
//                         if ([[NSFileManager defaultManager]
//                         removeItemAtPath:zipFilePath error:&deleteError]) {
//                             NSLog(@"File zip đã được xóa thành công sau khi
//                             giải nén");
//                         } else {
//                             NSLog(@"Lỗi khi xóa file zip: %@",
//                             deleteError.localizedDescription);
//                         }
//                     } else {
//                         NSLog(@"Không tìm thấy file video sau khi giải nén");
//                     }
//                 } else {
//                     NSLog(@"Lỗi khi giải nén file zip");
//                 }
//             } else {
//                 NSLog(@"Lỗi khi nén file video");
//             }
//         }
//     }];

//     UIAlertAction *autoFillAction = [UIAlertAction actionWithTitle:@"Tự Động"
//     style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull
//     action) {
//         NSString *autoFileName = [NSString
//         stringWithFormat:@"PvpBtnDynamic%@.mp4", idNowFromJson]; NSString
//         *autoFilePath = [extraPath
//         stringByAppendingPathComponent:autoFileName];

//         NSError *readError;
//         NSData *videoData = [NSData dataWithContentsOfURL:videoURL
//         options:NSDataReadingMappedIfSafe error:&readError];

//         if (readError) {
//             NSLog(@"Lỗi khi đọc dữ liệu video: %@",
//             readError.localizedDescription); return;
//         }

//         NSError *writeError;
//         BOOL success = [videoData writeToFile:autoFilePath
//         options:NSDataWritingAtomic error:&writeError];

//         if (!success) {
//             NSLog(@"Lỗi khi lưu video: %@", writeError.localizedDescription);
//         } else {
//             NSLog(@"Video đã được di chuyển và đổi tên thành: %@",
//             autoFileName); NSLog(@"Đường dẫn đầy đủ: %@", autoFilePath);

//             // Xóa file tạm thời nếu cần
//             [[NSFileManager defaultManager] removeItemAtURL:videoURL
//             error:nil];

//             // Nén file video
//             NSString *zipFileName = [autoFileName
//             stringByAppendingString:@".zip"]; NSString *zipFilePath =
//             [extraPath stringByAppendingPathComponent:zipFileName];

//             BOOL zipSuccess = [SSZipArchive createZipFileAtPath:zipFilePath
//             withFilesAtPaths:@[autoFilePath]];

//             if (zipSuccess) {
//                 NSLog(@"File video đã được nén thành công: %@", zipFilePath);

//                 // Xóa file video gốc sau khi nén
//                 [[NSFileManager defaultManager] removeItemAtPath:autoFilePath
//                 error:nil];

//                 // Giải nén file zip
//                 NSString *unzipPath = [extraPath
//                 stringByAppendingPathComponent:@"LobbyMovie"]; BOOL
//                 unzipSuccess = [SSZipArchive unzipFileAtPath:zipFilePath
//                 toDestination:unzipPath];

//                 if (unzipSuccess) {
//                     NSLog(@"File zip đã được giải nén thành công vào: %@",
//                     unzipPath);

//                     // Kiểm tra xem file video đã được giải nén chưa
//                     NSString *unzippedVideoPath = [unzipPath
//                     stringByAppendingPathComponent:autoFileName]; if
//                     ([[NSFileManager defaultManager]
//                     fileExistsAtPath:unzippedVideoPath]) {
//                         NSLog(@"File video đã được giải nén: %@",
//                         unzippedVideoPath);

//                         // Xóa file zip sau khi giải nén thành công
//                         NSError *deleteError;
//                         if ([[NSFileManager defaultManager]
//                         removeItemAtPath:zipFilePath error:&deleteError]) {
//                             NSLog(@"File zip đã được xóa thành công sau khi
//                             giải nén");
//                         } else {
//                             NSLog(@"Lỗi khi xóa file zip: %@",
//                             deleteError.localizedDescription);
//                         }
//                     } else {
//                         NSLog(@"Không tìm thấy file video sau khi giải nén");
//                     }
//                 } else {
//                     NSLog(@"Lỗi khi giải nén file zip");
//                 }
//             } else {
//                 NSLog(@"Lỗi khi nén file video");
//             }
//         }
//     }];

//     [alertController addAction:confirmAction];
//     [alertController addAction:autoFillAction];

//     UIViewController *rootViewController = [UIApplication
//     sharedApplication].delegate.window.rootViewController;
//     [rootViewController presentViewController:alertController animated:YES
//     completion:nil];
// }

- (void)resetsanh {
  NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
  NSString *targetPath = [documentsDirectory
      stringByAppendingPathComponent:@"Extra/2019.V2/ISPDiff/LobbyMovie"];

  NSError *error;
  NSFileManager *fileManager = [NSFileManager defaultManager];

  if ([fileManager fileExistsAtPath:targetPath]) {
    BOOL success = [fileManager removeItemAtPath:targetPath error:&error];

    if (success) {
      NSLog(@"Thư mục LobbyMovie đã được xóa thành công.");
    } else {
      NSLog(@"Lỗi khi xóa thư mục LobbyMovie: %@", error.localizedDescription);
    }
  } else {
    NSLog(@"Thư mục LobbyMovie không tồn tại.");
  }
}
- (void)requestNotificationPermission {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNAuthorizationOptions options = (UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge);
    [center requestAuthorizationWithOptions:options
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (granted) {
                                  NSLog(@"Đã được cấp quyền gửi thông báo");
                              } else {
                                  NSLog(@"Không được cấp quyền: %@", error.localizedDescription);
                              }
                          }];
}

-(void)createPushNotification {
    // 1. Lên lịch thông báo sau 10 giây
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"LQMB HACK VIP";
    content.subtitle = @"BẠN ĐANG LOG SONG SONG";
    content.body = @"NHẤN VÀO ĐÂY ĐỂ TRỞ LẠI BẢN HACK";
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @1;
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                 triggerWithTimeInterval:4.0 
                                                 repeats:NO];
    
    NSString *identifier = @"LocalNotification";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                         content:content
                                                                         trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Có lỗi khi tạo thông báo: %@", error.localizedDescription);
        } else {
            NSLog(@"Đã lên lịch thông báo thành công");
        }
    }];

    // 2. Tạo timer để mở URL sau 10 giây, đồng bộ với thông báo
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ngame1137://"]];
    });
}


-(void)createPushNotification15 {
    // 1. Lên lịch thông báo sau 10 giây
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"LQMB HACK VIP";
    content.subtitle = @"NHẤN VÀO ĐÂY ĐỂ VỀ BẢN HACK NHANH";
    content.body = @"Chỉ quay về hack khi bản gốc vào được trận";
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @1;
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                 triggerWithTimeInterval:20.0 
                                                 repeats:NO];
    
    NSString *identifier = @"LocalNotification";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                         content:content
                                                                         trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Có lỗi khi tạo thông báo: %@", error.localizedDescription);
        } else {
            NSLog(@"Đã lên lịch thông báo thành công");
        }
    }];

    // 2. Tạo timer để mở URL sau 10 giây, đồng bộ với thông báo
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ngame1137://"]];
    });
}

- (void)pushnonsongsong:(NSString *)bodyText {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"LQMB HACK VIP";
    content.subtitle = @"BẠN ĐANG LOG SONG SONG";
    content.body = bodyText;  // Dùng nội dung động
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @1;
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                 triggerWithTimeInterval:3.0 
                                                 repeats:NO];
    
    NSString *identifier = @"LocalNotification";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                         content:content
                                                                         trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Có lỗi khi tạo thông báo: %@", error.localizedDescription);
        } else {
            NSLog(@"Đã lên lịch thông báo thành công");
        }
    }];
}

- (void)pushnonsolo:(NSString *)bodyText {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"LQMB HACK VIP";
    content.subtitle = @"BẠN ĐANG CHƠI THẲNG SOLO";
    content.body = bodyText;  // Dùng nội dung động
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @1;
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                 triggerWithTimeInterval:3.0 
                                                 repeats:NO];
    
    NSString *identifier = @"LocalNotification";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                         content:content
                                                                         trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Có lỗi khi tạo thông báo: %@", error.localizedDescription);
        } else {
            NSLog(@"Đã lên lịch thông báo thành công");
        }
    }];
}

- (void)showlog {
    static UIButton *menuView = nil; // Giữ tham chiếu để kiểm tra trạng thái

    if (menuView) { 
        // Nếu menuView đã tồn tại, chuyển đổi trạng thái ẩn/hiện
        menuView.hidden = !menuView.hidden;
        return;
    }

    // Nếu chưa tồn tại, tạo mới
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat buttonYPosition = screenHeight * 0.3; 
    CGFloat screenwidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat buttonXPosition = screenwidth * 0.5; 
    menuView = [[UIButton alloc] initWithFrame:CGRectMake(buttonXPosition, buttonYPosition, 50, 50)];
    menuView.backgroundColor = [UIColor clearColor];
    [menuView addTarget:self action:@selector(buttonDragged:withEvent:) forControlEvents:UIControlEventTouchDragInside];

    [mainWindow addSubview:menuView];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    view.backgroundColor = [UIColor clearColor];
    view.layer.borderWidth = 2.0;
    view.layer.borderColor = [UIColor clearColor].CGColor; 
    view.layer.cornerRadius = 11.0;
    view.layer.masksToBounds = YES;
    [menuView addSubview:view];

    UISwitch *nutlog = [[UISwitch alloc] initWithFrame:CGRectMake(0, 8, 30, 30)];
    nutlog.transform = CGAffineTransformMakeScale(0.8, 0.8);
    nutlog.backgroundColor = [UIColor clearColor];
    [nutlog addTarget:self action:@selector(switchIsChanged1:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:nutlog];
}


- (void)switchIsChanged1:(UISwitch *)paramSender {
    [paramSender isOn] ? [self createPushNotification]
 : [self createPushNotification]
; 
}



- (void)buttonDragged:(UIButton *)button withEvent:(UIEvent *)event {
    UITouch *touch = [[event touchesForView:button] anyObject];
    CGPoint previousLocation = [touch previousLocationInView:button];
    CGPoint location = [touch locationInView:button];
    CGFloat delta_x = location.x - previousLocation.x;
    CGFloat delta_y = location.y - previousLocation.y;
    button.center = CGPointMake(button.center.x + delta_x, button.center.y + delta_y);
}


- (void)showlogV2 {
    static UIButton *menuView = nil; // Giữ tham chiếu để kiểm tra trạng thái

    if (menuView) { 
        // Nếu menuView đã tồn tại, chuyển đổi trạng thái ẩn/hiện
        menuView.hidden = !menuView.hidden;
        return;
    }

    // Nếu chưa tồn tại, tạo mới
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat buttonYPosition = screenHeight * 0.2; 
    CGFloat screenwidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat buttonXPosition = screenwidth * 0.5; 
    menuView = [[UIButton alloc] initWithFrame:CGRectMake(buttonXPosition, buttonYPosition, 50, 50)];
    menuView.backgroundColor = [UIColor clearColor];
    [menuView addTarget:self action:@selector(buttonDragged:withEvent:) forControlEvents:UIControlEventTouchDragInside];

    [mainWindow addSubview:menuView];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    view.backgroundColor = [UIColor clearColor];
    view.layer.borderWidth = 2.0;
    view.layer.borderColor = [UIColor clearColor].CGColor; 
    view.layer.cornerRadius = 11.0;
    view.layer.masksToBounds = YES;
    [menuView addSubview:view];

    UISwitch *nutlog = [[UISwitch alloc] initWithFrame:CGRectMake(0, 8, 30, 30)];
    nutlog.transform = CGAffineTransformMakeScale(0.8, 0.8);
    nutlog.backgroundColor = [UIColor clearColor];
    [nutlog addTarget:self action:@selector(switchIsChanged2:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:nutlog];
}


- (void)switchIsChanged2:(UISwitch *)paramSender {
    [paramSender isOn] ? [self createPushNotification2]
 : [self createPushNotification2]
; 
}


-(void)createPushNotification2 {
    // 1. Lên lịch thông báo sau 10 giây
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"LQMB HACK VIP";
    content.subtitle = @"BẠN ĐANG LOG SONG SONG V2";
    content.body = @"Nếu Bản Gốc Đã Đồng Bộ Với Bản Hack Thì Hãy Nhấn Vào Để Quay Về Gốc";
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @1;
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                 triggerWithTimeInterval:30.0 
                                                 repeats:NO];
    
    NSString *identifier = @"LocalNotification";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                         content:content
                                                                         trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Có lỗi khi tạo thông báo: %@", error.localizedDescription);
        } else {
            NSLog(@"Đã lên lịch thông báo thành công");
        }
    }];

    // 2. Tạo timer để mở URL sau 10 giây, đồng bộ với thông báo
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ngame1137://"]];
                      [self showlogV2];
    });
}


-(void)createPushNotification3 {
    // 1. Lên lịch thông báo sau 10 giây
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"LQMB HACK VIP";
    content.subtitle = @"BẠN ĐANG LOG SONG SONG V2";
    content.body = @"Nếu Bản Gốc Đã Đồng Bộ Với Bản Hack Thì Hãy Nhấn Vào Để Quay Về Gốc";
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @1;
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                 triggerWithTimeInterval:30.0 
                                                 repeats:NO];
    
    NSString *identifier = @"LocalNotification";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                         content:content
                                                                         trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Có lỗi khi tạo thông báo: %@", error.localizedDescription);
        } else {
            NSLog(@"Đã lên lịch thông báo thành công");
        }
    }];

    // 2. Tạo timer để mở URL sau 10 giây, đồng bộ với thông báo
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ngame1137://"]];
    });
}
- (void)linkcauhinh {
  UIAlertController *alertController =
      [UIAlertController alertControllerWithTitle:@"DÁN LINK CẤU HÌNH INI"
                                          message:nil
                                   preferredStyle:UIAlertControllerStyleAlert];

  [alertController
      addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
        textField.placeholder = @"DÁN LINK TẠI ĐÂY";

        // Tự động dán nội dung từ clipboard vào textField
        NSString *pasteboardString = [UIPasteboard generalPasteboard].string;
        if (pasteboardString) {
          textField.text = pasteboardString;
        }
      }];

  UIAlertAction *cancelAction =
      [UIAlertAction actionWithTitle:@"CANCEL"
                               style:UIAlertActionStyleCancel
                             handler:nil];
  [alertController addAction:cancelAction];

  UIAlertAction *okAction = [UIAlertAction
      actionWithTitle:@"TIẾP TỤC"
                style:UIAlertActionStyleDefault
              handler:^(UIAlertAction *_Nonnull action) {
                NSString *linkURL = alertController.textFields.firstObject.text;
                [self linkcauhinh2:linkURL];
              }];
  [alertController addAction:okAction];

  UIViewController *rootViewController =
      [[[UIApplication sharedApplication] keyWindow] rootViewController];
  [rootViewController presentViewController:alertController
                                   animated:YES
                                 completion:nil];
}

- (void)linkcauhinh2:(NSString *)linkURL {
  NSURL *url = [NSURL URLWithString:linkURL];
  NSURLSessionConfiguration *configuration =
      [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

  // Tạo và hiển thị alertController với thanh tiến trình
  UIAlertController *progressAlert =
      [UIAlertController alertControllerWithTitle:@"ĐANG LOAD"
                                          message:@"0%"
                                   preferredStyle:UIAlertControllerStyleAlert];
  UIProgressView *progressView = [[UIProgressView alloc]
      initWithProgressViewStyle:UIProgressViewStyleDefault];
  progressView.frame = CGRectMake(10, 70, 250, 10);
  [progressAlert.view addSubview:progressView];

  UIViewController *rootViewController =
      [[[UIApplication sharedApplication] keyWindow] rootViewController];
  [rootViewController presentViewController:progressAlert
                                   animated:YES
                                 completion:nil];

  NSURLSessionDownloadTask *downloadTask = [session
      downloadTaskWithURL:url
        completionHandler:^(NSURL *temporaryFileURL, NSURLResponse *response,
                            NSError *error) {
          if (error) {
            NSLog(@"Lỗi khi tải tệp zip: %@", error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
              [progressAlert dismissViewControllerAnimated:YES completion:nil];
            });
            return;
          } else {

          }
          NSURL *fileURL = temporaryFileURL;
          [self handleZipFile:fileURL
              withProgressAlert:progressAlert
                andProgressView:progressView];
        }];

  [downloadTask resume];

  // Cập nhật tiến trình tải xuống
  [session
      getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks,
                                      NSArray *downloadTasks) {
        NSURLSessionDownloadTask *task = downloadTasks.firstObject;
        [task addObserver:self
               forKeyPath:@"countOfBytesReceived"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
      }];
}

@end
