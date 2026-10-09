
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface maintool : NSObject <UIDocumentPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) UITapGestureRecognizer *tripleTapGesture;
@property (nonatomic, copy) NSString *selectedVideoPath;

+ (instancetype)sharemain;
- (void)initDisplayLabel;
- (void)thongbaomod;
- (void)showInputDialog;
// - (void)clear;
- (void)exit;
- (void)clearAll;
- (void)showVideoPicker;
// - (void)moveAndReplaceVideosWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info; // Thêm thông tin info vào khai báo
- (void)resetsanh;
- (void)openAppDirectory;
- (void)deleteBeetalkSessionDB;
- (void)openFilePicker;
- (void)xoamod;
- (void)inputLinkMod;
// -(void)modfullskin;
- (void)restore;
-(void)udid;
-(void)recall;
-(void)showInputFields;
-(void)paste;
-(void)restartApplicationgame;
-(void)modsanhfull;
-(void)modsanhless;
-(void)demsanh;
- (void)nvdia:(NSString *)showMapText;
- (void)nvdiagreen:(NSString *)showMapText;
- (void)nvdiared:(NSString *)showMapText;
- (void)nvdialong:(NSString *)showMapText;
-(void)autobando;
-(void)autobando2;
-(void)autobandobenphai;
-(void)activehack;
-(void)goodgame;
-(void)setupProfileModSkin;
-(void)AUTOCLICKER;
-(void)ChangeAccount;
-(void)LoadAcc;
-(void)togglenuttaiho;
-(void)togglenuthome;
-(void)labellogsongsong;
-(void)labeldanhthang;
-(void)labeldanhkin;
-(void)createPushNotification;
-(void)requestNotificationPermission;
-(void)showlog;
-(void)createPushNotification15;
-(void)pushnonsolo:(NSString *)bodyText;
-(void)pushnonsongsong:(NSString *)bodyText;
-(void)labellogsongsong3phut;
-(void)labelchoithangcanto;
-(void)nhacnhovegoc;
-(void)showlogV2;
-(void)toggleNotification;
-(void)setNotificationStateTrue;
-(void)setNotificationStateFalse;
-(void)createPushNotification3;
-(void)linkcauhinh;
-(void)showbando2;
-(void)createPushNotification2;
// - (void)deviceinfoWithAppName:(char *)appName
//                      bundleID:(char *)bundleID
//                    appVersion:(char *)appVersion
//                   deviceModel:(char *)deviceModel;
@end