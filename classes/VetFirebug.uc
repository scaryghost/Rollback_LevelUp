class VetFirebug extends KFVetFirebug;

static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P) {
    // If Level 5 or 6, give them a Flame Thrower
    if (KFPRI.ClientVeteranSkillLevel >= 5) {
        KFHumanPawn(P).CreateInventoryVeterancy("KFMod.FlameThrower", GetCostScaling(KFPRI, class'FlamethrowerPickup'));
    }

    // If Level 6, give them Body Armor
    if (KFPRI.ClientVeteranSkillLevel == 6) {
        P.ShieldStrength = 100;
    }
}
