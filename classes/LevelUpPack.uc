class LevelUpPack extends RollbackPack;

var array<class<Pickup> > weapons;

function array<class<Pickup> > getWeaponPickups() {
    return weapons;
}

function class<KFMonstersCollection> getMonstersCollection() {
    return class'LUMonstersCollection';
}

function string replaceActor(Actor other) {
    if (SCARMK17AssaultRifle(Other) != none) {
        SCARMK17AssaultRifle(Other).FireModeClass[0]= class'Rollback_LevelUp.SCARMK17Fire';
    } else if (Winchester(Other) != none) {
        Winchester(Other).FireModeClass[0]= class'Rollback_LevelUp.WinchesterFire';
    } else if (Axe(Other) != none) {
        Axe(Other).FireModeClass[0]= class'Rollback_LevelUp.AxeFire';
        Axe(Other).FireModeClass[1]= class'Rollback_LevelUp.AxeAltFire';
    } else if (Chainsaw(Other) != none) {
        Chainsaw(Other).FireModeClass[0]= class'Rollback_LevelUp.ChainsawFire';
        Chainsaw(Other).FireModeClass[1]= class'Rollback_LevelUp.ChainsawAltFire';
    } else if (Katana(Other) != none) {
        Katana(Other).FireModeClass[0]= class'Rollback_LevelUp.KatanaFire';
        Katana(Other).FireModeClass[1]= class'Rollback_LevelUp.KatanaAltFire';
    } else if (Knife(Other) != none) {
        Knife(Other).FireModeClass[0]= class'Rollback_LevelUp.KnifeFire';
        Knife(Other).FireModeClass[1]= class'Rollback_LevelUp.KnifeAltFire';
    } 
    return "";
}

defaultproperties {
    weapons(0)=Class'KFMod.MP7MPickup'
    weapons(1)=Class'KFMod.ShotgunPickup'
    weapons(2)=Class'KFMod.BoomStickPickup'
    weapons(3)=Class'KFMod.AA12Pickup'
    weapons(4)=Class'KFMod.SinglePickup'
    weapons(5)=Class'KFMod.DualiesPickup'
    weapons(6)=Class'KFMod.DeaglePickup'
    weapons(7)=Class'KFMod.DualDeaglePickup'
    weapons(8)=Class'KFMod.WinchesterPickup'
    weapons(9)=Class'Rollback_LevelUp.CrossbowPickup'
    weapons(10)=Class'Rollback_LevelUp.M14EBRPickup'
    weapons(11)=Class'KFMod.BullpupPickup'
    weapons(12)=Class'KFMod.AK47Pickup'
    weapons(13)=Class'KFMod.SCARMK17Pickup'
    weapons(14)=Class'KFMod.KnifePickup'
    weapons(15)=Class'Rollback_LevelUp.MachetePickup'
    weapons(16)=Class'KFRollback.AxePickup'
    weapons(17)=Class'KFRollback.ChainsawPickup'
    weapons(18)=Class'KFRollback.KatanaPickup'
    weapons(19)=Class'KFMod.FlameThrowerPickup'
    weapons(20)=Class'Rollback_LevelUp.PipebombPickup'
    weapons(21)=Class'KFMod.M79Pickup'
    weapons(22)=Class'Rollback_LevelUp.M32Pickup'
    weapons(23)=Class'KFMod.LAWPickup'
}
