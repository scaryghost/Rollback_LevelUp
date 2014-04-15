class VetBerserker extends KFVetBerserker;

var array<float> bloatDamageScale, damageScale, meleeSpeed;

static function float GetMeleeMovementSpeedModifier(KFPlayerReplicationInfo KFPRI) {
    return default.meleeSpeed[KFPRI.ClientVeteranSkillLevel];
}

static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType) {
    local float scale;

    if (DmgType == class'DamTypeVomit') {
        scale= default.bloatDamageScale[KFPRI.ClientVeteranSkillLevel];
    } else {
        scale= default.damageScale[KFPRI.ClientVeteranSkillLevel];
    }

    return float(InDamage) * scale;
}

static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item) {
    if (Item == class'KFRollback.ChainsawPickup' || Item == class'KFRollback.KatanaPickup') {
        return 0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel));
    }
    return 1.0;
}

static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P) {
    // If Level 5, give them Chainsaw
    if (KFPRI.ClientVeteranSkillLevel >= 5) {
        KFHumanPawn(P).CreateInventoryVeterancy("KFRollback.Chainsaw", GetCostScaling(KFPRI, class'KFRollback.ChainsawPickup'));
    }
}

defaultproperties {
    meleeSpeed(0)=0.0
    meleeSpeed(1)=0.15
    meleeSpeed(2)=0.15
    meleeSpeed(3)=0.15
    meleeSpeed(4)=0.15
    meleeSpeed(5)=0.15
    meleeSpeed(6)=0.20

    bloatDamageScale(0)=0.9
    bloatDamageScale(1)=0.75
    bloatDamageScale(2)=0.65
    bloatDamageScale(3)=0.50
    bloatDamageScale(4)=0.35
    bloatDamageScale(5)=0.25
    bloatDamageScale(6)=0.20

    damageScale(0)=1.0
    damageScale(1)=0.95
    damageScale(2)=0.90
    damageScale(3)=0.85
    damageScale(4)=0.85
    damageScale(5)=0.80
    damageScale(6)=0.75
}
