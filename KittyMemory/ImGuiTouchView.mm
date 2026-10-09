#import "ImGuiTouchView.h"
#import "MenuLoad/ImGuiDrawView.h"

extern bool MenDeal;

@implementation ImGuiTouchView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (MenDeal == false) return NO;
    CGRect touchableArea = CGRectMake(KTempVars.MenuOrigin.x, KTempVars.MenuOrigin.y, KTempVars.MenuSize.x, KTempVars.MenuSize.y);
    if (CGRectContainsPoint(touchableArea, point)) {
        return [super pointInside:point withEvent:event];
    }
    return NO;
}

@end
