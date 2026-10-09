void (*_Skslot)(void *ins, int del);
void Skslot(void *ins, int del) {
    if (ins != NULL) {
        int slot = *(int *)((uintptr_t)ins + Sk_SlotType);
        void *skillControl = *(void **)((uintptr_t)ins + Sk_skillIndicator);

        if (skillControl == NULL) return;

        int range = *(int *)((uintptr_t)skillControl + Sk_curindicatorDistance);
        Vector3 currentPosition = *(Vector3 *)((uintptr_t)skillControl + Sk_useSkillDirection);

        switch (slot) {
                case 0:
                        Req0 = ins;
                        Rangeskill0 = (float)range / 1000.0f;
                    break;
                    case 1:
                        Req1 = ins;
                        Rangeskill1 = (float)range / 1000.0f;
                    break;
                    case 2:
                        Req2 = ins;
                        Rangeskill2 = (float)range / 1000.0f;
                    break;
                    case 3:
                        Req3 = ins;
                        Rangeskill3 = (float)range / 1000.0f;
                    break;
                        case 4:
                        Req4 = ins;
                    break;
                        case 5:
                        Req5 = ins;
                    break;
                        case 6:
                        Req6 = ins;
                    break;
                        case 9:
                        Req9 = ins;
                    break;
                        case 13:
                        Req13 = ins;
                        Rangeskill13 = (float)range / 1000.0f;
                    break;
                default:
            break;
        }
        if (slot == SkillSlot) CurrentPosition = currentPosition;

        void* MySkill = Lmyactor;
        if (!MySkill) return;
        void* SKControl = LActorRoot_AsHero(MySkill);
        bool AutoPTLogID = false, AutoBPLogID = false, AutoTTLogID = false, CastSkill5 = false;
        if (SKControl != NULL) {
            HeroWrapSkillData SkillData5 = LHeroWrapper_GetHeroWrapSkillData(SKControl, 5);
            HeroWrapSkillData SkillData9 = LHeroWrapper_GetHeroWrapSkillData(SKControl, 9);
            AutoPTLogID = (SkillData9.SkillId == 80112 || SkillData9.SkillId == 8810101 || SkillData9.SkillId == 91145
                          || SkillData9.SkillId == 91149 || SkillData9.SkillId == 91020 || SkillData9.SkillId == 916211 || SkillData9.SkillId == 916231) ? true : false;
            AutoBPLogID = (SkillData5.SkillId == 80108) ? true : false;
            AutoTTLogID = (SkillData5.SkillId == 80104 || SkillData5.SkillId == 80116) ? true : false;

            void* MyActorLinker = espManager->MyPlayer;
            if (AutoPhuTro && AutoPTLogID && slot == 9) {
                if (MyActorLinker) {
                    void *ValueLinkerComponent = *(void **)((uint64_t)MyActorLinker + Actorlk_ValueComponent);
                    int Hp = ValueLinkerComponent_get_actorHp(ValueLinkerComponent);
                    int Hpt = ValueLinkerComponent_get_actorHpTotal(ValueLinkerComponent);
                    if (Hp <= 0 || Hpt <= 0) return;
                    float Per = ((float)Hp / (float)Hpt) * 100.0f;

                    for (int i = 0; i < espManager->enemies->size(); i++) {
                        void* MyActor = espManager->MyPlayer;
                        void* Enemy = (*espManager->enemies)[i]->object;
                        Vector3 MyPos  = Vector3::zero();
                        Vector3 EnemyPos = Vector3::zero();
                        if (!MyActor || !Enemy) continue;

                        MyPos = ActorLinker_getPosition(MyActor);
                        VInt3* locationPtr = (VInt3*)((uint64_t)Enemy + LActorRoot_location);
                        VInt3* forwardPtr = (VInt3*)((uint64_t)Enemy + LActorRoot_forward);
                        EnemyPos = VInt2Vector(*locationPtr, *forwardPtr);
                        float Distance = Vector3::Distance(MyPos, EnemyPos);

                        void *LObjWrapper = *(void **)((uint64_t)Enemy + LActorRoot_ActorControl);
                        void *ValuePropertyComponent = *(void **)((uint64_t)Enemy + LActorRoot_ValueComponent);

                        if (!LObjWrapper || !ValuePropertyComponent) continue;
                        if (LObjWrapper_get_IsDeadState(LObjWrapper)) continue;
                        int Health = ValuePropertyComponent_get_actorHp(ValuePropertyComponent);
                        int MaxHealth = ValuePropertyComponent_get_actorHpTotal(ValuePropertyComponent);
                        if (Health < 0 || MaxHealth < 0) continue;
                        float HpEnemy = ((float)Health / (float)MaxHealth) * 100.0f;
                        if (HpEnemy > 0.1f && Distance <= 10.0f && Per > 0.1f && Per <= MyHP) {
                            Reqskill2(ins, false);
                            Reqskill(ins);
                        }
                    }
                }
            }

            if (slot == 5) {
                if (AutoBocPha && AutoBPLogID) {
                    for (int i = 0; i < espManager->enemies->size(); i++) {
                        void* MyActor = espManager->MyPlayer;
                        void* Enemy = (*espManager->enemies)[i]->object;
                        Vector3 MyPos  = Vector3::zero();
                        Vector3 EnemyPos = Vector3::zero();
                        if (!MyActor || !Enemy) continue;

                        MyPos = ActorLinker_getPosition(MyActor);
                        VInt3* locationPtr = (VInt3*)((uint64_t)Enemy + LActorRoot_location);
                        VInt3* forwardPtr = (VInt3*)((uint64_t)Enemy + LActorRoot_forward);
                        EnemyPos = VInt2Vector(*locationPtr, *forwardPtr);
                        float Distance = Vector3::Distance(MyPos, EnemyPos);

                        void *LObjWrapper = *(void **)((uint64_t)Enemy + LActorRoot_ActorControl);
                        void *ValuePropertyComponent = *(void **)((uint64_t)Enemy + LActorRoot_ValueComponent);

                        if (!LObjWrapper || !ValuePropertyComponent) continue;
                        if (LObjWrapper_get_IsDeadState(LObjWrapper)) continue;
                        int Health = ValuePropertyComponent_get_actorHp(ValuePropertyComponent);
                        int MaxHealth = ValuePropertyComponent_get_actorHpTotal(ValuePropertyComponent);
                        if (Health < 0 || MaxHealth < 0) continue;
                        float HpEnemy = ((float)Health / (float)MaxHealth) * 100.0f;
                        if (Distance < 5.0f && HpEnemy > 0.1f && HpEnemy <= EnemyHP) {
                            CastSkill5 = true;
                            break;
                        }
                    }
                }

                if (AutoTrungTri && AutoTTLogID) {
                    void* MyLevel = *(void**)((uintptr_t)MyActorLinker + Actorlk_ValueComponent);
                    if (!MyLevel) return;
                    int MyLv = ValueLinkerComponent_get_actorSoulLevel(MyLevel) - 1;
                    int MinHp = 1350 + 100 * MyLv;

                    for (int i = 0; i < MonsterManager->enemies->size(); i++) {
                        void * ActorLK_Monster = (*MonsterManager->enemies)[i]->object;
                        if (ActorLK_Monster == NULL) continue;

                        void* ObjLinker = *(void **)((uintptr_t)ActorLK_Monster + Actorlk_ObjLinker);
                        void* ValueLinkerComponent = *(void **)((uint64_t)ActorLK_Monster + Actorlk_ValueComponent);
                        if (ValueLinkerComponent == NULL) continue;

                        int health = ValueLinkerComponent_get_actorHp(ValueLinkerComponent);
                        if (health < 1) continue;

                        int ConfigID = *(int *)((uintptr_t)ObjLinker + ActorConfig_ConfigID);

                        bool isTarget = false;
                        if (TTBua) isTarget = (ConfigID == 7010 || ConfigID == 7011); // bùa xanh/đỏ
                        if (TTBosst) isTarget = (ConfigID == 7012 || ConfigID == 7024 || ConfigID == 7009 || ConfigID == 70092 || ConfigID == 70093); // rồng, tà thần
                        if (TTALL) isTarget = (ConfigID == 7010 || ConfigID == 7011 || ConfigID == 7012 || ConfigID == 7024 || ConfigID == 7009 || ConfigID == 70092 || ConfigID == 70093); // ALL Monster

                        if (!isTarget) continue;

                        Vector3 MyPos = ActorLinker_getPosition(MyActorLinker);
                        Vector3 EnemyPos = ActorLinker_getPosition(ActorLK_Monster);
                        float distance = Vector3::Distance(MyPos, EnemyPos);

                        if (distance <= 5.0f && health <= MinHp) {
                            CastSkill5 = true;
                            break;
                        }
                    }
                }

                if (CastSkill5) {
                    Reqskill2(Req5, false);
                    Reqskill(Req5);
                }
            }
        }

        // if (bugSkillEnabled && espManager->MyPlayer != NULL) {
        //     void *myObjLinker = *(void **)((uintptr_t)espManager->MyPlayer + newGetFieldOffset("Project_d.dll", "Kyrios.Actor", "ActorLinker", "ObjLinker"));
        //     if (!myObjLinker) return;
        //     int currentHeroID = *(int *)((uintptr_t)myObjLinker + newGetFieldOffset("Project_d.dll", "Assets.Scripts.GameLogic", "ActorConfig", "ConfigID"));
        //     BugSkillInfo enemyInfo = GetEnemySkillRangeByID(currentHeroID);
        //     if (enemyInfo.skillID > 0 && enemyInfo.rangeFuture > 0.0f && enemyInfo.rangeOrigin > 0.0f)
        //     {
        //         Vector3 useOffsetPosition = *(Vector3 *)((uintptr_t)skillControl + newGetFieldOffset("Project_d.dll", "Assets.Scripts.GameLogic", "SkillControlIndicator", "useOffsetPosition"));
        //         float currentAimDistance = Vector3::Magnitude(useOffsetPosition);
        //         if (currentAimDistance > enemyInfo.rangeOrigin)
        //         {
        //             Vector3 aimDirection = Vector3::Normalized(useOffsetPosition);
        //             float targetLength = enemyInfo.rangeFuture - debugDistanceSub;
        //             if (targetLength < 0.0f) targetLength = 0.0f;
        //             Vector3 newOffset = aimDirection * targetLength;
        //             *(Vector3 *)((uintptr_t)skillControl + newGetFieldOffset("Project_d.dll", "Assets.Scripts.GameLogic", "SkillControlIndicator", "useOffsetPosition")) = newOffset;
        //         }
        //     }
        // }
    }
    return _Skslot(ins, del);
}