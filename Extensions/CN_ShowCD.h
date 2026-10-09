// esp
void (*old_ActorLinker_ActorDestroy)(void *instance);
void ActorLinker_ActorDestroy(void *instance) {
    if (instance != NULL) {
        old_ActorLinker_ActorDestroy(instance);
        ActorLinker_enemy->removeEnemyGivenObject(instance);
        MonsterManager->removeEnemyGivenObject(instance);
        Flo_Enemy->removeEnemyGivenObject(instance);
        if (espManager->MyPlayer == instance){
            espManager->MyPlayer = NULL;
        }
    }
}

void (*old_LActorRoot_ActorDestroy)(void *instance,bool bTriggerEvent);
void LActorRoot_ActorDestroy(void *instance, bool bTriggerEvent) {
    if (instance != NULL) {
        old_LActorRoot_ActorDestroy(instance, bTriggerEvent);
        espManager->removeEnemyGivenObject(instance);
        Flo_Enemy->removeEnemyGivenObject(instance);
    }
}
// Hide Name
bool CheckName = false;
const char* CheckPlayerName, * CheckPrefixName;
NSString* HideNamePlistPath() {
    NSString *docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [docsDir stringByAppendingPathComponent:@"HideName.plist"];
}

NSString* LoadCustomName() {
    NSString *path = HideNamePlistPath();
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    if (dict && dict[@"CustomName"]) return dict[@"CustomName"];
    return @"[ Chưa đặt tên ]";
}

NSString* LoadPrefixName() {
    NSString *path = HideNamePlistPath();
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    if (dict && dict[@"PrefixName"]) return dict[@"PrefixName"];
    return @"[ Chưa đặt tên ] ";
}

void SaveNameAndPrefix(NSString *name, NSString *prefix) {
    NSString *path = HideNamePlistPath();
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!dict) dict = [NSMutableDictionary dictionary];

    NSString *fixedPrefix = @"";
    NSString *trimPrefix = [prefix stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (trimPrefix.length > 0) fixedPrefix = [trimPrefix stringByAppendingString:@" "];
    
    dict[@"CustomName"] = name;
    dict[@"PrefixName"] = fixedPrefix;

    [dict writeToFile:path atomically:YES];
}

void SetHideName() {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"Đặt Tên Nào"
                                            message:@""
                                     preferredStyle:UIAlertControllerStyleAlert];

        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"PlayerName (VD: Tôi Nè)";
            textField.text = LoadCustomName();
        }];

        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"PrefixName (VD: ViP)";
            textField.text = LoadPrefixName();
        }];

        UIAlertAction *cancel =
        [UIAlertAction actionWithTitle:@"Huỷ"
                                 style:UIAlertActionStyleCancel
                               handler:nil];

        UIAlertAction *ok =
        [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action) {

            NSString *name   = alert.textFields[0].text;
            NSString *prefix = alert.textFields[1].text;

            if (name.length == 0) name = @"[ Chưa đặt tên ]";
            if (prefix.length == 0) prefix = @"";

            SaveNameAndPrefix(name, prefix);
            UpdateNameFake();
        }];

        [alert addAction:cancel];
        [alert addAction:ok];
        [rootVC presentViewController:alert animated:YES completion:nil];
    });
}

void ResetCustomName() {
    dispatch_async(dispatch_get_main_queue(), ^{
        SaveNameAndPrefix(@"[ Chưa đặt tên ]", @"[ Chưa đặt tên ]");
        UpdateNameFake();

        UIViewController *rootVC =
            [UIApplication sharedApplication].keyWindow.rootViewController;

        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"Reset Tên Done!"
                                            message:@"PlayerName và PrefixName đã được đặt lại về mặc định!"
                                     preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *ok =
        [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                               handler:nil];

        [alert addAction:ok];
        [rootVC presentViewController:alert animated:YES completion:nil];
    });
}

const char* GetCustomName() {
    static std::string cached;
    @autoreleasepool {
        cached = [LoadCustomName() UTF8String];
    }
    return cached.c_str();
}
const char* GetPrefixName() {
    static std::string cached;
    @autoreleasepool {
        cached = [LoadPrefixName() UTF8String];
    }
    return cached.c_str();
}

void UpdateNameFake() {
    CheckPlayerName = GetCustomName();
    CheckPrefixName = GetPrefixName();
    CheckName = true;
}
// end
void (*old_ActorLinker_Update)(void *instance);
void ActorLinker_Update(void *instance) {
    if (instance != NULL) {
        void* SkillControl = ActorLinker_AsHero(instance);
        void* HudControl = *(void**)((uintptr_t)instance + Aclk_HudControl);
        if (HudControl != NULL && isPlayerName) {
            const char* Players = CheckPlayerName;
            const char* Prefixs = CheckPrefixName;
            if (Players == CheckPlayerName || Prefixs == CheckPrefixName) CheckName = false;
            MonoString* PlayerName = String_CreateString(instance, Players, 0, strlen(Players));
            MonoString* PrefixName = String_CreateString(instance, Prefixs, 0, strlen(Prefixs)); 
            MonoString* CustomName = String_CreateString(instance, "", 0, 0);  
            SetPlayerName(HudControl, PlayerName, PrefixName, true, CustomName);
        }

        if (SkillControl != NULL && HudControl != NULL && ShowCD) {
            if (!ActorLinker_IsHostPlayer(instance) && !ActorLinker_IsHostCamp(instance)) {
                int Skill1CdMs = *(int*)((uintptr_t)SkillControl + (CD_Skill1 - 0x4));
                int Skill2CdMs = *(int*)((uintptr_t)SkillControl + (CD_Skill2 - 0x4));
                int Skill3CdMs = *(int*)((uintptr_t)SkillControl + (CD_Skill3 - 0x4));
                int Skill4CdMs = *(int*)((uintptr_t)SkillControl + (CD_SkillBoTro - 0x4));

                int Skill1Cd = Skill1CdMs / 1000;
                int Skill2Cd = Skill2CdMs / 1000;
                int Skill3Cd = Skill3CdMs / 1000;
                int Skill4Cd = Skill4CdMs / 1000;

                string sk1, sk2, sk3, sk4;
                
                sk1 = (Skill1Cd == 0) ? " [C1] " : " [" + to_string(Skill1Cd) + "] ";
                sk2 = (Skill2Cd == 0) ? " [C2] " : " [" + to_string(Skill2Cd) + "] ";
                sk3 = (Skill3Cd == 0) ? " [C3] " : " [" + to_string(Skill3Cd) + "] ";
                sk4 = (Skill4Cd == 0) ? " [SUBIN] " : " [" + to_string(Skill4Cd) + "] ";
                
                string ShowSkill = sk1 + sk2 + sk3; 
                string ShowSkill2 = sk4;
                const char *str1 = ShowSkill.c_str();
                const char *str2 = ShowSkill2.c_str();

                MonoString* PlayerName = String_CreateString(instance, str1, 0, strlen(str1));
                MonoString* PrefixName = String_CreateString(instance, str2, 0, strlen(str2)); 
                MonoString* CustomName = String_CreateString(instance, "", 0, 0);  
                SetPlayerName(HudControl, PlayerName, PrefixName, true, CustomName);
            }
        }

        old_ActorLinker_Update(instance);
        if (ActorLinker_ActorTypeDef(instance) == 0) {
            if (ActorLinker_IsHostPlayer(instance) == true) {
                espManager->tryAddMyPlayer(instance);
            } else {
                if (espManager->MyPlayer != NULL) {
                    if (ActorLinker_COM_PLAYERCAMP(espManager->MyPlayer) != ActorLinker_COM_PLAYERCAMP(instance)) {
                        ActorLinker_enemy->tryAddEnemy(instance);
                    }
                }
            }
        }
        if (ActorLinker_ActorTypeDef(instance) == 1) {
            void* ObjLinkerMT = *(void **)((uintptr_t)instance + Actorlk_ObjLinker);
            if (ObjLinkerMT != NULL){
                int ConfigIDMT = *(int *)((uintptr_t)ObjLinkerMT + ActorConfig_ConfigID);
                MonsterManager->tryAddEnemy(instance);
            }
        }
        if (autoflo && ActorLinker_ActorTypeDef(instance) == 4 && espManager->MyPlayer != NULL &&
            ActorLinker_IsHostCamp && ActorLinker_IsHostCamp(instance) &&
            ActorLinker_get_ObjID && ActorLinker_get_ObjID(instance) != 0) {
            int playerID = ActorLinker_get_playerId ? ActorLinker_get_playerId(instance) : -1;
            Vector3 myPos = ActorLinker_getPosition(espManager->MyPlayer);
            Vector3 flowerPos = ActorLinker_getPosition(instance);
            float distance = Vector3::Distance(myPos, flowerPos);
            if (playerID != 0 && playerID != 10001 && distance > 1.8f && distance < 12.0f && flowerPos.y < 0.3f) {
                Flo_Enemy->tryAddEnemy(instance);
            } else {
                Flo_Enemy->removeEnemyGivenObject(instance);
            }
        }
    }
}


void (*old_LActorRoot_UpdateLogic)(void *instance, int delta);
void LActorRoot_UpdateLogic(void *instance, int delta) {
    if (instance != NULL) {
        old_LActorRoot_UpdateLogic(instance, delta);
        if (espManager->MyPlayer != NULL) {
            if (LActorRoot_AsHero(instance) != NULL) {
                if (LActorRoot_COM_PLAYERCAMP(instance) == ActorLinker_COM_PLAYERCAMP(espManager->MyPlayer)) {
                    espManager->tryAddEnemy(instance);
                }
                Lactor = instance;
                ActorLK = espManager->MyPlayer;
                if (Lactor && ActorLK && LActorRoot_get_ObjID && ActorLinker_get_ObjID) {
                    if (LActorRoot_get_ObjID(Lactor) == ActorLinker_get_ObjID(ActorLK)) Lmyactor = instance;
                }
            }
        }
    }
}

// show cd
void DrawSkillCD(ImDrawList* draw, ImVec2 position, float size, int cd, int skillIndex, int skillId) {
    float radius = size / 2.0f;
    float fontSize = radius * 1.9f;

    ImU32 fillColor;
    ImU32 borderColor = IM_COL32(137, 218, 241, 255);
    ImU32 textColor = IM_COL32(255, 255, 255, 255);  

    // Màu nền theo trạng thái chiêu
    if (cd > 0) {
        fillColor = IM_COL32(0, 0, 0, 255); // Đang hồi chiêu
    } else {
        if (skillIndex == 4 || skillIndex == 5 || skillIndex == 6) {
            id<MTLTexture> skillTexture = [skillTextures objectForKey:@(skillId + 10000000)];
            if (skillTexture) {
                float radiusIcon = radius * 0.88f;
                ImVec2 pMin(position.x - radiusIcon, position.y - radiusIcon);
                ImVec2 pMax(position.x + radiusIcon, position.y + radiusIcon);
                draw->AddImageRounded((__bridge ImTextureID)skillTexture, pMin, pMax, ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f), IM_COL32(255, 255, 255, 255), radius, ImDrawCornerFlags_All);
                draw->AddCircle(position, radius, borderColor, 64, 0.1f);
                return;
            }
        }
        switch (skillIndex) {
            case 1:
            case 2:
            case 3:
                fillColor = IM_COL32(255, 163, 93, 255); // rgba(255, 163, 93, 1)
                break;            
            case 4:
                fillColor = IM_COL32(23, 167, 4, 255); // rgba(23, 167, 4, 1)
                break;
            case 5:
                fillColor = IM_COL32(86, 19, 148, 255); // rgba(86, 19, 148, 1)
                break;
            case 6:
                fillColor = IM_COL32(0, 215, 208, 255); // rgba(0, 215, 208, 1)
                break;
            default:
                fillColor = IM_COL32(255, 255, 255, 255);   
            break;
        }
    }

    draw->AddCircleFilled(position, radius, fillColor);
    draw->AddCircle(position, radius, borderColor, 64, 0.1f); 
    ImFont* font = ImGui::GetFont();

    if (cd > 0 && cd < 10) {
        std::string skill_cd = std::to_string(cd);
        ImVec2 textSize = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f, skill_cd.c_str());
        ImVec2 textPos = ImVec2(position.x - textSize.x * 0.5f, position.y - textSize.y * 0.5f);
        draw->AddText(font, fontSize, textPos, textColor, skill_cd.c_str());
    }
}
