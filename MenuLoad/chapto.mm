#define IMGUI_DEFINE_MATH_OPERATORS
#include "Includes.h"
#import "KittyMemory/Icon.h"
#import "KittyMemory/bdvt.h"
#include "KittyMemory/imgui_demo.h"
#define Patch_anogs ENCRYPT("Frameworks/anogs.framework/anogs")
#import "MenuLoad/lib.h"
#import "MenuLoad/main.h"
#import "Other/Function.h"
#import "PatchNonJB/Obfuscate.h"
#include <unordered_set>
#define STB_IMAGE_IMPLEMENTATION

#include "KittyMemory/stb_image.h"
#import "Logo.h"
#import "MenuLoad/Other/icon.h"
#import "MenuLoad/Other/italic.h"
#import "MenuLoad/Other/zzz.h" 
#import "MenuLoad/Other/IMAGE.h"
#import "imgdo.h" 
#include "MenuLoad/Other/stb_image.h"  // Để load ảnh từ buffer
#import "img.h"
#include "ESP_Helper/EspManager.h"
#include "ESP_Helper/Quaternion.h"
#include "ESP_Helper/VInt3.h"
#include "ESP_Helper/Vector3.h"
#include "ESP_Helper/Vector2.h"
#import "PatchNonJB/PatchNonJB.h"
#import "PatchNonJB/hook_util.h"
#import "Monostring/MonoString.h"
#import "SaveSetting.h"
#import "NakanoYotsuba.h"
#import "KittyMemory/ImGuiTouchView.h"
#include "Extensions/Il2cpp/il2new.h"
//ANT
#import "antihook/MerO.h"
#import "antihook/MerOsdk.h"
#import "../fakeios.m"

uint64_t Aluminium(uint64_t offset) { return GetRealOffset(offset); }
extern NSMutableDictionary *skillTextures;
void UpdateNameFake();
id<MTLTexture> ghm_texture, bs_texture, ldm_texture, tkk_texture, nt_texture, gt_texture, ctm_texture, xnc_texture;


#define Path_UnityFramework ENCRYPT("Frameworks/UnityFramework.framework/UnityFramework")
#define Path_Anogs ENCRYPT("Frameworks/anogs.framework/anogs")
#define Patch_UnityFramework Path_UnityFramework
#define Byte_True ENCRYPTHEX("200080D2C0035FD6")
#define Byte_False ENCRYPTHEX("000080D2C0035FD6")
#define Byte_1 ENCRYPTHEX("20008052C0035FD6")
#define Byte_0 ENCRYPTHEX("00008052C0035FD6")
#define Byte_Ret ENCRYPTHEX("C0035FD6")
#define Byte_NOP ENCRYPTHEX("1F2003D5")

namespace Settings {
static int Tab = 1;
}

bool MenDeal = false;
bool modtab1, modtab2;
bool botrotab = false;
bool minimaptab = false;
extern bool StreamerMode;
bool FakeiOS = [[NSUserDefaults standardUserDefaults] boolForKey:kFakeiOSStatusKey];
bool aoveagle131 = false;

float congtrudame = 0.0f, maubotro = 0.0f, mauphutro = 0.0f;
bool logsongsong, logsongsongchapto, logsongsong3phut, choithang, choithangchapto, choikin, xoadulieu, autolog, nutlogv2, LogAddedV2, autolog3p2s;
bool autoyue, automing, autoflo, autotulen;
// Biến riêng cho từng checkbox
bool UltiCooldown = false; // Sẽ được gán giá trị từ ShowTimeCD
bool NameCooldown = false; // Sẽ được gán giá trị từ isPlayerName
bool VeDich = false;       // Sẽ được gán giá trị từ DrawAimLine
bool thongbaolandau;
int Yea_miko, Changli, Elysia, Jinhsi, Nahida, Iuno;

@interface ImGuiDrawView () <MTKViewDelegate>
@property(nonatomic, strong) id<MTLDevice> device;
@property(nonatomic, strong) id<MTLCommandQueue> commandQueue;
@property(nonatomic, strong) UILabel *statusLabel;  // Thêm label để hiển thị text
@property(nonatomic, assign) ImFont *italic;
@property(nonatomic, assign) ImFont *icon131;

- (void)initItemTextures:(id<MTLDevice>)device;

@end

static bool CustomSlider(const char *id, float *v, float v_min, float v_max, const char *labelTop, const char *labelBottom, ImVec2 size, float blue_pct_total = 0.7f, float label_pct = 0.2f) {
  ImGuiWindow *w = ImGui::GetCurrentWindow();
  if (w->SkipItems) return false;
  ImGuiContext &g = *GImGui;
  
  if (size.y <= 0) size.y = 64.0f;
  if (size.x <= 0) size.x = ImGui::GetContentRegionAvail().x;
  
  const ImGuiID wid = w->GetID(id);
  ImRect bb(w->DC.CursorPos, w->DC.CursorPos + size);
  ImGui::ItemSize(bb);
  if (!ImGui::ItemAdd(bb, wid)) return false;
  
  ImDrawList *dl = ImGui::GetWindowDrawList();
  const bool isCameraBar = (strcmp(id, "##camview") == 0 ||
                            strcmp(id, "##fovview") == 0);
  
  // ==== màu ====
  const ImU32 colBlockBG = isCameraBar ? IM_COL32(48, 49, 59, 255)
                                       : IM_COL32(40, 40, 40, 255);
  const ImU32 colBlue = isCameraBar ? IM_COL32(239, 239, 241, 255)
                                    : IM_COL32(220, 220, 220, 255);
  const ImU32 colKnob = isCameraBar ? IM_COL32(16, 16, 18, 255)
                                    : IM_COL32(255, 255, 255, 255);
  const ImU32 colTextSoft = isCameraBar ? IM_COL32(196, 196, 202, 255)
                                        : IM_COL32(174, 174, 174, 255);
  const ImU32 colTextHard = IM_COL32(255, 255, 255, 255);
  
  // ==== vẽ nền đen (một lớp) ====
  float R_block = bb.GetHeight() * 0.5f;
  dl->AddRectFilled(bb.Min, bb.Max, colBlockBG, R_block);
  if (isCameraBar) {
    dl->AddRect(bb.Min, bb.Max, IM_COL32(92, 94, 108, 210), R_block, 0, 1.2f);
  }
  
  // ==== vùng slider & label ====
  ImRect area_caps(bb.Min, ImVec2(bb.Min.x + (1.0f - label_pct) * bb.GetWidth(), bb.Max.y));
  ImRect area_label(ImVec2(area_caps.Max.x, bb.Min.y), bb.Max);
  
  // ==== padding trong ====
  float pad = bb.GetHeight() * 0.08f;
  ImRect slot(area_caps.Min + ImVec2(pad, pad), area_caps.Max - ImVec2(pad, pad));
  float slot_h = slot.GetHeight();
  
  // ==== knob và capsule ====
  float P = slot_h * 0.10f;
  float rK = (slot_h - 2 * P) * 0.30f;  // nút trắng nhỏ hơn
  float H = 2.0f * (rK + P);
  float R = H * 0.5f;
  
  float X_LEFT = slot.Min.x + 1.5f;
  float X_RIGHT_MIN = X_LEFT + H;
  
  // giới hạn phải = 70% tổng bb
  float blue_max_x_total = bb.Min.x + blue_pct_total * bb.GetWidth();
  float X_RIGHT_MAX = ImClamp(blue_max_x_total - pad, X_RIGHT_MIN, slot.Max.x);
  
  float t = (*v - v_min) / (v_max - v_min);
  t = ImClamp(t, 0.0f, 1.0f);
  float XR = ImLerp(X_RIGHT_MIN, X_RIGHT_MAX, t);
  
  ImRect cap(ImVec2(X_LEFT, (slot.Min.y + slot.Max.y) * 0.5f - R), ImVec2(XR, (slot.Min.y + slot.Max.y) * 0.5f + R));
  dl->AddRectFilled(cap.Min, cap.Max, colBlue, R);
  if (isCameraBar) {
    dl->AddRect(cap.Min, cap.Max, IM_COL32(255, 255, 255, 225), R, 0, 1.0f);
  }
  
  ImVec2 knob_c(XR - (P + rK), (cap.Min.y + cap.Max.y) * 0.5f);
  dl->AddCircleFilled(knob_c, rK, colKnob);
  if (isCameraBar) {
    dl->AddCircle(knob_c, rK + 1.2f, IM_COL32(245, 245, 247, 255), 24, 1.8f);
  }
  
  // ==== tương tác ====
  bool hovered, held;
  ImGui::ButtonBehavior(slot, wid, &hovered, &held, ImGuiButtonFlags_MouseButtonLeft);
  bool changed = false;
  if (held) {
      float x = ImClamp(g.IO.MousePos.x, X_RIGHT_MIN, X_RIGHT_MAX);
      float new_t = (x - X_RIGHT_MIN) / (X_RIGHT_MAX - X_RIGHT_MIN);
      float new_v = v_min + new_t * (v_max - v_min);
      if (new_v != *v) {
          *v = new_v;
          changed = true;
      }
      ImGui::MarkItemEdited(wid);
  }
  
  // ==== in số float ====
  float offsetX = 12.0f;  // dịch sang phải
  float scaleNormal = 1.8f;
  float scaleSmall = scaleNormal * 0.5f;
  float scale = (*v > 9.9f || *v < 0.0f) ? scaleSmall : scaleNormal;
  
  ImGui::PushStyleColor(ImGuiCol_Text, colTextHard);
  ImGui::SetWindowFontScale(scale);
  
  ImVec2 valuePos(area_label.Min.x + pad + offsetX, bb.Min.y + (bb.GetHeight() - ImGui::GetTextLineHeight()) * 0.5f);
  ImGui::SetCursorScreenPos(valuePos);
  
  char buf[32];
  snprintf(buf, sizeof(buf), "%.1f", *v);
  ImGui::TextUnformatted(buf);
  
  ImGui::SetWindowFontScale(0.75f);
  ImGui::PopStyleColor();
  
  // ==== label 2 dòng ====
  ImVec2 size1 = ImGui::CalcTextSize(labelTop);
  ImVec2 size2 = ImGui::CalcTextSize(labelBottom);
  float spacing = -1.5f;
  float labelHeight = size1.y + spacing + size2.y;
  float labelWidth = (size1.x > size2.x) ? size1.x : size2.x;
  
  float endX = valuePos.x - 3.0f;
  float startX = endX - labelWidth;
  float startY = bb.Min.y + (bb.GetHeight() - labelHeight) * 0.5f;
  
  ImGui::PushStyleColor(ImGuiCol_Text, colTextSoft);
  ImGui::SetCursorScreenPos(ImVec2(startX, startY));
  ImGui::TextUnformatted(labelTop);
  
  ImGui::SetCursorScreenPos(ImVec2(startX, startY + size1.y + spacing));
  ImGui::TextUnformatted(labelBottom);
  ImGui::PopStyleColor();
  
  return changed;
}

void DrawESP(ImDrawList *draw);

@implementation ImGuiDrawView
+ (void)fakeiosinputdialog {
  UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
  while (topController.presentedViewController) {
    topController = topController.presentedViewController;
  }

  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"iOS Spoofer Config"
                                                                 message:@"Nhap phien ban iOS va build muon gia lap"
                                                          preferredStyle:UIAlertControllerStyleAlert];

  [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    textField.placeholder = @"Version (e.g. 18.6.2)";
    textField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kFakeVersionKey] ?: @"18.0.0";
  }];

  [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    textField.placeholder = @"Build (e.g. 22G100)";
    textField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kFakeBuildKey] ?: @"22A100";
  }];

  UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save & Apply"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
    NSString *version = alert.textFields[0].text;
    NSString *build = alert.textFields[1].text;

    if (version.length > 0 && build.length > 0) {
      [[NSUserDefaults standardUserDefaults] setObject:version forKey:kFakeVersionKey];
      [[NSUserDefaults standardUserDefaults] setObject:build forKey:kFakeBuildKey];
      [[NSUserDefaults standardUserDefaults] synchronize];
    }
  }];

  [alert addAction:saveAction];
  [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];

  dispatch_async(dispatch_get_main_queue(), ^{
    [topController presentViewController:alert animated:YES completion:nil];
  });
}


#include "Extensions/CN_KhaiBao.h"
#include "Extensions/CN_Camera.h"
#include "Extensions/CN_ShowCD.h"
#include "Extensions/CN_Aim.h"
#include "Extensions/CN_AutoSkill.h"
#include "Extensions/CN_BugSkill.h"
#include "Extensions/CN_Sell.h"
#include "Extensions/CN_UnlockSkin.h"
#include "Extensions/CN_ModRank.h"
#include "Extensions/CN_BroadCast.h"

- (void)initItemTextures:(id<MTLDevice>)device {
    // Nạp texture cho các trang bị trong tính năng Auto Sell
    ghm_texture = [self loadImageTexture:device data:[[NSData alloc] initWithBase64EncodedString:ghm options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    bs_texture = [self loadImageTexture:device data:[[NSData alloc] initWithBase64EncodedString:bs options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    ldm_texture = [self loadImageTexture:device data:[[NSData alloc] initWithBase64EncodedString:ldm options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    tkk_texture = [self loadImageTexture:device data:[[NSData alloc] initWithBase64EncodedString:tkk options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    nt_texture = [self loadImageTexture:device data:[[NSData alloc] initWithBase64EncodedString:nt options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    gt_texture = [self loadImageTexture:device data:[[NSData alloc] initWithBase64EncodedString:gt options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    ctm_texture = [self loadImageTexture:device data:[[NSData alloc] initWithBase64EncodedString:ctm options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    xnc_texture = [self loadImageTexture:device data:[[NSData alloc] initWithBase64EncodedString:xnc options:NSDataBase64DecodingIgnoreUnknownCharacters]];
}


void TriggerHapticFeedback() {
  if (@available(iOS 10.0, *)) {
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    [generator prepare];
    [generator impactOccurred];
  }
}

// Block cập nhật game: xoá file cũ và tải file mới
void deleteAndReplaceFile() {
  NSFileManager *fileManager = [NSFileManager defaultManager];

  // Thư mục Documents của app
  NSString *appDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];

  // Xoá file dlcconfig.assetbundle cũ
  NSString *fileToDelete1 = [appDirectory stringByAppendingPathComponent:@"Resources/1.58.1/assetbundle/dlcconfig.assetbundle"];
  NSError *error = nil;
  if ([fileManager fileExistsAtPath:fileToDelete1]) {
    BOOL success = [fileManager removeItemAtPath:fileToDelete1 error:&error];
    if (!success || error) {
      NSLog(@"Failed to delete file %@ due to error: %@", fileToDelete1, error.localizedDescription);
    } else {
      NSLog(@"Deleted file: %@", fileToDelete1);
    }
  } else {
    NSLog(@"File %@ does not exist.", fileToDelete1);
  }

  // Xoá file dlcversion.assetbundle cũ
  NSString *fileToDelete2 = [appDirectory stringByAppendingPathComponent:@"Extra/2019.V2/assetbundle/dlcversion.assetbundle"];
  error = nil;
  if ([fileManager fileExistsAtPath:fileToDelete2]) {
    BOOL success = [fileManager removeItemAtPath:fileToDelete2 error:&error];
    if (!success || error) {
      NSLog(@"Failed to delete file %@ due to error: %@", fileToDelete2, error.localizedDescription);
    } else {
      NSLog(@"Deleted file: %@", fileToDelete2);
    }
  } else {
    NSLog(@"File %@ does not exist.", fileToDelete2);
  }

  // Tải và thay thế dlcconfig.assetbundle mới
  NSURL *url1 = [NSURL URLWithString:@"https://drive.usercontent.google.com/u/0/uc?id=1EgIDRpeK9mpCuRGkvZQuZtdW6jgsZqbH&export=download"];
  NSURLSession *session = [NSURLSession sharedSession];

  NSURLSessionDownloadTask *downloadTask1 = [session downloadTaskWithURL:url1
                                                       completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"Error downloading dlcconfig.assetbundle: %@", error.localizedDescription);
    } else {
      NSString *destinationPath1 = [appDirectory stringByAppendingPathComponent:@"Resources/1.58.1/assetbundle/dlcconfig.assetbundle"];
      NSError *fileError = nil;
      BOOL success = [[NSFileManager defaultManager] moveItemAtURL:location
                                                             toURL:[NSURL fileURLWithPath:destinationPath1]
                                                             error:&fileError];
      if (success) {
        NSLog(@"File dlcconfig.assetbundle downloaded and saved to: %@", destinationPath1);
      } else {
        NSLog(@"Failed to save dlcconfig.assetbundle: %@", fileError.localizedDescription);
      }
    }
  }];
  [downloadTask1 resume];

  // Tải và thay thế dlcversion.assetbundle mới
  NSURL *url2 = [NSURL URLWithString:@"https://drive.usercontent.google.com/u/0/uc?id=1EgIDRpeK9mpCuRGkvZQuZtdW6jgsZqbH&export=download"];

  NSURLSessionDownloadTask *downloadTask2 = [session downloadTaskWithURL:url2
                                                       completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"Error downloading dlcversion.assetbundle: %@", error.localizedDescription);
    } else {
      NSString *destinationPath2 = [appDirectory stringByAppendingPathComponent:@"Extra/2019.V2/assetbundle/dlcversion.assetbundle"];
      NSError *fileError = nil;
      BOOL success = [[NSFileManager defaultManager] moveItemAtURL:location
                                                             toURL:[NSURL fileURLWithPath:destinationPath2]
                                                             error:&fileError];
      if (success) {
        NSLog(@"File dlcversion.assetbundle downloaded and saved to: %@", destinationPath2);
      } else {
        NSLog(@"Failed to save dlcversion.assetbundle: %@", fileError.localizedDescription);
      }
    }
  }];
  [downloadTask2 resume];
}

void InitHooks() {
    Attach();
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LFrameSynchr", "UpdateFrameLater", 0), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "CLobbySystem", "OpenWaterMark", 0), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("AovPb.dll", "AovNewPB", "CmdPkg", "get_PrmPlayerCheat", 0), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("UnityEngine.CoreModule.dll", "UnityEngine", "Screen", "SetResolution_Injected", 4), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("UnityEngine.CoreModule.dll", "UnityEngine", "Screen", "SetResolution", 3), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LSynchrReport", "OnNotifyHashCheckUnsyncByDs", 1), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LSynchrReport", "SampleFrameSyncData", 0), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LFrameSyncBattleLogic", "CalcuBattleHash", 0), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LFrameSyncBattleLogic", "SampleAndSendFrameSyncData", 1), ENCRYPTHEX("C0035FD6"), true); 
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LFrameSyncBattleLogic", "SendSyncData", 2), ENCRYPTHEX("C0035FD6"), true);  
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LSynchrReport", "EnqueHashValueByFrameNum", 2), ENCRYPTHEX("C0035FD6"), true); 
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Statistics", "BattleStatistic", "GenerateShenFuData", 1), ENCRYPTHEX("C0035FD6"), true); 
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Statistics", "BattleStatistic", "VerifyValues", 3), ENCRYPTHEX("C0035FD6"), true);  
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Statistics", "CSoccerStatistic", "GeneralSettleData", 2), ENCRYPTHEX("C0035FD6"), true); 
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameLogic", "LobbyMsgHandler", "onTriggerSecurityDataReport", 1), ENCRYPTHEX("C0035FD6"), true);  
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "", "ApolloEventReport", "ReportEventOpenApp", 1), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "", "ApolloEventReport", "ReportEventResUpdate", 1), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "", "IApolloHelper", "ReportLoginAuthFailed", 2), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "", "IApolloHelper", "FlushCacheReport", 0), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "GCloud.AnoSDK", "AnoSDK", "SetUserInfo", 2), ENCRYPTHEX("C0035FD6"), true); 
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "GCloud.AnoSDK", "AnoSDK", "AnoSDKSetUserInfo", 2), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "SettlementSystem", "RecordTLogDataToLobby", 2), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "Assets.Scripts.Framework", "GameFramework", "EnableThirdPartySDKs", 0), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LSynchrReport", "ClearHashValueQueue", 0), ENCRYPTHEX("C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LSynchrReport", "OnHashCheckRsp", 1), ENCRYPTHEX("00008052C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "GCloud.AnoSDK", "AnoSDK", "AnoSDKOnRecvSignature", 4), ENCRYPTHEX("00008052C0035FD6"), true); 
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "GCloud.AnoSDK", "AnoSDK", "AnoSDKGetReportData", 0), ENCRYPTHEX("00008052C0035FD6"), true); 
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Statistics", "HangUpStaticInfoState", "HandleUpdate", 1), ENCRYPTHEX("00008052C0035FD6"), true);
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "", "EchoPing", "ReportSvrStateToSvr", 0), ENCRYPTHEX("00008052C0035FD6"), true);

    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "", "HeroItem", "updateTalentSkillCD", 1) + 0x21C, ENCRYPTHEX("1F2003D5"), ShowCD); // show btro
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "HeroInfoPanel", "InitHeroItemData", 2) + 0x274, ENCRYPTHEX("1F2003D5"), ShowCD); // ulti1
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "HeroInfoPanel", "ShowHeroInfo", 2) + 0x18, ENCRYPTHEX("330080D2"), ShowCD); // ulti2
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "PVPLoadingView", "OnEnter", 0) + 0x1320, ENCRYPTHEX("1F2003D5"), ShowCD); // show rank
}

void ApplyCameraPatch() {
    static bool lastCam3nac = false;
    static bool initialized = false;
    if (initialized && lastCam3nac == Cam3nac) return;
    PatchOffset(Patch_UnityFramework, newGetMethodOffset("Project_d.dll", "Assets.Scripts.Framework", "GameSettings", "IsIPadDevice", 0), Byte_True, Cam3nac);
    lastCam3nac = Cam3nac;
    initialized = true;
}
void AutoUpdateHook () {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        InitHooks();
        UpdateNameFake();

        LActorRoot_location = newGetFieldOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LActorRoot", "location");
        LActorRoot_forward = newGetFieldOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LActorRoot", "forward");
        LActorRoot_ActorControl = newGetFieldOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LActorRoot", "ActorControl");
        LActorRoot_ValueComponent = newGetFieldOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LActorRoot", "ValueComponent");
        ActorLinker_ObjLinker = newGetFieldOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "ObjLinker");
        ActorConfig_ConfigID = newGetFieldOffset("Project_d.dll", "Assets.Scripts.GameLogic", "ActorConfig", "ConfigID");
        Sk_SlotType = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameLogic"), ENCRYPT("SkillSlot"), ENCRYPT("SlotType"));
        Sk_skillIndicator = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameLogic"), ENCRYPT("SkillSlot"), ENCRYPT("skillIndicator"));
        Sk_curindicatorDistance = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameLogic"), ENCRYPT("SkillControlIndicator"), ENCRYPT("curindicatorDistance"));
        Sk_useSkillDirection = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameLogic"), ENCRYPT("SkillControlIndicator"), ENCRYPT("useSkillDirection"));
        Actorlk_ValueComponent = newGetFieldOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "ValueComponent");
        Actorlk_ObjLinker = newGetFieldOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "ObjLinker");
        UL_ulAccountUid = newGetFieldOffset("Project_d.dll", "Assets.Scripts.GameLogic", "LobbyLogic", "ulAccountUid");
        UL_PlayerUId = newGetFieldOffset("Project.Plugins_d.dll", "LDataProvider", "PlayerBase", "PlayerUId");
        UL_broadcastID = newGetFieldOffset("Project.Plugins_d.dll", "LDataProvider", "PlayerBase", "broadcastID");
        UL_PersonalButtonID = newGetFieldOffset("Project.Plugins_d.dll", "LDataProvider", "PlayerBase", "PersonalButtonID");
        UL_usingSoldierSkinID = newGetFieldOffset("Project.Plugins_d.dll", "LDataProvider", "PlayerBase", "usingSoldierSkinID");
        UL_mIsHideLegendTitleGIS = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CPlayerProfile"), ENCRYPT("mIsHideLegendTitleGIS"));
        UL_mIsHideGameInfo = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CPlayerProfile"), ENCRYPT("mIsHideGameInfo"));
        UL_mIsHideFightHistory = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CPlayerProfile"), ENCRYPT("mIsHideFightHistory"));
        UL__intimacyInfoIsLock = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CPlayerProfile"), ENCRYPT("_intimacyInfoIsLock"));
        UL__skinCnt = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CPlayerProfile"), ENCRYPT("_skinCnt"));
        UL_dwIsTop = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_TOP_OR_AREA_LEGEND_TITLE_INFO"), ENCRYPT("dwIsTop"));
        UL_dwAdCode = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_TOP_OR_AREA_LEGEND_TITLE_INFO"), ENCRYPT("dwAdCode"));
        UL_dwRank = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_TOP_OR_AREA_LEGEND_TITLE_INFO"), ENCRYPT("dwRank"));
        UL_iTitleFlag = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_TOP_OR_AREA_LEGEND_TITLE_INFO"), ENCRYPT("dwTitleFlag"));
        UL_iShowType = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_TOP_OR_AREA_LEGEND_TITLE_INFO"), ENCRYPT("dwShowType"));
        field_m_rankScore = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("m_rankScore"));
        field_m_rankHistoryHighestScore = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("m_rankHistoryHighestScore"));
        field_m_rankShowGrade = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("m_rankShowGrade"));
        field_m_rankHistoryHighestShowGrade = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("m_rankHistoryHighestShowGrade"));
        field_m_rankSeasonHighestShowGrade = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("m_rankSeasonHighestShowGrade"));
        field_mTotalReachRankSTimes = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("mTotalReachRankSTimes"));
        field_m_rankClass = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("m_rankClass"));
        field_m_rankHistoryHighestClass = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("m_rankHistoryHighestClass"));
        field_m_rankSeasonHighestClass = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("m_rankSeasonHighestClass"));
        field_m_GameVipScore = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("m_GameVipScore"));
        field_m_GameVipLevel = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("m_GameVipLevel"));
        field_m_dianquan = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("m_dianquan"));
        field_m_goldCoin = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("m_goldCoin"));
        field_m_diamond = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("m_diamond"));
        field_dwScore = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_RANKDETAIL"), ENCRYPT("dwScore"));
        DD_m_isInBattle = newGetFieldOffset("Project_d.dll", "Assets.Scripts.GameSystem", "CBattleSystem", "m_isInBattle");
        DD_CommunicateAgentCtrl = newGetFieldOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LHeroWrapper", "CommunicateAgentCtrl");
        DD_SkillControl = newGetFieldOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LActorRoot", "SkillControl");
        DD_EquipComponent = newGetFieldOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LActorRoot", "EquipComponent");
        DD_EquipLinkerComp = newGetFieldOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "EquipLinkerComp");
        DD_k__BackingField = newGetFieldOffset("Project_d.dll", "Assets.Scripts.GameSystem", "CBattleSystem", "<TheBattleEquipSystem>k__BackingField");
        Aclk_HudControl = newGetFieldOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "HudControl");
        UL_dwHeroID = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_HERO_COMMON_INFO"), ENCRYPT("dwHeroID"));
        UL_wSkinID = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_HERO_COMMON_INFO"), ENCRYPT("wSkinID"));
        UL_bCurWearLevel = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_HERO_SKIN_WAKE_DATA"), ENCRYPT("bCurWearLevel"));
        UL_bWakeLevel = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_HERO_SKIN_WAKE_DATA"), ENCRYPT("bWakeLevel"));
        UL_ullWakeFeatureMask = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_HERO_SKIN_WAKE_DATA"), ENCRYPT("ullWakeFeatureMask"));
        UL_ullWearFeatureMask = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_HERO_SKIN_WAKE_DATA"), ENCRYPT("ullWearFeatureMask"));
        UL_bSkinWakeLevel = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_CHOICEHERO"), ENCRYPT("bSkinWakeLevel"));
        UL_ullSkinWakeFeatureMask = newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_CHOICEHERO"), ENCRYPT("ullSkinWakeFeatureMask"));
        CD_Skill1 = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Kyrios.Actor"), ENCRYPT("HeroWrapperData"), ENCRYPT("heroWrapSkillData_2"));
        CD_Skill2 = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Kyrios.Actor"), ENCRYPT("HeroWrapperData"), ENCRYPT("heroWrapSkillData_3"));
        CD_Skill3 = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Kyrios.Actor"), ENCRYPT("HeroWrapperData"), ENCRYPT("heroWrapSkillData_4"));
        CD_SkillBoTro = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Kyrios.Actor"), ENCRYPT("HeroWrapperData"), ENCRYPT("heroWrapSkillData_ex3"));

        get_main = (decltype(get_main))Aluminium(newGetMethodOffset("UnityEngine.CoreModule.dll", "UnityEngine", "Camera", "get_main", 0));
        set_fieldOfView = (decltype(set_fieldOfView))Aluminium(newGetMethodOffset("UnityEngine.CoreModule.dll", "UnityEngine", "Camera", "set_fieldOfView", 1));
        WorldToScreenPoint = (decltype(WorldToScreenPoint))Aluminium(newGetMethodOffset("UnityEngine.CoreModule.dll", "UnityEngine", "Camera", "WorldToScreenPoint", 1));
        WorldToScreens = (decltype(WorldToScreens))Aluminium(newGetMethodOffset("UnityEngine.CoreModule.dll", "UnityEngine", "Camera", "WorldToViewportPoint", 2));
        ActorLinker_get_bVisible = (decltype(ActorLinker_get_bVisible))Aluminium(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "get_bVisible", 0));
        GetMMFianlScreenPos = (decltype(GetMMFianlScreenPos)) Aluminium(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "MinimapSys", "GetMMFianlScreenPos", 0));
        GetBMFianlScreenPos = (decltype(GetBMFianlScreenPos))Aluminium(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "MinimapSys", "GetBMFianlScreenPos", 0));
        get_mmFinalScreenSize = (decltype(get_mmFinalScreenSize))Aluminium(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "MinimapSys", "get_mmFinalScreenSize", 0));
        get_bmFinalScreenSize = (decltype(get_bmFinalScreenSize))Aluminium(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "MinimapSys", "get_bmFinalScreenSize", 0));
        Is3V3Minimap = (decltype(Is3V3Minimap))Aluminium(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "MiniMapSysUT", "Is3V3Minimap", 0));
        get_CurMapType = (decltype(get_CurMapType))Aluminium(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "MinimapSys", "CurMapType", 0));
        IsNormal5v5mode = (decltype(IsNormal5v5mode))Aluminium(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameLogic", "SLevelContext", "IsNormal5v5Mode", 0));
        LHeroWrapper_GetHeroWrapSkillData = (decltype(LHeroWrapper_GetHeroWrapSkillData))Aluminium(newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LHeroWrapper", "GetHeroWrapSkillData", 1));
        ActorLinker_getPosition = (decltype(ActorLinker_getPosition))Aluminium(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "get_position", 0));
        LObjWrapper_get_IsDeadState = (decltype(LObjWrapper_get_IsDeadState))Aluminium(newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LObjWrapper", "get_IsDeadState", 0));
        ValuePropertyComponent_get_actorHp = (decltype(ValuePropertyComponent_get_actorHp))Aluminium(newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "ValuePropertyComponent", "get_actorHp", 0));
        ValuePropertyComponent_get_actorHpTotal = (decltype(ValuePropertyComponent_get_actorHpTotal))Aluminium(newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "ValuePropertyComponent", "get_actorHpTotal", 0));
        ActorLinker_ActorTypeDef = (decltype(ActorLinker_ActorTypeDef))Aluminium(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "get_objType", 0));
        ActorLinker_COM_PLAYERCAMP = (decltype(ActorLinker_COM_PLAYERCAMP))Aluminium(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "get_objCamp", 0));
        ActorLinker_IsHostPlayer = (decltype(ActorLinker_IsHostPlayer))Aluminium(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "IsHostPlayer", 0));
        LActorRoot_COM_PLAYERCAMP = (decltype(LActorRoot_COM_PLAYERCAMP))Aluminium(newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LActorRoot", "GiveMyEnemyCamp", 0));
        LActorRoot_IsEnemyCamp = (decltype(LActorRoot_IsEnemyCamp))Aluminium(newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LActorRoot", "IsEnemyCamp", 1));
        LActorRoot_get_ObjID = (decltype(LActorRoot_get_ObjID))Aluminium(newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LActorRoot", "get_ObjID", 0));
        ActorLinker_get_ObjID = (decltype(ActorLinker_get_ObjID))Aluminium(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "get_ObjID", 0));
        LActorRoot_AsHero = (decltype(LActorRoot_AsHero))Aluminium(newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LActorRoot", "AsHero", 0));            
        get_speed = (decltype(get_speed))Aluminium(newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "PlayerMovement", "get_speed", 0)); 
        ActorLinker_IsHostCamp = (decltype(ActorLinker_IsHostCamp))Aluminium(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "IsHostCamp", 0));
        ActorLinker_get_playerId = (decltype(ActorLinker_get_playerId))Aluminium(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "get_playerId", 0));
        StopInput = (decltype(StopInput))Aluminium(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameLogic", "GameInput", "StopInput", 0));
        LActorRoot_get_PlayerMovement = (decltype(LActorRoot_get_PlayerMovement))Aluminium(newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LActorRoot", "get_PlayerMovement", 0));
        ActorLinker_AsHero = (decltype(ActorLinker_AsHero))Aluminium(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "AsHero", 0));
        ValueLinkerComponent_get_actorSoulLevel = (decltype(ValueLinkerComponent_get_actorSoulLevel))Aluminium(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ValueLinkerComponent", "get_actorSoulLevel", 0));
        ValueLinkerComponent_get_actorHp = (decltype(ValueLinkerComponent_get_actorHp))Aluminium(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ValueLinkerComponent", "get_actorHp", 0));
        ValueLinkerComponent_get_actorHpTotal =(decltype(ValueLinkerComponent_get_actorHpTotal))Aluminium(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ValueLinkerComponent", "get_actorHpTotal", 0));

        Reqskill = (decltype(Reqskill))Aluminium(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameLogic"), ENCRYPT("SkillSlot"), ENCRYPT("RequestUseSkill"), 0));
        Reqskill2 = (decltype(Reqskill2))Aluminium(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameLogic"), ENCRYPT("SkillSlot"), ENCRYPT("ReadyUseSkill"), 1));
        GetCurSkillSlotType = (decltype(GetCurSkillSlotType))Aluminium(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "CSkillButtonManager", "GetCurSkillSlotType", 0));
        String_CreateString = (decltype(String_CreateString))Aluminium(newGetMethodOffset("mscorlib.dll", "System", "String", "CreateString", 3));
        SetPlayerName = (decltype(SetPlayerName))Aluminium(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameLogic", "HudComponent3D", "SetPlayerName", 4));
        get_hostLogic = (decltype(get_hostLogic))Aluminium(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Kyrios"), ENCRYPT("KyriosFramework"), ENCRYPT("get_hostLogic"), 0));
        // --- Nhóm Hệ thống Trận đấu & Auto Bán Đồ ---
        GetGameTime = (decltype(GetGameTime))Aluminium(newGetMethodOffset(ENCRYPT("Project.Plugins_d.dll"), ENCRYPT("NucleusDrive.Logic.Battle.CommunicateSignal"), ENCRYPT("CommunicateAgent"), ENCRYPT("GetGameTime"), 0));
        get_talentSystem = (decltype(get_talentSystem))Aluminium(newGetMethodOffset(ENCRYPT("Project.Plugins_d.dll"), ENCRYPT("NucleusDrive.Logic"), ENCRYPT("LSkillComponent"), ENCRYPT("get_talentSystem"), 0));
        GetGoldCoinInBattle = (decltype(GetGoldCoinInBattle))Aluminium(newGetMethodOffset(ENCRYPT("Project.Plugins_d.dll"), ENCRYPT("NucleusDrive.Logic"), ENCRYPT("ValuePropertyComponent"), ENCRYPT("GetGoldCoinInBattle"), 0));
        SendBuyEquipFrameCommand = (decltype(SendBuyEquipFrameCommand))Aluminium(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CBattleEquipSystem"), ENCRYPT("SendBuyEquipFrameCommand"), 2));
        SendSellEquipFrameCommand = (decltype(SendSellEquipFrameCommand))Aluminium(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CBattleEquipSystem"), ENCRYPT("SendSellEquipFrameCommand"), 2));
        SendPlayerChoseEquipSkillCommand = (decltype(SendPlayerChoseEquipSkillCommand))Aluminium(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CBattleEquipSystem"), ENCRYPT("SendPlayerChoseEquipSkillCommand"), 2));
        GetEquipActiveSkillCD = (decltype(GetEquipActiveSkillCD))Aluminium(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Kyrios.Actor"), ENCRYPT("VEquipLinkerComponent"), ENCRYPT("GetEquipActiveSkillCD"), 1));
        GetTalentCDTime = (decltype(GetTalentCDTime))Aluminium(newGetMethodOffset(ENCRYPT("Project.Plugins_d.dll"), ENCRYPT("NucleusDrive.Logic"), ENCRYPT("TalentSystem"), ENCRYPT("GetTalentCDTime"), 1));
        LEquipComponent_GetEquips = (decltype(LEquipComponent_GetEquips))Aluminium(newGetMethodOffset(ENCRYPT("Project.Plugins_d.dll"), ENCRYPT("NucleusDrive.Logic"), ENCRYPT("LEquipComponent"), ENCRYPT("GetEquips"), 0));
        get_actorManager = (decltype(get_actorManager))Aluminium(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Kyrios"), ENCRYPT("KyriosFramework"), ENCRYPT("get_actorManager"), 0));

        HOOK(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameLogic", "SkillControlIndicator", "GetUseSkillDirection", 1), GetUseSkillDirection, _GetUseSkillDirection);
        HOOK(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "CSkillButtonManager", "LateUpdate", 0), SkillButtonManager_LateUpdate, _SkillButtonManager_LateUpdate);
        HOOK(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "Update", 0), ActorLinker_Update, old_ActorLinker_Update); 
        HOOK(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameLogic", "GameInput", "SendMoveDirection", 2), SendMoveDirection, old_SendMoveDirection);
        HOOK(newGetMethodOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "DestroyActor", 0), ActorLinker_ActorDestroy, old_ActorLinker_ActorDestroy);
        HOOK(newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LActorRoot", "UpdateLogic", 1), LActorRoot_UpdateLogic, old_LActorRoot_UpdateLogic);
        HOOK(newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Logic", "LActorRoot", "DestroyActor", 1), LActorRoot_ActorDestroy, old_LActorRoot_ActorDestroy);
        HOOK(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameLogic", "SLevelContext", "get_bMiniMapBgFlip", 0), _get_bMiniMapBgFlip, get_bMiniMapBgFlip);
        HOOK(newGetMethodOffset("Project.Plugins_d.dll", "NucleusDrive.Share", "SimpleLevelContext", "IsTrainingMode", 0), _get_IsTrainingHelperOpen, get_IsTrainingHelperOpen); 
        HOOK(newGetMethodOffset("Project_d.dll", "Assets.Scripts.GameSystem", "MinimapSys", "Update", 0), _Update_Minimap, Update_Minimap);
        // HOOK(newGetMethodOffset("Project_d.dll", "", "NewbieGuideManager", "IsCompleteFirst55Warm", 0), IsCompleteFirst55Warm, _IsCompleteFirst55Warm);
        HOOK(newGetMethodOffset(ENCRYPT("Project.Plugins_d.dll"), ENCRYPT("NucleusDrive.Logic"), ENCRYPT("LVActorLinker"), ENCRYPT("SetVisible"), 3), SetVisible, _SetVisible);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CPlayerProfile"), ENCRYPT("get_IsHostProfile"), 0), get_IsHostProfile, _IsHostProfile);
        HOOK(newGetMethodOffset("Project_d.dll", "", "CameraSystem", "Update", 0), _CameraSystem_Update, CameraSystem_Update);
        HOOK(newGetMethodOffset("Project_d.dll", "", "CameraSystem", "LateUpdate", 0), LateUpdatecam, _LateUpdatecam);
        HOOK(newGetMethodOffset("Project_d.dll", "", "CameraSystem", "GetZoomRate", 0), _GetZoomRate, GetZoomRate);
        // HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.UI"), ENCRYPT("CUIManager"), ENCRYPT("OpenMessageBox"), 3), CUIManager_OpenMessageBox, old_CUIManager_OpenMessageBox);
        HOOK(newGetMethodOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_HERO_COMMON_INFO"), ENCRYPT("unpack"), 2), unpack, old_unpack);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("HeroSelectNormalWindow"), ENCRYPT("OnClickSelectHeroSkin"), 2), OnClickSelectHeroSkin, old_OnClickSelectHeroSkin);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("IsCanUseSkin"), 2), IsCanUseSkin, old_IsCanUseSkin);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("GetHeroWearSkinId"), 1), GetHeroWearSkinId, old_GetHeroWearSkinId);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfo"), ENCRYPT("IsHaveHeroSkin"), 3), IsHaveHeroSkin, old_IsHaveHeroSkin);
        // HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CSkinInfo"), ENCRYPT("GetSkinCfgId"), 2), GetSkinCfg, old_GetSkinCfg);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.Framework"), ENCRYPT("GameDataMgr"), ENCRYPT("IsSkinAvailable"), 1), IsSkinAvailable, _IsSkinAvailable);
            RefreshHeroPanel = (decltype(RefreshHeroPanel))Aluminium(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("HeroSelectNormalWindow"), ENCRYPT("RefreshHeroPanel"), 3));
        // HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("ComponentItem"), ENCRYPT("get_isWear"), 0), get_isWear, _get_isWear);
        // HOOK(newGetMethodOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_SKIN"), ENCRYPT("unpack"), 2), UnpackPK, _UnpackPK);
        // HOOK(newGetMethodOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("SCPKG_SKINCOMPONENT_WEAR_RSP"), ENCRYPT("unpack"), 2), UnpackPK2, _UnpackPK2);
        // HOOK(newGetMethodOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("CSPKG_SKINCOMPONENT_WEAR_REQ"), ENCRYPT("pack"), 2), pack, _pack);
        // HOOK(newGetMethodOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("CSPKG_SKINCOMPONENT_TAKEOFF_REQ"), ENCRYPT("pack"), 2), pack2, _pack2);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("AwakeSkinHelper"), ENCRYPT("IsAwakeSkin"), 1), IsAwakeSkin, _IsAwakeSkin);
        HOOK(newGetMethodOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_CHOICEHERO"), ENCRYPT("unpack"), 2), UnpackEvo5, _UnpackEvo5);
            GetAwakeSkinData = (decltype(GetAwakeSkinData))Aluminium(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("AwakeSkinHelper"), ENCRYPT("GetAwakeSkinData"), 1));
        HOOK(newGetMethodOffset(ENCRYPT("Project.Plugins_d.dll"), ENCRYPT("NucleusDrive.Logic.GameKernal"), ENCRYPT("GamePlayerCenter"), ENCRYPT("GetPlayer"), 1), GetAllPlayers, _GetAllPlayers);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameLogic"), ENCRYPT("LobbyLogic"), ENCRYPT("UpdateLogic"), 1), UpdateLogic, _UpdateLogic);
        // HOOK(newGetMethodOffset(ENCRYPT("AovUISys.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CLegendUtility"), ENCRYPT("SetLegendTitleCompleteNew"), 14), _SetLegendTitleCompleteNew, SetLegendTitleCompleteNew);
        HOOK(newGetMethodOffset(ENCRYPT("AovUISys.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CLegendHeroTitleData"), ENCRYPT("get_Valid"), 0), _get_Valid, get_Valid);
        HOOK(newGetMethodOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_TOP_OR_AREA_LEGEND_TITLE_INFO"), ENCRYPT("unpack"), 2), _unpackTop, unpackTop);
        HOOK(newGetMethodOffset(ENCRYPT("AovUISys.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CLegendUtility"), ENCRYPT("SetLegendTitleMedalImage"), 3), _SetLegendTitleMedalImageNew, SetLegendTitleMedalImageNew);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("PVPLoadingView"), ENCRYPT("TryShowLegendRank"), 6), _TryShowLegendRank, TryShowLegendRank);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("PVPLoadingView"), ENCRYPT("IsShowLegendRankMode"), 1), _IsShowLegendRankMode, IsShowLegendRankMode);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("PVPLoadingView"), ENCRYPT("CanPlayerShowLegendRank"), 8), _CanPlayerShowLegendRank, CanPlayerShowLegendRank);
        HOOK(newGetMethodOffset(ENCRYPT("AovUISys.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CLegendUtility"), ENCRYPT("GetLegendTitleAreaType"), 1), _GetLegendTitleAreaType, GetLegendTitleAreaType);
        HOOK(newGetMethodOffset(ENCRYPT("AovUISys.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CLegendHeroTitleData"), ENCRYPT("UpdateData"), 5), _UpdateData, UpdateData);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CRoleInfoManager"), ENCRYPT("GetMasterRoleInfo"), 0), GetMasterRoleInfo, _GetMasterRoleInfo);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CLadderSystem"), ENCRYPT("GetCurrentRankDetail"), 0), GetCurrentRankDetail, _GetCurrentRankDetail);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameLogic"), ENCRYPT("SkillSlot"), ENCRYPT("LateUpdate"), 1), Skslot, _Skslot);
        HOOK(newGetMethodOffset(ENCRYPT("Project.Plugins_d.dll"), ENCRYPT("NucleusDrive.Logic"), ENCRYPT("LBattlePooledClassObject"), ENCRYPT("get_battleLogic"), 0), _get_battleLogic, get_battleLogic);
        HOOK(newGetMethodOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("CBattleSystem"), ENCRYPT("Update"), 0), _CBattleSystem_Update, CBattleSystem_Update);
    });
}


void LuuChucNang() {
    // ========== Save BOOL ========== //
    [[SaveSetting shared] saveBool:HackMap forKey:@"HackMap"];
    [[SaveSetting shared] saveBool:ShowHistory forKey:@"ShowHistory"];
    [[SaveSetting shared] saveBool:ShowTimeCD forKey:@"ShowTimeCD"];
    [[SaveSetting shared] saveBool:ShowCD forKey:@"ShowCD"];
    [[SaveSetting shared] saveBool:Camxa forKey:@"Camxa"];
    [[SaveSetting shared] saveBool:LockCam forKey:@"LockCam"];
    [[SaveSetting shared] saveBool:Cam3nac forKey:@"Cam3nac"];
    [[SaveSetting shared] saveBool:Unlockskin forKey:@"Unlockskin"];
    [[SaveSetting shared] saveBool:UnlockEvo5 forKey:@"UnlockEvo5"];
    [[SaveSetting shared] saveBool:LockSkinAo forKey:@"LockSkinAo"];
    [[SaveSetting shared] saveBool:FullSkin forKey:@"FullSkin"];
    [[SaveSetting shared] saveBool:unlock2 forKey:@"unlock2"];
    [[SaveSetting shared] saveBool:ESPEnable forKey:@"ESPEnable"];
    [[SaveSetting shared] saveBool:PlayerLine forKey:@"PlayerLine"];
    [[SaveSetting shared] saveBool:PlayerBox forKey:@"PlayerBox"];
    [[SaveSetting shared] saveBool:PlayerHeal forKey:@"PlayerHeal"];
    [[SaveSetting shared] saveBool:PlayerName forKey:@"PlayerName"];
    [[SaveSetting shared] saveBool:ShowMinimap forKey:@"ShowMinimap"];
    [[SaveSetting shared] saveBool:IgnoreInvisible forKey:@"IgnoreInvisible"];
    [[SaveSetting shared] saveBool:NumberESP forKey:@"NumberESP"];
    [[SaveSetting shared] saveBool:DistanceESP forKey:@"DistanceESP"];
    [[SaveSetting shared] saveBool:HeroIconESP forKey:@"HeroIconESP"];
    [[SaveSetting shared] saveBool:Alert360 forKey:@"Alert360"];
    [[SaveSetting shared] saveFloat:minimapOffsetX forKey:@"minimapOffsetX"];
    [[SaveSetting shared] saveFloat:minimapOffsetY forKey:@"minimapOffsetY"];
    [[SaveSetting shared] saveFloat:minimapRotation forKey:@"minimapRotation"];
    [[SaveSetting shared] saveFloat:iconScale forKey:@"iconScale"];
    [[SaveSetting shared] saveFloat:minimapCustomScale forKey:@"minimapCustomScale"];
    [[SaveSetting shared] saveBool:AimSkill forKey:@"AimSkill"];
    [[SaveSetting shared] saveBool:DrawAimLine forKey:@"DrawAimLine"];
    [[SaveSetting shared] saveBool:AimSkill1 forKey:@"AimSkill1"];
    [[SaveSetting shared] saveBool:AimSkill2 forKey:@"AimSkill2"];
    [[SaveSetting shared] saveBool:AimSkill3 forKey:@"AimSkill3"];
    [[SaveSetting shared] saveBool:isPlayerName forKey:@"isPlayerName"];
    [[SaveSetting shared] saveBool:StreamerMode forKey:@"StreamerMode"];
    [[SaveSetting shared] saveBool:BugSkill forKey:@"BugSkill"];
    [[SaveSetting shared] saveBool:Showline forKey:@"Showline"];
    [[SaveSetting shared] saveBool:AutoPhuTro forKey:@"AutoPhuTro"];
    [[SaveSetting shared] saveBool:AutoBocPha forKey:@"AutoBocPha"];
    [[SaveSetting shared] saveBool:AutoTrungTri forKey:@"AutoTrungTri"];
    [[SaveSetting shared] saveBool:TTALL forKey:@"TTALL"];
    [[SaveSetting shared] saveBool:TTBua forKey:@"TTBua"];
    [[SaveSetting shared] saveBool:TTBosst forKey:@"TTBosst"];
    [[SaveSetting shared] saveBool:UltiCooldown forKey:@"UltiCooldown"];
    [[SaveSetting shared] saveBool:NameCooldown forKey:@"NameCooldown"];
    [[SaveSetting shared] saveBool:VeDich forKey:@"VeDich"];
    [[SaveSetting shared] saveBool:autoflo forKey:@"autoflo"];
    [[SaveSetting shared] saveInt:floMode forKey:@"floMode"];
    [[SaveSetting shared] saveBool:floShowFlower forKey:@"floShowFlower"];
    [[SaveSetting shared] saveBool:floShowLine forKey:@"floShowLine"];
    [[SaveSetting shared] saveBool:autoyue forKey:@"autoyue"];
    [[SaveSetting shared] saveBool:NumberESP forKey:@"NumberESP"];
    [[SaveSetting shared] saveBool:DistanceESP forKey:@"DistanceESP"];
    [[SaveSetting shared] saveBool:HeroIconESP forKey:@"HeroIconESP"];
    [[SaveSetting shared] saveBool:Alert360 forKey:@"Alert360"];
    // ========== End BOOL ========== //

    // ========== Save Int ========== //
    [[SaveSetting shared] saveInt:Yea_miko forKey:@"thongbaodiet"];
    [[SaveSetting shared] saveInt:Changli forKey:@"tbdiet"];
    [[SaveSetting shared] saveInt:Elysia forKey:@"nutbam"];
    [[SaveSetting shared] saveInt:Jinhsi forKey:@"nbam"];
    [[SaveSetting shared] saveInt:Nahida forKey:@"Nahida"];
    [[SaveSetting shared] saveInt:Iuno forKey:@"Iuno"];
    [[SaveSetting shared] saveInt:AimType forKey:@"AimType"];
    [[SaveSetting shared] saveInt:HeroSet forKey:@"HeroSet"];
    [[SaveSetting shared] saveInt:customSkinCount forKey:@"customSkinCount"];
    [[SaveSetting shared] saveInt:customDianquan forKey:@"customDianquan"];
    [[SaveSetting shared] saveInt:customGoldCoin forKey:@"customGoldCoin"];
    [[SaveSetting shared] saveInt:customDiamond forKey:@"customDiamond"];
    // ========== End Int ========== //

    // ========== Save Float ========== //
    [[SaveSetting shared] saveFloat:camera forKey:@"Cameras"];
    drone = defFov;
    [[SaveSetting shared] saveFloat:defFov forKey:@"defFov"];
    [[SaveSetting shared] saveFloat:Maxscale forKey:@"Maxscale"];
    [[SaveSetting shared] saveFloat:KhoangCach forKey:@"KhoangCach"];
    [[SaveSetting shared] saveFloat:DoLechAim forKey:@"DoLechAim"];
    [[SaveSetting shared] saveFloat:MyHP forKey:@"MyHP"];
    [[SaveSetting shared] saveFloat:EnemyHP forKey:@"EnemyHP"];
    // ========== End Float ========== //
}

void LoadChucNang (){
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // ========== Load BOOL ========== //
        HackMap = [[SaveSetting shared] loadBoolForKey:@"HackMap" defaultValue:NO];
        ShowHistory = [[SaveSetting shared] loadBoolForKey:@"ShowHistory" defaultValue:NO];
        ShowTimeCD = [[SaveSetting shared] loadBoolForKey:@"ShowTimeCD" defaultValue:NO];
        ShowCD = [[SaveSetting shared] loadBoolForKey:@"ShowCD" defaultValue:NO];
        Camxa = [[SaveSetting shared] loadBoolForKey:@"Camxa" defaultValue:NO];
        LockCam = [[SaveSetting shared] loadBoolForKey:@"LockCam" defaultValue:NO];
        Cam3nac = [[SaveSetting shared] loadBoolForKey:@"Cam3nac" defaultValue:NO];
        Unlockskin = [[SaveSetting shared] loadBoolForKey:@"Unlockskin" defaultValue:NO];
        UnlockEvo5 = [[SaveSetting shared] loadBoolForKey:@"UnlockEvo5" defaultValue:NO];
        LockSkinAo = [[SaveSetting shared] loadBoolForKey:@"LockSkinAo" defaultValue:NO];
        FullSkin = [[SaveSetting shared] loadBoolForKey:@"FullSkin" defaultValue:NO];
        unlock2 = [[SaveSetting shared] loadBoolForKey:@"unlock2" defaultValue:NO];
        ESPEnable = [[SaveSetting shared] loadBoolForKey:@"ESPEnable" defaultValue:NO];
        PlayerLine = [[SaveSetting shared] loadBoolForKey:@"PlayerLine" defaultValue:NO];
        PlayerBox = [[SaveSetting shared] loadBoolForKey:@"PlayerBox" defaultValue:NO];
        PlayerHeal = [[SaveSetting shared] loadBoolForKey:@"PlayerHeal" defaultValue:NO];
        PlayerName = [[SaveSetting shared] loadBoolForKey:@"PlayerName" defaultValue:NO];
        ShowMinimap = [[SaveSetting shared] loadBoolForKey:@"ShowMinimap" defaultValue:NO];
        IgnoreInvisible = [[SaveSetting shared] loadBoolForKey:@"IgnoreInvisible" defaultValue:NO];
        NumberESP = [[SaveSetting shared] loadBoolForKey:@"NumberESP" defaultValue:NO];
        DistanceESP = [[SaveSetting shared] loadBoolForKey:@"DistanceESP" defaultValue:NO];
        HeroIconESP = [[SaveSetting shared] loadBoolForKey:@"HeroIconESP" defaultValue:NO];
        Alert360 = [[SaveSetting shared] loadBoolForKey:@"Alert360" defaultValue:NO];
        minimapOffsetX = [[SaveSetting shared] loadFloatForKey:@"minimapOffsetX" defaultValue:0.0f];
        minimapOffsetY = [[SaveSetting shared] loadFloatForKey:@"minimapOffsetY" defaultValue:0.0f];
        minimapRotation = [[SaveSetting shared] loadFloatForKey:@"minimapRotation" defaultValue:0.0f];
        iconScale = [[SaveSetting shared] loadFloatForKey:@"iconScale" defaultValue:1.0f];
        minimapCustomScale = [[SaveSetting shared] loadFloatForKey:@"minimapCustomScale" defaultValue:1.0f];
        AimSkill = [[SaveSetting shared] loadBoolForKey:@"AimSkill" defaultValue:NO];
        DrawAimLine = [[SaveSetting shared] loadBoolForKey:@"DrawAimLine" defaultValue:NO];
        AimSkill1 = [[SaveSetting shared] loadBoolForKey:@"AimSkill1" defaultValue:NO];
        AimSkill2 = [[SaveSetting shared] loadBoolForKey:@"AimSkill2" defaultValue:NO];
        AimSkill3 = [[SaveSetting shared] loadBoolForKey:@"AimSkill3" defaultValue:NO];
        VeDich = DrawAimLine;
        isPlayerName = [[SaveSetting shared] loadBoolForKey:@"isPlayerName" defaultValue:NO];
        StreamerMode = [[SaveSetting shared] loadBoolForKey:@"StreamerMode" defaultValue:NO];
        BugSkill = [[SaveSetting shared] loadBoolForKey:@"BugSkill" defaultValue:NO];
        Showline = [[SaveSetting shared] loadBoolForKey:@"Showline" defaultValue:NO];
        AutoPhuTro = [[SaveSetting shared] loadBoolForKey:@"AutoPhuTro" defaultValue:NO];
        AutoBocPha = [[SaveSetting shared] loadBoolForKey:@"AutoBocPha" defaultValue:NO];
        AutoTrungTri = [[SaveSetting shared] loadBoolForKey:@"AutoTrungTri" defaultValue:NO];
        TTALL = [[SaveSetting shared] loadBoolForKey:@"TTALL" defaultValue:NO];
        TTBua = [[SaveSetting shared] loadBoolForKey:@"TTBua" defaultValue:NO];
        TTBosst = [[SaveSetting shared] loadBoolForKey:@"TTBosst" defaultValue:NO];
        NameCooldown = [[SaveSetting shared] loadBoolForKey:@"NameCooldown" defaultValue:NO];
        UltiCooldown = [[SaveSetting shared] loadBoolForKey:@"UltiCooldown" defaultValue:NO];
        autoflo = [[SaveSetting shared] loadBoolForKey:@"autoflo" defaultValue:NO];
        floMode = [[SaveSetting shared] loadIntForKey:@"floMode" defaultValue:1];
        floShowFlower = [[SaveSetting shared] loadBoolForKey:@"floShowFlower" defaultValue:YES];
        floShowLine = [[SaveSetting shared] loadBoolForKey:@"floShowLine" defaultValue:YES];
        autoyue = [[SaveSetting shared] loadBoolForKey:@"autoyue" defaultValue:NO];
        NumberESP = [[SaveSetting shared] loadBoolForKey:@"NumberESP" defaultValue:NO];
        DistanceESP = [[SaveSetting shared] loadBoolForKey:@"DistanceESP" defaultValue:NO];
        HeroIconESP = [[SaveSetting shared] loadBoolForKey:@"HeroIconESP" defaultValue:NO];
        Alert360 = [[SaveSetting shared] loadBoolForKey:@"Alert360" defaultValue:NO];
        thongbaolandau = YES;
        // Đồng bộ với biến chức năng
        UltiCooldown = UltiCooldown || ShowTimeCD;
        NameCooldown = NameCooldown || ShowCD;
        ShowTimeCD = UltiCooldown;
        ShowCD = NameCooldown;
        DrawAimLine = VeDich;
        // ========== End Load BOOL ========== //

        // ========== Load Int ========== //
        Yea_miko = [[SaveSetting shared] loadIntForKey:@"thongbaodiet" defaultValue:0];
        Elysia = [[SaveSetting shared] loadIntForKey:@"nutbam" defaultValue:0];
        Changli = [[SaveSetting shared] loadIntForKey:@"tbdiet" defaultValue:0];
        Jinhsi = [[SaveSetting shared] loadIntForKey:@"nbam" defaultValue:0];
        Nahida = [[SaveSetting shared] loadIntForKey:@"Nahida" defaultValue:0];
        Iuno = [[SaveSetting shared] loadIntForKey:@"Iuno" defaultValue:93000];
        Skinminion = [[SaveSetting shared] loadIntForKey:@"Skinminion" defaultValue:0];
        if (Skinminion < 0 || Skinminion >= IM_ARRAYSIZE(SoldierSkinIDs)) Skinminion = 0;
        SoldierID = [[SaveSetting shared] loadIntForKey:@"SoldierID" defaultValue:SoldierSkinIDs[Skinminion]];
        AimType = [[SaveSetting shared] loadIntForKey:@"AimType" defaultValue:1];
        HeroSet = [[SaveSetting shared] loadIntForKey:@"HeroSet" defaultValue:0];
        customSkinCount = [[SaveSetting shared] loadIntForKey:@"customSkinCount" defaultValue:3000];
        customDianquan = [[SaveSetting shared] loadIntForKey:@"customDianquan" defaultValue:9999];
        customGoldCoin = [[SaveSetting shared] loadIntForKey:@"customGoldCoin" defaultValue:9999999];
        customDiamond = [[SaveSetting shared] loadIntForKey:@"customDiamond" defaultValue:9999999];
        // ========== End Load Int ========== //

        // ========== Load Float ========== //
        camera = [[SaveSetting shared] loadFloatForKey:@"Cameras" defaultValue:0.6f];
        defFov = [[SaveSetting shared] loadFloatForKey:@"defFov" defaultValue:60.0f];
        drone = defFov;
        Maxscale = [[SaveSetting shared] loadFloatForKey:@"Maxscale" defaultValue:42.838f];
        KhoangCach = [[SaveSetting shared] loadFloatForKey:@"KhoangCach" defaultValue:0.0f];
        DoLechAim = [[SaveSetting shared] loadFloatForKey:@"DoLechAim" defaultValue:0.0f];
        MyHP = [[SaveSetting shared] loadFloatForKey:@"MyHP" defaultValue:54.0f];
        EnemyHP = [[SaveSetting shared] loadFloatForKey:@"EnemyHP" defaultValue:13.72f];
        // ========== End Load Float ========== //
        

    });
}


char label[32];



static bool ANICON = false;



ImVec4 maincolor = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
ImVec4 subcolor = ImVec4(0.2f, 0.2f, 0.2f, 1.0f);
ImVec4 xam = ImVec4(0.5f, 0.5f, 0.5f, 1.0f);
ImVec4 red = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
ImVec4 redsub = ImVec4(0.9f, 0.9f, 0.9f, 1.0f);

// Theme12-inspired monochrome palette: black glass, graphite surfaces and white accents.
static const ImVec4 kSubinAccent = ImVec4(0.78f, 0.78f, 0.80f, 1.0f);
static const ImVec4 kSubinAccentHover = ImVec4(0.92f, 0.92f, 0.94f, 1.0f);
static const ImU32 kSubinAccentU32 = IM_COL32(198, 198, 204, 255);
static const ImU32 kSubinAccentBrightU32 = IM_COL32(235, 235, 239, 255);



void RenderTabButton(const char *label, ImVec2 size, int tabId) {
  bool isActive = Settings::Tab == tabId;
  ImVec4 normalTextColor = ImVec4(0.68f, 0.68f, 0.70f, 1.0f);
  ImVec4 activeTextColor = ImVec4(1.00f, 1.00f, 1.00f, 1.0f);
  ImVec4 normalButtonColor = ImVec4(0.10f, 0.10f, 0.11f, 0.88f);
  ImVec4 hoverButtonColor = ImVec4(0.18f, 0.18f, 0.20f, 0.96f);
  ImVec4 activeButtonColor = ImVec4(0.25f, 0.25f, 0.27f, 1.0f);

  ImGui::PushStyleColor(ImGuiCol_Button, isActive ? activeButtonColor : normalButtonColor);
  ImGui::PushStyleColor(ImGuiCol_ButtonHovered, isActive ? activeButtonColor : hoverButtonColor);
  ImGui::PushStyleColor(ImGuiCol_ButtonActive, ImVec4(0.34f, 0.34f, 0.37f, 1.0f));
  ImGui::PushStyleColor(ImGuiCol_Text, isActive ? activeTextColor : normalTextColor);
  ImGui::PushStyleVar(ImGuiStyleVar_FrameRounding, 13.0f);
  ImGui::PushStyleVar(ImGuiStyleVar_FrameBorderSize, isActive ? 1.0f : 0.0f);
  ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(14.0f, 9.0f));
  ImGui::PushStyleColor(ImGuiCol_Border, ImVec4(0.78f, 0.78f, 0.80f, isActive ? 0.70f : 0.0f));

  if (ImGui::Button(label, size)) {
    Settings::Tab = tabId;
    TriggerHapticFeedback();
  }

  ImGui::PopStyleColor(5);
  ImGui::PopStyleVar(3);
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

  _device = MTLCreateSystemDefaultDevice();
  _commandQueue = [_device newCommandQueue];

  if (!self.device) abort();

  IMGUI_CHECKVERSION();
  ImGui::CreateContext();
  ImGuiIO &io = ImGui::GetIO();
  ImFontConfig config;
  static const ImWchar icons_ranges[] = {0xf000, 0xf3ff, 0};
  ImFontConfig icons_config;

  config.FontDataOwnedByAtlas = false;
  icons_config.MergeMode = true;
  icons_config.PixelSnapH = true;

  ImGui::StyleColorsClassic();

  io.Fonts->AddFontFromMemoryCompressedTTF((void *)font_compressed_data, font_compressed_size, 80.0f, NULL, io.Fonts->GetGlyphRangesVietnamese());
  self.italic = io.Fonts->AddFontFromMemoryCompressedTTF((void *)italic_compressed_data, italic_compressed_size, 70.0f, NULL, io.Fonts->GetGlyphRangesVietnamese());
  self.icon131 = io.Fonts->AddFontFromMemoryCompressedTTF((void *)icon_compressed_data, icon_compressed_size, 70.0f, NULL, io.Fonts->GetGlyphRangesVietnamese());

  ImGui_ImplMetal_Init(_device);
  [self initImageTexture:_device];
  [self initSkillTextures:_device];
  [self initItemTextures:_device];
  return self;
}
void ShowOverlayWindow() {
  ImGuiIO &io = ImGui::GetIO();
  ImDrawList *draw_list = ImGui::GetBackgroundDrawList();

  // Kích thước màn hình
  ImVec2 screen_size = io.DisplaySize;

  // Vẽ nền đen bán trong suốt phủ toàn bộ màn hình
  draw_list->AddRectFilled(ImVec2(0, 0), screen_size, IM_COL32(0, 0, 0, 128)  // alpha = 128 (50%)
  );

  // Tính toán vị trí hình chữ nhật chính giữa
  ImVec2 rect_size = ImVec2(385, 185);
  ImVec2 rect_pos = ImVec2((screen_size.x - rect_size.x) / 2.0f, (screen_size.y - rect_size.y) / 2.0f);

  // Vẽ hình chữ nhật trắng (có thể đổi màu)
  draw_list->AddRectFilled(rect_pos, ImVec2(rect_pos.x + rect_size.x, rect_pos.y + rect_size.y), IM_COL32(255, 255, 255, 255),  // màu trắng đục
                           10.0f                                                                                                // bo góc
  );

  // Bạn có thể thêm ImGui::SetCursorScreenPos(rect_pos) + ImGui::BeginChild(...) để đặt nội dung vào hình chữ nhật
}
struct TabAnimation {
  float alpha;
  std::chrono::steady_clock::time_point startTime;
  bool isAnimating;
  bool hasAnimated;
};

std::unordered_map<int, TabAnimation> tabAnimations;

void UpdateTabAnimation(int tabIndex) {
  auto &anim = tabAnimations[tabIndex];
  if (!anim.hasAnimated) {
    anim.alpha = 0.0f;
    anim.startTime = std::chrono::steady_clock::now();
    anim.isAnimating = true;
    anim.hasAnimated = true;
  }

  if (anim.isAnimating) {
    auto now = std::chrono::steady_clock::now();
    float elapsed = std::chrono::duration<float>(now - anim.startTime).count();
    float duration = 0.45f;  // Animation duration in seconds

    anim.alpha = std::min(elapsed / duration, 1.0f);

    if (anim.alpha >= 1.0f) {
      anim.isAnimating = false;
    }
  }
}

void ResetTabAnimations() {
  for (auto &pair : tabAnimations) {
    pair.second.hasAnimated = false;
  }
}

+ (void)showChange:(BOOL)open {
  MenDeal = open;
}

+ (BOOL)isMenuShowing {
  return MenDeal;
}

- (MTKView *)mtkView {
  return (MTKView *)self.view;
}

- (void)loadView {
  CGFloat w = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width;
  CGFloat h = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height;
  self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
  static dispatch_once_t onceToken;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.mtkView.device = self.device;
  if (!self.mtkView.device) {
    return;
  }
  self.mtkView.delegate = self;
  self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
  self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
  self.mtkView.clipsToBounds = YES;
}



#pragma mark - Interaction
struct MenuState {
  bool isVisible = false;
  float alpha = 0.0f;
  std::chrono::steady_clock::time_point transitionStart;
  bool isTransitioning = false;
};

MenuState menuState;

struct SelectionState {
  bool isVisible = false;
  float alpha = 0.0f;
  std::chrono::steady_clock::time_point transitionStart;
  bool isTransitioning = false;
};

std::map<int, SelectionState> selectionStates;
int previousSelection = -1;
int currentSelection = 0;

bool DrawAimbotBox(const char *label, const char *description, ImFont *italicFont, ImFont *iconFont, const char *uniqueID) {
  ImDrawList *draw_list = ImGui::GetWindowDrawList();
  ImVec2 pos = ImGui::GetCursorScreenPos();
  ImVec2 size = ImVec2(213.0f, 50.0f);
  ImVec2 end = ImVec2(pos.x + size.x, pos.y + size.y);

  // InvisibleButton bao phủ toàn bộ box để bắt sự kiện click
  ImGui::SetCursorScreenPos(pos);
  bool clicked = ImGui::InvisibleButton(uniqueID, size);

  // Vẽ nền
  draw_list->AddRectFilled(pos, end, IM_COL32(50, 50, 50, 255), 20.0f);
  draw_list->AddRect(pos, end, IM_COL32(255, 255, 255, 40), 20.0f, 0, 1.0f);

  // Text chính
  ImVec2 text1Pos = ImVec2(pos.x + 19.6f, pos.y + 9.0f);
  ImGui::SetCursorScreenPos(text1Pos);
  ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32_WHITE);
  ImGui::SetWindowFontScale(1.9f);
  ImGui::TextUnformatted(label);
  ImGui::PopStyleColor();

  // Text phụ
  ImVec2 text2Pos = ImVec2(text1Pos.x, text1Pos.y + ImGui::GetFontSize() - 3.0f);
  ImGui::SetCursorScreenPos(text2Pos);
  ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32(170, 170, 170, 255));
  ImGui::SetWindowFontScale(1.2f);
  ImGui::PushFont(italicFont);
  ImGui::TextUnformatted(description);
  ImGui::PopFont();
  ImGui::PopStyleColor();
  ImGui::SetWindowFontScale(3.5f);
  //   // Text "7" hoặc biểu tượng
  float textHeight = ImGui::GetFontSize();
  float centeredY = pos.y + (size.y - textHeight) / 2.0f;
  ImVec2 text7Pos = ImVec2(pos.x + 173.0f, centeredY - 1.5f);
  ImGui::SetCursorScreenPos(text7Pos);
  ImGui::SetWindowFontScale(3.5f);

  ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32_WHITE);
  ImGui::PushFont(iconFont);

  // Dùng InvisibleButton với ID duy nhất
  ImGui::SetCursorScreenPos(text7Pos);
  ImGui::InvisibleButton(uniqueID, ImVec2(30, 30));
  draw_list->AddText(text7Pos, IM_COL32_WHITE, "7");

  ImGui::PopFont();
  ImGui::PopStyleColor();

  return clicked;
}

bool DrawAimbotBoxdaihon(const char *label, const char *description, ImFont *italicFont, ImFont *iconFont, const char *uniqueID) {
  ImDrawList *draw_list = ImGui::GetWindowDrawList();
  ImVec2 pos = ImGui::GetCursorScreenPos();
  ImVec2 size = ImVec2(350.0f, 50.0f);
  ImVec2 end = ImVec2(pos.x + size.x, pos.y + size.y);

  // InvisibleButton bao phủ toàn bộ box để bắt sự kiện click
  ImGui::SetCursorScreenPos(pos);
  bool clicked = ImGui::InvisibleButton(uniqueID, size);

  // Vẽ nền
  draw_list->AddRectFilled(pos, end, IM_COL32(50, 50, 50, 255), 15.0f);
  draw_list->AddRect(pos, end, IM_COL32(255, 255, 255, 40), 15.0f, 0, 1.0f);

  // Text chính
  ImVec2 text1Pos = ImVec2(pos.x + 19.6f, pos.y + 9.0f);
  ImGui::SetCursorScreenPos(text1Pos);
  ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32_WHITE);
  ImGui::SetWindowFontScale(1.9f);
  ImGui::TextUnformatted(label);
  ImGui::PopStyleColor();

  // Text phụ
  ImVec2 text2Pos = ImVec2(text1Pos.x, text1Pos.y + ImGui::GetFontSize() - 3.0f);
  ImGui::SetCursorScreenPos(text2Pos);
  ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32(170, 170, 170, 255));
  ImGui::SetWindowFontScale(1.2f);
  ImGui::PushFont(italicFont);
  ImGui::TextUnformatted(description);
  ImGui::PopFont();
  ImGui::PopStyleColor();
  ImGui::SetWindowFontScale(3.9f);
  //   // Text "7" hoặc biểu tượng
  float textHeight = ImGui::GetFontSize();
  float centeredY = pos.y + (size.y - textHeight) / 2.0f;
  ImVec2 text7Pos = ImVec2(pos.x + 300.0f, centeredY - 1.5f);
  ImGui::SetCursorScreenPos(text7Pos);
  ImGui::SetWindowFontScale(3.5f);

  ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32_WHITE);
  ImGui::PushFont(iconFont);

  // Dùng InvisibleButton với ID duy nhất
  ImGui::SetCursorScreenPos(text7Pos);
  ImGui::InvisibleButton(uniqueID, ImVec2(30, 30));
  draw_list->AddText(text7Pos, IM_COL32_WHITE, "7");

  ImGui::PopFont();
  ImGui::PopStyleColor();

  return clicked;
}

bool Checkbox(bool &funcFlag, const char *funcLabel, const char *funcDescription, ImFont *productSansFont) {
  bool changed = false;
  ImGui::PushID(funcLabel);
  ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(9, 9));
  float cursorX = ImGui::GetCursorPosX();
  float checkboxWidth = ImGui::GetFrameHeight();
  float spacing = 2.0f;

    ImVec2 p = ImGui::GetCursorScreenPos();
    float height = ImGui::GetFrameHeight() * 0.7f;
    float width = height * 1.8f;
    float radius = height * 0.5f;
    ImVec2 center = ImVec2(p.x + radius, p.y + radius);
    checkboxWidth = width;

    if (ImGui::InvisibleButton("##toggle", ImVec2(width, height))) {
        funcFlag = !funcFlag;
        changed = true;
        TriggerHapticFeedback();
        LuuChucNang();
    }

    ImDrawList* draw_list = ImGui::GetWindowDrawList();
    float t = funcFlag ? 1.0f : 0.0f;

    ImU32 track_color = funcFlag ? IM_COL32(220, 220, 220, 255) : IM_COL32(50, 50, 50, 255);
    draw_list->AddRectFilled(p, ImVec2(p.x + width, p.y + height), track_color, height * 0.5f);

    float thumb_pos_x = ImLerp(p.x + radius, p.x + width - radius, t);
    draw_list->AddCircleFilled(ImVec2(thumb_pos_x, center.y), radius * 0.85f, IM_COL32(255, 255, 255, 255));
    draw_list->AddCircle(ImVec2(thumb_pos_x, center.y), radius * 0.85f, IM_COL32(0, 0, 0, 50), 12, 1.0f);

    ImGui::PushStyleColor(ImGuiCol_Text, funcFlag ? ImVec4(1.0f, 1.0f, 1.0f, 1.0f) : ImVec4(0.6f, 0.6f, 0.6f, 1.0f));

  ImGui::SameLine(checkboxWidth + spacing + cursorX);
  ImVec2 cursorPos = ImGui::GetCursorPos();
  ImGui::SetCursorPosY(cursorPos.y - 6.0f);
  ImGui::BeginGroup();

  ImGui::SetWindowFontScale(1.6f);
  ImGui::PushStyleColor(ImGuiCol_Header, ImVec4(0, 0, 0, 0));
  ImGui::PushStyleColor(ImGuiCol_HeaderHovered, ImVec4(0, 0, 0, 0));
  ImGui::PushStyleColor(ImGuiCol_HeaderActive, ImVec4(0, 0, 0, 0));

  if (ImGui::Selectable(funcLabel, false, ImGuiSelectableFlags_None, ImVec2(ImGui::CalcTextSize(funcLabel).x + 8.0f, 0.0f))) {
    funcFlag = !funcFlag;
    TriggerHapticFeedback();
    changed = true;
    LuuChucNang();
  }

  ImGui::SetCursorPosY(ImGui::GetCursorPosY() - 9.0f);
  ImGui::PushFont(productSansFont);
  ImGui::SetWindowFontScale(1.0f);
  ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(160.0f / 255.0f, 160.0f / 255.0f, 160.0f / 255.0f, 1.0f));
  if (ImGui::Selectable(funcDescription, false, ImGuiSelectableFlags_None, ImVec2(ImGui::CalcTextSize(funcDescription).x + 8.0f, 0.0f))) {
    funcFlag = !funcFlag;
    TriggerHapticFeedback();
    changed = true;
    LuuChucNang();
  }

  ImGui::PopFont();
  ImGui::PopStyleVar();
  ImGui::PopStyleColor();
  ImGui::EndGroup();
  ImGui::PopStyleColor(4);
  ImGui::PopID();

  return changed;
}
bool DrawToggleBox(const char *label, const char *description, const char *uniqueID, bool isActive, ImFont *italicFont, ImFont *iconFont) {
  ImDrawList *draw_list = ImGui::GetWindowDrawList();
  ImVec2 pos = ImGui::GetCursorScreenPos();
  ImVec2 size = ImVec2(150.0f, 50.0f);
  ImVec2 end = ImVec2(pos.x + size.x, pos.y + size.y);

  // InvisibleButton bao phủ toàn bộ box để bắt sự kiện click
  ImGui::SetCursorScreenPos(pos);
  bool clicked = ImGui::InvisibleButton(uniqueID, size);

  // Nền tùy theo trạng thái bật/tắt
  ImU32 boxColor = isActive ? IM_COL32(200, 200, 200, 255) : IM_COL32(50, 50, 50, 255);
  draw_list->AddRectFilled(pos, end, boxColor, 15.0f);

  // Text chính
  ImVec2 text1Pos = ImVec2(pos.x + 15.5f, pos.y + 8.0f);
  ImGui::SetCursorScreenPos(text1Pos);
  ImGui::PushStyleColor(ImGuiCol_Text, isActive ? IM_COL32_BLACK : IM_COL32_WHITE);
  ImGui::SetWindowFontScale(1.7f);
  ImGui::TextUnformatted(label);
  ImGui::PopStyleColor();

  // Text phụ
  if (isActive) {
    ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32_BLACK);
  } else {
    ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32(170, 170, 170, 255));
  }
  ImVec2 text2Pos = ImVec2(text1Pos.x, text1Pos.y + ImGui::GetFontSize() - 2.0f);
  ImGui::SetCursorScreenPos(text2Pos);
  ImGui::SetWindowFontScale(1.1f);
  ImGui::PushFont(italicFont);
  ImGui::TextUnformatted(description);
  ImGui::PopFont();
  ImGui::PopStyleColor();

  // Icon hoặc ký tự đặc biệt (nếu cần)
  float textHeight = ImGui::GetFontSize();
  float centeredY = pos.y + (size.y - textHeight) / 2.0f;
  ImVec2 iconPos = ImVec2(pos.x + size.x - 40.0f, centeredY - 18.0f);
  ImGui::SetCursorScreenPos(iconPos);
  ImGui::SetWindowFontScale(3.6f);
  ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32_WHITE);
  ImGui::PushFont(iconFont);
  draw_list->AddText(iconPos, IM_COL32_WHITE, "7");
  ImGui::PopFont();
  ImGui::PopStyleColor();

  return clicked;
}

bool DrawToggleBoxdaihon2(const char *label, const char *description, const char *uniqueID, bool isActive, ImFont *italicFont, ImFont *iconFont) {
  ImDrawList *draw_list = ImGui::GetWindowDrawList();
  ImVec2 pos = ImGui::GetCursorScreenPos();
  ImVec2 size = ImVec2(190.0f, 50.0f);
  ImVec2 end = ImVec2(pos.x + size.x, pos.y + size.y);

  // InvisibleButton bao phủ toàn bộ box để bắt sự kiện click
  ImGui::SetCursorScreenPos(pos);
  bool clicked = ImGui::InvisibleButton(uniqueID, size);

  // Nền tùy theo trạng thái bật/tắt
  ImU32 boxColor = isActive ? IM_COL32(200, 200, 200, 255) : IM_COL32(50, 50, 50, 255);
  draw_list->AddRectFilled(pos, end, boxColor, 15.0f);

  // Text chính
  ImVec2 text1Pos = ImVec2(pos.x + 15.5f, pos.y + 8.0f);
  ImGui::SetCursorScreenPos(text1Pos);
  ImGui::PushStyleColor(ImGuiCol_Text, isActive ? IM_COL32_BLACK : IM_COL32_WHITE);
  ImGui::SetWindowFontScale(1.7f);
  ImGui::TextUnformatted(label);
  ImGui::PopStyleColor();

  // Text phụ
  if (isActive) {
    ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32_BLACK);
  } else {
    ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32(170, 170, 170, 255));
  }
  ImVec2 text2Pos = ImVec2(text1Pos.x, text1Pos.y + ImGui::GetFontSize() - 2.0f);
  ImGui::SetCursorScreenPos(text2Pos);
  ImGui::SetWindowFontScale(1.1f);
  ImGui::PushFont(italicFont);
  ImGui::TextUnformatted(description);
  ImGui::PopFont();
  ImGui::PopStyleColor();

  // Icon hoặc ký tự đặc biệt (nếu cần)
  float textHeight = ImGui::GetFontSize();
  float centeredY = pos.y + (size.y - textHeight) / 2.0f;
  ImVec2 iconPos = ImVec2(pos.x + size.x - 40.0f, centeredY - 18.0f);
  ImGui::SetCursorScreenPos(iconPos);
  ImGui::SetWindowFontScale(3.6f);
  ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32_WHITE);
  ImGui::PushFont(iconFont);
  draw_list->AddText(iconPos, IM_COL32_WHITE, "7");
  ImGui::PopFont();
  ImGui::PopStyleColor();

  return clicked;
}

bool DrawToggleBoxdaihon(const char *label, const char *description, const char *uniqueID, bool isActive, ImFont *italicFont, ImFont *iconFont) {
  ImDrawList *draw_list = ImGui::GetWindowDrawList();
  ImVec2 pos = ImGui::GetCursorScreenPos();
  ImVec2 size = ImVec2(250.0f, 50.0f);
  ImVec2 end = ImVec2(pos.x + size.x, pos.y + size.y);

  // InvisibleButton bao phủ toàn bộ box để bắt sự kiện click
  ImGui::SetCursorScreenPos(pos);
  bool clicked = ImGui::InvisibleButton(uniqueID, size);

  // Nền tùy theo trạng thái bật/tắt
  ImU32 boxColor = isActive ? IM_COL32(200, 200, 200, 255) : IM_COL32(50, 50, 50, 255);
  draw_list->AddRectFilled(pos, end, boxColor, 15.0f);

  // Text chính
  ImVec2 text1Pos = ImVec2(pos.x + 15.5f, pos.y + 8.0f);
  ImGui::SetCursorScreenPos(text1Pos);
  ImGui::PushStyleColor(ImGuiCol_Text, isActive ? IM_COL32_BLACK : IM_COL32_WHITE);
  ImGui::SetWindowFontScale(1.7f);
  ImGui::TextUnformatted(label);
  ImGui::PopStyleColor();

  // Text phụ
  if (isActive) {
    ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32_BLACK);
  } else {
    ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32(170, 170, 170, 255));
  }
  ImVec2 text2Pos = ImVec2(text1Pos.x, text1Pos.y + ImGui::GetFontSize() - 2.0f);
  ImGui::SetCursorScreenPos(text2Pos);
  ImGui::SetWindowFontScale(1.1f);
  ImGui::PushFont(italicFont);
  ImGui::TextUnformatted(description);
  ImGui::PopFont();
  ImGui::PopStyleColor();

  // Icon hoặc ký tự đặc biệt (nếu cần)
  float textHeight = ImGui::GetFontSize();
  float centeredY = pos.y + (size.y - textHeight) / 2.0f;
  ImVec2 iconPos = ImVec2(pos.x + size.x - 40.0f, centeredY - 18.0f);
  ImGui::SetCursorScreenPos(iconPos);
  ImGui::SetWindowFontScale(3.6f);
  ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32_WHITE);
  ImGui::PushFont(iconFont);
  draw_list->AddText(iconPos, IM_COL32_WHITE, "7");
  ImGui::PopFont();
  ImGui::PopStyleColor();

  return clicked;
}
// Checkbox cố định chiều rộng dành cho tab MACRO, không phụ thuộc độ dài tên.
bool MacroCheckboxFixed(bool &funcFlag, const char *id, const char *label,
                        const char *description, ImFont *italicFont) {
  bool changed = false;
  ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(9, 9));
  ImGui::PushID(id);

    ImVec2 p = ImGui::GetCursorScreenPos();
    float height = ImGui::GetFrameHeight() * 0.7f;
    float width = height * 1.8f;
    float radius = height * 0.5f;
    ImVec2 center = ImVec2(p.x + radius, p.y + radius);

    if (ImGui::InvisibleButton("##toggle", ImVec2(width, height))) {
        funcFlag = !funcFlag;
        changed = true;
    }

    ImDrawList* draw_list = ImGui::GetWindowDrawList();
    float t = funcFlag ? 1.0f : 0.0f;

    ImU32 track_color = funcFlag ? IM_COL32(220, 220, 220, 255) : IM_COL32(50, 50, 50, 255);
    draw_list->AddRectFilled(p, ImVec2(p.x + width, p.y + height), track_color, height * 0.5f);

    float thumb_pos_x = ImLerp(p.x + radius, p.x + width - radius, t);
    draw_list->AddCircleFilled(ImVec2(thumb_pos_x, center.y), radius * 0.85f, IM_COL32(255, 255, 255, 255));
    draw_list->AddCircle(ImVec2(thumb_pos_x, center.y), radius * 0.85f, IM_COL32(0, 0, 0, 50), 12, 1.0f);

  ImGui::SameLine();
  ImGui::BeginGroup();
  ImGui::SetWindowFontScale(1.6f);
  ImGui::PushStyleColor(ImGuiCol_Text, funcFlag ? ImVec4(1.0f, 1.0f, 1.0f, 1.0f) : ImVec4(0.6f, 0.6f, 0.6f, 1.0f));
  if (ImGui::Selectable(label, false, ImGuiSelectableFlags_None, ImVec2(145.0f, 20.0f))) {
    funcFlag = !funcFlag;
    changed = true;
  }
  ImGui::PopStyleColor();
  ImGui::PushFont(italicFont);
  ImGui::SetWindowFontScale(1.0f);
  ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(160.0f / 255.0f, 160.0f / 255.0f, 160.0f / 255.0f, 1.0f));
  ImGui::TextUnformatted(description);
  ImGui::PopStyleColor();
  ImGui::PopFont();
  ImGui::EndGroup();
  ImGui::PopID();
  ImGui::PopStyleVar();
  if (changed) {
    LuuChucNang();
    TriggerHapticFeedback();
  }
  return changed;
}

- (void)updateIOWithTouchEvent:(UIEvent *)event {
  UITouch *anyTouch = event.allTouches.anyObject;
  CGPoint touchLocation = [anyTouch locationInView:self.view];
  ImGuiIO &io = ImGui::GetIO();
  io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

  BOOL hasActiveTouch = NO;
  for (UITouch *touch in event.allTouches) {
    if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled) {
      hasActiveTouch = YES;
      break;
    }
  }
  io.MouseDown[0] = hasActiveTouch;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self updateIOWithTouchEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self updateIOWithTouchEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self updateIOWithTouchEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self updateIOWithTouchEvent:event];
}

- (void)drawInMTKView:(MTKView *)view {
  // static bool Anten = loadState(kPlayerNameStateKey);
  static bool showthongbaokin = false;
  static bool showtblogsongsong = false;
  static bool showtblogsongsong3phut = false;
  static bool showtblogsschapto = false;
  static bool thongbaomodskin = false;
  static bool thongbaoautoflo = false;

  static id<MTLTexture> maintabimg = nil;
  if (maintabimg == nil) {
    NSString *base64String26 = defmaintabimg;
    std::string base64_std_string26([base64String26 UTF8String]);
    maintabimg = LoadTextureFromBase64(self.device, base64_std_string26);
  }
  static id<MTLTexture> background = nil;
  if (background == nil) {
    NSString *base64String26 = defbackground;
    std::string base64_std_string26([base64String26 UTF8String]);
    background = LoadTextureFromBase64(self.device, base64_std_string26);
  }
  static id<MTLTexture> aimtab = nil;
  if (aimtab == nil) {
    NSString *base64String26 = defaimtab;
    std::string base64_std_string26([base64String26 UTF8String]);
    aimtab = LoadTextureFromBase64(self.device, base64_std_string26);
  }
  static id<MTLTexture> autotab = nil;
  if (autotab == nil) {
    NSString *base64String26 = defautotab;
    std::string base64_std_string26([base64String26 UTF8String]);
    autotab = LoadTextureFromBase64(self.device, base64_std_string26);
  }
  static id<MTLTexture> esptab = nil;
  if (esptab == nil) {
    NSString *base64String26 = defesptab;
    std::string base64_std_string26([base64String26 UTF8String]);
    esptab = LoadTextureFromBase64(self.device, base64_std_string26);
  }
  static id<MTLTexture> modtab = nil;
  if (modtab == nil) {
    NSString *base64String26 = defmodtab;
    std::string base64_std_string26([base64String26 UTF8String]);
    modtab = LoadTextureFromBase64(self.device, base64_std_string26);
  }
  static id<MTLTexture> infotab = nil;
  if (infotab == nil) {
    NSString *base64String26 = definfotab;
    std::string base64_std_string26([base64String26 UTF8String]);
    infotab = LoadTextureFromBase64(self.device, base64_std_string26);
  }
  static id<MTLTexture> infotab2 = nil;
  if (infotab2 == nil) {
    NSString *base64String26 = definfotab2;
    std::string base64_std_string26([base64String26 UTF8String]);
    infotab2 = LoadTextureFromBase64(self.device, base64_std_string26);
  }
  static id<MTLTexture> thongbao = nil;
  if (thongbao == nil) {
    NSString *base64String26 = defthongbao;
    std::string base64_std_string26([base64String26 UTF8String]);
    thongbao = LoadTextureFromBase64(self.device, base64_std_string26);
  }
  hideRecordTextfield.secureTextEntry = StreamerMode;

  ImGuiIO &io = ImGui::GetIO();
  io.DisplaySize.x = view.bounds.size.width;
  io.DisplaySize.y = view.bounds.size.height;

  CGFloat framebufferScale = view.window.screen.nativeScale ?: UIScreen.mainScreen.nativeScale;
  io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
  io.DeltaTime = 1 / float(view.preferredFramesPerSecond ?: 60);


  id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];

  if (MenDeal != menuState.isVisible && !menuState.isTransitioning) {
    menuState.isVisible = MenDeal;
    menuState.transitionStart = std::chrono::steady_clock::now();
    menuState.isTransitioning = true;
  }

  if (MenDeal == true) {
    [self.view setUserInteractionEnabled:YES];
    [self.view.superview setUserInteractionEnabled:YES];
    [menuTouchView setUserInteractionEnabled:YES];

  } else if (MenDeal == false) {
    [self.view setUserInteractionEnabled:NO];
    [self.view.superview setUserInteractionEnabled:NO];
    [menuTouchView setUserInteractionEnabled:NO];
  }

  MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
  if (renderPassDescriptor != nil) {
    id<MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
    [renderEncoder pushDebugGroup:@"ImGui Jane"];

    ImGui_ImplMetal_NewFrame(renderPassDescriptor);
    ImGui::NewFrame();

    ImFont *font = ImGui::GetFont();
    font->Scale = 11.5f / font->FontSize;

    ImFont *italicFont = self.italic;
    italicFont->Scale = 11.0f / italicFont->FontSize;

    ImFont *iconFont = self.icon131;
    iconFont->Scale = 13.0f / iconFont->FontSize;

    // Match Blackvip's responsive presentation while keeping the original
    // 131 SUBIN content grid balanced vertically.
    const CGFloat screenWidth = [UIApplication sharedApplication]
                                    .windows[0]
                                    .rootViewController.view.frame.size.width;
    const CGFloat screenHeight = [UIApplication sharedApplication]
                                     .windows[0]
                                     .rootViewController.view.frame.size.height;
    const CGFloat width = ((screenWidth - 20.0f) < 700.0f)
                              ? (screenWidth - 20.0f)
                              : 700.0f;
    const CGFloat height = ((screenHeight - 20.0f) < 360.0f)
                               ? (screenHeight - 20.0f)
                               : 360.0f;
    CGFloat x = (screenWidth - width) * 0.5f;
    CGFloat y = (screenHeight - height) * 0.5f;
    if (x < 10.0f) x = 10.0f;
    if (y < 10.0f) y = 10.0f;
    ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_FirstUseEver);
    ImGui::SetNextWindowSize(ImVec2(width, height), ImGuiCond_FirstUseEver);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{


      AutoUpdateHook();
      LoadChucNang();
      chapto_HookAntibanLogic(); // Gọi hàm anti-ban từ chapto.mm
      chapto_ApplyPhangThangLogic(); // Gọi hàm phang thang từ chapto.mm
      LoadJS();


      [[maintool sharemain] requestNotificationPermission];
    });
    
    ApplyCameraPatch();
    if (MenDeal == true) {
      // Blackvip-style full-screen graphite backdrop. It is submitted before
      // the menu window, so the diagonal texture stays behind all controls.
      ImGuiViewport *menuViewport = ImGui::GetMainViewport();
      const ImVec2 backdropMin = menuViewport->Pos;
      const ImVec2 backdropMax = menuViewport->Pos + menuViewport->Size;
      ImDrawList *backdropDraw = ImGui::GetBackgroundDrawList();
      backdropDraw->AddRectFilled(backdropMin, backdropMax,
                                  IM_COL32(0, 0, 0, 105));

      const float stripeGap = 10.0f;
      const float stripeLength = menuViewport->Size.x + menuViewport->Size.y;
      for (float stripeX = backdropMin.x - menuViewport->Size.y;
           stripeX < backdropMax.x; stripeX += stripeGap) {
        backdropDraw->AddLine(
            ImVec2(stripeX, backdropMin.y),
            ImVec2(stripeX + stripeLength, backdropMin.y + stripeLength),
            IM_COL32(0, 0, 0, 72), 3.0f);
      }

      ImGui::Begin(ENCRYPT("EAGLE CHEAT AOV"), &MenDeal, ImGuiWindowFlags_NoScrollbar | ImGuiWindowFlags_NoScrollWithMouse | ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize);
      ImDrawList *draw = ImGui::GetWindowDrawList();

      ImVec2 windowPos = ImGui::GetWindowPos();
      ImVec2 windowSize = ImGui::GetWindowSize();

      if (thongbaolandau) {
        draw->AddRectFilled(windowPos, ImVec2(windowPos.x + windowSize.x, windowPos.y + windowSize.y), IM_COL32(0, 0, 0, 100), 35.0f);
        ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_FirstUseEver);
        ImGui::SetNextWindowSize(ImVec2(width, height), ImGuiCond_FirstUseEver);
        ImGui::SetNextWindowBgAlpha(0.0f);  // Hoàn toàn trong suốt

        ImGui::Begin("##block_input", nullptr, ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove);
        ImGui::End();
        ImDrawList *fg = ImGui::GetForegroundDrawList();
        ImVec2 screen_min = ImGui::GetMainViewport()->Pos;
        ImVec2 screen_max = screen_min + ImGui::GetMainViewport()->Size;
        // Nền đen phủ toàn màn hình
        fg->AddRectFilled(screen_min, screen_max, IM_COL32(0, 0, 0, 190));
        // Vị trí hình chữ nhật chính giữa màn hình
        ImVec2 rect_size = ImVec2(480, 230);
        ImVec2 center = ImGui::GetMainViewport()->GetCenter();
        ImVec2 half_size(rect_size.x * 0.5f,rect_size.y * 0.5f);

        ImVec2 rect_min(center.x - half_size.x,center.y - half_size.y);
        ImVec2 rect_max = rect_min + rect_size;

        // Vẽ nền hình chữ nhật màu đen có bo góc
        fg->AddRectFilled(rect_min, rect_max, IM_COL32(0, 0, 0, 255), 25.0f);

        if (thongbao) {
          fg->AddImage((__bridge void *)thongbao, rect_min, rect_max);
        }
        fg->AddRect(rect_min, rect_max, kSubinAccentBrightU32, 25.0f, 0, 2.0f);
        // Text: "thông báo"
        ImGui::SetWindowFontScale(3.9f);
        ImVec2 text1_pos(rect_min.x + 21.0f,rect_min.y + 15.0f);
        fg->AddText(text1_pos, kSubinAccentBrightU32, "CHÀO MỪNG");
        // Text: "abcabccbajkfbjafbsafbqjfqwroqjiwrjiqw"
        ImGui::SetWindowFontScale(1.2f);
        ImVec2 text2_pos(rect_min.x + 25.0f,rect_min.y + 60.0f);
        
        fg->AddText(text2_pos, IM_COL32_WHITE, "Chào Mừng Bạn Đến Với SUBIN IOS\nHãy Chơi Game 1 Cách Lành Mạnh Để An Toàn\nBạn Có Thể Cấu Hình Cách Chơi Ở Mục More\nCác Chức Năng Bạn Bật Sẽ Tự Động Bật Vào Lần Sau\n\nChúc Bạn Chơi Game Vui Vẻ");
        // Nút cancel
        ImVec2 btn1_pos(rect_min.x + 14.0f, rect_min.y + 175.0f);
        ImVec2 btn_size = ImVec2(125, 37);
        ImVec2 btn2_pos(btn1_pos.x + 133.0f, btn1_pos.y);
        ImU32 btn_color = IM_COL32(58, 58, 62, 255);
        ImVec2 btn1_end(btn1_pos.x + btn_size.x, btn1_pos.y + btn_size.y);
        fg->AddRectFilled(btn1_pos, btn1_end, btn_color, 15.0f);
        const char *text1 = "Đóng";
        ImVec2 text1_size = ImGui::CalcTextSize(text1);
        ImVec2 center_offset((btn_size.x - text1_size.x) * 0.5f,(btn_size.y - text1_size.y) * 0.5f);
        ImVec2 text1_poss(btn1_pos.x + center_offset.x,btn1_pos.y + center_offset.y);
        fg->AddText(text1_poss, IM_COL32_WHITE, text1);
        ImVec2 btn2_end(btn2_pos.x + btn_size.x, btn2_pos.y + btn_size.y);
        fg->AddRectFilled(btn2_pos, btn2_end, btn_color, 15.0f);
        const char *text2 = "Đóng Vĩnh Viễn";
        ImVec2 text2_size = ImGui::CalcTextSize(text2);
        ImVec2 offset((btn_size.x - text2_size.x) * 0.5f,(btn_size.y - text2_size.y) * 0.5f);
        ImVec2 text2_poss(btn2_pos.x + offset.x,btn2_pos.y + offset.y);
        fg->AddText(text2_poss, IM_COL32_WHITE, text2);
        // Xử lý click thủ công
        ImVec2 mouse = ImGui::GetIO().MousePos;
        bool click = ImGui::IsMouseClicked(0);

        if (click && ImGui::IsMouseHoveringRect(btn1_pos, btn1_end)) {
          TriggerHapticFeedback();
          thongbaolandau = false;
        }
      
        if (click && ImGui::IsMouseHoveringRect(btn2_pos, btn2_end)) {
          TriggerHapticFeedback();
          thongbaolandau = false;
        }
      }

      if (background) {
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x - 1.0f, windowPos.y - 1.0f));

        ImGui::Image((__bridge void *)background, windowSize);
      }

      ImVec2 windowMax = ImVec2(windowPos.x + windowSize.x, windowPos.y + windowSize.y);
      draw->AddRectFilled(windowPos + ImVec2(8.0f, 10.0f), windowMax + ImVec2(8.0f, 10.0f), IM_COL32(0, 0, 0, 92), 26.0f);
      draw->AddRectFilled(windowPos, windowMax, IM_COL32(8, 10, 15, 232), 22.0f);
      draw->AddRectFilled(windowPos, ImVec2(windowMax.x, windowPos.y + 42.0f), IM_COL32(76, 76, 82, 54), 22.0f, ImDrawFlags_RoundCornersTop);
      draw->AddRectFilledMultiColor(ImVec2(windowPos.x + 2.0f, windowPos.y + 24.0f), ImVec2(windowMax.x - 2.0f, windowPos.y + 82.0f), IM_COL32(76, 76, 82, 34), IM_COL32(46, 46, 50, 30), IM_COL32(46, 46, 50, 0), IM_COL32(76, 76, 82, 0));
      draw->AddRect(windowPos + ImVec2(1.0f, 1.0f), windowMax - ImVec2(1.0f, 1.0f), IM_COL32(178, 178, 184, 105), 22.0f, 0, 1.2f);
      // Tab 1 keeps its original artwork-only header. Other tabs use a short
      // separator that stops before the version badge and close button.
      if (Settings::Tab != 1) {
        draw->AddLine(ImVec2(windowPos.x + 92.0f, windowPos.y + 62.0f),
                      ImVec2(windowPos.x + 455.0f, windowPos.y + 62.0f),
                      IM_COL32(155, 155, 160, 112), 1.2f);
      }
      if (Settings::Tab == 1) {
        if (maintabimg) {
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 74.0f,
                                           windowPos.y - 1.0f));
          ImGui::Image((__bridge void *)maintabimg, ImVec2(400, 180));
        }
      }
      if (Settings::Tab == 2) {
        if (aimtab) {
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 402.3f, windowPos.y + 40.5f));
          // ImGui::Image((__bridge void *)aimtab, ImVec2(318.5f, 292.1));
        }
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 95.0f, windowPos.y + 29.0f));

        // Đặt màu chữ: #B56572 (RGB: 181, 101, 114)
        ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0f, 1.0f, 1.0f, 1.0f));

        // In dòng chữ
        ImGui::SetWindowFontScale(1.9f);
        ImGui::Text("AIMBOT");
        ImGui::SameLine();
        ImGui::PopStyleColor();
        ImGui::Text("TỰ ĐỘNG ĐỊNH HƯỚNG");
      }

      if (Settings::Tab == 3) {
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 95.0f, windowPos.y + 29.0f));
        ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0f, 1.0f, 1.0f, 1.0f));
        ImGui::SetWindowFontScale(1.9f);
        ImGui::Text("AUTOPLAY");
        ImGui::SameLine();
        ImGui::PopStyleColor();
        if (botrotab) {
          ImGui::Text("BỔ TRỢ / PHỤ TRỢ");
        }
        if (macrotab) {
          ImGui::Text("MACRO AUTO");
        }
        if (bandotab) {
          ImGui::Text("AUTO BÁN ĐỒ");
        }
      }

      if (Settings::Tab == 4) {
        if (esptab) {
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 299.0f, windowPos.y + 10.0f));
          // ImGui::Image((__bridge void *)esptab, ImVec2(390.3f, 322.7f));
        }
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 95.0f, windowPos.y + 29.0f));
        ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0f, 1.0f, 1.0f, 1.0f));
        ImGui::SetWindowFontScale(1.9f);
        ImGui::Text("ESP");
        ImGui::SameLine();
        ImGui::PopStyleColor();
        ImGui::Text("ẨN LIVESTREAM / VIDEO");
      }

      if (Settings::Tab == 5) {
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 95.0f, windowPos.y + 29.0f));
        ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0f, 1.0f, 1.0f, 1.0f));
        ImGui::SetWindowFontScale(1.9f);
        ImGui::Text("MOD");
        ImGui::SameLine();
        ImGui::PopStyleColor();
        ImGui::Text("TOOL MOD GAME");
        if (modtab) {
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 338.2f, windowPos.y + 2.5f));
          // ImGui::Image((__bridge void *)modtab, ImVec2(371.3f, 329.0f));
        }
        {
          ImVec2 btnClosePos = ImVec2(windowPos.x + 500, windowPos.y + 256);
          ImVec2 btnSize = ImVec2(155, 48);

          ImGui::SetCursorScreenPos(btnClosePos);
          if (ImGui::InvisibleButton("openmain", btnSize)) {
            Settings::Tab = 1;
          }

          ImVec2 closeEnd(btnClosePos.x + btnSize.x, btnClosePos.y + btnSize.y);
          draw->AddRect(btnClosePos, closeEnd, IM_COL32(255, 255, 255, 0), 10.0f);
          draw->AddText(btnClosePos + ImVec2(50, 15), IM_COL32(255, 255, 255, 0), "openmain");
        }
      }
      if (Settings::Tab == 6) {
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 95.0f, windowPos.y + 29.0f));
        ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0f, 1.0f, 1.0f, 1.0f));
        ImGui::SetWindowFontScale(1.9f);
        ImGui::Text("INFORMATION");
        ImGui::SameLine();
        ImGui::PopStyleColor();
        ImGui::Text("PLAYER");
        if (infotab) {
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 358.4f, windowPos.y + 2.0f));
          // ImGui::Image((__bridge void *)infotab, ImVec2(369.1f, 329.1f));
        }
        if (infotab2) {
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 93.0f, windowPos.y + 55.0f));
          // ImGui::Image((__bridge void *)infotab2, ImVec2(360.1f, 58.6f));
        }
        ImGui::SetWindowFontScale(1.5f);
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 92.0f, windowPos.y + 130.0f));
        if (Checkbox(ANICON, "ẨN ICON", "CHẠM 3 NGÓN 3 LẦN ĐỂ MỞ LẠI MENU NẾU BỊ ẨN", self.italic)) {
          MenuLoad *menuLoadInstance = [MenuLoad createInstance];
          [menuLoadInstance hidemenuBtn];
          TriggerHapticFeedback();
        }

        ImGui::SetWindowFontScale(1.5f);
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 92.0f, windowPos.y + 172.0f));
        if (Checkbox(isPlayerName, "FAKE NAME", "ĐỔI TÊN NGƯỜI CHƠI", self.italic)) {
          [[SaveSetting shared] saveBool:isPlayerName forKey:@"isPlayerName"];
          TriggerHapticFeedback();
        }

        ImGui::SetWindowFontScale(1.5f);
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 92.0f, windowPos.y + 214.0f));
        if (Checkbox(FakeiOS, "FAKE IOS", "GIA LAP PHIEN BAN IOS", self.italic)) {
          [[NSUserDefaults standardUserDefaults] setBool:FakeiOS forKey:kFakeiOSStatusKey];
          [[NSUserDefaults standardUserDefaults] synchronize];
          TriggerHapticFeedback();
        }

        ImGui::SetWindowFontScale(1.4f);
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 92.0f, windowPos.y + 256.0f));
        if (ImGui::Button("CHINH SUA TEN", ImVec2(180.0f, 40.0f))) {
          SetHideName();
          TriggerHapticFeedback();
        }

        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 282.0f, windowPos.y + 256.0f));
        if (ImGui::Button("DAT LAI TEN", ImVec2(180.0f, 40.0f))) {
          ResetCustomName();
          TriggerHapticFeedback();
        }

        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 92.0f, windowPos.y + 306.0f));
        if (ImGui::Button("SETTINGS FAKE IOS", ImVec2(370.0f, 36.0f))) {
          [ImGuiDrawView fakeiosinputdialog];
          TriggerHapticFeedback();
        }
        {
          ImVec2 btnClosePos = ImVec2(windowPos.x + 500, windowPos.y + 256);
          ImVec2 btnSize = ImVec2(155, 48);

          ImGui::SetCursorScreenPos(btnClosePos);
          if (ImGui::InvisibleButton("openmain", btnSize)) {
            Settings::Tab = 1;
          }
          ImVec2 closeEnd(btnClosePos.x + btnSize.x, btnClosePos.y + btnSize.y);
          
          draw->AddRect(btnClosePos, closeEnd, IM_COL32(255, 255, 255, 0), 10.0f);
          draw->AddText(btnClosePos + ImVec2(50, 15), IM_COL32(255, 255, 255, 0), "openmain");
        }
      }
      if (Settings::Tab == 7) {
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 95.0f, windowPos.y + 29.0f));
        ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0f, 1.0f, 1.0f, 1.0f));
        ImGui::SetWindowFontScale(1.9f);
        ImGui::Text("CHỨC NĂNG KHÁC");
        ImGui::SameLine();
        ImGui::PopStyleColor();
        ImGui::Text("MOREEE");
                // EXTRA/MORE uses the shared glass background only; keep the info artwork hidden here.
        ImGui::SetWindowFontScale(1.2f);
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 95.5f, windowPos.y + 88.0f));
        if (Checkbox(Unlockskin, "Unlockskin", "Mở Khóa Skin Tướng", self.italic)) {
          [[SaveSetting shared] saveBool:Unlockskin forKey:@"Unlockskin"];
          TriggerHapticFeedback();
        }

        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 320.0f, windowPos.y + 88.0f));
        if (Checkbox(UnlockEvo5, "Unlock Evo 5", "Mở Khóa Evo 5", self.italic)) {
          Unlockskin = true;
          [[SaveSetting shared] saveBool:Unlockskin forKey:@"Unlockskin"];
          [[SaveSetting shared] saveBool:UnlockEvo5 forKey:@"UnlockEvo5"];
          TriggerHapticFeedback();
        }

        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 95.5f, windowPos.y + 138.0f));
        if (Checkbox(LockSkinAo, "Lock Skin Ảo", "Khóa Skin Ảo", self.italic)) {
          [[SaveSetting shared] saveBool:LockSkinAo forKey:@"LockSkinAo"];
          TriggerHapticFeedback();
        }

        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 320.0f, windowPos.y + 138.0f));
        if (Checkbox(FullSkin, "Full Skin", "Unlock Full Skin", self.italic)) {
          Unlockskin = true;
          [[SaveSetting shared] saveBool:Unlockskin forKey:@"Unlockskin"];
          [[SaveSetting shared] saveBool:FullSkin forKey:@"FullSkin"];
          TriggerHapticFeedback();
        }
        
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 95.5f, windowPos.y + 200.0f));
        if (DrawAimbotBoxdaihon("MOD KHOE VIP", "MOD GAME / Khoe VIP Profile", self.italic, self.icon131, "modkhoevip131")) {
          Settings::Tab = 8;
          TriggerHapticFeedback();
        }
        {
          ImVec2 btnClosePos = ImVec2(windowPos.x + 500, windowPos.y + 256);
          ImVec2 btnSize = ImVec2(155, 48);

          ImGui::SetCursorScreenPos(btnClosePos);
          if (ImGui::InvisibleButton("openmain", btnSize)) {
            Settings::Tab = 1;
          }

          ImVec2 closeEnd(btnClosePos.x + btnSize.x, btnClosePos.y + btnSize.y);
          draw->AddRect(btnClosePos, closeEnd, IM_COL32(255, 255, 255, 0), 10.0f);
          draw->AddText(btnClosePos + ImVec2(50, 15), IM_COL32(255, 255, 255, 0), "openmain");
        }
      }
      if (Settings::Tab == 8) {
        ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 95.0f, windowPos.y + 29.0f));
        ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.0f, 1.0f, 1.0f, 1.0f));
        ImGui::SetWindowFontScale(1.9f);
        ImGui::Text("MOD KHOE VIP");
        ImGui::SameLine();
        ImGui::PopStyleColor();
        ImGui::Text("PROFILE");
      }      {
        ImGui::SetWindowFontScale(1.6f);
        ImVec2 versionBoxPos = ImVec2(windowPos.x + 471.0f, windowPos.y + 20.0f);
        ImVec2 versionBoxSize = ImVec2(169.0f, 37.5f);
        draw->AddRectFilled(versionBoxPos, ImVec2(versionBoxPos.x + versionBoxSize.x, versionBoxPos.y + versionBoxSize.y), IM_COL32(13, 16, 23, 235), 9.0f);
        draw->AddRect(versionBoxPos, ImVec2(versionBoxPos.x + versionBoxSize.x, versionBoxPos.y + versionBoxSize.y), IM_COL32(145, 145, 150, 105), 9.0f, 0, 1.0f);

        const char *versionText = "THAITUDC | AOV";
        ImVec2 textSize = ImGui::CalcTextSize(versionText);
        ImVec2 textPos = ImVec2(versionBoxPos.x + (versionBoxSize.x - textSize.x) / 2.0f, versionBoxPos.y + (versionBoxSize.y - textSize.y) / 2.0f);

        draw->AddText(textPos, IM_COL32(255, 255, 255, 255), versionText);
        ImVec2 squarePos = ImVec2(versionBoxPos.x + versionBoxSize.x + 7.0f, versionBoxPos.y);
        ImVec2 squareSize = ImVec2(37.5f, 37.5f);
        ImGui::SetCursorScreenPos(squarePos);
        if (ImGui::InvisibleButton("CloseBtn", squareSize)) {
          MenDeal = false;
        }
        draw->AddRectFilled(squarePos, ImVec2(squarePos.x + squareSize.x, squarePos.y + squareSize.y), IM_COL32(13, 16, 23, 235), 9.0f);
        draw->AddRect(squarePos, ImVec2(squarePos.x + squareSize.x, squarePos.y + squareSize.y), IM_COL32(145, 145, 150, 105), 9.0f, 0, 1.0f);
        ImGui::PushFont(self.icon131);
        ImGui::SetWindowFontScale(1.6f);
        const char *symbolText = "`";
        ImVec2 symbolSize = ImGui::CalcTextSize(symbolText);
        ImVec2 symbolPos = ImVec2(squarePos.x + (squareSize.x - symbolSize.x) / 2.0f, squarePos.y + (squareSize.y - symbolSize.y) / 2.0f);
        draw->AddText(symbolPos, IM_COL32(255, 255, 255, 255), symbolText);
        ImGui::PopFont();
      }
      ImGui::SetWindowFontScale(2.75f);

      // CỘT BÊN TRÁI
      {
        ImGui::PushFont(self.icon131);
        ImVec2 rectPos = ImVec2(windowPos.x + 15, windowPos.y + 15);
        ImVec2 rectSize = ImVec2(rectPos.x + 62, rectPos.y + 330);

        ImDrawList *draw_list = ImGui::GetWindowDrawList();
        draw_list->AddRectFilled(rectPos, rectSize, IM_COL32(12, 15, 22, 238), 20.0f);
        draw_list->AddRect(rectPos, rectSize, IM_COL32(145, 145, 150, 95), 20.0f, 0, 1.0f);

        float buttonWidth = 40.0f;
        float buttonHeight = 30.0f;
        float centerX = rectPos.x + (62.0f - buttonWidth) / 2.0f; // Căn giữa nút trong thanh bên trái

        // Duyệt 6 nút
        for (int i = 0; i < 6; ++i) {
          int tabValue = i + 1;
          ImVec2 pos = ImVec2(centerX, rectPos.y + 25.0f + i * (buttonHeight + 15.0f));
          ImGui::SetCursorScreenPos(pos);

          char btnId[8];
          sprintf(btnId, "btn%d", tabValue);
          if (ImGui::InvisibleButton(btnId, ImVec2(buttonWidth, buttonHeight))) {
            Settings::Tab = tabValue;
            TriggerHapticFeedback();
          }

          // Kiểm tra nếu nút này được chọn
          bool isActive = (Settings::Tab == tabValue);

          // Chỉnh font scale và màu tương ứng
          ImGui::SetWindowFontScale(2.75f);
          ImU32 textColor = isActive ? IM_COL32(20, 20, 22, 255) : IM_COL32(150, 150, 154, 255);

          if (isActive) {
            ImVec2 activeRectMin = ImVec2(pos.x - 4, pos.y - 4);
            ImVec2 activeRectMax = ImVec2(pos.x + buttonWidth + 4, pos.y + buttonHeight + 4);
            draw_list->AddRectFilled(activeRectMin, activeRectMax, IM_COL32(218, 218, 222, 255), 10.0f);
            draw_list->AddRect(activeRectMin, activeRectMax, IM_COL32(255, 255, 255, 210), 10.0f, 0, 1.0f);
          }

          // Vẽ chữ số tương ứng
          char label[2];
          sprintf(label, "%d", tabValue);
          ImVec2 textSize = ImGui::CalcTextSize(label);
          ImVec2 textPos = ImVec2(
              pos.x + (buttonWidth - textSize.x) * 0.5f,
              pos.y + (buttonHeight - textSize.y) * 0.5f
          );
          draw_list->AddText(textPos, textColor, label);
        }
        ImGui::PopFont();
      }
      // CỘT BÊN PHẢI
      ImGui::NextColumn();
      ImGui::PushStyleColor(ImGuiCol_WindowBg, ImVec4(0 / 255.0f, 0 / 255.0f, 0 / 255.0f, 1.0f));
      ImFont *font = ImGui::GetIO().Fonts->Fonts[0];  // Get the first font from the font atlas
      ImGui::PushFont(font);                          // Push the font
      ImGui::SetWindowFontScale(1.2f);                // Set the font scale (18.0f / default font size)
      // Right side content based on selected tab

      static int lastTab = -1;
      if (Settings::Tab != lastTab) {
        ResetTabAnimations();
        lastTab = Settings::Tab;
      }

      if (Settings::Tab >= 1 && Settings::Tab <= 10) {
        UpdateTabAnimation(Settings::Tab);
        float alpha = tabAnimations[Settings::Tab].alpha;
        ImGui::PushStyleVar(ImGuiStyleVar_Alpha, alpha);

        if (Settings::Tab == 1) {
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 471.0f, windowPos.y + 65.0f));
          if (DrawAimbotBox("AIMBOT", "Aimbot Tướng Elsu, Gildur,...", self.italic, self.icon131, "aimbot")) {
            Settings::Tab = 2;
            TriggerHapticFeedback();
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 471.0f, windowPos.y + 121.0f));
          if (DrawAimbotBox("AUTOMATIC", "Macro Tự Động Dùng Chiêu", self.italic, self.icon131, "auto")) {
            Settings::Tab = 3;
            macrotab = true;
            TriggerHapticFeedback();
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 471.0f, windowPos.y + 177.0f));
          if (DrawAimbotBox("ESP", "ESP Giúp Ẩn Hack Khi Quay", self.italic, self.icon131, "esp")) {
            Settings::Tab = 4;
            TriggerHapticFeedback();
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 471.0f, windowPos.y + 233.0f));
          if (DrawAimbotBox("MOD", "Mod Skin | Nút | TB Hạ | Rank", self.italic, self.icon131, "mod")) {
            Settings::Tab = 5;
            TriggerHapticFeedback();
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 471.0f, windowPos.y + 289.0f));
          if (DrawAimbotBox("EXTRA", "Cấu Hình Chế Độ Chơi Tại Đây", self.italic, self.icon131, "extra")) {
            Settings::Tab = 7;
            TriggerHapticFeedback();
          }
          ImGui::SetWindowFontScale(1.5f);
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 97.0f, windowPos.y + 181.0f));
          if (Checkbox(HackMap, "Map Hack", "Hiển Thị Tầm Nhìn", self.italic)) {
            [[SaveSetting shared] saveBool:HackMap forKey:@"HackMap"];
            TriggerHapticFeedback();
          }

          ImGui::SetWindowFontScale(1.5f);
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 275.0f, windowPos.y + 181.0f));
          if (Checkbox(UltiCooldown, "Ulti Cooldown", "Hiển Thị Thời Gian Hồi Ulti", self.italic)) {
            ShowTimeCD = UltiCooldown;
            [[SaveSetting shared] saveBool:UltiCooldown forKey:@"UltiCooldown"];
            [[SaveSetting shared] saveBool:ShowTimeCD forKey:@"ShowTimeCD"];
            TriggerHapticFeedback();
          }

          ImGui::SetWindowFontScale(1.5f);
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 97.0f, windowPos.y + 223.0f));
          if (Checkbox(NameCooldown, "Name Cooldown", "Đổi Tên Thành Hồi Chiêu", self.italic)) {
            ShowCD = NameCooldown;
            [[SaveSetting shared] saveBool:NameCooldown forKey:@"NameCooldown"];
            [[SaveSetting shared] saveBool:ShowCD forKey:@"ShowCD"];
            TriggerHapticFeedback();
          }
          ImGui::SetWindowFontScale(1.5f);
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 275.0f, windowPos.y + 223.0f));
          if (Checkbox(ShowHistory, "Show LSĐ", "Hiển Thị Lịch Sử Đấu", self.italic)) {
            [[SaveSetting shared] saveBool:ShowHistory forKey:@"ShowHistory"];
            TriggerHapticFeedback();
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 97.0f, windowPos.y + 265.0f));
          ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(9, 9));
          ImGui::PushStyleVar(ImGuiStyleVar_GrabMinSize, 30);
          ImGui::PushStyleVar(ImGuiStyleVar_GrabRounding, 8.5);
          if (CustomSlider("##camview", &camera, 0.5f, 6.0f, "CAMERA", "THẲNG", ImVec2(360, 35))) {
            [[SaveSetting shared] saveFloat:camera forKey:@"Cameras"];
            TriggerHapticFeedback();
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 97.0f, windowPos.y + 305.0f));
          if (CustomSlider("##fovview", &defFov, 30.0f, 120.0f, "DRONE", "NGHIÊNG", ImVec2(360, 35))) {
            Camxa = true;
            drone = defFov;
            [[SaveSetting shared] saveBool:Camxa forKey:@"Camxa"];
            [[SaveSetting shared] saveFloat:defFov forKey:@"defFov"];
            TriggerHapticFeedback();
          }
          ImGui::PopStyleVar(3);
        } else if (Settings::Tab == 2) {
          // Nút bật/tắt Aimbot theo giao diện của aoveagle131.
          {
            ImVec2 pos = ImVec2(windowPos.x + 92.0f, windowPos.y + 75.0f);
            ImVec2 size = ImVec2(180.0f, 40.0f);
            ImVec2 end = ImVec2(pos.x + size.x, pos.y + size.y);
            ImDrawList *draw_list = ImGui::GetWindowDrawList();

            ImGui::SetCursorScreenPos(pos);
            if (ImGui::InvisibleButton("toggleAimbot", size)) {
              AimSkill = !AimSkill;
              LuuChucNang();
              TriggerHapticFeedback();
            }

            ImU32 bgColor = AimSkill ? IM_COL32(205, 205, 210, 255) : IM_COL32(48, 48, 52, 255);
            draw_list->AddRectFilled(pos, end, bgColor, 50.0f);

            ImGui::SetWindowFontScale(1.4f);
            const char *label = "BẬT AIMBOT";
            ImVec2 textSize = ImGui::CalcTextSize(label);
            float baseTextX = pos.x + (size.x - textSize.x) / 2.0f;
            float textY = pos.y + (size.y - textSize.y) / 2.0f;

            static float textOffset = 0.0f;
            float targetOffset = AimSkill ? 5.0f : 0.0f;
            float deltaTime = ImGui::GetIO().DeltaTime;
            textOffset += (targetOffset - textOffset) * 12.0f * deltaTime;

            float textX = baseTextX + textOffset;
            draw_list->AddText(ImVec2(textX, textY), IM_COL32(255, 255, 255, 255), label);
            if (AimSkill) {
              ImGui::SetWindowFontScale(2.1f);
              draw_list->AddText(ImVec2(textX - 20.0f, textY - 4.0f), IM_COL32(255, 255, 255, 255), "~ ");
            }
          }

          ImGui::SetWindowFontScale(1.5f);
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 285.0f, windowPos.y + 82.0f));
          if (Checkbox(VeDich, "Vẽ Địch", "Vẽ địch đang bị Aim", self.italic)) {
            DrawAimLine = VeDich;
            LuuChucNang();
            TriggerHapticFeedback();
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 92.0f, windowPos.y + 120.0f));
          ImGui::SetWindowFontScale(1.2f);
          ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(13, 13));
          {
            ImVec2 old_spacing = ImGui::GetStyle().ItemSpacing;
            ImGui::GetStyle().ItemSpacing.y = 6.0f;
            ImGui::SetNextItemWidth(300);
            DrawAimbotTab();
            ImGui::GetStyle().ItemSpacing = old_spacing;
          }

          ImGui::SetNextItemWidth(290);
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 92.0f, windowPos.y + 163.0f));
          {
            ImVec2 old_spacing = ImGui::GetStyle().ItemSpacing;
            ImGui::GetStyle().ItemSpacing.y = 6.0f;
            ImGui::SetNextItemWidth(300);
            AutoHero();
            ImGui::GetStyle().ItemSpacing = old_spacing;
          }
          ImGui::PopStyleVar();

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 92.0f, windowPos.y + 213.0f));
          ImGui::PushStyleColor(ImGuiCol_Text, red);
          ImGui::SetWindowFontScale(1.65f);
          ImGui::Text("CÁCH DÙNG");
          ImGui::SameLine();
          ImGui::PopStyleColor();
          ImGui::Text("HỆ THỐNG TỰ ĐIỀU CHỈNH");

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 92.0f, windowPos.y + 282.0f));
          ImGui::SetWindowFontScale(1.29f);
          ImGui::Text("Elsu | Gildur | Grakk | Slimz | Yue | Natalya\nEnzo | Stuart | Florentino | Volkath | Raz");

          ImVec2 btnClosePos = ImVec2(windowPos.x + 500.0f, windowPos.y + 256.0f);
          ImGui::SetCursorScreenPos(btnClosePos);
          if (ImGui::InvisibleButton("openmain", ImVec2(155.0f, 48.0f))) {
            Settings::Tab = 1;
            TriggerHapticFeedback();
          }
        } else if (Settings::Tab == 3) {
          if (!botrotab && !macrotab && !bandotab) botrotab = true;
          if (botrotab) { macrotab = false; bandotab = false; }
          else if (macrotab) { bandotab = false; }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 95.5f, windowPos.y + 72.0f));
          if (DrawToggleBox("BỔ TRỢ", "Auto Dùng Bổ Trợ", "botroToggle131", botrotab, self.italic, self.icon131)) {
            macrotab = false;
            bandotab = false;
            botrotab = true;
            TriggerHapticFeedback();
          }
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 254.5f, windowPos.y + 72.0f));
          if (DrawToggleBox("MACRO", "Macro Tự Động", "macroToggle131", macrotab, self.italic, self.icon131)) {
            botrotab = false;
            bandotab = false;
            macrotab = true;
            TriggerHapticFeedback();
          }
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 413.5f, windowPos.y + 72.0f));
          if (DrawToggleBox("BÁN ĐỒ", "Tự Động Bán Đồ", "bandoToggle131", bandotab, self.italic, self.icon131)) {
            botrotab = false;
            macrotab = false;
            bandotab = true;
            TriggerHapticFeedback();
          }

          if (botrotab) {
            ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(9, 9));
            ImGui::PushStyleVar(ImGuiStyleVar_GrabMinSize, 30);
            ImGui::PushStyleVar(ImGuiStyleVar_GrabRounding, 8.5);

            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 132.0f));
            if (CustomSlider("##bocpha_slider", &EnemyHP, 0.0f, 100.0f, "BỘC PHÁ", "MÁU ĐỊCH", ImVec2(360, 35))) {
              [[SaveSetting shared] saveFloat:EnemyHP forKey:@"EnemyHP"];
              TriggerHapticFeedback();
            }

            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 172.0f));
            if (CustomSlider("##phutro_slider", &MyHP, 0.0f, 100.0f, "PHỤ TRỢ", "MÁU THÂN", ImVec2(360, 35))) {
              [[SaveSetting shared] saveFloat:MyHP forKey:@"MyHP"];
              TriggerHapticFeedback();
            }
            ImGui::PopStyleVar(3);

            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 218.0f));
            ImGui::PushStyleColor(ImGuiCol_Text, red);
            ImGui::SetWindowFontScale(1.3f);
            ImGui::Text("TỰ ĐỘNG TRỪNG TRỊ");
            ImGui::SameLine();
            ImGui::PopStyleColor();
            ImGui::Text("TỰ ĐỘNG CHECK BÙA HẠI");
            AutoTrungTri = TTBua || TTBosst;

            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 240.0f));
            {
              ImVec2 pos = ImVec2(windowPos.x + 100.0f, windowPos.y + 240.0f);
              ImVec2 size = ImVec2(151.0f, 35.0f);
              ImVec2 end = ImVec2(pos.x + size.x, pos.y + size.y);
              ImDrawList *draw_list = ImGui::GetWindowDrawList();
              if (ImGui::InvisibleButton("Buaxanh131", size)) {
                TTBua = !TTBua;
                TTBosst = false;
                TTALL = false;
                AutoTrungTri = TTBua;
                LuuChucNang();
                TriggerHapticFeedback();
              }
              ImU32 bgColor = TTBua ? IM_COL32(205, 205, 210, 255) : IM_COL32(48, 48, 52, 255);
              draw_list->AddRectFilled(pos, end, bgColor, 50.0f);
              ImGui::SetWindowFontScale(1.3f);
              const char *label = "BÙA XANH / ĐỎ";
              ImVec2 textSize = ImGui::CalcTextSize(label);
              float baseTextX = pos.x + (size.x - textSize.x) / 2.0f;
              float textY = pos.y + (size.y - textSize.y) / 2.0f;
              static float textOffsetBua131 = 0.0f;
              float targetOffset = TTBua ? 5.0f : 0.0f;
              textOffsetBua131 += (targetOffset - textOffsetBua131) * 12.0f * ImGui::GetIO().DeltaTime;
              float textX = baseTextX + textOffsetBua131;
              draw_list->AddText(ImVec2(textX, textY), IM_COL32(255, 255, 255, 255), label);
              if (TTBua) {
                ImGui::SetWindowFontScale(2.1f);
                draw_list->AddText(ImVec2(textX - 20.0f, textY - 4.0f), IM_COL32(255, 255, 255, 255), "~ ");
              }
            }
            ImGui::SameLine();
            {
              ImVec2 pos = ImVec2(windowPos.x + 260.0f, windowPos.y + 240.0f);
              ImGui::SetCursorScreenPos(pos);
              ImVec2 size = ImVec2(160.0f, 35.0f);
              ImVec2 end = ImVec2(pos.x + size.x, pos.y + size.y);
              ImDrawList *draw_list = ImGui::GetWindowDrawList();
              if (ImGui::InvisibleButton("TTBosst131", size)) {
                TTBosst = !TTBosst;
                TTBua = false;
                TTALL = false;
                AutoTrungTri = TTBosst;
                LuuChucNang();
                TriggerHapticFeedback();
              }
              ImU32 bgColor = TTBosst ? IM_COL32(205, 205, 210, 255) : IM_COL32(48, 48, 52, 255);
              draw_list->AddRectFilled(pos, end, bgColor, 50.0f);
              ImGui::SetWindowFontScale(1.3f);
              const char *label = "RỒNG / TÀ THẦN";
              ImVec2 textSize = ImGui::CalcTextSize(label);
              float baseTextX = pos.x + (size.x - textSize.x) / 2.0f;
              float textY = pos.y + (size.y - textSize.y) / 2.0f;
              static float textOffsetBoss131 = 0.0f;
              float targetOffset = TTBosst ? 5.0f : 0.0f;
              textOffsetBoss131 += (targetOffset - textOffsetBoss131) * 12.0f * ImGui::GetIO().DeltaTime;
              float textX = baseTextX + textOffsetBoss131;
              draw_list->AddText(ImVec2(textX, textY), IM_COL32(255, 255, 255, 255), label);
              if (TTBosst) {
                ImGui::SetWindowFontScale(2.1f);
                draw_list->AddText(ImVec2(textX - 20.0f, textY - 4.0f), IM_COL32(255, 255, 255, 255), "~ ");
              }
            }
          }
          if (macrotab) {
            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 132.0f));
            ImGui::SetWindowFontScale(1.5f);
            if (Checkbox(autoyue, "Macro Auto Yue", "Tự Động Ném Chiêu Khi Vào Tầm Chiêu", self.italic)) {
              [[SaveSetting shared] saveBool:autoyue forKey:@"autoyue"];
              TriggerHapticFeedback();
            }

            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 172.0f));
            ImGui::SetWindowFontScale(1.5f);
            if (Checkbox(autoflo, "Macro Auto Florentino", "Giúp Múa Dễ Hơn ( Chỉ Cần Di Chuyển Để Lụm Bông )", self.italic)) {
              [[SaveSetting shared] saveBool:autoflo forKey:@"autoflo"];
              TriggerHapticFeedback();
            }

            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 212.0f));
            ImGui::SetWindowFontScale(1.35f);
            ImGui::Text("Flo Skill");
            ImGui::SameLine(145.0f); if (ImGui::RadioButton("Chiêu 1", &floMode, 1)) [[SaveSetting shared] saveInt:floMode forKey:@"floMode"];
            ImGui::SameLine(235.0f); if (ImGui::RadioButton("Chiêu 3", &floMode, 2)) [[SaveSetting shared] saveInt:floMode forKey:@"floMode"];
            ImGui::SameLine(325.0f); if (ImGui::RadioButton("Cả hai", &floMode, 3)) [[SaveSetting shared] saveInt:floMode forKey:@"floMode"];
            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 250.0f));
            if (ImGui::Checkbox("Hiện hoa", &floShowFlower)) [[SaveSetting shared] saveBool:floShowFlower forKey:@"floShowFlower"];
            ImGui::SameLine(220.0f);
            if (ImGui::Checkbox("Kẻ đường tới hoa", &floShowLine)) [[SaveSetting shared] saveBool:floShowLine forKey:@"floShowLine"];

            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 294.0f));
            ImGui::SetWindowFontScale(1.35f);
            if (Checkbox(BugSkill, "BugSkill", "Mở rộng kỹ năng", self.italic)) {
              [[SaveSetting shared] saveBool:BugSkill forKey:@"BugSkill"];
              TriggerHapticFeedback();
            }

            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 318.0f, windowPos.y + 294.0f));
            ImGui::SetWindowFontScale(1.35f);
            if (Checkbox(Showline, "Hiện Tia Bug", "Hiện tia kỹ năng", self.italic)) {
              [[SaveSetting shared] saveBool:Showline forKey:@"Showline"];
              TriggerHapticFeedback();
            }
          }
          if (bandotab) {
              ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 132.0f));
              ImGui::SetWindowFontScale(1.5f);
              if (Checkbox(muaitem, "Tự Động Mua/Bán", "Kích hoạt tính năng tự động đổi đồ", self.italic)) {
                  LuuChucNang();
              }

              ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 172.0f));
              ImGui::SetWindowFontScale(1.5f);
              if (Checkbox(doiitem, "Tự Động Đổi Phụ Trợ", "Tự động chọn trang bị kích hoạt có sẵn", self.italic)) {
                  LuuChucNang();
              }

              ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 220.0f));
              ShowSequentialItemCombosWithCheckbox();
          }
        } else if (Settings::Tab == 4) {
          if (minimaptab) {
            ImGui::SetWindowFontScale(1.2f);
            ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(9, 9));
            ImGui::PushStyleVar(ImGuiStyleVar_GrabMinSize, 30);
            ImGui::PushStyleVar(ImGuiStyleVar_GrabRounding, 8.5);

            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 74.0f));
            if (CustomSlider("##minimapngang131", &minimapOffsetX, -200.0f, 200.0f, "MINIMAP", "NGANG", ImVec2(360, 35))) {
                [[SaveSetting shared] saveFloat:minimapOffsetX forKey:@"minimapOffsetX"];
            }

            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 118.0f));
            if (CustomSlider("##minimapdoc131", &minimapOffsetY, -200.0f, 200.0f, "MINIMAP", "DỌC", ImVec2(360, 35))) {
                [[SaveSetting shared] saveFloat:minimapOffsetY forKey:@"minimapOffsetY"];
            }

            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 162.0f));
            if (CustomSlider("##minimapxoay131", &minimapRotation, -180.0f, 180.0f, "MINIMAP", "XOAY", ImVec2(360, 35))) {
                [[SaveSetting shared] saveFloat:minimapRotation forKey:@"minimapRotation"];
            }

            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 206.0f));
            if (CustomSlider("##minimapicon131", &iconScale, 0.1f, 5.0f, "ICON", "SIZE", ImVec2(360, 35))) {
                [[SaveSetting shared] saveFloat:iconScale forKey:@"iconScale"];
            }

            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 250.0f));
            if (CustomSlider("##minimapscale131", &minimapCustomScale, 0.5f, 2.0f, "MINIMAP", "SIZE", ImVec2(360, 35))) {
                [[SaveSetting shared] saveFloat:minimapCustomScale forKey:@"minimapCustomScale"];
            }

            ImGui::PopStyleVar(3);
          } else {
          struct EspToggleItem { bool *value; const char *label; const char *description; NSString *key; };
          EspToggleItem espItems[] = {
            {&ESPEnable, "Bật ESP", "Bắt đầu vẽ ESP", @"ESPEnable"},
            {&IgnoreInvisible, "Bỏ Qua Khi Thấy", "Không vẽ địch đang có tầm nhìn", @"IgnoreInvisible"},
            {&PlayerName, "InFo Player", "Hiển thị thông tin tướng địch", @"PlayerName"},
            {&NumberESP, "Number", "Khung đếm số địch", @"NumberESP"},
            {&Alert360, "Chỉ Địch", "Chỉ hướng địch", @"Alert360"},
            {&PlayerLine, "Line", "Tia ESP màu vàng", @"PlayerLine"},
            {&PlayerBox, "Box", "Hộp bao quanh địch", @"PlayerBox"},
            {&DistanceESP, "Distance", "Khoảng cách đến địch", @"DistanceESP"},
            {&PlayerHeal, "Health", "Thanh máu địch", @"PlayerHeal"},
            {&HeroIconESP, "Hero Icon", "Icon địch trên minimap có viền trắng", @"HeroIconESP"},
            {&ShowMinimap, "MiniMap", "Icon tướng khi địch khuất tầm nhìn", @"ShowMinimap"},
            {&StreamerMode, "Ẩn Hack", "Ẩn menu và ESP khi quay/chụp", @"StreamerMode"}
          };

          for (int i = 0; i < 12; ++i) {
            float columnX = (i % 2 == 0) ? 92.0f : 285.0f;
            float rowY = 82.0f + (i / 2) * 34.0f;
            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + columnX, windowPos.y + rowY));
            ImGui::SetWindowFontScale(1.35f);
            if (Checkbox(*espItems[i].value, espItems[i].label, espItems[i].description, self.italic)) {
              [[SaveSetting shared] saveBool:*espItems[i].value forKey:espItems[i].key];
              TriggerHapticFeedback();
            }
          }
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 290.0f));
          if (DrawToggleBoxdaihon("Tùy Chỉnh Minimap", "Chỉnh Độ Lệch MiniMap", "minimapToggle131", minimaptab, self.italic, self.icon131)) {
            minimaptab = !minimaptab;
            TriggerHapticFeedback();
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 500.0f, windowPos.y + 306.0f));
          if (ImGui::InvisibleButton("openmain_esp", ImVec2(155.0f, 38.0f))) {
            Settings::Tab = 1;
            TriggerHapticFeedback();
          }
        } else if (Settings::Tab == 5) {
          // Tab MOD KHÁC: hai nhóm MOD MEMORY và MOD KHÁC theo mẫu aoveagle131.
          if (!modtab1 && !modtab2) modtab1 = true;
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 95.0f, windowPos.y + 72.0f));
          if (DrawToggleBoxdaihon2("MOD MEMORY", "Mod Skin Lính", "modmemory131", modtab1, self.italic, self.icon131)) {
            modtab1 = true;
            modtab2 = false;
            TriggerHapticFeedback();
          }
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 295.0f, windowPos.y + 72.0f));
          if (DrawToggleBox("MOD KHÁC", "Mod File ...", "modother131", modtab2, self.italic, self.icon131)) {
            modtab1 = false;
            modtab2 = true;
            TriggerHapticFeedback();
          }

          if (modtab1) {
            ImGui::SetWindowFontScale(1.2f);
            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 140.0f));
            ImGui::SetNextItemWidth(300.0f);
            if (ImGui::Combo("Skin Lính", &Skinminion, SoldierSkinNames, IM_ARRAYSIZE(SoldierSkinNames))) {
              SoldierID = SoldierSkinIDs[Skinminion];
              [[SaveSetting shared] saveInt:Skinminion forKey:@"Skinminion"];
              [[SaveSetting shared] saveInt:SoldierID forKey:@"SoldierID"];
              TriggerHapticFeedback();
            }
            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 184.0f));
            ImGui::SetNextItemWidth(300.0f);
            DrawModButton();
            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 228.0f));
            ImGui::SetNextItemWidth(300.0f);
            DrawModNotify();
            ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 272.0f));
            ImGui::SetNextItemWidth(300.0f);
            ImGui::TextDisabled("Chọn trang phục lính và hiệu ứng cho tài khoản đang dùng.");
          }

          if (modtab2) {
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 142.0f));
          if (DrawAimbotBoxdaihon("MODSKIN FILE", "Mod Qua File / Link", self.italic, self.icon131, "modfilelink131")) {
            MenDeal = false;
            [self ModSkin];
            TriggerHapticFeedback();
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 204.0f));
          if (DrawAimbotBoxdaihon("XÓA MOD", "Xóa Mod / Xóa Resources", self.italic, self.icon131, "Xoamod131")) {
            MenDeal = false;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"XÓA MOD SKIN ?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *clear = [UIAlertAction actionWithTitle:@"XÓA MOD SKIN" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *_Nonnull action) {
              [[maintool sharemain] xoamod];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:clear];
            [alert addAction:cancel];
            UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
            [viewController presentViewController:alert animated:YES completion:nil];
            TriggerHapticFeedback();
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 266.0f));
          if (DrawAimbotBoxdaihon("SAVE ACCOUNT", "Chức Năng Hữu Ích Cho Ai Nhiều Acc", self.italic, self.icon131, "SaveAcc131")) {
            MenDeal = false;
            [[maintool sharemain] LoadAcc];
            [[maintool sharemain] ChangeAccount];
            TriggerHapticFeedback();
          }
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 500.0f, windowPos.y + 306.0f));
          if (ImGui::InvisibleButton("openmain_mod", ImVec2(155.0f, 38.0f))) {
            Settings::Tab = 1;
            TriggerHapticFeedback();
          }
        } else if (Settings::Tab == 8) {
          ImGui::SetWindowFontScale(1.35f);
          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 82.0f));
          if (Checkbox(unlock2, "MOD GAME / KHOE VIP", "Bat thong so profile sanh", self.italic)) {
            [[SaveSetting shared] saveBool:unlock2 forKey:@"unlock2"];
            TriggerHapticFeedback();
          }

          ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(8.0f, 8.0f));
          ImGui::PushStyleVar(ImGuiStyleVar_GrabMinSize, 24.0f);
          ImGui::PushStyleVar(ImGuiStyleVar_GrabRounding, 8.0f);
          ImGui::SetWindowFontScale(1.15f);

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 132.0f));
          ImGui::SetNextItemWidth(360.0f);
          if (ImGui::SliderInt("So Luong Skin", &customSkinCount, 0, 3000)) {
            [[SaveSetting shared] saveInt:customSkinCount forKey:@"customSkinCount"];
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 172.0f));
          ImGui::SetNextItemWidth(360.0f);
          if (ImGui::SliderInt("So Luong Quan Huy", &customDianquan, 0, 9999)) {
            [[SaveSetting shared] saveInt:customDianquan forKey:@"customDianquan"];
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 212.0f));
          ImGui::SetNextItemWidth(360.0f);
          if (ImGui::SliderInt("So Luong Vang", &customGoldCoin, 0, 99999999)) {
            [[SaveSetting shared] saveInt:customGoldCoin forKey:@"customGoldCoin"];
          }

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 100.0f, windowPos.y + 252.0f));
          ImGui::SetNextItemWidth(360.0f);
          if (ImGui::SliderInt("So Luong Ruby", &customDiamond, 0, 99999999)) {
            [[SaveSetting shared] saveInt:customDiamond forKey:@"customDiamond"];
          }
          ImGui::PopStyleVar(3);

          ImGui::SetCursorScreenPos(ImVec2(windowPos.x + 500.0f, windowPos.y + 306.0f));
          ImGui::SetWindowFontScale(1.2f);
          if (ImGui::Button("QUAY LAI", ImVec2(155.0f, 38.0f))) {
            Settings::Tab = 7;
            TriggerHapticFeedback();
          }
        } else {
          ImGui::Dummy(ImVec2(0.0f, 0.0f));
        }

        ImGui::PopStyleVar();
      }
      ImGui::PopStyleColor();
      ImGui::PopFont();
      const ImVec2 pos = ImGui::GetWindowPos();

      ImDrawList *draw_list = ImGui::GetWindowDrawList();
      ImDrawList *backdraw = ImGui::GetBackgroundDrawList();
      backdraw->AddRectFilled(ImVec2(0, 0), ImGui::GetIO().DisplaySize, IM_COL32(0, 0, 0, 150)  // màu đen mờ
      );
      ImGui::End();

    }
    ImDrawList *draw_list = ImGui::GetBackgroundDrawList();
    DrawESP(draw_list);
    DrawBugSkill(draw_list);
    floren(draw_list);
    HandleAuto(draw_list);
    AutoYueRun();
    ImGuiStyle &style = ImGui::GetStyle();

    ImVec4 *colors = style.Colors;
    colors[ImGuiCol_Text]                   = ImVec4(0.96f, 0.96f, 0.97f, 1.00f);
    colors[ImGuiCol_TextDisabled]           = ImVec4(0.48f, 0.48f, 0.51f, 1.00f);
    colors[ImGuiCol_WindowBg]               = ImVec4(0.04f, 0.04f, 0.05f, 0.96f);
    colors[ImGuiCol_ChildBg]                = ImVec4(0.08f, 0.08f, 0.09f, 0.62f);
    colors[ImGuiCol_PopupBg]                = ImVec4(0.07f, 0.07f, 0.08f, 0.98f);
    colors[ImGuiCol_Border]                 = ImVec4(0.52f, 0.52f, 0.55f, 0.42f);
    colors[ImGuiCol_BorderShadow]           = ImVec4(0.00f, 0.00f, 0.00f, 0.00f);
    colors[ImGuiCol_FrameBg]                = ImVec4(0.12f, 0.12f, 0.13f, 0.96f);
    colors[ImGuiCol_FrameBgHovered]         = ImVec4(0.20f, 0.20f, 0.22f, 1.00f);
    colors[ImGuiCol_FrameBgActive]          = ImVec4(0.30f, 0.30f, 0.33f, 0.95f);
    colors[ImGuiCol_TitleBg]                = ImVec4(0.04f, 0.04f, 0.05f, 1.00f);
    colors[ImGuiCol_TitleBgActive]          = ImVec4(0.09f, 0.09f, 0.10f, 1.00f);
    colors[ImGuiCol_TitleBgCollapsed]       = ImVec4(0.04f, 0.04f, 0.05f, 0.84f);
    colors[ImGuiCol_MenuBarBg]              = ImVec4(0.09f, 0.09f, 0.10f, 1.00f);
    colors[ImGuiCol_ScrollbarBg]            = ImVec4(0.04f, 0.04f, 0.05f, 0.45f);
    colors[ImGuiCol_ScrollbarGrab]          = ImVec4(0.26f, 0.26f, 0.28f, 0.95f);
    colors[ImGuiCol_ScrollbarGrabHovered]   = ImVec4(0.62f, 0.62f, 0.65f, 0.90f);
    colors[ImGuiCol_ScrollbarGrabActive]    = kSubinAccent;
    colors[ImGuiCol_CheckMark]              = kSubinAccentHover;
    colors[ImGuiCol_SliderGrab]             = kSubinAccent;
    colors[ImGuiCol_SliderGrabActive]       = kSubinAccentHover;
    colors[ImGuiCol_Button]                 = ImVec4(0.12f, 0.12f, 0.13f, 0.96f);
    colors[ImGuiCol_ButtonHovered]          = ImVec4(0.22f, 0.22f, 0.24f, 1.00f);
    colors[ImGuiCol_ButtonActive]           = ImVec4(0.34f, 0.34f, 0.37f, 1.00f);
    colors[ImGuiCol_Header]                 = ImVec4(0.17f, 0.17f, 0.19f, 0.95f);
    colors[ImGuiCol_HeaderHovered]          = ImVec4(0.42f, 0.42f, 0.45f, 0.34f);
    colors[ImGuiCol_HeaderActive]           = ImVec4(0.32f, 0.32f, 0.35f, 0.92f);
    colors[ImGuiCol_Separator]              = ImVec4(0.48f, 0.48f, 0.51f, 0.30f);
    colors[ImGuiCol_SeparatorHovered]       = ImVec4(0.72f, 0.72f, 0.75f, 0.78f);
    colors[ImGuiCol_SeparatorActive]        = kSubinAccent;
    colors[ImGuiCol_ResizeGrip]             = ImVec4(0.58f, 0.58f, 0.61f, 0.22f);
    colors[ImGuiCol_ResizeGripHovered]      = ImVec4(0.72f, 0.72f, 0.75f, 0.58f);
    colors[ImGuiCol_ResizeGripActive]       = ImVec4(0.72f, 0.72f, 0.75f, 0.95f);
    colors[ImGuiCol_Tab]                    = ImVec4(0.10f, 0.10f, 0.11f, 1.00f);
    colors[ImGuiCol_TabHovered]             = ImVec4(0.48f, 0.48f, 0.51f, 0.45f);
    colors[ImGuiCol_TabActive]              = ImVec4(0.34f, 0.34f, 0.37f, 0.96f);
    colors[ImGuiCol_TabUnfocused]           = ImVec4(0.08f, 0.08f, 0.09f, 1.00f);
    colors[ImGuiCol_TabUnfocusedActive]     = ImVec4(0.17f, 0.17f, 0.19f, 1.00f);
    colors[ImGuiCol_PlotLines]              = kSubinAccent;
    colors[ImGuiCol_PlotLinesHovered]       = kSubinAccentHover;
    colors[ImGuiCol_PlotHistogram]          = ImVec4(0.64f, 0.64f, 0.67f, 1.00f);
    colors[ImGuiCol_PlotHistogramHovered]   = kSubinAccentHover;
    colors[ImGuiCol_TextSelectedBg]         = ImVec4(0.72f, 0.72f, 0.75f, 0.30f);
    colors[ImGuiCol_DragDropTarget]         = ImVec4(0.82f, 0.82f, 0.85f, 0.90f);
    colors[ImGuiCol_NavHighlight]           = kSubinAccentHover;
    colors[ImGuiCol_NavWindowingHighlight]  = ImVec4(1.00f, 1.00f, 1.00f, 0.70f);
    colors[ImGuiCol_NavWindowingDimBg]      = ImVec4(0.04f, 0.05f, 0.08f, 0.50f);
    colors[ImGuiCol_ModalWindowDimBg]       = ImVec4(0.00f, 0.00f, 0.00f, 0.72f);

    style.ChildRounding = 16.0f;
    style.WindowPadding = ImVec2(12, 12);
    style.WindowRounding = 24.0f;
    style.WindowBorderSize = 1.0f;
    style.FramePadding = ImVec2(14, 9);
    style.FrameRounding = 13.0f;
    style.FrameBorderSize = 0.0f;
    style.ItemSpacing = ImVec2(12, 10);
    style.ItemInnerSpacing = ImVec2(8, 6);
    style.ScrollbarSize = 14.0f;
    style.ScrollbarRounding = 12.0f;
    style.GrabMinSize = 18.0f;
    style.GrabRounding = 12.0f;
    style.PopupRounding = 16.0f;
    style.TabRounding = 12.0f;
    style.Alpha = 1.0;

    ImGui::Render();
    ImDrawData *draw_data = ImGui::GetDrawData();
    ImGui_ImplMetal_RenderDrawData(draw_data, commandBuffer, renderEncoder);

    [renderEncoder popDebugGroup];
    [renderEncoder endEncoding];

    [commandBuffer presentDrawable:view.currentDrawable];


  }

  [commandBuffer commit];
}


static void chapto_HookAntibanLogic() {
  PatchOffset(Patch_anogs, 0x25DD64, ENCRYPTHEX("C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x2439AC, ENCRYPTHEX("C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x240EC8, ENCRYPTHEX("C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x23FD98, ENCRYPTHEX("C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x23FAFC, ENCRYPTHEX("C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x23FAF4, ENCRYPTHEX("C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x23F770, ENCRYPTHEX("C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x23F8FC, ENCRYPTHEX("C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x3916C, ENCRYPTHEX("00008052C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x4CC0C, ENCRYPTHEX("00008052C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x9A7F0, ENCRYPTHEX("00008052C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x229964, ENCRYPTHEX("00008052C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x23D47C, ENCRYPTHEX("20008052C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x23E60C, ENCRYPTHEX("20008052C0035FD6"), true);
  PatchOffset(Patch_anogs, 0x25DFF4, ENCRYPTHEX("20008052C0035FD6"), true);
}

static void chapto_ApplyPhangThangLogic() {
    static bool phangthang_active = false;
    // Nếu đã patch rồi thì không làm gì nữa để đỡ tốn tài nguyên
    if (phangthang_active) return;

    phangthang_active = true; // Đánh dấu ngay lập tức để tránh gọi trùng lặp
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        const char* framework = ENCRYPT("Frameworks/UnityFramework.framework/UnityFramework");
        PatchOffset(framework, 0X51C31C, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X51D952C, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X45478E0, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X4AE56C0, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X5386CC, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X51B60C, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X65BE6F8, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X5A4310C, ENCRYPTHEX("C0035FD6"), true);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        const char* framework = ENCRYPT("Frameworks/UnityFramework.framework/UnityFramework");
        PatchOffset(framework, 0X5ADBD9C, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X754BAC0, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X3727F94, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X3828714, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X382878C, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X4AE56C0, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0XB4D84C, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X4AE56C0, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X5D23068, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X5ADBD9C, ENCRYPTHEX("C0035FD6"), true);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        const char* framework = ENCRYPT("Frameworks/UnityFramework.framework/UnityFramework");
        PatchOffset(framework, 0X462476C, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X5F16C5C, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X4C272F8, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X4C3E61C, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X5D43C80, ENCRYPTHEX("C0035FD6"), true);
        PatchOffset(framework, 0X5F89254, ENCRYPTHEX("C0035FD6"), true);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        const char* framework = ENCRYPT("Frameworks/UnityFramework.framework/UnityFramework");
        PatchOffset(framework, 0X103566C, ENCRYPTHEX("C0035FD6"), true); // CheatCommandsSaveBanCountAndTime
        PatchOffset(framework, 0X78352CC, ENCRYPTHEX("C0035FD6"), true); // CheatCommandsClearBanCountAndTime
        PatchOffset(framework, 0X1034E38, ENCRYPTHEX("C0035FD6"), true);  // new_CSDT_CHEAT_ADD_MATCH_BLACKLIST
        PatchOffset(framework, 0X3B8351C, ENCRYPTHEX("C0035FD6"), true); // onTriggerSecurityDataReport
    });
}
- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size {
}


- (void)ModSkin {
  MenDeal = false;

  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CHỌN LOẠI MOD BẠN CẦN" message:nil preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *clear = [UIAlertAction actionWithTitle:@"MOD SKIN QUA LINK"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *_Nonnull action) {
                                                  [[maintool sharemain] inputLinkMod];
                                                }];

  UIAlertAction *force = [UIAlertAction actionWithTitle:@"MOD SKIN QUA FILE"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *_Nonnull action) {
                                                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"MOD SKIN QUA FILE" message:@"Trước khi mod hãy vuốt về màn hình chính rồi vào lại game để mod" preferredStyle:UIAlertControllerStyleAlert];
                                                  UIAlertAction *clear = [UIAlertAction actionWithTitle:@"Mod Ngay"
                                                                                                  style:UIAlertActionStyleDefault
                                                                                                handler:^(UIAlertAction *_Nonnull action) {
                                                                                                  [[maintool sharemain] openFilePicker];
                                                                                                }];

                                                  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
                                                  [alert addAction:okAction];
                                                  [alert addAction:clear];
                                                  UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                                                  [viewController presentViewController:alert animated:YES completion:nil];
                                                }];

  UIAlertAction *video = [UIAlertAction actionWithTitle:@"MOD VIDEO SẢNH"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *_Nonnull action) {
                                                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Mod Sảnh LQM" message:@"Trước khi mod hãy vuốt về màn hình chính rồi vào lại game để mod" preferredStyle:UIAlertControllerStyleAlert];
                                                  UIAlertAction *mod = [UIAlertAction actionWithTitle:@"Mod Ngay"
                                                                                                style:UIAlertActionStyleDefault
                                                                                              handler:^(UIAlertAction *_Nonnull action) {
                                                                                                [[maintool sharemain] modsanhfull];
                                                                                              }];
                                                  UIAlertAction *clear = [UIAlertAction actionWithTitle:@"Reset"
                                                                                                  style:UIAlertActionStyleDefault
                                                                                                handler:^(UIAlertAction *_Nonnull action) {
                                                                                                  [[maintool sharemain] resetsanh];
                                                                                                }];
                                                  UIAlertAction *count = [UIAlertAction actionWithTitle:@"Count"
                                                                                                  style:UIAlertActionStyleDefault
                                                                                                handler:^(UIAlertAction *_Nonnull action) {
                                                                                                  [[maintool sharemain] demsanh];
                                                                                                }];
                                                  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
                                                  [alert addAction:mod];
                                                  [alert addAction:clear];
                                                  [alert addAction:okAction];

                                                  UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                                                  [viewController presentViewController:alert animated:YES completion:nil];
                                                }];

  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

  [alert addAction:clear];
  [alert addAction:force];
  [alert addAction:video];
  [alert addAction:okAction];

  UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
  [viewController presentViewController:alert animated:YES completion:nil];
}

@end
