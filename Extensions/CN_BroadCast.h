void* (*_UpdateLogic)(void* instance, int inPlayerID);
void* UpdateLogic(void* instance, int inPlayerID) {
    if (instance != NULL) {
        ulAccountUid = *(long long *)((uintptr_t)instance + UL_ulAccountUid);
    }
    return _UpdateLogic(instance, inPlayerID);
}

void* (*_GetAllPlayers)(void* instance, int delta);
void* GetAllPlayers(void* instance, int delta) {
    void* GetPlayer = _GetAllPlayers(instance, delta);
    if (GetPlayer != NULL) {
        long long playerUID = *(long long *)((uint64_t)GetPlayer + UL_PlayerUId);
        if (playerUID == ulAccountUid) {
            *(int *)((uint64_t)GetPlayer + UL_broadcastID) = TypeKill;
            *(int *)((uint64_t)GetPlayer + UL_PersonalButtonID) = ButtonID;
            *(int *)((uint64_t)GetPlayer + UL_usingSoldierSkinID) = SoldierID;
        }
    }
    return GetPlayer;
}

const int SoldierSkinIDs[] = {93000, 93001, 93002, 93003};
const char* SoldierSkinNames[] = {"[Mặc Định]", "[Thám Tử]", "[Yêu Tinh]", "[Cinnamon Dessert]"};
void Skinsoldier() {
    if (ImGui::Combo("Trang Phục Lính", &Skinminion, SoldierSkinNames, IM_ARRAYSIZE(SoldierSkinNames))) {
        SoldierID = SoldierSkinIDs[Skinminion];
    }
}

NSArray* loadJSONLink(NSString *urlString) {
    @try {
        NSURL *url = [NSURL URLWithString:urlString];
        if (!url) return nil;
        
        NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:nil];
        if (!data) return nil;
        
        NSError *error = nil;
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingFragmentsAllowed error:&error];
        return error ? nil : json;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

void LoadJS() {
    if (isLoadingJSON) return;
    isLoadingJSON = true;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *arrz = loadJSONLink(@"https://raw.githubusercontent.com/Bannei19/LoadJS/refs/heads/main/Button_Skill.json");
        NSArray *arr = loadJSONLink(@"https://raw.githubusercontent.com/Bannei19/LoadJS/refs/heads/main/Notify_Kill.json");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (arrz) {
                g_options1.clear();
                g_options1.reserve(arrz.count);
                for (NSDictionary *dictz in arrz) {
                    Option1 opt1;
                    opt1.name = [dictz[@"name"] UTF8String];
                    opt1.value = [dictz[@"value"] intValue];
                    opt1.ButtonID = [dictz[@"PersonalButtonID"] intValue];
                    g_options1.push_back(opt1);
                }
                items1_needUpdate = true; // Rebuild cache
            }

            if (arr) {
                options2.clear();
                options2.reserve(arr.count);
                for (NSDictionary *dict in arr) {
                    Option2 opt2;
                    opt2.name = [dict[@"name"] UTF8String];
                    opt2.value = [dict[@"value"] intValue];
                    opt2.TypeKill = [dict[@"broadcastID"] intValue];
                    options2.push_back(opt2);
                }
                items2_needUpdate = true; // Rebuild cache
            }
            
            isLoadingJSON = false;
        });
    });
}

struct Option1 {
    std::string name;
    int value;
    int ButtonID;
};

static std::vector<Option1> g_options1;
static std::vector<const char*> items1_cache;
static bool items1_needUpdate = true;

void UpdateButtonID(int heroId, int skinId) {
    currentHeroId = heroId;
    currentSkinId = skinId;
    if (selectedValue1 == 1) {
        int heroSkinId = currentHeroId * 100 + currentSkinId;
        for (size_t i = 2; i < g_options1.size(); i++) {
            if (g_options1[i].value == heroSkinId) {
                ButtonID = g_options1[i].ButtonID;
                return;
            }
        }
        ButtonID = 0;
    } else if (selectedValue1 < (int)g_options1.size()) {
        ButtonID = g_options1[selectedValue1].ButtonID;
    }
}

void DrawModButton() {
    if (g_options1.empty()) {
        ImGui::TextColored(ImVec4(1.0f, 0.8f, 0.0f, 1.0f), isLoadingJSON ? "Đang tải..." : "Lỗi tải dữ liệu");
        return;
    }
    
    // Only rebuild cache when data changes
    if (items1_needUpdate) {
        items1_cache.clear();
        items1_cache.reserve(g_options1.size());
        for (const auto &opt1 : g_options1) {
            items1_cache.push_back(opt1.name.c_str());
        }
        items1_needUpdate = false;
    }
    
    if (selectedValue1 >= (int)items1_cache.size()) selectedValue1 = 0;
    
    if (ImGui::Combo("Hiệu Ứng Nút", &selectedValue1, items1_cache.data(), (int)items1_cache.size())) {
        UpdateButtonID(currentHeroId, currentSkinId);
    }
}

struct Option2 {
    std::string name;
    int value;
    int TypeKill;
};

static std::vector<Option2> options2;
static std::vector<const char*> items2_cache;
static bool items2_needUpdate = true;

void UpdateTypeKill(int heroId, int skinId) {
    currentHeroId = heroId;
    currentSkinId = skinId;
    if (selectedValue2 == 1) {
        int heroSkinId = currentHeroId * 100 + currentSkinId;
        for (size_t i = 2; i < options2.size(); i++) {
            if (options2[i].value == heroSkinId) {
                TypeKill = options2[i].TypeKill;
                return;
            }
        }
        TypeKill = 0;
    } else if (selectedValue2 < (int)options2.size()) {
        TypeKill = options2[selectedValue2].TypeKill;
    }
}

void DrawModNotify() {
    if (options2.empty()) {
        ImGui::TextColored(ImVec4(1.0f, 0.8f, 0.0f, 1.0f), isLoadingJSON ? "Đang tải..." : "Lỗi tải dữ liệu");
        return;
    }
    
    // Only rebuild cache when data changes
    if (items2_needUpdate) {
        items2_cache.clear();
        items2_cache.reserve(options2.size());
        for (const auto &opt2 : options2) {
            items2_cache.push_back(opt2.name.c_str());
        }
        items2_needUpdate = false;
    }
    
    if (selectedValue2 >= (int)items2_cache.size()) selectedValue2 = 0;
    
    if (ImGui::Combo("Hiệu Ứng Hạ", &selectedValue2, items2_cache.data(), (int)items2_cache.size())) {
        UpdateTypeKill(currentHeroId, currentSkinId);
    }
}
