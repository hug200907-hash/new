#import <MetalKit/MetalKit.h>
#import "KittyMemory/imgui.h"
#import "KittyMemory/imgui_internal.h"

struct GlobalVariables {
   static GlobalVariables& GetInstance() {
        static GlobalVariables Instance;
        return Instance;
    }
    
    ImFont* Font;
    ImVec2 MenuSize = ImVec2(0, 0);
    ImVec2 MenuOrigin = ImVec2(0, 0);
};

static GlobalVariables& KTempVars = GlobalVariables::GetInstance();

@interface ImGuiTouchView : MTKView
@end
