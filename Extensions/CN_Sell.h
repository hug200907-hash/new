int (*GetGameTime)(void *instance);
void *(*get_talentSystem)(void *instance);
int (*GetGoldCoinInBattle)(void *instance);
void (*SendBuyEquipFrameCommand)(void *instance, int equipID, bool InIsQuicklyBuy);
void (*SendSellEquipFrameCommand)(void *instance, int equipID);
void (*SendPlayerChoseEquipSkillCommand)(void *instance, int slot);
int (*GetEquipActiveSkillCD)(void *instance, int equipID);
int (*GetTalentCDTime)(void *instance, int _talentID);
void *(*LEquipComponent_GetEquips)(void *instance);
void *(*get_actorManager)();

void *CBattleSystem_instance;
void *LBattleLogic_instance;

uint16_t ItemID[6];
int solan = 0;
int goldcoin = 0;
bool giap = true;
bool bangsuong = true;
bool liem = true;
bool thuongkhung = true;
bool nhamthuan = true;
bool hercules = true;
int lastId = -1;
int stt = 0;
bool checktime = false;
bool doiitem = false;
bool fullslot = false;
bool muaitem = false;

struct EquipSkill
{
    int id;
    int cooldown;
    int index;
};

enum EquipID
{
    CauBangSuong = 1242, // Cầu Băng Sương
    ThuanNhamThach = 1340, // Thuẫn Nham Thạch
    ThuongKhungKiem = 1149, // Thương Khung Kiếm
    GiapHoiSinh = 1337, // Giáp Hồi Sinh
    LiemDoatMenh = 11271, // Liềm Đoạt Mệnh
    HerculesThinhNo = 1328, // Hercules Thịnh Nộ
    DaiDiaThanKhien = 16211, // Đại Địa Thần Khiên
    DaiDiaMaNhan = 16212, // Đại Địa Ma Nhãn
    DaiDiaThanToc = 16213, // Đại Địa Thần Tốc
    DaiDiaMoTroi = 16214, // Đại Địa Mở Trói
    DaiDiaHoiHuyet = 16, // Đại Địa Hồi Huyết
    LietHoaThanKhien = 16231, // Liệt Hỏa Thần Khiên
    LietHoaMaNhan = 16232, // Liệt Hỏa Ma Nhãn
    LietHoaThanToc = 16233, // Liệt Hỏa Thần Tốc
    LietHoaMoTroi = 16234, // Liệt Hỏa Mở Trói
    LietHoaHoiHuyet = 16235, // Liệt Hỏa Hồi Huyết
    CungTaMa = 1145, // Cung Tà Ma
    XaNhatCung = 1148 // Xạ Nhật Cung
};

struct ItemData
{
    int stt;
    int id;
    int cost;
    int sellPrice;
    int cd;
    int lastSold;
    int cdRemain;
    int index;
    int lastbuy;
    bool shouldBuy;
    int cdmax;
};

vector<ItemData> items = {
    {1, EquipID::GiapHoiSinh, 2400, 1440, 0, 0, 0, -1, 0, true, 150}, // Giáp hồi sinh
    {2, EquipID::CauBangSuong, 2200, 1320, 0, 0, 0, -1, 0, true, 75}, // Cầu băng sương
    {3, EquipID::LiemDoatMenh, 2000, 1200, 0, 0, 0, -1, 0, true, 120}, // Liềm đoạt mệnh
    {4, EquipID::ThuongKhungKiem, 2120, 1272, 0, 0, 0, -1, 0, true, 90}, // Thương khung kiếm
    {5, EquipID::ThuanNhamThach, 1980, 1188, 0, 0, 0, -1, 0, true, 60}, // Thuẫn Nham Thạch
    {6, EquipID::HerculesThinhNo, 2080, 1248, 0, 0, 0, -1, 0, true, 60}, // Hercules thịnh nộ
    {7, EquipID::CungTaMa, 2250, 1350, 0, 0, 0, -1, 0, true, 60}, // Cung Tà Ma
    {8, EquipID::XaNhatCung, 2000, 1200, 0, 0, 0, -1, 0, true, 60}, // Xạ Nhật Cung

};

struct ItemOption
{
    const char *name;
    ItemData item;
};

static const ItemOption itemOptions[] = {
    {"Giáp Hồi sinh", items[0]},
    {"Cầu Băng Sương", items[1]},
    {"Liềm Đoạt Mệnh", items[2]},
    {"Thương Khung Kiếm", items[3]},
    {"Thuẫn Nham Thạch", items[4]},
    {"Hercules Thịnh Nộ", items[5]},
    {"Cung Tà Ma", items[6]},
    {"Xạ Nhật Cung", items[7]}
};

const int ITEM_COUNT = sizeof(itemOptions) / sizeof(ItemOption);
const int COMBO_COUNT = 8;
static int selectedIndices[COMBO_COUNT] = {0, 1, 2, 3, 4, 5, 6, 7};
static bool isEnabled[COMBO_COUNT] = {true, true, true, true, true, true, true, true};

// ========== ANIMATION & SMOOTHING VARIABLES ==========
static float slotAnimProgress[COMBO_COUNT] = {0};
static float dragAnimScale = 1.0f;
static float previewAlpha = 0.0f;
const float ANIM_SPEED = 8.0f;

static inline float easeOutCubic(float t) {
    float f = t - 1.0f;
    return f * f * f + 1.0f;
}

static inline void UpdateAnimations(float deltaTime) {
    for (int i = 0; i < COMBO_COUNT; ++i) {
        slotAnimProgress[i] = ImMax(0.0f, slotAnimProgress[i] - deltaTime * ANIM_SPEED);
    }
    dragAnimScale += (1.0f - dragAnimScale) * deltaTime * ANIM_SPEED;
    previewAlpha = ImMax(0.0f, previewAlpha - deltaTime * 6.0f);
}

// ========== End ==========

void (*CBattleSystem_Update)(void *instance);
void _CBattleSystem_Update(void *instance)
{
    if (instance != NULL)
    {
        CBattleSystem_instance = instance;
    }
    CBattleSystem_Update(CBattleSystem_instance);
}

void* (*get_battleLogic)(void* instance);
void* _get_battleLogic(void* instance) {
    if (instance != NULL) {
        LBattleLogic_instance = get_battleLogic(instance);
        return LBattleLogic_instance;
    }
    return get_battleLogic(instance);
}

vector<ItemData> BuildSelectedItemsVector(vector<ItemData> &items, int selectedIndices[COMBO_COUNT], bool isEnabled[COMBO_COUNT])
{
    vector<ItemData> selectedItems;
    for (int i = 0; i < COMBO_COUNT; ++i)
    {
        if (isEnabled[i] && selectedIndices[i] >= 0)
        {
            int indexInItems = selectedIndices[i];
            if (indexInItems >= 0 && indexInItems < items.size())
            {
                selectedItems.push_back(items[indexInItems]);
            }
        }
    }
    return selectedItems;
}

static id<MTLTexture> TextureForItemIndex(int chisoitem)
{
    switch (chisoitem)
    {
        case 0: return ghm_texture;  
        case 1: return bs_texture;   
        case 2: return ldm_texture;  
        case 3: return tkk_texture;  
        case 4: return nt_texture;  
        case 5: return gt_texture;  
        case 6: return ctm_texture; 
        case 7: return xnc_texture;  
        default: return nil;
    }
}

static inline double thoigianhientai()
{
    return CACurrentMediaTime();
}

static double thoigianketthuc[COMBO_COUNT] = {0};
static int thoigianconlai[COMBO_COUNT]  = {0};

static inline void UI_ReportCooldownMs(int chisoitem, int thoigiangiay)
{
    if (chisoitem < 0 || chisoitem >= COMBO_COUNT) return;
    if (thoigiangiay <= 0) return;
    thoigianketthuc[chisoitem] = thoigianhientai() + (double)thoigiangiay / 1000.0;
}

static inline void UI_TickCooldownRuntime()
{
    double hien_tai = thoigianhientai();
    for (int i = 0; i < COMBO_COUNT; ++i)
    {
        double conlaisogiay = thoigianketthuc[i] - hien_tai;
        if (conlaisogiay > 0.0)
        {
            thoigianconlai[i] = (int)floor(conlaisogiay + 0.999);
        }
        else
        {
            thoigianconlai[i] = 0;
            thoigianketthuc[i] = 0.0;
        }
    }
}

static inline void UI_CooldownNotifyTick()
{
    UI_TickCooldownRuntime();
}

static std::string dinhdangtime(int giay)
{
    if (giay <= 0) return "";
    return std::to_string(giay);
}

static void DrawCooldownOverlay(ImDrawList* ve, const ImRect& khung, int thoigianconlai)
{
    if (thoigianconlai <= 0) return;

    ve->AddRectFilled(khung.Min, khung.Max, IM_COL32(0,0,0,140), 10.0f);

    std::string chuoi_time = dinhdangtime(thoigianconlai);
    ImFont* font_dung = ImGui::GetFont();
    float cochu = ImGui::GetFontSize() * 1.2f;

    ImVec2 size_chu = font_dung->CalcTextSizeA(cochu, FLT_MAX, 0.0f, chuoi_time.c_str());
    ImVec2 center((khung.Min.x + khung.Max.x) * 0.5f, (khung.Min.y + khung.Max.y) * 0.5f);
    ImVec2 vitriso(center.x - size_chu.x * 0.5f, center.y - size_chu.y * 0.5f);

    ve->AddText(font_dung, cochu, vitriso, IM_COL32(255,255,255,255), chuoi_time.c_str());
}

static bool hoanve0(const int* mang, int so_luong)
{
    std::vector<int> danh_dau(so_luong, 0);
    for (int i = 0; i < so_luong; ++i) {
        int v = mang[i];
        if (v < 0 || v >= so_luong) return false;
        if (danh_dau[v]) return false;
        danh_dau[v] = 1;
    }
    return true;
}

const char* GetItemName(int itemIndex)
{
    static const char* itemNames[] = {
        "Giáp Hồi Sinh",
        "Cầu Băng Sương",
        "Liềm Đoạt Mệnh",
        "Thương Khung Kiếm",
        "Thuẫn Nham Thạch",
        "Hercules Thịnh Nộ",
        "Cung Tà Ma",
        "Xạ Nhật Cung"
    };
    
    if (itemIndex >= 0 && itemIndex < 8) return itemNames[itemIndex];
    return "Unknown";
}

void ShowSequentialItemCombosWithCheckbox()
{
    ImGui::PushID("AutoSellUI");
    ImVec2 vitrikhung = ImGui::GetCursorScreenPos();
    float dorongkhung = ImGui::GetContentRegionAvail().x;
    if (dorongkhung > 480) dorongkhung = 480;

    ImGui::SetCursorScreenPos(vitrikhung);
    ImGui::BeginGroup();
    ImGui::SetWindowFontScale(1.3f);
    ImGui::Text("Thứ Tự Bán Đồ");
    ImGui::SetWindowFontScale(1.0f);
    ImGui::TextDisabled("Kéo-thả để thay đổi thứ tự ưu tiên");
    ImGui::EndGroup();
    vitrikhung.y += ImGui::GetTextLineHeightWithSpacing() * 2.2f;

    static bool loamacdinh = false;
    if (!loamacdinh)
    {
        NSArray* luuvitri = [[NSUserDefaults standardUserDefaults] arrayForKey:@"selectedItemIndices"];
        if (luuvitri && luuvitri.count == COMBO_COUNT)
        {
            for (int i = 0; i < COMBO_COUNT; ++i) selectedIndices[i] = [luuvitri[i] intValue];
            if (!hoanve0(selectedIndices, COMBO_COUNT)) {
                for (int i = 0; i < COMBO_COUNT; ++i) selectedIndices[i] = i;
            }
        }

        NSArray* luutrangthai = [[NSUserDefaults standardUserDefaults] arrayForKey:@"itemEnabledStates"];
        if (luutrangthai && luutrangthai.count == COMBO_COUNT)
        {
            for (int i = 0; i < COMBO_COUNT; ++i) isEnabled[i] = [luutrangthai[i] boolValue];
        }

        loamacdinh = true;
    }

    static double lastFrameTime = 0;
    double currentTime = ImGui::GetTime();
    float deltaTime = (lastFrameTime > 0) ? (float)(currentTime - lastFrameTime) : 0.016f;
    lastFrameTime = currentTime;
    UpdateAnimations(deltaTime);

    bool trangthaithaydoi = false;
    ImDrawList* ve = ImGui::GetWindowDrawList();

    // ====== LAYOUT: 8 ITEM / 1 HÀNG + TỰ CO ICON ĐỂ VỪA VÙNG ======
    const float lebentrong1 = 8.0f;
    float bankinh = 8.0f;

    const int soicontren1hang = 8;
    int max_per_row = soicontren1hang;
    int total_rows = (COMBO_COUNT + max_per_row - 1) / max_per_row;
    if (total_rows < 1) total_rows = 1;

    float khoangcach = 6.0f;

    float innerWidth = dorongkhung - lebentrong1 * 2.0f;
    if (innerWidth < 10.0f) innerWidth = dorongkhung;

    auto calcIconSize = [&](float spacing) -> float {
        return (innerWidth - (soicontren1hang - 1) * spacing) / (float)soicontren1hang;
    };

    float kichcoicon = calcIconSize(khoangcach);

    if (kichcoicon < 34.0f) { khoangcach = 4.0f; kichcoicon = calcIconSize(khoangcach); }
    if (kichcoicon < 30.0f) { khoangcach = 2.0f; kichcoicon = calcIconSize(khoangcach); }

    if (kichcoicon < 24.0f) kichcoicon = 24.0f;
    if (kichcoicon > 50.5f) kichcoicon = 50.5f;

    if (kichcoicon < 34.0f) bankinh = 6.0f;
    else bankinh = 8.0f;

    float rongluoiicon = soicontren1hang * kichcoicon + (soicontren1hang - 1) * khoangcach;
    float caoluoiicon = total_rows * kichcoicon + (total_rows - 1) * khoangcach;
    float caokhung = caoluoiicon + lebentrong1 * 2.0f;

    ImVec2 khung_min(vitrikhung.x, vitrikhung.y);
    ImVec2 khung_max(vitrikhung.x + dorongkhung, vitrikhung.y + caokhung);
    ImVec2 batdau_luoi(khung_min.x + lebentrong1, khung_min.y + lebentrong1);

    ve->AddRectFilled(khung_min, khung_max, IM_COL32(25, 25, 25, 200), 8.0f);
    ve->AddRect(khung_min, khung_max, IM_COL32(80, 80, 80, 100), 8.0f, 0, 1.0f);

    static int vitrinhanvao = -1;
    static bool nguoidungkeo = false;
    static int icon_tray = -1;
    static ImVec2 lastMousePos = ImVec2(0, 0);

    ImVec2 cursor_draw = ImGui::GetMousePos();

    auto veslot = [&](int vi_tri)
    {
        int chisoitem = selectedIndices[vi_tri];
        bool &dang_bat = isEnabled[vi_tri];

        ImGui::PushID(vi_tri);

        ImVec2 p = ImGui::GetCursorScreenPos();
        ImRect khung(p, ImVec2(p.x + kichcoicon, p.y + kichcoicon));

        ImGui::InvisibleButton("##icon", ImVec2(kichcoicon, kichcoicon));
        bool hovered = ImGui::IsItemHovered();

        if (ImGui::IsItemActivated()) {
            vitrinhanvao = vi_tri;
            nguoidungkeo = false;
        }

        if (ImGui::IsItemActive() && vitrinhanvao == vi_tri) {
            if (ImGui::IsMouseDragging(0, 5.0f)) {
                nguoidungkeo = true;
                icon_tray = vi_tri;
                dragAnimScale = 0.85f;
            }
        }

        if (ImGui::IsItemDeactivated() && vitrinhanvao == vi_tri) {
            if (!nguoidungkeo) {
                dang_bat = !dang_bat;
                trangthaithaydoi = true;
                slotAnimProgress[vi_tri] = 1.0f;
            }
            vitrinhanvao = -1;
            nguoidungkeo = false;
            icon_tray = -1;
            dragAnimScale = 1.0f;
        }

        if (ImGui::BeginDragDropSource(ImGuiDragDropFlags_SourceAllowNullID | ImGuiDragDropFlags_SourceNoPreviewTooltip))
        {
            int du_lieu = vi_tri;
            ImGui::SetDragDropPayload("##BANDO_POS", &du_lieu, sizeof(int));
            ImGui::EndDragDropSource();
        }

        if (ImGui::BeginDragDropTarget())
        {
            if (const ImGuiPayload* payload = ImGui::AcceptDragDropPayload("##BANDO_POS"))
            {
                int vitringuon = *(const int*)payload->Data;
                if (vitringuon >= 0 && vitringuon < COMBO_COUNT && vitringuon != vi_tri)
                {
                    std::swap(selectedIndices[vitringuon], selectedIndices[vi_tri]);
                    std::swap(isEnabled[vitringuon], isEnabled[vi_tri]);
                    slotAnimProgress[vitringuon] = 1.0f;
                    slotAnimProgress[vi_tri] = 1.0f;
                    trangthaithaydoi = true;
                }
            }
            ImGui::EndDragDropTarget();
        }

        id<MTLTexture> tex = TextureForItemIndex(chisoitem);
        int alpha_icon = dang_bat ? 255 : 100;
        ImU32 maunen = dang_bat ? IM_COL32(80, 80, 80, 255) : IM_COL32(40, 40, 40, 255);

        float animScale = 1.0f + slotAnimProgress[vi_tri] * 0.08f;
        float hoverScale = hovered ? 1.05f : 1.0f;
        float finalScale = animScale * hoverScale;

        ImVec2 center = ImVec2((khung.Min.x + khung.Max.x) * 0.5f, (khung.Min.y + khung.Max.y) * 0.5f);
        float halfSize = kichcoicon * 0.5f * finalScale;
        ImVec2 scaledMin(center.x - halfSize, center.y - halfSize);
        ImVec2 scaledMax(center.x + halfSize, center.y + halfSize);

        ve->AddRectFilled(scaledMin, scaledMax, maunen, bankinh);

        if (tex) {
            ve->AddImageRounded((ImTextureID)(__bridge void*)tex,  scaledMin, scaledMax,
                                ImVec2(0,0), ImVec2(1,1),
                                IM_COL32(255, 255, 255, alpha_icon), bankinh);
        } else {
            ve->AddRectFilled(scaledMin, scaledMax, IM_COL32(100, 100, 120, alpha_icon), bankinh);
        }

        ImU32 mauborder = dang_bat ? IM_COL32(220, 220, 220, 255) : IM_COL32(80, 80, 80, 150);
        float dodayline = dang_bat ? 1.5f : 1.0f;
        ve->AddRect(scaledMin, scaledMax, mauborder, bankinh, 0, dodayline);

        // Thêm chấm tròn chỉ thị trạng thái
        ImVec2 dot_pos(scaledMin.x + 5, scaledMin.y + 5);
        ImU32 dot_color = dang_bat ? IM_COL32(120, 255, 120, 255) : IM_COL32(255, 100, 100, 200);
        ve->AddCircleFilled(dot_pos, 3.0f, dot_color);
        ve->AddCircle(dot_pos, 3.0f, IM_COL32(0,0,0,100), 12, 0.5f);

        if (chisoitem >= 0 && chisoitem < COMBO_COUNT)
        {
            int cd_con = thoigianconlai[chisoitem];
            DrawCooldownOverlay(ve, ImRect(scaledMin, scaledMax), cd_con);
        }

        ImGui::PopID();
    };

    int index = 0;

    for (int row = 0; row < total_rows; ++row)
    {
        int remaining = COMBO_COUNT - index;
        int icons_in_row = ImMin(max_per_row, remaining);
        float row_width = icons_in_row * kichcoicon + (icons_in_row - 1) * khoangcach;

        float offset_x = (dorongkhung - row_width) * 0.5f;
        if (offset_x < lebentrong1) offset_x = lebentrong1;

        float y = batdau_luoi.y + row * (kichcoicon + khoangcach);

        for (int col = 0; col < icons_in_row; ++col)
        {
            ImVec2 pos(khung_min.x + offset_x + col * (kichcoicon + khoangcach), y);
            ImGui::SetCursorScreenPos(pos);
            veslot(index);
            index++;
        }
    }

    if (icon_tray >= 0 && ImGui::IsMouseDragging(0))
    {
        int chisoitem = selectedIndices[icon_tray];
        bool &dang_bat = isEnabled[icon_tray];

        id<MTLTexture> tex = TextureForItemIndex(chisoitem);
        const char* tenitem = GetItemName(chisoitem);
        const char* trangthai = dang_bat ? "ĐÃ KÍCH HOẠT" : "CHƯA KÍCH HOẠT";
        ImU32 mautrangthai = dang_bat ? IM_COL32(120, 255, 160, 255) : IM_COL32(220, 100, 100, 255);

        previewAlpha = ImMin(1.0f, previewAlpha + deltaTime * 10.0f);

        float previewSize = (35.0f);
        float spacing = (8.0f);

        ImVec2 preview_pos(cursor_draw.x - previewSize * 0.5f - 8, cursor_draw.y - previewSize * 0.5f - 8);

        float text_width = ImGui::CalcTextSize(tenitem).x;
        float trangthai_width = ImGui::CalcTextSize(trangthai).x;
        float max_text_width = ImMax(text_width, trangthai_width);

        float total_width = previewSize + spacing + max_text_width + (12.0f);
        float total_height = previewSize + (4.0f);

        ImVec2 bg_min(preview_pos.x - 6, preview_pos.y - 6);
        ImVec2 bg_max(preview_pos.x + total_width + 6, preview_pos.y + total_height + 6);

        int alpha_preview = (int)(previewAlpha * 240.0f);
        ve->AddRectFilled(bg_min, bg_max, IM_COL32(35, 35, 35, alpha_preview), 8.0f);
        ve->AddRect(bg_min, bg_max, IM_COL32(120, 120, 120, (int)(previewAlpha * 200.0f)), 8.0f, 0, 1.0f);

        ImVec2 icon_min = preview_pos;
        ImVec2 icon_max(preview_pos.x + previewSize, preview_pos.y + previewSize);

        ImU32 maunen = dang_bat ? IM_COL32(80, 80, 80, 220) : IM_COL32(40, 40, 40, 180);
        ve->AddRectFilled(icon_min, icon_max, maunen, 6.0f);

        if (tex) ve->AddImageRounded((ImTextureID)(__bridge void*)tex, icon_min, icon_max,
                                     ImVec2(0,0), ImVec2(1,1),
                                     IM_COL32(255, 255, 255, (int)(previewAlpha * 220.0f)), 6.0f);

        ImU32 mauborder = dang_bat ? IM_COL32(255, 255, 255, (int)(previewAlpha * 255.0f))
                                  : IM_COL32(120, 120, 120, (int)(previewAlpha * 200.0f));
        ve->AddRect(icon_min, icon_max, mauborder, 6.0f, 0, 2.0f);

        float text_x = preview_pos.x + previewSize + spacing;
        float text_y = preview_pos.y + (3.0f);

        ImU32 textColor = IM_COL32(220, 220, 220, (int)(previewAlpha * 255.0f));
        ImU32 statusColor = IM_COL32(
            (int)(mautrangthai >> 0 & 0xFF),
            (int)(mautrangthai >> 8 & 0xFF),
            (int)(mautrangthai >> 16 & 0xFF),
            (int)(previewAlpha * ((mautrangthai >> 24 & 0xFF)))
        );

        ImGui::PushFont(ImGui::GetIO().Fonts->Fonts[0]);

        ve->AddText(ImVec2(text_x, text_y), textColor, tenitem);
        ve->AddText(ImVec2(text_x, text_y + (18)), statusColor, trangthai);

        ImGui::PopFont();
    }

    lastMousePos = cursor_draw;
    ImGui::SetCursorScreenPos(ImVec2(khung_min.x, khung_max.y + 12.0f));

    if (trangthaithaydoi)
    {
        NSMutableArray* arr_vitri = [NSMutableArray arrayWithCapacity:COMBO_COUNT];
        for (int i = 0; i < COMBO_COUNT; ++i) [arr_vitri addObject:@(selectedIndices[i])];
        [[NSUserDefaults standardUserDefaults] setObject:arr_vitri forKey:@"selectedItemIndices"];

        NSMutableArray* arr_battat = [NSMutableArray arrayWithCapacity:COMBO_COUNT];
        for (int i = 0; i < COMBO_COUNT; ++i) [arr_battat addObject:@(isEnabled[i])];
        [[NSUserDefaults standardUserDefaults] setObject:arr_battat forKey:@"itemEnabledStates"];

        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    ImGui::PopID();
}


void HandleAuto(ImDrawList *draw)
{
    if (!get_actorManager || !GetGameTime || !get_talentSystem || !SendBuyEquipFrameCommand) return;
    if (CBattleSystem_instance != NULL && LBattleLogic_instance != NULL)
    {
        int ingame = *(bool *)((uint64_t)CBattleSystem_instance + DD_m_isInBattle);

        if (ingame)
        {
            void* myActorLinker = espManager->MyPlayer;
            void* myLactorRoot = Lmyactor;

            if (myActorLinker != NULL && myLactorRoot != NULL)
            {
                int currentTimer = 0;
                
                void* heroWrapper = LActorRoot_AsHero(myLactorRoot);
                if (heroWrapper)
                {
                    void *CommunicateAgent = *(void **)((uintptr_t)heroWrapper + DD_CommunicateAgentCtrl);
                    if (CommunicateAgent)
                    {
                        currentTimer = GetGameTime(CommunicateAgent);
                    }
                }

                void *SkillControl = *(void **)((uintptr_t)myLactorRoot + DD_SkillControl);
                void *EquipComponent = *(void **)((uint64_t)myLactorRoot + DD_EquipComponent);
                void *EquipLinkerComp = *(void **)((uint64_t)myActorLinker + DD_EquipLinkerComp);
                void *CBattleEquipSystem = *(void **)((uint64_t)CBattleSystem_instance + DD_k__BackingField);
                                
                if (EquipComponent != NULL && EquipLinkerComp != NULL && SkillControl != NULL && CBattleEquipSystem != NULL)
                {
                    void *TalentSystem = get_talentSystem(SkillControl);
                    if (TalentSystem != NULL)
                    {
                        int cdCauBangSuong = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::CauBangSuong); 
                        int cdThuanNhamThach = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::ThuanNhamThach); 
                        int cdThuongKhungKiem = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::ThuongKhungKiem);
                        int cdDaiDiaThanKhien = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::DaiDiaThanKhien); 
                        int cdDaiDiaMaNhan = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::DaiDiaMaNhan); 
                        int cdDaiDiaThanToc = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::DaiDiaThanToc); 
                        int cdDaiDiaMoTroi = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::DaiDiaMoTroi); 
                        int cdDaiDiaHoiHuyet = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::DaiDiaHoiHuyet); 
                        int cdLietHoaThanKhien = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::LietHoaThanKhien); 
                        int cdLietHoaMaNhan = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::LietHoaMaNhan); 
                        int cdLietHoaThanToc = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::LietHoaThanToc); 
                        int cdLietHoaMoTroi = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::LietHoaMoTroi); 
                        int cdLietHoaHoiHuyet = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::LietHoaHoiHuyet); 
                        int cdCungTaMa = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::CungTaMa); 
                        int cdXaNhatCung = GetEquipActiveSkillCD(EquipLinkerComp, EquipID::XaNhatCung); 
                        int cdGiapHoiSinh = GetTalentCDTime(TalentSystem, 91337); 
                        int cdLiemDoatMenh = GetTalentCDTime(TalentSystem, 911271); 
                        int cdHerculesThinhNo = GetTalentCDTime(TalentSystem, 91328);

                        UI_TickCooldownRuntime();
                        UI_ReportCooldownMs(0, cdGiapHoiSinh);
                        UI_ReportCooldownMs(1, cdCauBangSuong);
                        UI_ReportCooldownMs(2, cdLiemDoatMenh);
                        UI_ReportCooldownMs(3, cdThuongKhungKiem);
                        UI_ReportCooldownMs(4, cdThuanNhamThach);
                        UI_ReportCooldownMs(5, cdHerculesThinhNo);
                        UI_ReportCooldownMs(6, cdCungTaMa);
                        UI_ReportCooldownMs(7, cdXaNhatCung);

                        int DaiDiaThanKhien_index = -1;
                        int DaiDiaMaNhan_index = -1;
                        int DaiDiaThanToc_index = -1;
                        int DaiDiaMoTroi_index = -1;
                        int DaiDiaHoiHuyet_index = -1;
                        int LietHoaThanKhien_index = -1;
                        int LietHoaMaNhan_index = -1;
                        int LietHoaThanToc_index = -1;
                        int LietHoaMoTroi_index = -1;
                        int LietHoaHoiHuyet_index = -1;
                        int CungTaMa_index = -1;
                        int XaNhatCung_index = -1;

                        void* EquipArray = *(void**)((uint64_t)EquipComponent + 0x48);
                        if (EquipArray != NULL)
                        {
                            uint64_t baseData = (uint64_t)EquipArray + 0x18;
                            for (int i = 0; i < 6; i++)
                            {
                                uint16_t currentID = *(uint16_t*)(baseData + (i * 12));
                                ItemID[i] = currentID;
                            }
                        }

                        bool haveitem[8] = {false, false, false, false, false, false, false, false};
                        for (int i = 0; i < 6; i++)
                        {
                            if (ItemID[i] == EquipID::GiapHoiSinh)
                            {
                                items[0].index = i;
                                haveitem[0] = true;
                                items[0].cdRemain = (int)ceil(cdGiapHoiSinh / 1000 - 1) > 0 ? (int)ceil(cdGiapHoiSinh / 1000 - 1) : 0;
                                items[0].lastSold = currentTimer;
                            }
                            else if (ItemID[i] == EquipID::CauBangSuong)
                            {
                                items[1].index = i;
                                haveitem[1] = true;
                                items[1].cdRemain = (int)ceil(cdCauBangSuong / 1000 - 1) > 0 ? (int)ceil(cdCauBangSuong / 1000 - 1) : 0;
                                items[1].lastSold = currentTimer;
                            }
                            else if (ItemID[i] == EquipID::LiemDoatMenh)
                            {
                                items[2].index = i;
                                haveitem[2] = true;
                                items[2].cdRemain = (int)ceil(cdLiemDoatMenh / 1000 - 1) > 0 ? (int)ceil(cdLiemDoatMenh / 1000 - 1) : 0;
                                items[2].lastSold = currentTimer;
                            }
                            else if (ItemID[i] == EquipID::ThuongKhungKiem)
                            {
                                items[3].index = i;
                                haveitem[3] = true;
                                items[3].cdRemain = (int)ceil(cdThuongKhungKiem / 1000 - 1) > 0 ? (int)ceil(cdThuongKhungKiem / 1000 - 1) : 0;
                                items[3].lastSold = currentTimer;
                            }
                            else if (ItemID[i] == EquipID::ThuanNhamThach)
                            {
                                items[4].index = i;
                                haveitem[4] = true;
                                items[4].cdRemain = (int)ceil(cdThuanNhamThach / 1000 - 1) > 0 ? (int)ceil(cdThuanNhamThach / 1000 - 1) : 0;
                                items[4].lastSold = currentTimer;
                            }
                            else if (ItemID[i] == EquipID::HerculesThinhNo)
                            {
                                items[5].index = i;
                                haveitem[5] = true;
                                items[5].cdRemain = (int)ceil(cdHerculesThinhNo / 1000 - 1) > 0 ? (int)ceil(cdHerculesThinhNo / 1000 - 1) : 0;
                                items[5].lastSold = currentTimer;
                            }
                            else if (ItemID[i] == EquipID::CungTaMa)
                            {
                                CungTaMa_index = i;
                                items[6].index = i;
                                haveitem[6] = true;
                                items[6].cdRemain = max(0, (int)ceil(cdCungTaMa / 1000 - 1));
                                items[6].lastSold = currentTimer;
                            }
                            else if (ItemID[i] == EquipID::XaNhatCung)
                            {
                                XaNhatCung_index = i;
                                items[7].index = i;
                                haveitem[7] = true;
                                items[7].cdRemain = max(0, (int)ceil(cdXaNhatCung / 1000 - 1));
                                items[7].lastSold = currentTimer;
                            }
                            else if (ItemID[i] == EquipID::DaiDiaThanKhien)
                            {
                                DaiDiaThanKhien_index = i;
                            }
                            else if (ItemID[i] == EquipID::DaiDiaMaNhan)
                            {
                                DaiDiaMaNhan_index = i;
                            }
                            else if (ItemID[i] == EquipID::DaiDiaThanToc)
                            {
                                DaiDiaThanToc_index = i;
                            }
                            else if (ItemID[i] == EquipID::DaiDiaMoTroi)
                            {
                                DaiDiaMoTroi_index = i;
                            }
                            else if (ItemID[i] == EquipID::DaiDiaHoiHuyet)
                            {
                                DaiDiaHoiHuyet_index = i;
                            }
                            else if (ItemID[i] == EquipID::LietHoaThanKhien)
                            {
                                LietHoaThanKhien_index = i;
                            }
                            else if (ItemID[i] == EquipID::LietHoaMaNhan)
                            {
                                LietHoaMaNhan_index = i;
                            }
                            else if (ItemID[i] == EquipID::LietHoaThanToc)
                            {
                                LietHoaThanToc_index = i;
                            }
                            else if (ItemID[i] == EquipID::LietHoaMoTroi)
                            {
                                LietHoaMoTroi_index = i;
                            }
                            else if (ItemID[i] == EquipID::LietHoaHoiHuyet)
                            {
                                LietHoaHoiHuyet_index = i;
                            }
                        }

                        if (!haveitem[0])
                        {
                            items[0].index = -1;
                        }
                        if (!haveitem[1])
                        {
                            items[1].index = -1;
                        }
                        if (!haveitem[2])
                        {
                            items[2].index = -1;
                        }
                        if (!haveitem[3])
                        {
                            items[3].index = -1;
                        }
                        if (!haveitem[4])
                        {
                            items[4].index = -1;
                        }
                        if (!haveitem[5])
                        {
                            items[5].index = -1;
                        }
                        if (!haveitem[6])
                        {
                            items[6].index = -1;
                        }
                        if (!haveitem[7])
                        {
                            items[7].index = -1;
                        }

                        unordered_map<int, EquipSkill> equipSkillMap = {
                            {EquipID::CauBangSuong, {EquipID::CauBangSuong, cdCauBangSuong, items[1].index}},
                            {EquipID::ThuongKhungKiem, {EquipID::ThuongKhungKiem, cdThuongKhungKiem, items[3].index}},
                            {EquipID::ThuanNhamThach, {EquipID::ThuanNhamThach, cdThuanNhamThach, items[4].index}},
                            {EquipID::DaiDiaThanKhien, {EquipID::DaiDiaThanKhien, cdDaiDiaThanKhien, DaiDiaThanKhien_index}},
                            {EquipID::DaiDiaMaNhan, {EquipID::DaiDiaMaNhan, cdDaiDiaMaNhan, DaiDiaMaNhan_index}},
                            {EquipID::DaiDiaThanToc, {EquipID::DaiDiaThanToc, cdDaiDiaThanToc, DaiDiaThanToc_index}},
                            {EquipID::DaiDiaMoTroi, {EquipID::DaiDiaMoTroi, cdDaiDiaMoTroi, DaiDiaMoTroi_index}},
                            {EquipID::DaiDiaHoiHuyet, {EquipID::DaiDiaHoiHuyet, cdDaiDiaHoiHuyet, DaiDiaHoiHuyet_index}},
                            {EquipID::LietHoaThanKhien, {EquipID::LietHoaThanKhien, cdLietHoaThanKhien, LietHoaThanKhien_index}},
                            {EquipID::LietHoaMaNhan, {EquipID::LietHoaMaNhan, cdLietHoaMaNhan, LietHoaMaNhan_index}},
                            {EquipID::LietHoaThanToc, {EquipID::LietHoaThanToc, cdLietHoaThanToc, LietHoaThanToc_index}},
                            {EquipID::LietHoaMoTroi, {EquipID::LietHoaMoTroi, cdLietHoaMoTroi, LietHoaMoTroi_index}},
                            {EquipID::LietHoaHoiHuyet, {EquipID::LietHoaHoiHuyet, cdLietHoaHoiHuyet, LietHoaHoiHuyet_index}},
                            {EquipID::CungTaMa, {EquipID::CungTaMa, cdCungTaMa, CungTaMa_index}},
                            {EquipID::XaNhatCung, {EquipID::XaNhatCung, cdXaNhatCung, XaNhatCung_index}},
                        };

                        int goldcoin = 0;
                        void *ValuePropertyComponent = *(void **)((uint64_t)myLactorRoot + LActorRoot_ValueComponent);
                        
                        if (ValuePropertyComponent)
                        {
                            goldcoin = GetGoldCoinInBattle(ValuePropertyComponent);
                        }

                        bool check6 = false;
                        if (fullslot)
                        {
                            for (int i = 0; i < 6; i++)
                            {
                                if (ItemID[i] == 0)
                                {
                                    check6 = true;
                                    break;
                                }
                            }
                        }
                        
                        if (muaitem && !check6)
                        {
                            auto selectedItems = BuildSelectedItemsVector(items, selectedIndices, isEnabled);
                            static int itembuy = 0;
                            bool isbuyed = false;
                            for (auto &owned : selectedItems)
                            {
                                if (isbuyed) break;
                                if (owned.index == -1) continue;
                                if (currentTimer - owned.lastSold >= owned.cdRemain) continue;
                                if (owned.cdRemain + 4 <= owned.cdmax && checktime) continue;

                                for (auto &item : selectedItems)
                                {
                                    if (isbuyed) break;
                                    if (item.index != -1) continue;
                                    if (currentTimer - item.lastSold < item.cdRemain) continue;
                                    if (currentTimer - item.lastbuy < 1) continue;

                                    int totalGold = goldcoin + owned.sellPrice;
                                    if (totalGold < item.cost) continue;
                                    SendSellEquipFrameCommand(CBattleEquipSystem, owned.index);
                                    owned.cd = currentTimer;
                                    switch (owned.stt)
                                    {
                                        case 1:
                                            if (solan < 1) {
                                                owned.cdRemain = max(0, (int)ceil(cdGiapHoiSinh / 1000 - 1));
                                                solan++;
                                            }
                                            break;
                                        case 2:
                                            owned.cdRemain = max(0, (int)ceil(cdCauBangSuong / 1000 - 1));
                                            break;
                                        case 3:
                                            owned.cdRemain = max(0, (int)ceil(cdLiemDoatMenh / 1000 - 1));
                                            break;
                                        case 4:
                                            owned.cdRemain = max(0, (int)ceil(cdThuongKhungKiem / 1000 - 1));
                                            break;
                                        case 5:
                                            owned.cdRemain = max(0, (int)ceil(cdThuanNhamThach / 1000 - 1));
                                            break;
                                        case 6:
                                            owned.cdRemain = max(0, (int)ceil(cdHerculesThinhNo / 1000 - 1));
                                            break;
                                        case 7:
                                            owned.cdRemain = max(0, (int)ceil(cdCungTaMa / 1000 - 1));
                                            break;
                                        case 8:
                                            owned.cdRemain = max(0, (int)ceil(cdXaNhatCung / 1000 - 1));
                                        break;
                                    }

                                    owned.lastSold = currentTimer;
                                    owned.index = -1;
                                    for (auto &realItem : items)
                                    {
                                        if (realItem.id == owned.id)
                                        {
                                            realItem.cd = currentTimer;
                                            realItem.cdRemain = owned.cdRemain;
                                            realItem.lastSold = currentTimer;
                                            realItem.index = -1;
                                            break;
                                        }
                                    }

                                    itembuy = item.id;
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        SendBuyEquipFrameCommand(CBattleEquipSystem, itembuy, false);
                                        for (auto &realItem : items)
                                        {
                                            if (realItem.id == itembuy)
                                            {
                                                realItem.lastbuy = currentTimer;
                                                realItem.cdRemain = 0;
                                                break;
                                            }
                                        }
                                    });

                                    goldcoin = totalGold - item.cost;
                                    isbuyed = true;
                                    break;
                                }
                            }
                        }

                        if (doiitem)
                        {
                            vector<EquipSkill> validEquipSkills;
                            for (const auto &entry : equipSkillMap)
                            {
                                const EquipSkill &equipSkill = entry.second;
                                if (equipSkill.index != -1 && equipSkill.cooldown == 0)
                                {
                                    validEquipSkills.push_back(equipSkill);
                                }
                            }

                            sort(validEquipSkills.begin(), validEquipSkills.end(), [](const EquipSkill &a, const EquipSkill &b) { return a.index < b.index; });
                            if (!validEquipSkills.empty() && lastId != validEquipSkills[0].id)
                            {
                                SendPlayerChoseEquipSkillCommand(CBattleEquipSystem, validEquipSkills[0].index);
                                lastId = validEquipSkills[0].id;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            items = {
                {1, EquipID::GiapHoiSinh, 2400, 1440, 0, 0, 0, -1, 0, true, 150}, // Giáp hồi sinh
                {2, EquipID::CauBangSuong, 2200, 1320, 0, 0, 0, -1, 0, true, 75}, // Cầu băng sương
                {3, EquipID::LiemDoatMenh, 2000, 1200, 0, 0, 0, -1, 0, true, 120}, // Liềm đoạt mệnh
                {4, EquipID::ThuongKhungKiem, 2120, 1272, 0, 0, 0, -1, 0, true, 90}, // Thương khung kiếm
                {5, EquipID::ThuanNhamThach, 1980, 1188, 0, 0, 0, -1, 0, true, 60}, //  thuẫn Nham thach
                {6, EquipID::HerculesThinhNo, 2080, 1248, 0, 0, 0, -1, 0, true, 60}, // Hercules thịnh nộ
                {7, EquipID::CungTaMa, 2250, 1350, 0, 0, 0, -1, 0, true, 60}, // huyết thương
                {8, EquipID::XaNhatCung, 2000, 1200, 0, 0, 0, -1, 0, true, 60}, // Thiên hạ đại kiếm
            };
            solan = 0;
            lastId = -1;
        }
    }
}