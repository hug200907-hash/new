bool isSkinLocked(uint32_t skinId) {
    if (FullSkin) return false;
    return LockSkinAo && lockedSkins.count(skinId);
}

class TdrReadBuf {
private:
    std::vector<uint8_t> beginPtr;
    int32_t position;
    int32_t length;
    bool isNetEndian;
public:
    bool isUseCache;
};

namespace CSProtocol {
	class COMDT_HERO_COMMON_INFO {
    public:
        uint32_t getdwHeroID() {
            return *(uint32_t *)((uint64_t)this + UL_dwHeroID);
        };
        uint16_t getwSkinID() {
            return *(uint16_t *)((uint64_t)this + UL_wSkinID);
        };

        void setdwHeroID(uint32_t dwHeroID) {
            *(uint32_t *)((uint64_t)this + UL_dwHeroID) = dwHeroID;
        };
        void setwSkinID(uint16_t wSkinID) {
            *(uint16_t *)((uint64_t)this + UL_wSkinID) = wSkinID;
		};
    };

	struct saveData {
        static uint32_t heroId;
        static uint16_t skinId;
		static bool enable;
		static std::vector<std::pair<COMDT_HERO_COMMON_INFO*, uint16_t>> arrayUnpackSkin;

        static void setData(uint32_t hId, uint16_t sId) {
            heroId = hId;
            skinId = sId;
        }

		static void setEnable(bool eb) {
            enable = eb;
        }

        static uint32_t getHeroId() {
            return heroId;
        }

        static uint16_t getSkinId() {
            return skinId;
        }

		static bool getEnable() {
            return enable;
        }

		static void resetArrayUnpackSkin() {
    		if (!saveData::arrayUnpackSkin.empty()) {
        		for (const auto& skinInfo : saveData::arrayUnpackSkin) {
            		COMDT_HERO_COMMON_INFO* heroInfo = skinInfo.first;
            		uint16_t skinId = skinInfo.second;
            		heroInfo->setwSkinID(skinId);
        		}
        		saveData::arrayUnpackSkin.clear();
    		}
		}
    };

    uint32_t saveData::heroId = 0;
    uint16_t saveData::skinId = 0;
	bool saveData::enable = false;
	std::vector<std::pair<COMDT_HERO_COMMON_INFO*, uint16_t>> saveData::arrayUnpackSkin;
}

void hook_unpack(CSProtocol::COMDT_HERO_COMMON_INFO* instance) { // Khoá Skin Ảo
	if (!CSProtocol::saveData::enable) return;
    uint32_t heroId = instance->getdwHeroID();
    uint16_t targetSkin = CSProtocol::saveData::skinId;
    if (heroId == CSProtocol::saveData::heroId &&
        heroId != 0 && targetSkin != 0 &&
        !isSkinLocked(targetSkin)) {
		CSProtocol::saveData::arrayUnpackSkin.emplace_back(instance, instance->getwSkinID());
		instance->setwSkinID(targetSkin);
	}
}

int (*old_unpack)(CSProtocol::COMDT_HERO_COMMON_INFO* instance, TdrReadBuf& srcBuf, int32_t cutVer);
int unpack(CSProtocol::COMDT_HERO_COMMON_INFO* instance, TdrReadBuf& srcBuf, int32_t cutVer) {
    int result = old_unpack(instance, srcBuf, cutVer);
	if (instance != NULL && (Unlockskin || FullSkin)) hook_unpack(instance);
    return result;
}

void (*RefreshHeroPanel)(void *instance, bool bForceRefreshAddSkillPanel, bool bRefreshSymbol, bool bRefreshHeroSkill);
void (*old_OnClickSelectHeroSkin)(void *instance, uint32_t heroId, uint32_t skinId);
void OnClickSelectHeroSkin(void *instance, uint32_t heroId, uint32_t skinId) {
	if (instance != NULL && (Unlockskin || FullSkin) && heroId != 0) RefreshHeroPanel(instance, true, true, true);
	old_OnClickSelectHeroSkin(instance, heroId, skinId);
}

bool (*old_IsCanUseSkin)(void *instance, uint32_t heroId, uint32_t skinId);
bool IsCanUseSkin(void *instance, uint32_t heroId, uint32_t skinId) {
    if (instance != NULL && (Unlockskin || FullSkin)) { // Unlock / Full Skin
        if (!isSkinLocked(heroId * 100 + skinId)) {
            CSProtocol::saveData::setData(heroId, skinId);
            return true;
        }
        return false;
    }
    return old_IsCanUseSkin(instance, heroId, skinId);
}

uint32_t (*old_GetHeroWearSkinId)(void* instance, uint32_t heroId);
uint32_t GetHeroWearSkinId(void* instance, uint32_t heroId) {
    currentHeroId = heroId;
    uint32_t skinId = 0;
    if (instance != NULL && (Unlockskin || FullSkin)) { // Unlock / Full Skin
        CSProtocol::saveData::setEnable(true);
        skinId = CSProtocol::saveData::getSkinId();

        if (!isSkinLocked(heroId * 100 + skinId)) {
            currentSkinId = skinId;
            UpdateButtonID(currentHeroId, currentSkinId);
            UpdateTypeKill(currentHeroId, currentSkinId);
            return skinId;
        }
    }
    skinId = old_GetHeroWearSkinId(instance, heroId);

    currentSkinId = skinId;
    UpdateButtonID(currentHeroId, currentSkinId);
    UpdateTypeKill(currentHeroId, currentSkinId);

    return skinId;
}

bool (*old_IsHaveHeroSkin)(uint32_t heroId, uint32_t skinId, bool isIncludeTimeLimited);
bool IsHaveHeroSkin(uint32_t heroId, uint32_t skinId, bool isIncludeTimeLimited = false) {
    if (Unlockskin || FullSkin) { // Unlock / Full Skin
        return !isSkinLocked(heroId * 100 + skinId);
    }
    return old_IsHaveHeroSkin(heroId, skinId, isIncludeTimeLimited);
}

// EVO 5
void *(*GetAwakeSkinData)(uint32_t wakeSkinID);
bool  (*_IsAwakeSkin)(uint32_t wakeSkinID);
bool IsAwakeSkin(uint32_t wakeSkinID) {
    bool result = _IsAwakeSkin(wakeSkinID);
    if (result && UnlockEvo5) {
        void *awakeSkin = GetAwakeSkinData(wakeSkinID);
        if (awakeSkin) {
            uintptr_t base = (uintptr_t)awakeSkin;
            *(uint8_t  *)(base + UL_bCurWearLevel) = 5;
            *(uint8_t  *)(base + UL_bWakeLevel) = 5;
            *(uint64_t *)(base + UL_ullWakeFeatureMask) = UINT64_MAX;
            *(uint64_t *)(base + UL_ullWearFeatureMask) = UINT64_MAX;
        }
    }
    return result;
}

int (*_UnpackEvo5)(uintptr_t instance, void **srcBuf, uint32_t cutVer);
int UnpackEvo5(uintptr_t instance, void **srcBuf, uint32_t cutVer) {
    auto result = _UnpackEvo5(instance, srcBuf, cutVer);
    if (result == 0 && UnlockEvo5) {
        uintptr_t base = (uintptr_t)instance;
        *(uint8_t  *)(base + UL_bSkinWakeLevel) = 5;
        *(uint64_t *)(base + UL_ullSkinWakeFeatureMask) = UINT64_MAX;
    }
    return result;
}

// Unlock Phụ Kiện
// int (*_pack)(uintptr_t instance, void **srcBuf, uint32_t cutVer);
// int pack(uintptr_t instance, void **srcBuf, uint32_t cutVer) {
// 	auto result = _pack(instance, srcBuf, cutVer);
// 	if (Unlockskin) {

//         if (result) return result;
//         isWearComponent = 1;

//         void *stSkinInfo = *(void **)(instance + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("CSPKG_SKINCOMPONENT_WEAR_REQ"), ENCRYPT("stSkinInfo")));

//         if (stSkinInfo != NULL) {
//             iSkinID = *(int *)((uintptr_t)stSkinInfo + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_SKIN"), ENCRYPT("iSkinID")));
//             Array<void *> * astCompList = *(Array<void *> **)((uintptr_t)stSkinInfo + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_SKIN"), ENCRYPT("astCompList")));

//             if (astCompList != NULL) {
//                 selectedComp = astCompList->getPointer()[0];

//                 iID = *(int *)((uintptr_t)selectedComp + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_COMP_DETAIL"), ENCRYPT("iID")));
//                 chType = *(int *)((uintptr_t)selectedComp + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_COMP_DETAIL"), ENCRYPT("chType")));

//                 compListData.push_back({iID, chType});
//             }
//         }
//         return result;
//     }
// }

// int (*_pack2)(uintptr_t instance, void **srcBuf, uint32_t cutVer);
// int pack2(uintptr_t instance, void **srcBuf, uint32_t cutVer) {
// 	auto result = _pack2(instance, srcBuf, cutVer);
//     if (Unlockskin) {
//         if (result) return result;

//         isWearComponent = 0;
//         void *stSkinInfo = *(void **)(instance + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("CSPKG_SKINCOMPONENT_WEAR_REQ"), ENCRYPT("stSkinInfo")));

//         if (stSkinInfo != NULL) {
//             Array<void *> * astCompList = *(Array<void *> **)((uintptr_t)stSkinInfo + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_SKIN"), ENCRYPT("astCompList")));

//             if (astCompList != NULL) {
//                 selectedComp = astCompList->getPointer()[0];

//                 iID = *(int *)((uintptr_t)selectedComp + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_COMP_DETAIL"), ENCRYPT("iID")));
//                 chType = *(int *)((uintptr_t)selectedComp + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_COMP_DETAIL"), ENCRYPT("chType")));

//                 for (auto it = compListData.begin(); it != compListData.end(); ) {
//                     if (it->first == iID && it->second == chType)
//                         it = compListData.erase(it);
//                     else
//                         ++it;
//                 }
//             }
//         }
//         return result;
//     }
// }

// int getFirstNDigits(int number, int n) {
// 	std::string str = std::to_string(number);
// 	if (n > str.length()) {
// 		return number;
// 	}
// 	std::string firstN = str.substr(0, n);
// 	return std::stoi(firstN);
// }

// void applyCompList(Array<void *> *CompList) {
// 	if (CompList == NULL || compListData.empty()) return;

// 	int count = CompList->getLength();
// 	size_t compDataIndex = 0;

// 	for (int i = 0; i < count && compDataIndex < compListData.size(); i++) {
// 		void *comp = CompList->getPointer()[i];
// 		if (comp == NULL) continue;

// 		int curID = *(int *)((uintptr_t)comp + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_COMP_DETAIL"), ENCRYPT("iID")));
// 		uint8_t curChType = *(uint8_t *)((uintptr_t)comp + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_COMP_DETAIL"), ENCRYPT("chType")));
// 		const auto &data = compListData[compDataIndex];

// 		if (curChType == data.second || (curID == 0 && curChType == 0)) {
// 			*(int *)((uintptr_t)comp + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_COMP_DETAIL"), ENCRYPT("iID"))) = data.first;
// 			*(uint8_t *)((uintptr_t)comp + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_COMP_DETAIL"), ENCRYPT("chType"))) = data.second;
// 			compDataIndex++;
// 		}
// 	}
// }

// int (*_UnpackPK)(uintptr_t instance, void **srcBuf, uint32_t cutVer);
// int UnpackPK(uintptr_t instance, void **srcBuf, uint32_t cutVer) {
// 	auto result = _UnpackPK(instance, srcBuf, cutVer);
//     if (Unlockskin) {
//         if (result) return result;
//         int *iSkinID2 = (int *)(instance + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_SKIN"), ENCRYPT("iSkinID")));

//         if (iSkinID2 == &iSkinID && isWearComponent == 1) {
//             Array<void *> *CompList = *(Array<void *> **)(instance + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_SKIN"), ENCRYPT("astCompList")));
//             applyCompList(CompList);
//         } else if (getFirstNDigits(iSkinID, 3) == getFirstNDigits(*iSkinID2, 3) && *iSkinID2 > 0) {
//             *iSkinID2 = iSkinID;
//             Array<void *> *CompList = *(Array<void *> **)(instance + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_SKIN"), ENCRYPT("astCompList")));

//             if (CompList != NULL && !compListData.empty()) {
//                 int count = CompList->getLength();
//                 size_t compDataIndex = 0;

//                 for (int i = 0; i < count && compDataIndex < compListData.size(); i++) {
//                     void *comp = CompList->getPointer()[i];
//                     if (comp == NULL) continue;

//                     const auto &data = compListData[compDataIndex];

//                     *(int *)((uintptr_t)comp + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_COMP_DETAIL"), ENCRYPT("iID"))) = data.first;
//                     *(uint8_t *)((uintptr_t)comp + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("COMDT_SKINCOMPONENT_COMP_DETAIL"), ENCRYPT("chType"))) = data.second;

//                     compDataIndex++;
//                 }
//             }
//         }
//         return result;
//     }
// }

// int (*_UnpackPK2)(uintptr_t instance, void **srcBuf, uint32_t cutVer);
// int UnpackPK2(uintptr_t instance, void **srcBuf, uint32_t cutVer){
// 	auto result = _UnpackPK2(instance, srcBuf, cutVer);
//     if (Unlockskin) {
//         if (result) return result;

//         void *stResultInfo = *(void **)(instance + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("SCPKG_SKINCOMPONENT_WEAR_RSP"), ENCRYPT("stResultInfo")));
//         if (stResultInfo != NULL) {
//             int *iResultId = (int *)((uintptr_t)stResultInfo + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("ResultInfo"), ENCRYPT("iResultId")));
//             if (*iResultId == 1) {
//                 *iResultId = 0;
//             }

//             if (*iResultId == 18113) {
//                 *iResultId = 0;
//             }
//         }

//         if (selectedComp != NULL) {
//             *(void **)(instance + newGetFieldOffset(ENCRYPT("AovTdr.dll"), ENCRYPT("CSProtocol"), ENCRYPT("SCPKG_SKINCOMPONENT_WEAR_RSP"), ENCRYPT("stSkinInfo"))) = selectedComp;
//         }
//         return result;
//     }
// }

// bool (*_get_isWear)(void *instance);
// bool get_isWear(void *instance) {
// 	if (Unlockskin) {
//         if (instance != NULL) {
//             *(bool *)((uintptr_t)instance + newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("ComponentItem"), ENCRYPT("own"))) = true;

//             uint32_t entry = *(uint32_t *)((uintptr_t)instance + newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("ComponentItem"), ENCRYPT("entry")));
//             uint32_t componentType = *(uint32_t *)((uintptr_t)instance + newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("ComponentItem"), ENCRYPT("componentType")));

//             if (entry == iID && isWearComponent > -1) {
//                 *(bool *)((uintptr_t)instance + newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("ComponentItem"), ENCRYPT("wear"))) = isWearComponent;
//                 *(bool *)((uintptr_t)instance + newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("ComponentItem"), ENCRYPT("isShow"))) = isWearComponent;
//                 *(bool *)((uintptr_t)instance + newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("ComponentItem"), ENCRYPT("isDefault"))) = isWearComponent;
//                 isWearComponent = -1;
//             }

//             if (entry != iID && componentType == chType) {
//                 *(bool *)((uintptr_t)instance + newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("ComponentItem"), ENCRYPT("wear"))) = false;
//                 *(bool *)((uintptr_t)instance + newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("ComponentItem"), ENCRYPT("isShow"))) = false;
//                 *(bool *)((uintptr_t)instance + newGetFieldOffset(ENCRYPT("Project_d.dll"), ENCRYPT("Assets.Scripts.GameSystem"), ENCRYPT("ComponentItem"), ENCRYPT("isDefault"))) = false;
//             }
//         }
//         return _get_isWear(instance);
//     }
// }



bool (*_IsSkinAvailable)(void *instance, int skinCfgId);
bool IsSkinAvailable(void *instance, int skinCfgId) {
    if (instance != NULL && FullSkin) {
        return true;
    }
    return _IsSkinAvailable(instance, skinCfgId);
}