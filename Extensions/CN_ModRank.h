struct OriginalRankData {
    int rankScore = 0;
    int rankHistoryHighestScore = 0;
    int rankShowGrade = 0;
    int rankHistoryHighestShowGrade = 0;
    int rankSeasonHighestShowGrade = 0;
    int totalReachRankSTimes = 0;
    int rankClass = 0;
    int rankHistoryHighestClass = 0;
    int rankSeasonHighestClass = 0;
    int GameVipScore = 0;
    int GameVipLevel = 0;
    int goldCoin = 0;
    int diamond = 0;
    int dianquan = 0;
    bool dataLoaded = false;
};

static int customDianquan = 9999;
static int customGoldCoin = 9999999;
static int customDiamond = 9999999;

static OriginalRankData g_OriginalRankData;
void SaveOriginalRankData(void* CRoleInfo) {
    if (CRoleInfo && !g_OriginalRankData.dataLoaded) {
        g_OriginalRankData.rankScore = *(int*)((uint64_t)CRoleInfo + field_m_rankScore);
        g_OriginalRankData.rankHistoryHighestScore = *(int*)((uint64_t)CRoleInfo + field_m_rankHistoryHighestScore);
        g_OriginalRankData.rankShowGrade = *(uint8_t*)((uint64_t)CRoleInfo + field_m_rankShowGrade);
        g_OriginalRankData.rankHistoryHighestShowGrade = *(uint8_t*)((uint64_t)CRoleInfo + field_m_rankHistoryHighestShowGrade);
        g_OriginalRankData.rankSeasonHighestShowGrade = *(uint8_t*)((uint64_t)CRoleInfo + field_m_rankSeasonHighestShowGrade);
        g_OriginalRankData.totalReachRankSTimes = *(int*)((uint64_t)CRoleInfo + field_mTotalReachRankSTimes);
        g_OriginalRankData.rankClass = *(int*)((uint64_t)CRoleInfo + field_m_rankClass);
        g_OriginalRankData.rankHistoryHighestClass = *(int*)((uint64_t)CRoleInfo + field_m_rankHistoryHighestClass);
        g_OriginalRankData.rankSeasonHighestClass = *(int*)((uint64_t)CRoleInfo + field_m_rankSeasonHighestClass);
        g_OriginalRankData.GameVipScore = *(uint32_t*)((uint64_t)CRoleInfo + field_m_GameVipScore);
        g_OriginalRankData.GameVipLevel = *(uint8_t*)((uint64_t)CRoleInfo + field_m_GameVipLevel);
        g_OriginalRankData.goldCoin = *(int*)((uint64_t)CRoleInfo +field_m_goldCoin);
        g_OriginalRankData.diamond = *(int*)((uint64_t)CRoleInfo + field_m_diamond);
        g_OriginalRankData.dianquan = *(uint64_t*)((uint64_t)CRoleInfo + field_m_dianquan);
        
        g_OriginalRankData.dataLoaded = true;
    }
}

void RestoreOriginalRankData(void* CRoleInfo) {
    if (CRoleInfo && g_OriginalRankData.dataLoaded) {
        *(int*)((uint64_t)CRoleInfo + field_m_rankScore) = g_OriginalRankData.rankScore;
        *(int*)((uint64_t)CRoleInfo + field_m_rankHistoryHighestScore) = g_OriginalRankData.rankHistoryHighestScore;
        *(uint8_t*)((uint64_t)CRoleInfo +field_m_rankShowGrade) = g_OriginalRankData.rankShowGrade;
        *(uint8_t*)((uint64_t)CRoleInfo + field_m_rankHistoryHighestShowGrade) = g_OriginalRankData.rankHistoryHighestShowGrade;
        *(uint8_t*)((uint64_t)CRoleInfo + field_m_rankSeasonHighestShowGrade) = g_OriginalRankData.rankSeasonHighestShowGrade;
        *(int*)((uint64_t)CRoleInfo + field_mTotalReachRankSTimes) = g_OriginalRankData.totalReachRankSTimes;
        *(int*)((uint64_t)CRoleInfo + field_m_rankClass) = g_OriginalRankData.rankClass;
        *(int*)((uint64_t)CRoleInfo + field_m_rankHistoryHighestClass) = g_OriginalRankData.rankHistoryHighestClass;
        *(int*)((uint64_t)CRoleInfo + field_m_rankSeasonHighestClass) = g_OriginalRankData.rankSeasonHighestClass;
        *(uint32_t*)((uint64_t)CRoleInfo + field_m_GameVipScore) = g_OriginalRankData.GameVipScore;
        *(uint8_t*)((uint64_t)CRoleInfo + field_m_GameVipLevel) = g_OriginalRankData.GameVipLevel;
        *(int*)((uint64_t)CRoleInfo + field_m_goldCoin) = g_OriginalRankData.goldCoin;
        *(int*)((uint64_t)CRoleInfo + field_m_diamond) = g_OriginalRankData.diamond;
        *(uint64_t*)((uint64_t)CRoleInfo + field_m_dianquan) = g_OriginalRankData.dianquan;
    }
}

int rankType = 0;
const char* cucOptions[] = {
    "Mặc Định",        // 0
    "Top | Silver",    // 1
    "Top | Green",     // 2
    "Top | Blue",      // 3
    "Top | Purple",    // 4
    "Top | Red",       // 5
    "Top | Việt Nam"   // 6
};
void DrawtopTab1() {
    ImGui::Combo("##SelectedTypeTop", &rankType, cucOptions, IM_ARRAYSIZE(cucOptions));
}

// Struct rank setting
static int selectedRank = 0;
static int starCount = 0;

struct RankSetting {
    const char* name;
    int LitStar;
    int maxStar;
    int IDRank;
    int ThackDau;
};

RankSetting ranks[] = {
    { "  Cao Thủ", 0, 9, 16, 100},
    { "  Chiến Tướng", 50, 99, 27, 100},
    { "  Chiến Thần", 100, 147, 32, 100},
    { "  Thách Đấu", 148, 99999, 32, 1}
};

void DrawTopTab2() {
    if (ImGui::Combo("Chọn Rank", &selectedRank, [](void*, int i, const char** out){ *out = ranks[i].name; return true; }, NULL, IM_ARRAYSIZE(ranks))) {
        starCount = ranks[selectedRank].LitStar;
    }
}

void SetStarCount(int value) {
    starCount = value;
    std::cout << "Số sao hiện tại: " << starCount << std::endl;
}


bool (*TryShowLegendRank)(void* instance, bool canShowProficiency, void* elementGo, void* playerData, int adCode, int rankNo, int medalType);
bool _TryShowLegendRank(void* instance, bool canShowProficiency, void* elementGo, void* playerData, int adCode, int rankNo, int medalType) {
    if(instance != NULL&& unlock2) {
        adCode = 505;// top vietnam
        rankNo = 2; // top 1,2,3.........
        medalType = rankType;
    }
    return TryShowLegendRank(instance, canShowProficiency, elementGo, playerData,adCode, rankNo,medalType);
}

bool (*IsShowLegendRankMode)(void* instance, void* levelContext);
bool _IsShowLegendRankMode(void* instance, void* levelContext) {
    if(instance != NULL && unlock2) {
        return true;
    }
    return IsShowLegendRankMode(instance, levelContext);
}

void* (*unpackTop)(void *instance,void* srcBuf,long cutVer);
void* _unpackTop(void *instance,void* srcBuf,long cutVer){
    if(instance != NULL && unlock2)
    {
        void * call = unpackTop(instance,srcBuf,cutVer);
        *(int *)((uintptr_t)instance + UL_dwIsTop) = 1; // cục vàng , 0 cục tím,xanh........       
        *(int*)((uintptr_t)instance + UL_dwAdCode) = 505; //top vietnam
        *(int*)((uintptr_t)instance + UL_dwRank) = 1; // vị trí hiện tại, ví dụ đang top 1,2,3 vùng miền vn
        *(int*)((uintptr_t)instance + UL_iTitleFlag) = 1;
        *(int*)((uintptr_t)instance + UL_iShowType) = 1;
        return call;
    }
    return unpackTop(instance,srcBuf,cutVer);
}

bool (*CanPlayerShowLegendRank)(void* instance, void* playerData, void* dataProvider, int targetCampId, bool isWarmBattle, void** actorMeta, int* adCode, int* rankNo, int* medalType);
bool _CanPlayerShowLegendRank(void* instance, void* playerData, void* dataProvider, int targetCampId, bool isWarmBattle, void** actorMeta, int* adCode, int* rankNo, int* medalType) {
    if(instance != NULL && unlock2) {
        void* VHostLogic = get_hostLogic();
        int playerID = 0;
        if(VHostLogic != NULL) {
            playerID = *(int*)((uintptr_t)VHostLogic + 0x10);
        }

        if(playerData != NULL) {
            int PlayerID = *(int*)((uintptr_t)playerData + 0x8);
            if(PlayerID == playerID) {
                return true;
            }
        }
    }
    return CanPlayerShowLegendRank(instance, playerData, dataProvider, targetCampId, isWarmBattle, actorMeta, adCode, rankNo, medalType);
}

// monoString *String_CreateString(const char *str) {
//   int length = (int)strlen(str);
//   int startIndex = 0;
//     monoString *(*String_CreateString)(void *instance, const char *value, int startIndex, int length) = (monoString * (*)(void *, const char *, int, int))GetRealOffset(0x3979EC4);
//     return String_CreateString(NULL, str, startIndex, length);
// }

void* (*_GetMasterRoleInfo)(void*);
void* GetMasterRoleInfo(void* instance) {
void* CRoleInfo = _GetMasterRoleInfo(instance);
    if (instance != NULL && CRoleInfo != NULL && unlock2) {
            
        // Số Sao 
        *(int*)((uint64_t)CRoleInfo + field_m_rankScore) = starCount; // m_rankScore
        *(int*)((uint64_t)CRoleInfo + field_m_rankHistoryHighestScore) = starCount; // m_rankHistoryHighestScore

        // Bậc Rank 
        *(uint8_t*)((uint64_t)CRoleInfo + field_m_rankShowGrade) = ranks[selectedRank].IDRank; // m_rankShowGrade
        *(uint8_t*)((uint64_t)CRoleInfo + field_m_rankHistoryHighestShowGrade) = ranks[selectedRank].IDRank; // m_rankHistoryHighestShowGrade
        *(uint8_t*)((uint64_t)CRoleInfo + field_m_rankSeasonHighestShowGrade) = ranks[selectedRank].IDRank; // m_rankSeasonHighestShowGrade

        // Top Thách Đấu 
        *(int*)((uint64_t)CRoleInfo + field_mTotalReachRankSTimes) = 32; // mTotalReachRankSTimes
        *(int*)((uint64_t)CRoleInfo + field_m_rankClass) = ranks[selectedRank].ThackDau; // m_rankClass
        *(int*)((uint64_t)CRoleInfo + field_m_rankHistoryHighestClass) = ranks[selectedRank].ThackDau; // m_rankHistoryHighestClass
        *(int*)((uint64_t)CRoleInfo + field_m_rankSeasonHighestClass) = ranks[selectedRank].ThackDau; // m_rankSeasonHighestClass

        // --- PHẦN VIP ---
        *(uint32_t*)((uint64_t)CRoleInfo + field_m_GameVipScore) = 999999; // private uint m_GameVipScore;
        *(uint8_t*)((uint64_t)CRoleInfo + field_m_GameVipLevel) = 10; // private uint m_GameVipLevel;

        *(uint64_t*)((uint64_t)CRoleInfo + field_m_dianquan) = customDianquan; // private ulong m_dianquan;
        *(uint32_t*)((uint64_t)CRoleInfo + field_m_goldCoin) = customGoldCoin; // private uint m_goldCoin;
        *(uint32_t*)((uint64_t)CRoleInfo + field_m_diamond) = customDiamond; // private uint m_diamond;
        // *(monoString**)((uint64_t)CRoleInfo + field_m_name) = (monoString*)String_CreateString(oxorany("BANNEI")); // private string m_name;
    }

    return CRoleInfo;
}

void* GetCurrentRankDetail(void* instance) {
    if (instance != NULL && unlock2) {
        void* rankdetail = _GetCurrentRankDetail(instance);
        if(rankdetail) {
        *(int*)((uint64_t)rankdetail + field_dwScore) = starCount;
        return rankdetail;
       }
    }
   return _GetCurrentRankDetail(instance);
}

bool (*get_Valid)(void* instance); // full cục
bool _get_Valid(void* instance)
{
if (instance != NULL && unlock2){
    return true;
}
return get_Valid(instance);
}

int (*GetLegendTitleAreaType)(int titleAdCode);
int _GetLegendTitleAreaType(int titleAdCode)
{
    if(unlock2) {
        return 3; // 3 cục vàng
    }
    return GetLegendTitleAreaType(titleAdCode);
}


void (*UpdateData)(void* instance, uint32_t adCode, uint32_t heroId, uint32_t ranking, uint32_t showType, uint32_t titleFlag);
void _UpdateData(void* instance,uint32_t adCode, uint32_t heroId, uint32_t ranking, uint32_t showType, uint32_t titleFlag)
{
    if(unlock2)
    {
    ranking   = 0;     // TOP 1
    showType  = 1;     // COM_LEGEND_TITLE_SHOW_TYPE_RANK
    titleFlag = 1;     // COM_LEGEND_TITLE_FLAG_NATION
    } 
       
    UpdateData(instance, adCode, heroId, ranking, showType, titleFlag);
}

int (*SetLegendTitleMedalImageNew)(void* medalImage, uint32_t titleFlag, bool vis);
int _SetLegendTitleMedalImageNew(void* medalImage, uint32_t titleFlag, bool vis)
{
    if (unlock2) {

        titleFlag = 1; // TOP
        return 1;
    }

    return SetLegendTitleMedalImageNew(medalImage, titleFlag, vis);
}

void (*SetLegendTitleCompleteNew)(void* medalImage, void* rankingText, void* titleText, void* titleCntText, uint32_t titleCode, uint32_t showType, uint32_t titleFlag, uint32_t heroId, uint32_t ranking, uint32_t titleCnt, bool hideGIS, bool vis, MonoString* normalTitle, MonoString* topTitle);
void _SetLegendTitleCompleteNew(void* medalImage, void* rankingText, void* titleText, void* titleCntText, uint32_t titleCode, uint32_t showType, uint32_t titleFlag, uint32_t heroId, uint32_t ranking, uint32_t titleCnt, bool hideGIS, bool vis, MonoString* normalTitle, MonoString* topTitle) {
    if (unlock2) {
        titleFlag = 1; // TOP
        titleCode = 505;
        ranking = 0; // top1
        showType  = 1;
    }
    SetLegendTitleCompleteNew(medalImage, rankingText, titleText, titleCntText, titleCode, showType, titleFlag, heroId, ranking, titleCnt, hideGIS, vis, normalTitle, topTitle);
}
