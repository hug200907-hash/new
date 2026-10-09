#include <MetalKit/MetalKit.h>
#include <Metal/Metal.h>
#include <iostream>
#include <UIKit/UIKit.h>
#include <vector>
#include <array>
#include <Foundation/Foundation.h>
#include <libgen.h>
#include <mach-o/dyld.h>
#include <mach-o/fat.h>
#include <mach-o/loader.h>
#include <mach/vm_page_size.h>
#include <unistd.h>
#include <array>
#include <deque>
#include <map>
#include <random>
#include <string>
#include <unordered_map>
#include <vector>
#import <SafariServices/SafariServices.h>
#import <WebKit/WebKit.h>
#include <dlfcn.h>
#include <pthread.h>
#include <string.h>
#import <sys/utsname.h>  // Thêm header để sử dụng struct utsname
#include <unistd.h>


#include <cstring>
#include <fstream>
#include <iostream>
#include <list>
#include <regex>
#include <thread>
#include <vector>

#import "ImGuiDrawView.h"
#import "MenuLoad.h"
#import "KittyMemory/imgui.h"
#import "KittyMemory/imgui_internal.h"
#import "KittyMemory/imgui_impl_metal.h"


#include "cryptor.h"
#include <fstream>

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale
#define RadiansToDegree  180 /3.141592654f;
#define timer(sec) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, sec * NSEC_PER_SEC), dispatch_get_main_queue(), ^
#define PI 3.14159265

extern MenuInteraction* menuTouchView;
extern UIButton* InvisibleMenuButton;
extern UIButton* VisibleMenuButton;
extern UITextField* hideRecordTextfield;
extern UIView* hideRecordView;
extern bool StreamerMode;
extern bool blockdanhthang;
