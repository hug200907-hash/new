Vector2 MinimapOrg; 
bool Count = false;
bool ShowArrowToEnemy = false;
bool Box4Lines = false;
Vector2 MinimapSize; 
Vector2 BigmapSize; 
Vector2 bigmapPos;
Vector2 minimapPos;

NSMutableDictionary *heroTextures;
NSMutableDictionary *skillTextures;

std::unordered_map<uintptr_t, Vector3> previousEnemyPositions;

Vector3 RotateVectorByQuaternion(Quaternion q) {
    Vector3 v(0.0f, 0.0f, 1.0f);
    float w = q.w, x = q.x, y = q.y, z = q.z;

    Vector3 u(x, y, z);
    Vector3 cross1 = Vector3::Cross(u, v);
    Vector3 cross2 = Vector3::Cross(u, cross1);
    Vector3 result = v + 2.0f * cross1 * w + 2.0f * cross2;

    return result;
}

float SquaredDistance(Vector3 v, Vector3 o) {
    return (v.x - o.x) * (v.x - o.x) + (v.y - o.y) * (v.y - o.y) + (v.z - o.z) * (v.z - o.z);
}

int dem(int num){
    int div=1, num1 = num;
    while (num1 != 0) {
        num1=num1/10;
        div=div*10;
    }
    return div;
}

Vector3 VInt2Vector(VInt3 location, VInt3 forward){
    return Vector3((float)(location.X*dem(forward.X)+forward.X)/(1000*dem(forward.X)), (float)(location.Y*dem(forward.Y)+forward.Y)/(1000*dem(forward.Y)), (float)(location.Z*dem(forward.Z)+forward.Z)/(1000*dem(forward.Z)));
}

Vector3 Lerp(Vector3 &a,const Vector3 &b, float t) {
    if(Vector3::Distance(a,b) > 1) a = b;
    return Vector3{
        a.x + (b.x - a.x) * t,
        a.y + (b.y - a.y) * t,
        a.z + (b.z - a.z) * t
    };
}

Vector3 VIntVector(VInt3 location) {
    return Vector3((float)(location.X) / (1000), (float)(location.Y) / (1000), (float)(location.Z) / (1000));
}

float ClosestDistanceEnemy(Vector3 myPos, Vector3 enemyPos, Vector3 direction) {
    Vector3 AC = enemyPos - myPos; 
    Vector3 AB = direction; 
    float t = Vector3::Dot(AC, AB); 
    Vector3 projectionPoint = myPos + AB * t;
    return Vector3::Distance(projectionPoint, enemyPos);
}

Vector3 calculateSkillDirection(Vector3 myPosi, Vector3 enemyPosi, Vector3 moveForward, int currentSpeed, float DoLech) {
    Vector3 futureEnemyPos = Vector3::zero();
    Vector3 toEnemy = enemyPosi - myPosi;
    float distanceToEnemy = Vector3::Magnitude(toEnemy);
    float defaultBulletSpeed = KhoangCach/DoLechAim;
    float timeToHit = distanceToEnemy/defaultBulletSpeed;
    futureEnemyPos = enemyPosi + moveForward * currentSpeed * timeToHit;
    Vector3 shootingDirection = futureEnemyPos - myPosi;
    return Vector3::Normalized(shootingDirection);
}

Vector3 (*_GetUseSkillDirection)(void *instance, bool isTouchUse);
Vector3 GetUseSkillDirection(void *instance, bool isTouchUse) {
    if (instance != NULL && (AimSkill || autoyue)) {
        if (EnemyTarget.myPos != Vector3::zero() && EnemyTarget.enemyPos != Vector3::zero() &&
            ((SkillSlot == 1 && (AimSkill1 || autoyue)) ||
             (SkillSlot == 2 && (AimSkill2 || autoyue)) ||
             (SkillSlot == 3 && AimSkill3))) {
            return calculateSkillDirection(
                EnemyTarget.myPos,
                EnemyTarget.enemyPos,
                EnemyTarget.moveForward,
                EnemyTarget.currentSpeed,
                EnemyTarget.DoLech
            );
        }
    }
    return _GetUseSkillDirection(instance, isTouchUse);
}

void (*_SkillButtonManager_LateUpdate)(void* instance);
void SkillButtonManager_LateUpdate(void* instance) {
    if (instance != NULL) SkillSlot = GetCurSkillSlotType(instance);
    return _SkillButtonManager_LateUpdate(instance);
}

// mini map
bool (*get_bMiniMapBgFlip)(void *instance);
bool _get_bMiniMapBgFlip(void *instance){
    if(instance != NULL){
        isFliped = get_bMiniMapBgFlip(instance);
        isNormal5v5mode = IsNormal5v5mode(instance);
        return isFliped;
    }
    return get_bMiniMapBgFlip(instance);
}

bool (*get_IsTrainingHelperOpen)(void *instance);
bool _get_IsTrainingHelperOpen(void *instance){
    if(instance != NULL){
        Trainningmode = get_IsTrainingHelperOpen(instance);
        return Trainningmode;
    }
    return get_IsTrainingHelperOpen(instance);
}

void (*Update_Minimap)(void *instance);
void _Update_Minimap(void *instance){
    if (instance != NULL) {   
        if(isFirst){
            MinimapOrg = GetMMFianlScreenPos(instance);
            isFirst = false;
        }
        is3V3Minimap = Is3V3Minimap(instance);

        minimapPos = GetMMFianlScreenPos(instance); 
        bigmapPos = GetBMFianlScreenPos(instance);
        MapType = get_CurMapType(instance);

        float newscale = (float)5*(kScale+1)/14;

        if(kScale == 2 && kHeight < 600){
            newscale = (float)5*(kScale+2)/14;
        }

        if(minimapPos.x > 0) {
            MinimapScale = MinimapOrg.x/minimapPos.x;
            if (MinimapOrg.y/newscale > kHeight){
                MinimapSize = get_mmFinalScreenSize(instance)/kScale;
                BigmapSize = get_bmFinalScreenSize(instance)/kScale;
                MinimapCenterX = (minimapPos.x*MinimapScale)/kScale;
                MinimapCenterY = kHeight - minimapPos.y*MinimapScale/kScale;
                BigmapCenterX = (bigmapPos.x*MinimapScale)/kScale;
                BigmapCenterY = kHeight - bigmapPos.y*MinimapScale/kScale;              
            } else {
                MinimapSize = get_mmFinalScreenSize(instance)/newscale;
                BigmapSize = get_bmFinalScreenSize(instance)/newscale;
                MinimapCenterX = minimapPos.x/newscale;
                MinimapCenterY = kHeight - minimapPos.y/newscale;
                BigmapCenterX = bigmapPos.x/newscale;
                BigmapCenterY = kHeight - bigmapPos.y/newscale; 
            }
        }
    }
    return Update_Minimap(instance);
}
#include "ESP_Helper/HeroIcon/iconHero.h"
#include "ESP_Helper/IconBotro/iconbotro.h"
std::string GetNameActors(int id) {
    static std::unordered_map<int, std::string> actors = {
        {105, ENCRYPT("Toro")},
        {106, ENCRYPT("Krixi")},
        {107, ENCRYPT("Zephys")},
        {108, ENCRYPT("Gildur")},
        {109, ENCRYPT("Veera")},
        {110, ENCRYPT("Kahlii")},
        {111, ENCRYPT("Violet")},
        {112, ENCRYPT("Yorn")},
        {113, ENCRYPT("Chaugnar")},
        {114, ENCRYPT("Omega")},
        {115, ENCRYPT("Jinna")},
        {116, ENCRYPT("Butterfly")},
        {117, ENCRYPT("Ormarr")},
        {118, ENCRYPT("Alice")},
        {119, ENCRYPT("Mganga")},
        {120, ENCRYPT("Mina")},
        {121, ENCRYPT("Marja")},
        {123, ENCRYPT("Maloch")},
        {124, ENCRYPT("Ignis")},
        {126, ENCRYPT("Arduin")},
        {127, ENCRYPT("Azzen'Ka")},
        {128, ENCRYPT("Lữ Bố")},
        {129, ENCRYPT("Triệu Vân")},
        {130, ENCRYPT("Airi")},
        {131, ENCRYPT("Murad")},
        {132, ENCRYPT("Hayate")},
        {133, ENCRYPT("Valhein")},
        {134, ENCRYPT("Skud")},
        {135, ENCRYPT("Thane")},
        {136, ENCRYPT("Ilumia")},
        {137, ENCRYPT("Paine")},
        {139, ENCRYPT("Kil'Groth")},
        {140, ENCRYPT("Superman")},
        {141, ENCRYPT("Lauriel")},
        {142, ENCRYPT("Natalya")},
        {144, ENCRYPT("Taara")},
        {146, ENCRYPT("Zill")},
        {148, ENCRYPT("Preyta")},
        {149, ENCRYPT("Xeniel")},
        {150, ENCRYPT("Nakroth")},
        {152, ENCRYPT("Điêu Thuyền")},
        {153, ENCRYPT("Kaine")},
        {154, ENCRYPT("Yena")},
        {156, ENCRYPT("Aleister")},
        {157, ENCRYPT("Raz")},
        {159, ENCRYPT("Dolia")},
        {162, ENCRYPT("Kriknak")},
        {163, ENCRYPT("Ryoma")},
        {166, ENCRYPT("Arthur")},
        {167, ENCRYPT("Ngộ Không")},
        {168, ENCRYPT("Lumburr")},
        {169, ENCRYPT("Slimz")},
        {170, ENCRYPT("Moren")},
        {171, ENCRYPT("Cresht")},
        {173, ENCRYPT("Fennik")},
        {174, ENCRYPT("Stuart")},
        {175, ENCRYPT("Grakk")},
        {177, ENCRYPT("Lindis")},
        {180, ENCRYPT("Max")},
        {184, ENCRYPT("Helen")},
        {186, ENCRYPT("TeeMee")},
        {187, ENCRYPT("Arum")},
        {189, ENCRYPT("Krizzix")},
        {190, ENCRYPT("Tulen")},
        {191, ENCRYPT("Rouie")},
        {192, ENCRYPT("Celica")},
        {193, ENCRYPT("Amily")},
        {194, ENCRYPT("Wiro")},
        {195, ENCRYPT("Enzo")},
        {196, ENCRYPT("Elsu")},
        {199, ENCRYPT("Eland'orr")},
        {206, ENCRYPT("Charlotte")},
        {501, ENCRYPT("Tel'Annas")},
        {502, ENCRYPT("Astrid")},
        {503, ENCRYPT("Zuka")},
        {504, ENCRYPT("Wonder Woman")},
        {505, ENCRYPT("Baldum")},
        {506, ENCRYPT("Omen")},
        {507, ENCRYPT("The Flash")},
        {508, ENCRYPT("Wisp")},
        {509, ENCRYPT("Y'bneth")},
        {510, ENCRYPT("Liliana")},
        {511, ENCRYPT("Ata")},
        {512, ENCRYPT("Rourke")},
        {513, ENCRYPT("Zata")},
        {514, ENCRYPT("Roxie")},
        {515, ENCRYPT("Richter")},
        {518, ENCRYPT("Quillen")},
        {519, ENCRYPT("Annette")},
        {520, ENCRYPT("Veres")},
        {521, ENCRYPT("Florentino")},
        {522, ENCRYPT("Errol")},
        {523, ENCRYPT("D'arcy")},
        {524, ENCRYPT("Capheny")},
        {525, ENCRYPT("Zip")},
        {526, ENCRYPT("Ishar")},
        {527, ENCRYPT("Sephera")},
        {528, ENCRYPT("Qi")},
        {529, ENCRYPT("Volkath")},
        {530, ENCRYPT("Dirak")},
        {531, ENCRYPT("Keera")},
        {532, ENCRYPT("Thorne")},
        {533, ENCRYPT("Laville")},
        {534, ENCRYPT("Dextra")},
        {535, ENCRYPT("Sinestrea")},
        {536, ENCRYPT("Aoi")},
        {537, ENCRYPT("Allain")},
        {538, ENCRYPT("Iggy")},
        {539, ENCRYPT("Lorion")},
        {540, ENCRYPT("Bright")},
        {541, ENCRYPT("Bonnie")},
        {542, ENCRYPT("Tachi")},
        {543, ENCRYPT("Aya")},
        {544, ENCRYPT("Yan")},
        {545, ENCRYPT("Yue")},
        {546, ENCRYPT("Teeri")},
        {548, ENCRYPT("Bijan")},
        {563, ENCRYPT("Heino")},
        {567, ENCRYPT("Erin")},
        {568, ENCRYPT("Ming")},
        {595, ENCRYPT("Edras")},
        {596, ENCRYPT("Goverra")},
        {597, ENCRYPT("Biron")},
        {598, ENCRYPT("Bolt Baron")},
        {599, ENCRYPT("Billow")},
        {751, ENCRYPT("Điêu Thuyền")},
        {808, ENCRYPT("Bot Arthur")},
        {809, ENCRYPT("Bot Tel")},
    };
    auto it = actors.find(id);
    if (it != actors.end()) {
        return it->second;
    } else {
        return ENCRYPT("Unknown - ") + std::to_string(id);
    }
}
// Base Hero
- (void)initImageTexture: (id<MTLDevice>)device {
    heroTextures = [[NSMutableDictionary alloc] init];

    [self addHeroTexture:device heroID:105 base64Data:Toro];
    [self addHeroTexture:device heroID:106 base64Data:Krixi];
    [self addHeroTexture:device heroID:107 base64Data:Zephys];
    [self addHeroTexture:device heroID:108 base64Data:Gildur];
    [self addHeroTexture:device heroID:109 base64Data:Veera];
    [self addHeroTexture:device heroID:110 base64Data:Kahlii];
    [self addHeroTexture:device heroID:111 base64Data:Violet];
    [self addHeroTexture:device heroID:112 base64Data:Yorn];
    [self addHeroTexture:device heroID:113 base64Data:Chaugnar];
    [self addHeroTexture:device heroID:114 base64Data:Omega];
    [self addHeroTexture:device heroID:115 base64Data:Jinna];
    [self addHeroTexture:device heroID:116 base64Data:Butterfly];
    [self addHeroTexture:device heroID:117 base64Data:Ormarr];
    [self addHeroTexture:device heroID:118 base64Data:Alice];
    [self addHeroTexture:device heroID:119 base64Data:Mganga];
    [self addHeroTexture:device heroID:120 base64Data:Mina];
    [self addHeroTexture:device heroID:121 base64Data:Marja];
    [self addHeroTexture:device heroID:123 base64Data:Maloch];
    [self addHeroTexture:device heroID:124 base64Data:Ignis];
    [self addHeroTexture:device heroID:126 base64Data:Arduin];
    [self addHeroTexture:device heroID:127 base64Data:AzzenKa];
    [self addHeroTexture:device heroID:128 base64Data:LuBu];
    [self addHeroTexture:device heroID:129 base64Data:Zanis];
    [self addHeroTexture:device heroID:130 base64Data:Airi];
    [self addHeroTexture:device heroID:131 base64Data:Murad];
    [self addHeroTexture:device heroID:132 base64Data:Hayate];
    [self addHeroTexture:device heroID:133 base64Data:Valhein];
    [self addHeroTexture:device heroID:134 base64Data:Skud];
    [self addHeroTexture:device heroID:135 base64Data:Thane];
    [self addHeroTexture:device heroID:136 base64Data:Ilumia];
    [self addHeroTexture:device heroID:137 base64Data:Paine];
    [self addHeroTexture:device heroID:139 base64Data:KilGroth];
    [self addHeroTexture:device heroID:140 base64Data:Superman];
    [self addHeroTexture:device heroID:141 base64Data:Lauriel];
    [self addHeroTexture:device heroID:142 base64Data:Natalya];
    [self addHeroTexture:device heroID:144 base64Data:Taara];
    [self addHeroTexture:device heroID:146 base64Data:Zill];
    [self addHeroTexture:device heroID:148 base64Data:Preyta];
    [self addHeroTexture:device heroID:149 base64Data:Xeniel];
    [self addHeroTexture:device heroID:150 base64Data:Nakroth];
    [self addHeroTexture:device heroID:152 base64Data:DiaoChan];
    [self addHeroTexture:device heroID:153 base64Data:Kaine];
    [self addHeroTexture:device heroID:154 base64Data:Yena];
    [self addHeroTexture:device heroID:156 base64Data:Aleister];
    [self addHeroTexture:device heroID:157 base64Data:Raz];
    [self addHeroTexture:device heroID:159 base64Data:Dolia];
    [self addHeroTexture:device heroID:162 base64Data:Kriknak];
    [self addHeroTexture:device heroID:163 base64Data:Ryoma];
    [self addHeroTexture:device heroID:166 base64Data:Arthur];
    [self addHeroTexture:device heroID:167 base64Data:Wukong];
    [self addHeroTexture:device heroID:168 base64Data:Lumburr];
    [self addHeroTexture:device heroID:169 base64Data:Slimz];
    [self addHeroTexture:device heroID:170 base64Data:Moren];
    [self addHeroTexture:device heroID:171 base64Data:Cresht];
    [self addHeroTexture:device heroID:173 base64Data:Fennik];
    [self addHeroTexture:device heroID:174 base64Data:Stuart];
    [self addHeroTexture:device heroID:175 base64Data:Grakk];
    [self addHeroTexture:device heroID:177 base64Data:Lindis];
    [self addHeroTexture:device heroID:180 base64Data:_Max];
    [self addHeroTexture:device heroID:184 base64Data:Helen];
    [self addHeroTexture:device heroID:186 base64Data:TeeMee];
    [self addHeroTexture:device heroID:187 base64Data:Arum];
    [self addHeroTexture:device heroID:189 base64Data:Krizzix];
    [self addHeroTexture:device heroID:190 base64Data:Tulen];
    [self addHeroTexture:device heroID:191 base64Data:Rouie];
    [self addHeroTexture:device heroID:192 base64Data:Celica];
    [self addHeroTexture:device heroID:193 base64Data:Amily];
    [self addHeroTexture:device heroID:194 base64Data:Wiro];
    [self addHeroTexture:device heroID:195 base64Data:Enzo];
    [self addHeroTexture:device heroID:196 base64Data:Elsu];
    [self addHeroTexture:device heroID:199 base64Data:Elandorr];
    [self addHeroTexture:device heroID:206 base64Data:Charlotte];
    [self addHeroTexture:device heroID:501 base64Data:TelAnnas];
    [self addHeroTexture:device heroID:502 base64Data:Astrid];
    [self addHeroTexture:device heroID:503 base64Data:Zuka];
    [self addHeroTexture:device heroID:504 base64Data:WonderWoman];
    [self addHeroTexture:device heroID:505 base64Data:Baldum];
    [self addHeroTexture:device heroID:506 base64Data:Omen];
    [self addHeroTexture:device heroID:507 base64Data:TheFlash];
    [self addHeroTexture:device heroID:508 base64Data:Wisp];
    [self addHeroTexture:device heroID:509 base64Data:Ybneth];
    [self addHeroTexture:device heroID:510 base64Data:Liliana];
    [self addHeroTexture:device heroID:511 base64Data:Ata];
    [self addHeroTexture:device heroID:512 base64Data:Rourke];
    [self addHeroTexture:device heroID:513 base64Data:Zata];
    [self addHeroTexture:device heroID:514 base64Data:Roxie];
    [self addHeroTexture:device heroID:515 base64Data:Richter];
    [self addHeroTexture:device heroID:518 base64Data:Quillen];
    [self addHeroTexture:device heroID:519 base64Data:Annette];
    [self addHeroTexture:device heroID:520 base64Data:Veres];
    [self addHeroTexture:device heroID:521 base64Data:Florentino];
    [self addHeroTexture:device heroID:522 base64Data:Errol];
    [self addHeroTexture:device heroID:523 base64Data:Darcy];
    [self addHeroTexture:device heroID:524 base64Data:Capheny];
    [self addHeroTexture:device heroID:525 base64Data:Zip];
    [self addHeroTexture:device heroID:526 base64Data:Ishar];
    [self addHeroTexture:device heroID:527 base64Data:Sephera];
    [self addHeroTexture:device heroID:528 base64Data:Qi];
    [self addHeroTexture:device heroID:529 base64Data:Volkath];
    [self addHeroTexture:device heroID:530 base64Data:Dirak];
    [self addHeroTexture:device heroID:531 base64Data:Keera];
    [self addHeroTexture:device heroID:532 base64Data:Thorne];
    [self addHeroTexture:device heroID:533 base64Data:Laville];
    [self addHeroTexture:device heroID:534 base64Data:Dextra];
    [self addHeroTexture:device heroID:535 base64Data:Sinestrea];
    [self addHeroTexture:device heroID:536 base64Data:Aoi];
    [self addHeroTexture:device heroID:537 base64Data:Allain];
    [self addHeroTexture:device heroID:538 base64Data:Iggy];
    [self addHeroTexture:device heroID:539 base64Data:Lorion];
    [self addHeroTexture:device heroID:540 base64Data:Bright];
    [self addHeroTexture:device heroID:541 base64Data:Bonnie];
    [self addHeroTexture:device heroID:542 base64Data:Tachi];
    [self addHeroTexture:device heroID:543 base64Data:Aya];
    [self addHeroTexture:device heroID:544 base64Data:Yan];
    [self addHeroTexture:device heroID:545 base64Data:Yue];
    [self addHeroTexture:device heroID:546 base64Data:Teeri];
    [self addHeroTexture:device heroID:548 base64Data:Bijan];
    [self addHeroTexture:device heroID:563 base64Data:Heino];
    [self addHeroTexture:device heroID:567 base64Data:Erin];
    [self addHeroTexture:device heroID:568 base64Data:Ming];
    [self addHeroTexture:device heroID:577 base64Data:ThieuTuDuyen];
    [self addHeroTexture:device heroID:595 base64Data:Edras];
    [self addHeroTexture:device heroID:596 base64Data:Goverra];
    [self addHeroTexture:device heroID:597 base64Data:Biron];
    [self addHeroTexture:device heroID:598 base64Data:BoltBaron];
    [self addHeroTexture:device heroID:599 base64Data:Billow];
    [self addHeroTexture:device heroID:751 base64Data:DiaoChan];
    [self addHeroTexture:device heroID:808 base64Data:Arthur];
    [self addHeroTexture:device heroID:809 base64Data:TelAnnas];

}

- (void)addHeroTexture:(id<MTLDevice>)device heroID:(int)heroID base64Data:(NSString *)base64Data {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64Data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    id<MTLTexture> texture = [self loadImageTexture:device data:data];
    if (texture) {
        [heroTextures setObject:texture forKey:@(heroID + 10000)];
    }
}

// Base Bổ trợ
- (void)initSkillTextures:(id<MTLDevice>)device {
    skillTextures = [[NSMutableDictionary alloc] init];

    [self addSkillTexture:device SkillCDID:80108 base64Data:Boc_Pha];
    [self addSkillTexture:device SkillCDID:80110 base64Data:Gam_Thet];
    [self addSkillTexture:device SkillCDID:80102 base64Data:Cap_Cuu];
    [self addSkillTexture:device SkillCDID:80105 base64Data:Suy_Nhuoc];
    [self addSkillTexture:device SkillCDID:80107 base64Data:Thanh_Tay];
    [self addSkillTexture:device SkillCDID:80103 base64Data:Ngap_Ngu];
    [self addSkillTexture:device SkillCDID:80109 base64Data:Toc_Hanh];
    [self addSkillTexture:device SkillCDID:80115 base64Data:Toc_Bien];
    [self addSkillTexture:device SkillCDID:80104 base64Data:Trung_Tri];
    [self addSkillTexture:device SkillCDID:80116 base64Data:Te_Tai];
    [self addSkillTexture:device SkillCDID:80133 base64Data:May_Bay];
    [self addSkillTexture:device SkillCDID:90000 base64Data:Hoi_Mau];
    [self addSkillTexture:device SkillCDID:90003 base64Data:Hoi_Mau];
    [self addSkillTexture:device SkillCDID:91000 base64Data:Hoi_Mau_Sieu_Cap];
    [self addSkillTexture:device SkillCDID:15970 base64Data:Hoi_Mau_Dolia];
    [self addSkillTexture:device SkillCDID:80503 base64Data:Linh_Bao_Vang];
    [self addSkillTexture:device SkillCDID:80504 base64Data:Linh_Bao_Giap];
    [self addSkillTexture:device SkillCDID:80112 base64Data:Bang_Suong];
    [self addSkillTexture:device SkillCDID:8810101 base64Data:Bang_Suong];
    [self addSkillTexture:device SkillCDID:91148 base64Data:Xa_Nhat_Cung];
    [self addSkillTexture:device SkillCDID:91145 base64Data:Cung_Ta_Ma];
    [self addSkillTexture:device SkillCDID:91149 base64Data:Thuong_Khung_Kiem];
    [self addSkillTexture:device SkillCDID:91020 base64Data:Nham_Thuan];
    [self addSkillTexture:device SkillCDID:916211 base64Data:Dai_Dia_Than_Khien];
    [self addSkillTexture:device SkillCDID:916212 base64Data:Dai_Dia_Ma_Nhan];
    [self addSkillTexture:device SkillCDID:916217 base64Data:Dai_Dia_Than_Toc];
    [self addSkillTexture:device SkillCDID:916214 base64Data:Dai_Dia_Mo_Troi];
    [self addSkillTexture:device SkillCDID:916216 base64Data:Dai_Dia_Hoi_Huyet];
    [self addSkillTexture:device SkillCDID:916231 base64Data:Liet_Hoa_Than_Khien];
    [self addSkillTexture:device SkillCDID:916232 base64Data:Liet_Hoa_Ma_Nhan];
    [self addSkillTexture:device SkillCDID:916237 base64Data:Liet_Hoa_Than_Toc];
    [self addSkillTexture:device SkillCDID:916234 base64Data:Liet_Hoa_Mo_Troi];
    [self addSkillTexture:device SkillCDID:916236 base64Data:Liet_Hoa_Hoi_huyet];

}

- (void)addSkillTexture:(id<MTLDevice>)device SkillCDID:(int)SkillCDID base64Data:(NSString *)base64Data {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64Data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    id<MTLTexture> texture = [self loadImageTexture:device data:data];
    if (texture) {
        [skillTextures setObject:texture forKey:@(SkillCDID + 10000000)];
    }
}

- (id<MTLTexture>)loadImageTexture:(id<MTLDevice>)device data:(NSData *)imageData {
    int width, height;
    unsigned char *pixels = stbi_load_from_memory((stbi_uc const *)[imageData bytes], (int)[imageData length], &width, &height, NULL, 4);

    MTLTextureDescriptor *textureDescriptor = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatRGBA8Unorm
                                                            width:(NSUInteger)width
                                                        height:(NSUInteger)height
                                                        mipmapped:NO];
    textureDescriptor.usage = MTLTextureUsageShaderRead;
    textureDescriptor.storageMode = MTLStorageModeShared;
    id<MTLTexture> texture = [device newTextureWithDescriptor:textureDescriptor];
    [texture replaceRegion:MTLRegionMake2D(0, 0, (NSUInteger)width, (NSUInteger)height) mipmapLevel:0 withBytes:pixels bytesPerRow:(NSUInteger)width * 4];
    return texture;
}

// Minimap Máu
void DrawCircleHealth2(ImVec2 position, int health, int max_health, float radius, float IconAuto) {
    if (max_health <= 0) return;
    auto draw_list = ImGui::GetForegroundDrawList();
    const float twoPi = 3.14159265359f * 2.0f;
    const float topAngle = -3.14159265359f * 0.5f; 
    float hpPerc = (float)health / (float)max_health;
    float missPerc = 1.0f - hpPerc;         
    float missAngle = twoPi * missPerc;     
    float missStart = topAngle - missAngle * 0.5f;
    float missEnd = topAngle + missAngle * 0.5f;

    // Vẽ máu tụt
    draw_list->PathArcTo(position, radius, missStart, missEnd);
    draw_list->PathStroke(IM_COL32(89, 0, 0, 255), ImDrawFlags_None, IconAuto);  //rgb(89, 0, 0)

    // Vẽ máu đầy
    draw_list->PathArcTo(position, radius, missEnd, missStart + twoPi);
    draw_list->PathStroke(IM_COL32(182, 1, 1, 255), ImDrawFlags_None, IconAuto);  //rgb(182, 1, 1)
}

ImU32 HealthColorGradient(float percent) {
    ImVec4 color;
    if (percent > 50.0f) {
        float t = (percent - 50.0f) / 50.0f;
        color = ImVec4(1.0f - t, 1.0f, 0.0f, 1.0f);
    } else {
        float t = percent / 50.0f;
        color = ImVec4(1.0f, t, 0.0f, 1.0f);
    }
    return ImGui::ColorConvertFloat4ToU32(color);
}

struct FLinearColor 
{
    float R, G, B, A;
    
    FLinearColor(float r, float g, float b, float a)
        : R(r), G(g), B(b), A(a) {}
};

ImU32 ColorToImU32(const FLinearColor& color) 
{
    return IM_COL32(static_cast<unsigned char>(color.R * 255), 
                    static_cast<unsigned char>(color.G * 255), 
                    static_cast<unsigned char>(color.B * 255), 
                    static_cast<unsigned char>(color.A * 255));
}

void Box4Line(ImDrawList *draw, float thicc, int x, int y, int w, int h, FLinearColor greenColor = FLinearColor(0.f, 1.f, 0.f, 1.f)) 
{
    int iw = w / 4;
    int ih = h / 4;

    ImU32 col = ColorToImU32(greenColor);

    draw->AddLine(ImVec2(x, y), ImVec2(x + iw, y), col, thicc);
    draw->AddLine(ImVec2(x + w - iw, y), ImVec2(x + w, y), col, thicc);
    
    draw->AddLine(ImVec2(x, y + h), ImVec2(x + iw, y + h), col, thicc);
    draw->AddLine(ImVec2(x + w - iw, y + h), ImVec2(x + w, y + h), col, thicc);
    
    draw->AddLine(ImVec2(x, y), ImVec2(x, y + iw), col, thicc);
    draw->AddLine(ImVec2(x, y + h - iw), ImVec2(x, y + h), col, thicc);
    
    draw->AddLine(ImVec2(x + w, y), ImVec2(x + w, y + iw), col, thicc);
    draw->AddLine(ImVec2(x + w, y + h - iw), ImVec2(x + w, y + h), col, thicc);
}

// show cd
void DrawSkillCd(ImDrawList* draw, ImVec2 position, float size, int cd, int skillIndex, int skillId) {
    float radius = size / 2.0f;
    float fontSize = radius * 1.9f;

    ImU32 fillColor;
    ImU32 borderColor = IM_COL32(255, 255, 255, 100);
    ImU32 textColor = IM_COL32(255, 255, 255, 255);  

    // Màu nền theo trạng thái chiêu
    if (cd > 0) {
        fillColor = IM_COL32(0, 0, 0, 200); // Đang hồi chiêu
    } else {
        if (skillIndex == 4 || skillIndex == 5 || skillIndex == 6) {
            id<MTLTexture> skillTexture = [skillTextures objectForKey:@(skillId + 10000000)];
            if (skillTexture) {
                float radiusIcon = radius * 0.88f;
                ImVec2 pMin(position.x - radiusIcon, position.y - radiusIcon);
                ImVec2 pMax(position.x + radiusIcon, position.y + radiusIcon);
                draw->AddImageRounded((__bridge ImTextureID)skillTexture, pMin, pMax, ImVec2(0.0f, 0.0f), ImVec2(1.0f, 1.0f), IM_COL32(255, 255, 255, 255), radius, ImDrawCornerFlags_All);
                draw->AddCircle(position, radius, borderColor, 32, 0.1f);
                return;
            }
        }
        switch (skillIndex) {
            case 1:
            case 2:
            case 3:
                fillColor = IM_COL32(200, 200, 200, 255);
                break;            
            case 4:
            case 5:
            case 6:
            default:
                fillColor = IM_COL32(150, 150, 150, 255);
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

static void* autoFloFlowerTarget = nullptr;
static void* autoFloEnemyTarget = nullptr;
static bool autoFloHadMove = false;
static const int kAutoFloRemovedMax = 30;
static std::vector<Vector3> autoFloRemovedFlowers;

void SendMoveDirection(void *instance, Vector2 start, Vector2 end) {
    if (instance != nullptr && autoflo) MoveInstance = instance;
    if (old_SendMoveDirection) old_SendMoveDirection(instance, start, end);
}

static bool AutoFloClosePos(const Vector3 &a, const Vector3 &b, float tolerance = 0.1f) {
    return fabs(a.x - b.x) < tolerance && fabs(a.y - b.y) < tolerance && fabs(a.z - b.z) < tolerance;
}

static void AutoFloRememberRemoved(Vector3 pos) {
    for (const auto &oldPos : autoFloRemovedFlowers) {
        if (AutoFloClosePos(oldPos, pos)) return;
    }
    if (autoFloRemovedFlowers.size() >= kAutoFloRemovedMax) autoFloRemovedFlowers.erase(autoFloRemovedFlowers.begin());
    autoFloRemovedFlowers.push_back(pos);
}

static bool AutoFloWasRemoved(Vector3 pos) {
    for (const auto &oldPos : autoFloRemovedFlowers) {
        if (AutoFloClosePos(oldPos, pos)) return true;
    }
    return false;
}

static ImVec2 AutoFloScreenPos(Vector3 pos) {
    void *cam = get_main();
    if (!cam) return ImVec2(0, 0);
    Vector3 sc = WorldToScreens(cam, pos, 2);
    if (sc.z > 0) return ImVec2(sc.x * kWidth, kHeight - sc.y * kHeight);
    return ImVec2(kWidth - sc.x * kWidth, sc.y * kHeight);
}

static int AutoFloConfigId(void *instance) {
    if (!instance || !Actorlk_ObjLinker || !ActorConfig_ConfigID) return 0;
    void *objLinker = *(void **)((uintptr_t)instance + Actorlk_ObjLinker);
    if (!objLinker) return 0;
    return *(int *)((uintptr_t)objLinker + ActorConfig_ConfigID);
}

static int *AutoFloCooldowns(void *instance) {
    void *skillControl = LActorRoot_AsHero(instance);
    int *cooldowns = (int *)malloc(4 * sizeof(int));
    if (skillControl != NULL) {
        cooldowns[0] = *(int *)((uintptr_t)skillControl + (CD_Skill1 - 0x4)) / 1000;
        cooldowns[1] = *(int *)((uintptr_t)skillControl + (CD_Skill2 - 0x4)) / 1000;
        cooldowns[2] = *(int *)((uintptr_t)skillControl + (CD_Skill3 - 0x4)) / 1000;
        cooldowns[3] = *(int *)((uintptr_t)skillControl + (CD_SkillBoTro - 0x4)) / 1000;
        return cooldowns;
    }
    free(cooldowns);
    return NULL;
}

static void AutoFloUse(void *slot) {
    if (!slot || !Reqskill || !Reqskill2) return;
    Reqskill2(slot, false);
    Reqskill(slot);
}

static void AutoFloMoveToFlower(void *flower, Vector3 myPos) {
    if (!flower || !MoveInstance || !ActorLinker_getPosition) return;
    Vector3 flowerPos = ActorLinker_getPosition(flower);
    Vector3 direction = flowerPos - myPos;
    Vector2 dir2D = {direction.x, direction.z};
    if (isFliped) dir2D = {-direction.x, -direction.z};
    dir2D = Vector2::Normalized(dir2D);
    Vector2 start = {0.0f, 0.0f};
    Vector2 end = {dir2D.x * 1600.0f, dir2D.y * 1600.0f};
    SendMoveDirection(MoveInstance, start, end);
    autoFloHadMove = true;
}

static void AutoFloCollectFlower(void *instance) {
    if (!autoflo || !instance || !Flo_Enemy || !espManager || !espManager->MyPlayer) return;
    if (ActorLinker_ActorTypeDef(instance) != 4) return;
    if (!ActorLinker_IsHostCamp || !ActorLinker_IsHostCamp(instance)) return;
    if (ActorLinker_get_ObjID && ActorLinker_get_ObjID(instance) == 0) return;

    int configId = AutoFloConfigId(instance);
    if (configId == 10001 || configId == 0) return;

    Vector3 myPos = ActorLinker_getPosition(espManager->MyPlayer);
    Vector3 flowerPos = ActorLinker_getPosition(instance);
    float distance = Vector3::Distance(myPos, flowerPos);
    if (distance > 1.8f && distance < 12.0f && flowerPos.y < 0.3f) {
        Flo_Enemy->tryAddEnemy(instance);
    } else {
        Flo_Enemy->removeEnemyGivenObject(instance);
        AutoFloRememberRemoved(flowerPos);
    }
}

static void AutoFloDrawAndPickFlower(ImDrawList *draw, void *enemyLinker) {
    if (!MoveInstance || !autoflo || !Flo_Enemy || Flo_Enemy->enemies->empty() || !enemyLinker || !espManager || !espManager->MyPlayer) return;

    Vector3 myPos = ActorLinker_getPosition(espManager->MyPlayer);
    Vector3 enemyPos = ActorLinker_getPosition(enemyLinker);
    float nearest = std::numeric_limits<float>::infinity();
    autoFloFlowerTarget = nullptr;

    for (int i = 0; i < Flo_Enemy->enemies->size() && i <= 3; ++i) {
        void *flower = (*Flo_Enemy->enemies)[i]->object;
        if (!flower) continue;
        Vector3 flowerPos = ActorLinker_getPosition(flower);
        if (AutoFloWasRemoved(flowerPos)) continue;
        float myToFlower = Vector3::Distance(myPos, flowerPos);
        float myToEnemy = Vector3::Distance(myPos, enemyPos);
        if (myToFlower < 1.8f) {
            AutoFloRememberRemoved(flowerPos);
            continue;
        }
        if (myToFlower < nearest) {
            nearest = myToFlower;
            if (myToEnemy < 3.8f && draw) {
                ImVec2 flowerScreen = AutoFloScreenPos(flowerPos);
                ImVec2 myScreen = AutoFloScreenPos(myPos);
                if (floShowFlower) {
                    draw->AddCircle(flowerScreen, 4.5f, IM_COL32(0, 191, 255, 180), 80, 1.0f);
                    draw->AddCircleFilled(flowerScreen, 3.0f, IM_COL32(255, 0, 0, 255), 80);
                }
                if (floShowLine) {
                    draw->AddLine(myScreen, flowerScreen, IM_COL32(0, 255, 255, 90), 3.2f);
                    draw->AddLine(myScreen, flowerScreen, IM_COL32(0, 255, 255, 255), 1.4f);
                    draw->AddCircleFilled(flowerScreen, 4.0f, IM_COL32(255, 225, 0, 255), 50);
                    draw->AddCircle(flowerScreen, 6.0f, IM_COL32(255, 255, 255, 230), 64, 1.0f);
                }
            }
            autoFloFlowerTarget = flower;
        }
    }
}

static void AutoFloFromEnemy(void *myActor, void *enemy, void *enemyLinker, Vector3 myPos, Vector3 enemyPos, int enemyHp) {
    if (!autoflo || !myActor || !enemy || !enemyLinker) return;
    if (AutoFloConfigId(myActor) != 521 || enemyHp <= 1) return;

    float distance = Vector3::Distance(myPos, enemyPos);
    int *cooldowns = AutoFloCooldowns(enemy);
    if (!cooldowns) return;

    if (distance <= 7.0f) autoFloEnemyTarget = enemyLinker;

    if ((floMode == 1 || floMode == 3) && Req1 && distance > 2.4f && distance < 5.0f && cooldowns[0] == 0) {
        AutoFloUse(Req1);
    }
    if ((floMode == 2 || floMode == 3) && Req3 && distance > 2.4f && distance < 5.0f && cooldowns[2] == 0 && Flo_Enemy && Flo_Enemy->enemies->size()) {
        AutoFloUse(Req3);
    }
    if (distance < 1.5f) {
        if (Req2) {
            if (autoFloFlowerTarget) AutoFloMoveToFlower(autoFloFlowerTarget, myPos);
            if (cooldowns[1] == 0) AutoFloUse(Req2);
        }
    } else if (distance < 7.0f) {
        if (Req0) {
            if (autoFloFlowerTarget && cooldowns[1] == 0) AutoFloMoveToFlower(autoFloFlowerTarget, myPos);
            AutoFloUse(Req0);
        }
    }
    free(cooldowns);
}

void floren(ImDrawList *draw) {
    if (autoflo && autoFloEnemyTarget) AutoFloDrawAndPickFlower(draw, autoFloEnemyTarget);
    if (!autoflo && autoFloHadMove && MoveInstance && StopInput) {
        StopInput(MoveInstance);
        autoFloHadMove = false;
    }
}
static float autoYueLastCast = 0.0f;

void AutoYueRun() {
    if (!autoyue || !espManager || !espManager->MyPlayer || !ActorLinker_enemy ||
        !ActorLinker_enemy->enemies || !ActorLinker_getPosition) return;

    void *myPlayer = espManager->MyPlayer;
    void *myConfig = *(void **)((uintptr_t)myPlayer + ActorLinker_ObjLinker);
    if (!myConfig || *(int *)((uintptr_t)myConfig + ActorConfig_ConfigID) != 545) return;

    Vector3 myPos = ActorLinker_getPosition(myPlayer);
    float closestDistance = 99999.0f;
    void *closestEnemy = nullptr;

    for (enemy_t *entry : *ActorLinker_enemy->enemies) {
        if (!entry || !entry->object) continue;
        void *enemy = entry->object;
        if (ActorLinker_IsHostCamp && ActorLinker_IsHostCamp(enemy)) continue;

        void *valueComponent = *(void **)((uintptr_t)enemy + Actorlk_ValueComponent);
        if (!valueComponent || (ValueLinkerComponent_get_actorHp && ValueLinkerComponent_get_actorHp(valueComponent) < 1)) continue;

        float distance = Vector3::Distance(myPos, ActorLinker_getPosition(enemy));
        if (distance < closestDistance) {
            closestDistance = distance;
            closestEnemy = enemy;
        }
    }

    if (!closestEnemy) return;
    bool inSkill1Range = Rangeskill1 > 0.0f && closestDistance <= Rangeskill1;
    bool inSkill2Range = Rangeskill2 > 0.0f && closestDistance <= Rangeskill2;
    if (!inSkill1Range && !inSkill2Range) return;

    float now = ImGui::GetTime();
    if (now - autoYueLastCast < 0.15f) return;
    autoYueLastCast = now;

    if (inSkill1Range && Req1) {
        Reqskill2(Req1, false);
        Reqskill(Req1);
    }
    if (inSkill2Range && Req2) {
        Reqskill2(Req2, false);
        Reqskill(Req2);
    }
}

void DrawESP(ImDrawList *draw) { 
    auto WorldToScreen = [&](const Vector3& wp) -> ImVec2 {
    void* cam = get_main();
    if (!cam) return ImVec2(0.f, 0.f);
        Vector3 sc = WorldToScreens(cam, wp, 2);
    if (sc.z > 0.0f)
        return ImVec2(sc.x * kWidth, kHeight - sc.y * kHeight);
    else
        return ImVec2(kWidth - sc.x * kWidth, sc.y * kHeight);
    };
    float headHeightOffset = 1.7f; 

    static uint64_t LActorRoot_location = newGetFieldOffset(ENCRYPT("Project.Plugins_d.dll"), ENCRYPT("NucleusDrive.Logic"), ENCRYPT("LActorRoot"), ENCRYPT("_location"));
    static uint64_t LActorRoot_forward = newGetFieldOffset(ENCRYPT("Project.Plugins_d.dll"), ENCRYPT("NucleusDrive.Logic"), ENCRYPT("LActorRoot"), ENCRYPT("_forward"));
    static uint64_t LActorRoot_ActorControl = newGetFieldOffset(ENCRYPT("Project.Plugins_d.dll"), ENCRYPT("NucleusDrive.Logic"), ENCRYPT("LActorRoot"), ENCRYPT("ActorControl"));
    static uint64_t LActorRoot_ValueComponent = newGetFieldOffset(ENCRYPT("Project.Plugins_d.dll"), ENCRYPT("NucleusDrive.Logic"), ENCRYPT("LActorRoot"), ENCRYPT("ValueComponent"));
    static uint64_t ActorLinker_ObjLinker = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Kyrios.Actor"), ENCRYPT("ActorLinker"), ENCRYPT("ObjLinker"));
    static uint64_t ActorConfig_ConfigID = newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameLogic"), ENCRYPT("ActorConfig"), ENCRYPT("ConfigID"));

    int numberOfEnemies = 0;
    int soluongherosong = 0;
    int soluongherochet = 0;

    float minHealth = std::numeric_limits<float>::infinity();
    float minHealth2 = std::numeric_limits<float>::infinity();
    float minHealthPercent = std::numeric_limits<float>::max();
    float closestEnemyDistance = std::numeric_limits<float>::infinity();
    float closestEnemyDistanceView = std::numeric_limits<float>::infinity();

    void* Entity = NULL;

    for (int i = 0; i < espManager->enemies->size(); i++) {
        void* MyActor = espManager->MyPlayer;
        void* Enemy = (*espManager->enemies)[i]->object;
        void* EnemyLinker = (*ActorLinker_enemy->enemies)[i]->object;
        
        if (Enemy == NULL) isFirst = true;

        Vector3 EnemyPos = Vector3::zero();

        if (MyActor && Enemy) {
            Vector3 myPos = ActorLinker_getPosition(MyActor);
            
            void* cammyPos = get_main();
            Vector3 myPosSC = WorldToScreens(cammyPos, myPos, 2);

            ImVec2 myPos_Vec2 = ImVec2(myPosSC.x, myPosSC.y);

            if (myPosSC.z > 0) {
                myPos_Vec2 = ImVec2(myPosSC.x* kWidth, kHeight - myPosSC.y* kHeight);
            } else {
                myPos_Vec2 = ImVec2(kWidth - myPosSC.x* kWidth,myPosSC.y* kHeight);
            }

            VInt3* locationPtr = (VInt3*)((uint64_t)Enemy + LActorRoot_location);
            VInt3* forwardPtr = (VInt3*)((uint64_t)Enemy + LActorRoot_forward);

            EnemyPos = VInt2Vector(*locationPtr, *forwardPtr);

            if (previousEnemyPositions.find((uintptr_t)Enemy) == previousEnemyPositions.end()) {
                previousEnemyPositions[(uintptr_t)Enemy] = EnemyPos;
            }
            EnemyPos = Lerp(previousEnemyPositions[(uintptr_t)Enemy], EnemyPos, 0.2f);
            previousEnemyPositions[(uintptr_t)Enemy] = EnemyPos;

            void *LObjWrapper = *(void **)((uint64_t)Enemy + LActorRoot_ActorControl);
            void *ValuePropertyComponent = *(void **)((uint64_t)Enemy + LActorRoot_ValueComponent);

            if (!LObjWrapper || !ValuePropertyComponent) continue;
            
            void* ActorConfig = *(void **)((uint64_t)EnemyLinker + ActorLinker_ObjLinker);
            if (ActorConfig == NULL) continue;

            int ActorID = *(int *)((uint64_t)ActorConfig + ActorConfig_ConfigID);

            void* camEnemyPos = get_main();
            Vector3 rootPos_W2S = WorldToScreens(camEnemyPos, EnemyPos, 2);
            Vector2 rootPos_Vec2 = Vector2(rootPos_W2S.x, rootPos_W2S.y);

            if (rootPos_W2S.z > 0) {
                rootPos_Vec2 = Vector2(rootPos_W2S.x* kWidth, kHeight -rootPos_W2S.y* kHeight);
            } else {
                rootPos_Vec2 = Vector2(kWidth - rootPos_W2S.x* kWidth, rootPos_W2S.y* kHeight);
            }

            Vector2 headPos_Vec2 = Vector2(rootPos_Vec2.x, rootPos_Vec2.y - (kHeight / 9)); // Đầu cao hơn
            Vector2 headPos_Vec2SSS = Vector2(rootPos_Vec2.x, rootPos_Vec2.y - (kHeight / 13)); // Đầu cao hơn Box4Lines
            Vector2 bottomPos_Vec2 = Vector2(rootPos_Vec2.x, rootPos_Vec2.y + (kHeight / 25)); // Chân thấp hơn
            GetDistanceEnemy = Vector3::Distance(myPos, EnemyPos);
            ImVec2 myPos_ImVec2 = ImVec2(myPos_Vec2.x, myPos_Vec2.y);
            ImVec2 rootPos_ImVec2 = ImVec2(rootPos_Vec2.x, rootPos_Vec2.y);

            int MauTarGet = ValuePropertyComponent_get_actorHp(ValuePropertyComponent);
            if (MauTarGet < 1) soluongherochet++;
            if (MauTarGet > 1) soluongherosong++;

            if (!LObjWrapper_get_IsDeadState(LObjWrapper)) {
                int Health = ValuePropertyComponent_get_actorHp(ValuePropertyComponent);
                int MaxHealth = ValuePropertyComponent_get_actorHpTotal(ValuePropertyComponent);
                int HealthPercent = (int)std::round((float)Health / MaxHealth * 100);
                if (autoflo) {
                    AutoFloDrawAndPickFlower(draw, EnemyLinker);
                    AutoFloFromEnemy(MyActor, Enemy, EnemyLinker, myPos, EnemyPos, Health);
                }

                ImGuiViewport* vp = ImGui::GetMainViewport();
                float screenW = vp->WorkSize.x;
                float screenFraction = 0.046f;
                float fixedBoxWidth = screenW * screenFraction;

                float boxWidth = fixedBoxWidth / (rootPos_W2S.z / fixedBoxWidth);
                float boxHeight = boxWidth * 1.25f;

                float boxCenterOffsetY = -7.0f; 

                ImVec2 vStart = {rootPos_Vec2.x - boxWidth / 2, rootPos_Vec2.y - boxHeight / (float)1.35};
                ImVec2 vEnd = {vStart.x + boxWidth, vStart.y + boxHeight};
                ImVec2 CenterBox = {(vStart.x + vEnd.x) / 2, (vStart.y + vEnd.y - 1) / 2};

                // === Show CD ===
                void* camEnemySKCD = get_main();
                Vector3 EnemySKCD = WorldToScreens(camEnemySKCD, EnemyPos, 2);
                Vector2 ViewSKCD  = Vector2(EnemySKCD.x, EnemySKCD.y);
                if (EnemySKCD.z > 0)
                    ViewSKCD = Vector2(EnemySKCD.x * kWidth, kHeight - EnemySKCD.y * kHeight);
                else
                    ViewSKCD = Vector2(kWidth - EnemySKCD.x * kWidth, EnemySKCD.y * kHeight);

                if (ShowTimeCD) {
                    void* Lplayer = Enemy;
                    if (!Lplayer) continue;

                    void* skillControl = LActorRoot_AsHero(Lplayer);
                    if (!skillControl) continue;

                    if (skillControl != NULL && EnemySKCD.z > 0) {        
                        HeroWrapSkillData SD1 = LHeroWrapper_GetHeroWrapSkillData(skillControl, 1);
                        HeroWrapSkillData SD2 = LHeroWrapper_GetHeroWrapSkillData(skillControl, 2);
                        HeroWrapSkillData SD3 = (ActorID == 595) ? SD3 = LHeroWrapper_GetHeroWrapSkillData(skillControl, 13) : SD3 = LHeroWrapper_GetHeroWrapSkillData(skillControl, 3);
                        HeroWrapSkillData SD4 = LHeroWrapper_GetHeroWrapSkillData(skillControl, 4);
                        HeroWrapSkillData SD5 = LHeroWrapper_GetHeroWrapSkillData(skillControl, 5);
                        HeroWrapSkillData SD9 = LHeroWrapper_GetHeroWrapSkillData(skillControl, 9);

                        int CD1 = SD1.Skill1SlotCD / 1000;
                        int CD2 = SD2.Skill1SlotCD / 1000;
                        int CD3 = SD3.Skill1SlotCD / 1000;
                        int CD4 = SD4.Skill1SlotCD / 1000;
                        int CD5 = SD5.Skill1SlotCD / 1000;
                        int CD9 = SD9.Skill1SlotCD / 1000;

                        float scale = 120.0f / EnemySKCD.z;
                        if (scale > 1.0f) scale = 1.0f;
                        if (scale < 0.5f) scale = 0.5f;

                        float iconSize = 12.0f * scale;
                        float baseOffsetY = 28.0f;
                        float baseLogY = 45.0f;
                        float offsetY = baseOffsetY * scale;
                        float logOffsetY = baseLogY * scale;

                        auto applyOffsetX = [&](float baseX) {
                            return baseX * scale;
                        };

                        DrawSkillCd(draw, {ViewSKCD.x + applyOffsetX(- 45), ViewSKCD.y + offsetY}, iconSize, CD1, 1, SD1.SkillId);
                        DrawSkillCd(draw, {ViewSKCD.x + applyOffsetX(- 30), ViewSKCD.y + offsetY}, iconSize, CD2, 2, SD2.SkillId);
                        DrawSkillCd(draw, {ViewSKCD.x + applyOffsetX(- 15), ViewSKCD.y + offsetY}, iconSize, CD3, 3, SD3.SkillId);
                        DrawSkillCd(draw, {ViewSKCD.x + applyOffsetX(0), ViewSKCD.y + offsetY}, iconSize, CD4, 4, SD4.SkillId);
                        DrawSkillCd(draw, {ViewSKCD.x + applyOffsetX(+ 15), ViewSKCD.y + offsetY}, iconSize, CD5, 5, SD5.SkillId);

                        if (SD9.SkillId == 80112 // Băng Sương
                            || SD9.SkillId == 8810101 // Băng Sương 2
                            || SD9.SkillId == 91148 // Xạ Nhật Cung
                            || SD9.SkillId == 91145 // Cung Tà Ma
                            || SD9.SkillId == 91149 // Thương Khung Kiếm
                            || SD9.SkillId == 91020 // Nham Thuẫn
                            || SD9.SkillId == 916211 // Đại Địa Thần Khiên
                            || SD9.SkillId == 916212 // Đại Địa Ma Nhãn
                            || SD9.SkillId == 916217 // Đại Địa Thần Tốc
                            || SD9.SkillId == 916214 // Đại Địa Mở Trói
                            || SD9.SkillId == 916216 // Đại Địa Hồi Huyết
                            || SD9.SkillId == 916231 // Liệt Hoả Thần Khiên
                            || SD9.SkillId == 916232 // Liệt Hoả Ma Nhãn
                            || SD9.SkillId == 916237 // Liệt Hoả Thần Tốc
                            || SD9.SkillId == 916234 // Liệt Hoả Mở Trói
                            || SD9.SkillId == 916236) // Liệt Hoả Hồi Huyết
                        {
                            DrawSkillCd(draw, {ViewSKCD.x + applyOffsetX(+ 30), ViewSKCD.y + offsetY}, iconSize, CD9, 6, SD9.SkillId);
                        }

                        // === Log ID ===
                        // for (int i = 0; i <= 15; ++i) {
                        //     HeroWrapSkillData sd = LHeroWrapper_GetHeroWrapSkillData(skillControl, i);
                        //     if (sd.SkillId != 0) {
                        //         char buf[96];
                        //         std::snprintf(buf, sizeof(buf), "Slot:%d | ID:%d", i, sd.SkillId);

                        //         ImDrawList* dl = draw ? draw : ImGui::GetForegroundDrawList();
                        //         ImVec2 ts = ImGui::CalcTextSize(buf);
                        //         ts.x *= scale;
                        //         ts.y *= scale;

                        //         ImVec2 pad(4.f * scale, 2.f * scale);
                        //         ImVec2 pos(ViewSKCD.x + applyOffsetX(-65), ViewSKCD.y + logOffsetY + i * (ts.y + pad.y + 2)); // mỗi dòng cách nhau

                        //         ImVec2 p0(pos.x - pad.x, pos.y - pad.y);
                        //         ImVec2 p1(pos.x + ts.x + pad.x, pos.y + ts.y + pad.y);

                        //         dl->AddRectFilled(p0, p1, IM_COL32(0, 0, 0, 150), 4.0f * scale);
                        //         dl->AddText(NULL, ImGui::GetFontSize() * scale, pos, IM_COL32(200, 255, 200, 255), buf);
                        //     }
                        // }
                    }
                }

                if (AimSkill) {
                    float speedEnemy = (float)get_speed(LActorRoot_get_PlayerMovement(Enemy)) / 1000.0f;
                    float hpPercent = (float)Health / (float)MaxHealth;
                    bool validSlot = (SkillSlot == 1 && AimSkill1) || (SkillSlot == 2 && AimSkill2) || (SkillSlot == 3 && AimSkill3);

                    if (Entity == NULL) {
                        EnemyTarget.myPos = Vector3::zero();
                        EnemyTarget.enemyPos = Vector3::zero();
                        EnemyTarget.moveForward = Vector3::zero();
                        EnemyTarget.currentSpeed = 0.0f;
                        EnemyTarget.DoLech = 0.0f;
                        EnemyTarget.Ranger = 0.0f;
                        minHealth = std::numeric_limits<float>::infinity();
                        minHealth2 = std::numeric_limits<float>::infinity();
                        minHealthPercent = std::numeric_limits<float>::max();
                        closestEnemyDistance = std::numeric_limits<float>::infinity();
                        closestEnemyDistanceView = std::numeric_limits<float>::infinity();
                    }

                    if (validSlot && GetDistanceEnemy <= KhoangCach) {
                        bool isBestTarget = false;

                        if (AimType == 0 && Health < minHealth) {
                            minHealth = Health;
                            isBestTarget = true;
                        } else if (AimType == 1) {
                            if (hpPercent < minHealthPercent) {
                                minHealthPercent = hpPercent;
                                minHealth2 = Health;
                                isBestTarget = true;
                            } else if (hpPercent == minHealthPercent && Health < minHealth2) {
                                minHealth2 = Health;
                                isBestTarget = true;
                            }
                        } else if (AimType == 2 && GetDistanceEnemy < closestEnemyDistance) {
                            closestEnemyDistance = GetDistanceEnemy;
                            isBestTarget = true;
                        } else if (AimType == 3) {
                            float angleDist = ClosestDistanceEnemy(myPos, EnemyPos, CurrentPosition);
                            if (angleDist < closestEnemyDistanceView) {
                                closestEnemyDistanceView = angleDist;
                                isBestTarget = true;
                            }
                        }

                        if (isBestTarget) {
                            Entity = Enemy;
                            EnemyTarget.myPos = myPos;
                            EnemyTarget.enemyPos = EnemyPos;
                            EnemyTarget.moveForward = VIntVector(*forwardPtr);
                            EnemyTarget.currentSpeed = speedEnemy;
                            EnemyTarget.DoLech = DoLechAim;
                            EnemyTarget.Ranger = KhoangCach;
                        } 
                    }
                }
                
                bool CheckVisible = false;
                if (!ActorLinker_get_bVisible(EnemyLinker)) CheckVisible = true;

                if (IgnoreInvisible && ActorLinker_get_bVisible(EnemyLinker)) continue;

                if (ESPEnable && PlayerLine) {
                    // Code port từ 131dotheme: Line Vàng + Chấm tròn
                    ImVec2 endPos = ImVec2(headPos_Vec2.x, headPos_Vec2.y); 
                    ImU32 lineColor = IM_COL32(255, 255, 255, 150);
                    
                    draw->AddLine(ImVec2(ImGui::GetIO().DisplaySize.x / 2, 48.3f), endPos, lineColor, 1.0f);
                    draw->AddCircleFilled(endPos, 2.0f, IM_COL32(255, 255, 255, 200));
                    draw->AddCircle(endPos, 5.0f, IM_COL32(255, 255, 255, 100), 0, 1.0f);
                }
                
                if (ESPEnable && PlayerBox) {
                    draw->AddRect(ImVec2(vStart.x , vStart.y), ImVec2(vStart.x + boxWidth, vStart.y + boxHeight),  IM_COL32(255, 255, 255, 255), 0.0f, 1.0f); //rgb(39, 224, 29)
                }

                if (ESPEnable && PlayerHeal) {
                    float fullHeight = boxHeight;
                    float healthHeight = fullHeight * ((float)HealthPercent / 100.0f);
                    float barLeft = vEnd.x + 3;
                    float barRight = barLeft + 5;
                    float radius = 1.5f; 
                    ImVec2 healthBarTop = ImVec2(barLeft, vStart.y);
                    ImVec2 healthBarBottom = ImVec2(barRight, vStart.y + boxHeight); 
                    draw->AddRectFilled(ImVec2(barLeft, vStart.y), ImVec2(barRight, vStart.y + boxHeight), IM_COL32(30, 30, 30, 255), radius);
                    draw->AddRectFilled(ImVec2(barLeft, vStart.y + (boxHeight - healthHeight)), ImVec2(barRight, vStart.y + boxHeight), IM_COL32(255, 255, 255, 255), radius);
                }

                // TP131 "MiniMap": hiện icon tướng trên màn hình khi địch khuất tầm nhìn.
                if (ESPEnable && ShowMinimap && !ActorLinker_get_bVisible(EnemyLinker)) {
                    id<MTLTexture> heroTexture = [heroTextures objectForKey:@(ActorID + 10000)];
                    if (heroTexture) {
                        ImVec2 iconSize(38.0f, 38.0f);
                        ImVec2 iconMin(rootPos_Vec2.x - iconSize.x * 0.5f,
                                       rootPos_Vec2.y - 15.0f - iconSize.y * 0.5f);
                        draw->AddImage((__bridge ImTextureID)heroTexture, iconMin,
                                       ImVec2(iconMin.x + iconSize.x, iconMin.y + iconSize.y));
                    }
                }

                if (ESPEnable && PlayerName) {
                    std::string heroName = GetNameActors(ActorID);
                    ImVec2 textSize = ImGui::CalcTextSize(heroName.c_str());
                    ImVec2 infoPos(vStart.x + boxWidth / 2 - textSize.x / 2, vStart.y - textSize.y - 4.0f);
                    draw->AddText(infoPos, IM_COL32(255, 255, 255, 255), heroName.c_str());
                }

                if (ESPEnable && DistanceESP) {
                    char distanceText[32];
                    snprintf(distanceText, sizeof(distanceText), "%.1fm", GetDistanceEnemy);
                    ImVec2 textSize = ImGui::CalcTextSize(distanceText);
                    ImVec2 textPos(vStart.x + boxWidth / 2 - textSize.x / 2, vStart.y + boxHeight + 2.0f);
                    draw->AddText(textPos, IM_COL32(255, 255, 255, 255), distanceText);
                }

                if (ESPEnable && Alert360) {
                    ImVec2 direction(rootPos_Vec2.x - myPos_Vec2.x, rootPos_Vec2.y - myPos_Vec2.y);
                    float length = sqrtf(direction.x * direction.x + direction.y * direction.y);
                    if (length > 0.0f) {
                        ImVec2 norm(direction.x / length, direction.y / length);
                        ImVec2 center(myPos_Vec2.x + norm.x * 100.0f, myPos_Vec2.y + norm.y * 100.0f);
                        ImVec2 perp(-norm.y, norm.x);
                        ImVec2 tip(center.x + norm.x * 6.0f, center.y + norm.y * 6.0f);
                        ImVec2 left(center.x - norm.x * 4.0f + perp.x * 5.0f, center.y - norm.y * 4.0f + perp.y * 5.0f);
                        ImVec2 right(center.x - norm.x * 4.0f - perp.x * 5.0f, center.y - norm.y * 4.0f - perp.y * 5.0f);
                        draw->AddTriangle(tip, left, right, IM_COL32(255, 255, 255, 255), 1.8f);
                    }
                }

                // TP131 "Hero Icon": icon địch trên minimap, viền trắng và vòng máu.
                if (ESPEnable && HeroIconESP && MapType > 0) {
                    id<MTLTexture> heroTexture = [heroTextures objectForKey:@(ActorID + 10000)];
                    float mapScaleX = is3V3Minimap ? 132.0f : 104.0f;
                    float mapScaleY = is3V3Minimap ? 34.7f : 104.0f;
                    ImVec2 iconPos;
                    if (MapType == 1) {
                        iconPos = ImVec2(MinimapCenterX + EnemyPos.x * MinimapSize.x / mapScaleX,
                                         MinimapCenterY - EnemyPos.z * MinimapSize.y / mapScaleY);
                    } else {
                        iconPos = ImVec2(BigmapCenterX + EnemyPos.x * BigmapSize.x / mapScaleX,
                                         BigmapCenterY - EnemyPos.z * BigmapSize.y / mapScaleY);
                    }
                    if (isFliped) {
                        iconPos.x = (MapType == 1 ? MinimapCenterX : BigmapCenterX) * 2.0f - iconPos.x;
                        iconPos.y = (MapType == 1 ? MinimapCenterY : BigmapCenterY) * 2.0f - iconPos.y;
                    }
                    ImVec2 baseCenter = MapType == 1
                        ? ImVec2(MinimapCenterX, MinimapCenterY)
                        : ImVec2(BigmapCenterX, BigmapCenterY);
                    ImVec2 mapCenter(baseCenter.x + minimapOffsetX, baseCenter.y + minimapOffsetY);
                    ImVec2 relative(iconPos.x - baseCenter.x, iconPos.y - baseCenter.y);
                    float rotationRad = minimapRotation * ((float)M_PI / 180.0f);
                    float cosRotation = cosf(rotationRad);
                    float sinRotation = sinf(rotationRad);
                    ImVec2 rotated(relative.x * cosRotation - relative.y * sinRotation,
                                   relative.x * sinRotation + relative.y * cosRotation);
                    iconPos = ImVec2(mapCenter.x + rotated.x * minimapCustomScale,
                                     mapCenter.y + rotated.y * minimapCustomScale);
                    if (heroTexture) {
                        Vector2 selectedMapSize = MapType == 1 ? MinimapSize : BigmapSize;
                        ImVec2 mapSize(selectedMapSize.x * minimapCustomScale,
                                       selectedMapSize.y * minimapCustomScale);
                        draw->AddRect(
                            ImVec2(mapCenter.x - mapSize.x * 0.5f, mapCenter.y - mapSize.y * 0.5f),
                            ImVec2(mapCenter.x + mapSize.x * 0.5f, mapCenter.y + mapSize.y * 0.5f),
                            IM_COL32(255, 255, 255, 255), 0.0f, 0, 1.0f);

                        float radius = std::max(3.0f, (float)(Maxscale / kScale * 0.5f) * iconScale);
                        draw->AddImageRounded((__bridge ImTextureID)heroTexture,
                            ImVec2(iconPos.x - radius, iconPos.y - radius),
                            ImVec2(iconPos.x + radius, iconPos.y + radius),
                            ImVec2(0, 0), ImVec2(1, 1), IM_COL32_WHITE, radius, ImDrawFlags_RoundCornersAll);
                        draw->AddCircle(iconPos, radius + 1.0f, IM_COL32_WHITE, 24, 1.0f);
                        DrawCircleHealth2(iconPos, Health, MaxHealth, radius + 1.0f, 2.2f);
                    }
                }

                if (ESPEnable && ShowArrowToEnemy) {
                    bool isVisible = !CheckVisible;

                    ImVec2 direction = ImVec2(rootPos_Vec2.x - myPos_Vec2.x, rootPos_Vec2.y - myPos_Vec2.y);
                    float length = sqrtf(direction.x * direction.x + direction.y * direction.y);
                    if (length > 0.0f) {
                        ImVec2 normDir = ImVec2(direction.x / length, direction.y / length);

                        // Đặt đầu mũi tên gần rìa vòng tròn (khoảng cách từ người chơi)
                        float arrowDistanceFromPlayer = 60.0f;
                        ImVec2 arrowTip = ImVec2(myPos_Vec2.x + normDir.x * arrowDistanceFromPlayer,
                                                 myPos_Vec2.y + normDir.y * arrowDistanceFromPlayer);

                        // Kích thước mũi tên
                        float arrowLength = 10.0f;
                        float arrowWidth = 7.0f;

                        ImVec2 perp = ImVec2(-normDir.y, normDir.x);
                        ImVec2 baseCenter = ImVec2(arrowTip.x - normDir.x * arrowLength, arrowTip.y - normDir.y * arrowLength);
                        ImVec2 leftPoint = ImVec2(baseCenter.x + perp.x * (arrowWidth * 0.5f), baseCenter.y + perp.y * (arrowWidth * 0.5f));
                        ImVec2 rightPoint = ImVec2(baseCenter.x - perp.x * (arrowWidth * 0.5f), baseCenter.y - perp.y * (arrowWidth * 0.5f));

                        // Đổi màu theo trạng thái
                        ImU32 arrowColor = isVisible ? IM_COL32(0, 255, 0, 255) : IM_COL32(255, 0, 0, 255);

                        draw->AddTriangleFilled(arrowTip, leftPoint, rightPoint, arrowColor);
                    }
                }

                if (ESPEnable && Box4Lines) {
                    float heightScale = 1.3f;
                    float widthRatio = 0.75f;

                    float boxHeights = abs(headPos_Vec2SSS.y - rootPos_Vec2.y) * heightScale;
                    float boxWidths = boxHeights * widthRatio;

                    ImVec2 vBox = ImVec2(
                        headPos_Vec2SSS.x - (boxWidths / 2),
                        headPos_Vec2SSS.y
                    );

                    Box4Line(draw, 2.5f, vBox.x, vBox.y, boxWidths, boxHeights, 
                             FLinearColor(0.0f, 0.0f, 0.0f, 1.0f));

                    Box4Line(draw, 1.5f, vBox.x, vBox.y, boxWidths, boxHeights, 
                             FLinearColor(0.0f, 1.0f, 0.0f, 1.0f));
                }
            }
        }
    }

    if (NumberESP) {
        // Code port từ chapto.mm: Hộp đếm số lượng địch
        ImU32 backgroundColor = IM_COL32(0, 0, 0, 150);
        ImU32 borderColor = IM_COL32(255, 255, 255, 100);

        std::string countDisplay = std::to_string(soluongherosong) + " | " + std::to_string(soluongherochet);
        auto textSize = ImGui::CalcTextSize(countDisplay.c_str());

        float paddingX = 10.0f;
        float paddingY = 2.0f;

        ImVec2 topLeft = ImVec2((ImGui::GetIO().DisplaySize.x / 2) - (textSize.x / 2) - paddingX, 46.3f - textSize.y - paddingY);
        ImVec2 bottomRight = ImVec2((ImGui::GetIO().DisplaySize.x / 2) + (textSize.x / 2) + paddingX, 46.3f + paddingY);

        draw->AddRectFilled(topLeft, bottomRight, backgroundColor, 10.0f);
        draw->AddRect(topLeft, bottomRight, borderColor, 10.0f);
        draw->AddText(ImVec2((topLeft.x + bottomRight.x) / 2 - (textSize.x / 2), topLeft.y + paddingY), IM_COL32(255, 255, 255, 255), countDisplay.c_str());
    }

    if (Entity != NULL && AimSkill && DrawAimLine) {
        Vector3 myHeadPos = EnemyTarget.myPos + Vector3(0.0f, headHeightOffset - 1.0f, 0.0f);
        Vector3 enemyHeadPos = EnemyTarget.enemyPos + Vector3(0.0f, headHeightOffset - 1.0f, 0.0f);

        ImVec2 myScreenPos = WorldToScreen(myHeadPos);
        ImVec2 enemyScreenPos = WorldToScreen(enemyHeadPos);

        draw->AddLine(myScreenPos, enemyScreenPos, IM_COL32(116, 255, 23, 255), 1.2f); // rgb(116, 255, 23)
        draw->AddCircleFilled(enemyScreenPos, 4.0f, IM_COL32(116, 255, 23, 200)); 
        draw->AddCircle(enemyScreenPos, 6.0f, IM_COL32(116, 255, 23, 100), 64, 2.0f); 
    }
}

void DrawAimbotTab() {
    static int selectedAimWhen = AimType; 
    const char* aimWhenOptions[] = {"Theo % Máu", "Máu Thấp Nhất", "Khoảng Cách Gần", "Theo Hướng Skill"};
    if (ImGui::Combo("Chọn Mục Tiêu", &selectedAimWhen, aimWhenOptions, IM_ARRAYSIZE(aimWhenOptions))) {
        AimType = selectedAimWhen;
    }
}

static bool AutoSet= false;
static bool Reset1lan = false;
int HeroSet = 0;
static int ResetSkill = -1;
static bool ResetDraw = false;

void AutoHero() {
    const char* HeroList[] = {
        "Tướng Tuỳ Chỉnh", "Elsu", "Gildur", "Grakk", "Slimz",
        "Yue", "Natalya", "Enzo", "Stuart", "Florentino",
        "Volkath", "Raz"
    };

    ImGui::AlignTextToFramePadding();
    if (ImGui::Combo("Chọn Tướng", &HeroSet, HeroList, IM_ARRAYSIZE(HeroList))) {
        AutoSet = false;
        Reset1lan = false;
        ResetSkill = -1;
        ResetDraw = false;
    }

    if (ResetSkill != HeroSet) {
        ResetSkill = HeroSet;
        Reset1lan = false;

        AimSkill1 = false;
        AimSkill2 = false;
        AimSkill3 = false;

        switch (HeroSet) {
            case 0: // Hero Custom
                KhoangCach = 0.0f;
                DoLechAim = 0.0f;
                break;

            case 1: // Elsu
                KhoangCach = 25.0f;
                DoLechAim = 0.368f;
                AimSkill2 = true;
                break;

            case 2: // Gildur
                KhoangCach = 15.0f;
                DoLechAim = 1.064f;
                AimSkill2 = true;
                break;

            case 3: // Grakk
                KhoangCach = 13.0f;
                DoLechAim = 1.085f;
                AimSkill2 = true;
                break;

            case 4: // Slimz
                KhoangCach = 19.0f;
                DoLechAim = 1.692f;
                AimSkill1 = true;
                break;

            case 5: // Yue
                KhoangCach = 14.0f;
                DoLechAim = 0.952f;
                AimSkill2 = true;
                break;

            case 6: // Natalya
                KhoangCach = 13.0f;
                DoLechAim = 1.556f;
                AimSkill2 = true;
                break;

            case 7: // Enzo
                KhoangCach = 11.0f;
                DoLechAim = 0.932f;
                AimSkill2 = true;
                break;

            case 8: // Stuart
                KhoangCach = 17.0f;
                DoLechAim = 1.418f;
                AimSkill1 = true;
                break;

            case 9: // Florentino
                KhoangCach = 9.0f;
                DoLechAim = 0.542f;
                AimSkill1 = true;
                break;

            case 10: // Volkath
                KhoangCach = 11.0f;
                DoLechAim = 1.032f;
                AimSkill2 = true;
                break;

            case 11: // Raz
                KhoangCach = 12.0f;
                DoLechAim = 0.842f;
                AimSkill2 = true;
                break;
        }

        Reset1lan = true;
        ResetDraw = true;
    }

    if (HeroSet == 5) { // Yue
        AimSkill1 = (GetDistanceEnemy <= 10.0f);
    }

    if (HeroSet == 9) { // Florentino
        AimSkill3 = (GetDistanceEnemy <= 7.5f);
    }

    if (HeroSet == 11) { // Raz
        AimSkill1 = (GetDistanceEnemy <= 4.5f);
        AimSkill3 = (GetDistanceEnemy <= 7.0f);
    }
}
