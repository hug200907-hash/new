// Class Update
struct EntityInfo {
    Vector3 myPos;
    Vector3 enemyPos;
    Vector3 moveForward;
    int currentSpeed;
    float DoLech;
    float Ranger;
};
EntityInfo EnemyTarget;

struct HeroWrapSkillData {
    int SkillId;
    int skillSlotCDMax;
    int skillLv;
    const char *skillIconPath;
    bool skillSlotUnlock;
    bool skillSlotReady;
    int Skill1SlotCD;
};

void* (*get_main)();
void (*set_fieldOfView)(void*, float);
Vector3 (*WorldToScreenPoint)(void*, Vector3);
Vector3 (*WorldToScreens)(void*, Vector3, int);
Vector3 (*ActorLinker_getPosition)(void *instance);
bool (*LObjWrapper_get_IsDeadState)(void *instance);
int (*ValuePropertyComponent_get_actorHp)(void *instance);
int (*ValuePropertyComponent_get_actorHpTotal)(void *instance);
int (*ActorLinker_ActorTypeDef)(void *instance);
int (*ActorLinker_COM_PLAYERCAMP)(void *instance);
bool (*ActorLinker_IsHostPlayer)(void *instance);
bool (*ActorLinker_IsHostCamp)(void *instance);
int (*LActorRoot_COM_PLAYERCAMP)(void *instance);
bool (*LActorRoot_IsEnemyCamp)(void *instance);
int (*LActorRoot_get_ObjID)(void *instance);
int (*ActorLinker_get_ObjID)(void *instance);
int (*ActorLinker_get_playerId)(void *instance);
void* (*LActorRoot_AsHero)(void *instance);
int (*get_speed)(void *instance);
void* (*LActorRoot_get_PlayerMovement)(void *instance);
bool (*ActorLinker_get_bVisible)(void *instance);
Vector2 (*GetMMFianlScreenPos)(void *instance);
Vector2 (*GetBMFianlScreenPos)(void *instance);
Vector2 (*get_mmFinalScreenSize)(void *instance);
Vector2 (*get_bmFinalScreenSize)(void *instance);
bool (*Is3V3Minimap)(void *instance);
int (*get_CurMapType)(void *instance);
bool (*IsNormal5v5mode)(void *instance);
HeroWrapSkillData (*LHeroWrapper_GetHeroWrapSkillData)(void *instance, int slot);
int (*GetCurSkillSlotType)(void *instance);
bool (*Reqskill)(void *ins);
bool (*Reqskill2)(void *ins, bool bForce);
MonoString* (*String_CreateString)(void *instance, const char *value, int startIndex, int length);
void* (*SetPlayerName)(void* instance, MonoString* playerName, MonoString* prefixName, bool isGuideLevel, MonoString* customName);
void* (*ActorLinker_AsHero)(void* instance);
int (*ValueLinkerComponent_get_actorHp)(void *instance);
int (*ValueLinkerComponent_get_actorHpTotal)(void *instance);
int (*ValueLinkerComponent_get_actorSoulLevel)(void *instance);
// Camera & ESP
static float camera = 0.6f; // Đổi tên từ Cameras
static float drone = 0.0f;  // Đổi tên từ Drones
static float defFov = 60.0f;
static bool Camxa = false;
static bool LockCam = false;
static bool Cam3nac = false;

// Hiển thị
static bool ShowHistory = false;

// Tab controls
static bool macrotab = false;
static bool bandotab = false;
static bool autobando = false;
static bool autobandobenphai = false;
static bool HoaPos = false;
// Florentino macro mode (ported from 131dotheme)
static int floMode = 1; // 1 = chiêu 1, 2 = chiêu 3, 3 = cả hai
static bool floShowFlower = true;
static bool floShowLine = true;
static bool minimapType = false;
static bool previousMinimapType = false;
static bool IgnoreInvisible = false;
static bool NumberESP = false;
static bool DistanceESP = false;
static bool HeroIconESP = false;
static bool Alert360 = false;

// Hack Map
static bool HackMap = false;
// Auto Skill
Vector3 CurrentPosition;
float Rangeskill0;
float Rangeskill1;
float Rangeskill2;
float Rangeskill3;
float Rangeskill4;
float Rangeskill5;
float Rangeskill6;
float Rangeskill9;
float Rangeskill13;
bool AutoPhuTro = false, AutoBocPha = false, AutoTrungTri = false;
bool TTBua = false, TTBosst = false, TTALL = false;
float MyHP = 0.0f, EnemyHP = 0.0f, MonsterHP = 0.0f;
void* Req0 = NULL, * Req1 = NULL, * Req2 = NULL, * Req3 = NULL, * Req4 = NULL, * Req5 = NULL, * Req6 = NULL, * Req9 = NULL, * Req13 = NULL;
// Bug Skill
static bool BugSkill = false;
static bool Showline = false;
// Unlockskin
static bool Unlockskin = false;
static bool UnlockEvo5 = false;
static bool LockSkinAo = false;
static bool FullSkin = false;
static bool enableBanList = false;
static const std::unordered_set<uint32_t> lockedSkins = {
10611, 10620, 10915, 11110,
11113, 11119, 11120, 11215,
13011,
13118, 13210, 13213, 13613, 13705, 13706, 14111, 15013, 15015, 15212,
16707, 19908, 52414, 54804,
59802, 59901,
};static int isWearComponent = -1;
static int iSkinID = 0;
static int iID = 0;
static int chType = 0;
void * selectedComp = NULL;
std::vector<std::pair<int, int>> compListData;
static int currentHeroId = 0;
static int currentSkinId = 0;
// Mod Rank
static bool unlock2 = false;
static int customSkinCount = 3000;
void* (*get_hostLogic)();
void* (*_GetCurrentRankDetail)(void*);
// Show CD
static bool ShowTimeCD = false;
static bool ShowCD = false;
// #define CD_Skill1 ENCRYPTOFFSET("0x40") // HeroWrapperData_heroWrapSkillData_2
// #define CD_Skill2 ENCRYPTOFFSET("0x60") // HeroWrapperData_heroWrapSkillData_3
// #define CD_Skill3 ENCRYPTOFFSET("0x80") // HeroWrapperData_heroWrapSkillData_4
// #define CD_SkillBoTro ENCRYPTOFFSET("0xC0") // HeroWrapperData_heroWrapSkillData_ex3
// mod broadcast
static long long ulAccountUid = 0;
static int Skinminion = 0;
static int SoldierID = 0;
static bool isLoadingJSON = false;
static int selectedValue1 = 1;
static int ButtonID = 0;
static int selectedValue2 = 1;
static int TypeKill = 0;
// aimbot & Esp
EntityManager* espManager = new EntityManager();
EntityManager* ActorLinker_enemy = new EntityManager();
EntityManager* MonsterManager = new EntityManager();
EntityManager* Flo_Enemy = new EntityManager();
void* MoveInstance = nullptr;
void (*StopInput)(void *instance);
void (*old_SendMoveDirection)(void *instance, Vector2 start, Vector2 end);

bool AimSkill = false, AimSkill1 = false, AimSkill2 = false, AimSkill3 = false, DrawAimLine = false;
int SkillSlot, AimType;
float KhoangCach = 0.0f, DoLechAim = 0.0f, GetDistanceEnemy = 0.0f;

bool ESPEnable = true, PlayerLine = false, PlayerBox = false, PlayerHeal = false, PlayerName = false, ShowMinimap = false;
bool isPlayerName = false;
bool BlockUpdate = false;
static bool isFliped = false;
static bool Trainningmode = false;
static bool isFirst = true;
static bool is3V3Minimap = false;
static bool isNormal5v5mode = false;
float MinimapScale;
float minimapRotation = 0.0f;
float iconScale = 1.0f;
float minimapOffsetX = 0.0f;
float minimapOffsetY = 0.0f;
float minimapCustomScale = 1.0f;
float MinimapCenterX;
float MinimapCenterY;
float BigmapCenterX;
float BigmapCenterY;
float Maxscale = 42.838f;
int MapType;
void* Lmyactor = NULL, * Lactor = NULL, * ActorLK = NULL;

// Khai báo các biến lưu Offset
uintptr_t LActorRoot_location, LActorRoot_forward, LActorRoot_ActorControl, LActorRoot_ValueComponent;
uintptr_t ActorLinker_ObjLinker, ActorConfig_ConfigID;
uintptr_t CD_Skill1, CD_Skill2, CD_Skill3, CD_SkillBoTro;
uintptr_t Sk_SlotType, Sk_skillIndicator, Sk_curindicatorDistance, Sk_useSkillDirection;
uintptr_t Actorlk_ValueComponent, Actorlk_ObjLinker;
uintptr_t UL_ulAccountUid, UL_PlayerUId, UL_broadcastID, UL_PersonalButtonID, UL_usingSoldierSkinID;
uintptr_t UL_mIsHideLegendTitleGIS, UL_mIsHideGameInfo, UL_mIsHideFightHistory, UL__intimacyInfoIsLock, UL__skinCnt;
uintptr_t UL_dwIsTop, UL_dwAdCode, UL_dwRank, UL_iTitleFlag, UL_iShowType;
uintptr_t field_m_rankScore, field_m_rankHistoryHighestScore, field_m_rankShowGrade, field_m_rankHistoryHighestShowGrade;
uintptr_t field_m_rankSeasonHighestShowGrade, field_mTotalReachRankSTimes, field_m_rankClass, field_m_rankHistoryHighestClass;
uintptr_t field_m_rankSeasonHighestClass, field_m_GameVipScore, field_m_GameVipLevel, field_m_dianquan, field_m_goldCoin, field_m_diamond, field_dwScore;
uintptr_t DD_m_isInBattle, DD_CommunicateAgentCtrl, DD_SkillControl, DD_EquipComponent, DD_EquipLinkerComp, DD_k__BackingField;
uintptr_t Aclk_HudControl, UL_dwHeroID, UL_wSkinID, UL_bCurWearLevel, UL_bWakeLevel, UL_ullWakeFeatureMask, UL_ullWearFeatureMask, UL_bSkinWakeLevel, UL_ullSkinWakeFeatureMask;
// BANNEI_ (hihi) 
