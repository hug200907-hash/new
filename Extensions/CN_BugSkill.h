#pragma once

// BugSkill được thay bằng logic đang dùng trong Black VIP.
// BugSkill kéo dài tầm; Showline chỉ vẽ tia/chấm chỉ báo.
void DrawBugSkill(ImDrawList *draw) {
    if ((!BugSkill && !Showline) || !draw || !espManager || !espManager->MyPlayer)
        return;

    void *myActorLinker = espManager->MyPlayer;
    void *objLinker = *(void **)((uintptr_t)myActorLinker + ActorLinker_ObjLinker);
    if (!objLinker) return;

    int configID = *(int *)((uintptr_t)objLinker + ActorConfig_ConfigID);
    int skillID = 0;
    float rangeOrigin = 0.0f;
    float rangeFuture = 0.0f;

    switch (configID) {
        case 173: skillID = 3; rangeOrigin = 8.98f;  rangeFuture = 9.50f;  break; // Fennik
        case 531: skillID = 1; rangeOrigin = 4.90f;  rangeFuture = 5.40f;  break; // Keera
        case 123: skillID = 3; rangeOrigin = 11.90f; rangeFuture = 12.50f; break; // Maloch
        case 137: skillID = 3; rangeOrigin = 19.90f; rangeFuture = 20.70f; break; // Paine
        case 150: skillID = 1; rangeOrigin = 5.40f;  rangeFuture = 6.00f;  break; // Nakroth
        case 146: skillID = 2; rangeOrigin = 6.90f;  rangeFuture = 7.50f;  break; // Zill
        case 169: skillID = 2; rangeOrigin = 5.90f;  rangeFuture = 6.30f;  break; // Slimz
        case 536: skillID = 1; rangeOrigin = 5.40f;  rangeFuture = 6.10f;  break; // Aoi
        case 149: skillID = 2; rangeOrigin = 5.90f;  rangeFuture = 6.40f;  break; // Xeniel
        case 162: skillID = 3; rangeOrigin = 6.90f;  rangeFuture = 7.50f;  break; // Kriknak
        case 107: skillID = 3; rangeOrigin = 6.40f;  rangeFuture = 7.00f;  break; // Zephys
        case 523: skillID = 2; rangeOrigin = 8.98f;  rangeFuture = 9.60f;  break; // Darcy
        case 539: skillID = 1; rangeOrigin = 8.98f;  rangeFuture = 9.56f;  break; // Lorion
        case 156: skillID = 2; rangeOrigin = 7.98f;  rangeFuture = 8.68f;  break; // Aleister
        case 534: skillID = 2; rangeOrigin = 6.48f;  rangeFuture = 6.90f;  break; // Dextra
        case 510: skillID = 1; rangeOrigin = 7.98f;  rangeFuture = 8.40f;  break; // Liliana
        case 118: skillID = 1; rangeOrigin = 8.98f;  rangeFuture = 9.88f;  break; // Alice
        case 177: skillID = 2; rangeOrigin = 10.98f; rangeFuture = 12.07f; break; // Lindis
        case 187: skillID = 2; rangeOrigin = 6.98f;  rangeFuture = 7.68f;  break; // Arum
        case 148: skillID = 2; rangeOrigin = 7.98f;  rangeFuture = 8.34f;  break; // Preyta
        case 152: skillID = 1; rangeOrigin = 7.98f;  rangeFuture = 8.44f;  break; // Điêu Thuyền
        case 171: skillID = 2; rangeOrigin = 6.48f;  rangeFuture = 6.89f;  break; // Cresht
        case 124: skillID = 2; rangeOrigin = 7.98f;  rangeFuture = 8.42f;  break; // Ignis
        case 191: skillID = 2; rangeOrigin = 9.98f;  rangeFuture = 10.46f; break; // Rouie
        case 519: skillID = 1; rangeOrigin = 8.98f;  rangeFuture = 9.58f;  break; // Annette
        case 541: skillID = 1; rangeOrigin = 9.48f;  rangeFuture = 9.77f;  break; // Bonnie
        case 596: skillID = 2; rangeOrigin = 7.90f;  rangeFuture = 8.78f;  break; // Goverra
        default: return;
    }

    void *skillUse = skillID == 1 ? Req1 : (skillID == 2 ? Req2 : Req3);
    if (!skillUse) return;

    void *skillIndicator = *(void **)((uintptr_t)skillUse + Sk_skillIndicator);
    if (!skillIndicator) return;

    static uintptr_t useOffsetPositionOffset = 0;
    static uintptr_t useSkillPositionOffset = 0;
    static uintptr_t initSkillCfgOffset = 0;
    static uintptr_t maxAttackDistanceOffset = 0;
    static uintptr_t guideDistanceOffset = 0;
    static dispatch_once_t bugSkillOffsetToken;
    dispatch_once(&bugSkillOffsetToken, ^{
        useOffsetPositionOffset = newGetFieldOffset("Project_d.dll", "Assets.Scripts.GameLogic", "SkillControlIndicator", "useOffsetPosition");
        useSkillPositionOffset = newGetFieldOffset("Project_d.dll", "Assets.Scripts.GameLogic", "SkillControlIndicator", "useSkillPosition");
        initSkillCfgOffset = newGetFieldOffset("Project_d.dll", "Assets.Scripts.GameLogic", "SkillSlot", "initSkillCfg");
        maxAttackDistanceOffset = newGetFieldOffset("AovTdr.dll", "ResData", "ResSkillCfgInfo", "iMaxAttackDistance");
        guideDistanceOffset = newGetFieldOffset("AovTdr.dll", "ResData", "ResSkillCfgInfo", "iGuideDistance");
    });

    if (!useOffsetPositionOffset || !useSkillPositionOffset) return;

    Vector3 myPosition = ActorLinker_getPosition(myActorLinker);
    Vector3 useOffsetPosition = *(Vector3 *)((uintptr_t)skillIndicator + useOffsetPositionOffset);
    float distance2D = sqrtf(useOffsetPosition.x * useOffsetPosition.x + useOffsetPosition.z * useOffsetPosition.z);
    Vector3 newOffset = useOffsetPosition;
    if (distance2D > rangeOrigin) {
        useOffsetPosition.Normalize();
        newOffset = useOffsetPosition * rangeFuture;
    }
    Vector3 skillPosition = myPosition + newOffset;

    if (BugSkill) {
        if (initSkillCfgOffset && maxAttackDistanceOffset && guideDistanceOffset) {
            void *initSkillCfg = *(void **)((uintptr_t)skillUse + initSkillCfgOffset);
            if (initSkillCfg) {
                int maxDistance = *(int *)((uintptr_t)initSkillCfg + maxAttackDistanceOffset);
                *(int *)((uintptr_t)initSkillCfg + guideDistanceOffset) = maxDistance;

                static std::unordered_map<void *, int> baseRadiusMap;
                if (baseRadiusMap.find(initSkillCfg) == baseRadiusMap.end())
                    baseRadiusMap[initSkillCfg] = *(int *)((uintptr_t)initSkillCfg + 0xF4);
                float scaleFactor = rangeFuture / rangeOrigin;
                *(int *)((uintptr_t)initSkillCfg + 0xF4) = (int)(baseRadiusMap[initSkillCfg] * scaleFactor);
            }
        }
        *(Vector3 *)((uintptr_t)skillIndicator + useSkillPositionOffset) = skillPosition;
    }

    if (Showline && SkillSlot == skillID) {
        void *camera = get_main();
        if (!camera) return;
        Vector3 mySC = WorldToScreens(camera, myPosition, 2);
        Vector3 skillSC = WorldToScreens(camera, skillPosition, 2);
        if (mySC.z <= 0.0f || skillSC.z <= 0.0f) return;

        ImVec2 from(mySC.x * kWidth, kHeight - mySC.y * kHeight);
        ImVec2 to(skillSC.x * kWidth, kHeight - skillSC.y * kHeight);
        draw->AddLine(from, to, IM_COL32(0, 255, 255, 255), 2.0f);
        draw->AddCircleFilled(to, 5.0f, IM_COL32(255, 225, 0, 255));
        draw->AddCircle(to, 6.0f, IM_COL32(255, 255, 255, 255), 0, 1.5f);
    }
}
