//camera
static void* get_OnCameraHeightChanged(void *instance) {
    auto (*_get_OnCameraHeightChanged)(void *instance) = (void *(*)(void *))Aluminium(newGetMethodOffset("Project_d.dll", "", "CameraSystem", "OnCameraHeightChanged", 0));
    return _get_OnCameraHeightChanged(instance);
}

static void ApplyCameraTilt(void *instance) {
    if (instance == NULL || !Camxa) return;

    get_OnCameraHeightChanged(instance);
    void *cam = get_main ? get_main() : NULL;
    if (cam != NULL && set_fieldOfView) {
        float fov = defFov > 0.0f ? defFov : 60.0f;
        set_fieldOfView(cam, fov);
    }
}

void (*CameraSystem_Update)(void *instance);
void _CameraSystem_Update(void *instance) {
    if (CameraSystem_Update) CameraSystem_Update(instance);
    ApplyCameraTilt(instance);
}

void (*_LateUpdatecam)(void *instance);
void LateUpdatecam(void *instance) {
    if (_LateUpdatecam) _LateUpdatecam(instance);
    ApplyCameraTilt(instance);
}

float (*GetZoomRate)(void *instance);
float _GetZoomRate(void *instance) {
    float Onview = GetZoomRate(instance);
    if (instance != NULL && Camxa) {
        return LockCam ? camera : (Onview + camera);
    }
    return Onview;
}

void (*_SetVisible)(void *instance, int camp, bool bVisible, const bool forceSync);
void SetVisible(void *instance, int camp, bool bVisible, const bool forceSync = false) {
    if (instance != NULL && HackMap) {
        if(camp == 1 || camp == 2 || camp == 110 || camp == 255) {
            bVisible = true;
        } 
    }
 return _SetVisible(instance, camp, bVisible, forceSync);
}

bool (*_IsHostProfile)(void *instance);
bool get_IsHostProfile(void *instance)
{
    if (!instance)
        return false;
    if (ShowHistory) {
        *(bool *)((uintptr_t)instance + UL_mIsHideFightHistory) = false;
    }
    if (HackMap || unlock2) {
        *(bool *)((uintptr_t)instance + UL_mIsHideLegendTitleGIS) = false;
        *(bool *)((uintptr_t)instance + UL_mIsHideGameInfo) = false;
        *(bool *)((uintptr_t)instance + UL_mIsHideFightHistory) = false;
        *(bool *)((uintptr_t)instance + UL__intimacyInfoIsLock) = false;
        *(uint32_t *)((uintptr_t)instance + UL__skinCnt) = unlock2 ? customSkinCount : 4090;
        return true;
    }

    return _IsHostProfile(instance);
}

bool (*_IsCompleteFirst55Warm)(void* instance);
bool IsCompleteFirst55Warm(void* instance) {
    if (instance != NULL) {
        return true;
    }
    return _IsCompleteFirst55Warm(instance);
}

// thông báo ban
// void (*old_CUIManager_OpenMessageBox)(void *instance, monoString* strContent, int confirmID, bool isContentLeftAlign);
// void CUIManager_OpenMessageBox(void *instance, monoString* strContent, int confirmID, bool isContentLeftAlign) {
//     if (instance != NULL && confirmID == 253) {
//         std::string content = strContent->toCString();
//         dispatch_async(dispatch_get_main_queue(), ^{
//             CGSize screenSize = [UIScreen mainScreen].bounds.size;
//             CGFloat alertWidth = 560;
//             CGFloat padding = 10;
//             CGFloat triangleSize = 40;
//             CGFloat titleHeight = 20;
//             CGFloat titlePadding = 10;
//             CGFloat messagePadding = 5;

//             NSString *messageText = [NSString stringWithUTF8String:content.c_str()];
//             UIFont *messageFont = [UIFont fontWithName:@"AvenirNext-Bold" size:12];
//             if (!messageFont) {
//                 messageFont = [UIFont systemFontOfSize:16];
//             }

//             CGSize constraintSize = CGSizeMake(alertWidth - 2 * padding, CGFLOAT_MAX);
//             CGRect messageRect = [messageText boundingRectWithSize:constraintSize
//                                                            options:NSStringDrawingUsesLineFragmentOrigin
//                                                         attributes:@{NSFontAttributeName: messageFont}
//                                                            context:nil];
//             CGFloat messageHeight = ceil(messageRect.size.height);
//             CGFloat alertHeight = triangleSize + titleHeight + titlePadding + messageHeight + messagePadding + padding;

//             UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake((screenSize.width - alertWidth) / 2, 200, alertWidth, alertHeight)];
//             alertView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
//             alertView.layer.cornerRadius = 8;
//             alertView.clipsToBounds = YES;

//             CGPoint center = CGPointMake(alertWidth / 2, padding + triangleSize / 2);
//             CAShapeLayer *triangleLayer = [CAShapeLayer layer];
//             UIBezierPath *trianglePath = [UIBezierPath bezierPath];

//             CGPoint p1 = CGPointMake(center.x, center.y - triangleSize/2); // đỉnh trên
//             CGPoint p2 = CGPointMake(center.x - triangleSize/2, center.y + triangleSize/2); // trái dưới
//             CGPoint p3 = CGPointMake(center.x + triangleSize/2, center.y + triangleSize/2); // phải dưới

//             [trianglePath moveToPoint:p1];
//             [trianglePath addLineToPoint:p2];
//             [trianglePath addLineToPoint:p3];
//             [trianglePath closePath];

//             triangleLayer.path = trianglePath.CGPath;
//             triangleLayer.strokeColor = [UIColor yellowColor].CGColor;
//             triangleLayer.fillColor = [UIColor clearColor].CGColor;
//             triangleLayer.lineWidth = 2.2; // viền
//             triangleLayer.strokeEnd = 0;
//             [alertView.layer addSublayer:triangleLayer];

//             CAShapeLayer *exclamLayer = [CAShapeLayer layer];
//             UIBezierPath *exclamPath = [UIBezierPath bezierPath];

//             CGFloat exclamHeight = 20; // chiều dài dấu !
//             CGFloat exclamDotSize = 4; // chấm dưới
//             CGFloat exclamOffsetY = 5; // dịch xuống

//             [exclamPath moveToPoint:CGPointMake(center.x, center.y - exclamHeight/2 + 2 + exclamOffsetY)];
//             [exclamPath addLineToPoint:CGPointMake(center.x, center.y + exclamHeight/2 - exclamDotSize - 1 + exclamOffsetY)];
//             [exclamPath moveToPoint:CGPointMake(center.x, center.y + exclamHeight/2 - exclamDotSize + exclamOffsetY)];
//             [exclamPath addLineToPoint:CGPointMake(center.x, center.y + exclamHeight/2 + exclamOffsetY)];

//             exclamLayer.path = exclamPath.CGPath;
//             exclamLayer.strokeColor = [UIColor redColor].CGColor;
//             exclamLayer.fillColor = [UIColor clearColor].CGColor;
//             exclamLayer.lineWidth = 3;
//             exclamLayer.strokeEnd = 0;
//             [alertView.layer addSublayer:exclamLayer];

//             UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, triangleSize + 14, alertWidth - 2 * padding, titleHeight)];
//             titleLabel.text = @"Garena vn WarninG !";
//             titleLabel.textColor = [UIColor redColor];
//             titleLabel.font = [UIFont fontWithName:@"AvenirNext-Bold" size:20];
//             titleLabel.textAlignment = NSTextAlignmentCenter;
//             [alertView addSubview:titleLabel];

//             UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(titleLabel.frame) + messagePadding, alertWidth - 2 * padding, messageHeight)];
//             messageLabel.text = messageText;
//             messageLabel.textColor = [UIColor whiteColor];
//             messageLabel.font = messageFont;
//             messageLabel.numberOfLines = 0;
//             messageLabel.textAlignment = NSTextAlignmentCenter;
//             [alertView addSubview:messageLabel];

//             CABasicAnimation *triangleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//             triangleAnimation.fromValue = @0;
//             triangleAnimation.toValue = @1;
//             triangleAnimation.duration = 0.8;
//             triangleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//             triangleAnimation.removedOnCompletion = NO;
//             triangleAnimation.fillMode = kCAFillModeForwards;
//             [triangleLayer addAnimation:triangleAnimation forKey:@"triangleAnimation"];

//             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                 CABasicAnimation *exclamAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//                 exclamAnimation.fromValue = @0;
//                 exclamAnimation.toValue = @1;
//                 exclamAnimation.duration = 0.5;
//                 exclamAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//                 exclamAnimation.removedOnCompletion = NO;
//                 exclamAnimation.fillMode = kCAFillModeForwards;
//                 [exclamLayer addAnimation:exclamAnimation forKey:@"exclamAnimation"];
//             });

//             UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//             alertView.alpha = 0;
//             alertView.center = keyWindow.center;
//             [keyWindow addSubview:alertView];

//             [UIView animateWithDuration:0.2 animations:^{
//                 alertView.alpha = 1;
//             }];

//             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                 [UIView animateWithDuration:0.2 animations:^{
//                     alertView.alpha = 0;
//                 } completion:^(BOOL finished) {
//                     [alertView removeFromSuperview];
//                     deleteBeetalkSessionDB();
//                 }];
//             });
//         });
//         return;
//     }
//     old_CUIManager_OpenMessageBox(instance, strContent, confirmID, isContentLeftAlign);
// }

