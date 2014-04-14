class VetSharpshooter extends KFVetSharpshooter;

static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, 
        int InDamage, class<DamageType> DmgType) {
    if (DmgType == class'DamTypeCrossbow' || DmgType == class'DamTypeWinchester' || 
            DmgType == class'DamTypeDeagle' || DmgType == class'DamTypeDualDeagle' ||
            DmgType == class'DamTypeDualies' || DmgType == class'Rollback_LevelUp.DamTypeM14EBR' ) {
        if (KFPRI.ClientVeteranSkillLevel <= 3) {
            return float(InDamage) * (1.05 + (0.05 * float(KFPRI.ClientVeteranSkillLevel)));
        } else if (KFPRI.ClientVeteranSkillLevel == 4) {
            return float(InDamage) * 1.30;
        } else if (KFPRI.ClientVeteranSkillLevel == 5) {
            return float(InDamage) * 1.50;
        }

        return float(InDamage) * 1.60; // 60% increase in Crossbow/Winchester/Handcannon damage
    }

    return InDamage;
}

static function float GetHeadShotDamMulti(KFPlayerReplicationInfo KFPRI, KFPawn P, class<DamageType> DmgType) {
    if (KFPRI.ClientVeteranSkillLevel == 0) {
        return 1.05;
    }

    return 1.0 + (0.10 * float(Min(KFPRI.ClientVeteranSkillLevel, 5)));
}

static function float GetFireSpeedMod(KFPlayerReplicationInfo KFPRI, Weapon Other) {
    if (Winchester(Other) != none) {
        if (KFPRI.ClientVeteranSkillLevel == 0) {
            return 1.0;
        }

        return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% faster fire rate with Winchester
    }
    return 1.0;
}

static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item) {
    if (Item == class'DeaglePickup' || Item == class'DualDeaglePickup' || Item == class'Rollback_LevelUp.M14EBRPickup') {
        return 0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 70% discount on Handcannon/Dual Handcannons/EBR
    }

    return 1.0;
}

// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P) {
    // If Level 5, give them a  Lever Action Rifle
    if (KFPRI.ClientVeteranSkillLevel == 5 ) {
        KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Winchester", GetCostScaling(KFPRI, class'WinchesterPickup'));
    }

    // If Level 6, give them a Crossbow
    if (KFPRI.ClientVeteranSkillLevel == 6) {
        KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Crossbow", GetCostScaling(KFPRI, class'CrossbowPickup'));
    }
}
