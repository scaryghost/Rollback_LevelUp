class LevelUpPack extends RollbackPack;

struct Replacement {
    var class<Object> oldClass;
    var class<Object> newClass;
};

var array<Replacement> firemodes, pickups;
var array<class<Pickup> > weapons;

function array<class<Pickup> > getWeaponPickups() {
    return weapons;
}

function class<KFMonstersCollection> getMonstersCollection() {
    return class'LUMonstersCollection';
}

function string replaceActor(Actor other) {
    local Weapon weapon;
    local Pickup pickup;
    local int i, j;

    if (Weapon(Other) != none) {
        weapon= Weapon(Other);
        for(i= 0; i < ArrayCount(weapon.FireModeClass); i++) {
            for(j= 0; j < firemodes.Length; j++) {
                if (ClassIsChildOf(weapon.FireModeClass[i], firemodes[j].oldClass)) {
                    weapon.FireModeClass[i]= class<WeaponFire>(firemodes[j].newClass);
                }
            }
        }
    } else if (Pickup(Other) != none) {
        pickup= Pickup(Other);
        for(i= 0; i < pickups.Length; i++) {
            if (ClassIsChildOf(pickup.class, pickups[i].oldClass) && pickup.class != pickups[i].newClass) {
                return string(pickups[i].newClass);
            }
        }
    }
    return "";
}

defaultproperties {
    firemodes(0)=(oldClass=class'KFMod.SCARMK17Fire',newClass=class'Rollback_LevelUp.SCARMK17Fire')
    firemodes(1)=(oldClass=class'KFMod.WinchesterFire',newClass=class'Rollback_LevelUp.WinchesterFire')
    firemodes(2)=(oldClass=class'KFMod.KnifeFire',newClass=class'Rollback_LevelUp.KnifeFire')
    firemodes(3)=(oldClass=class'KFMod.KnifeFireB',newClass=class'Rollback_LevelUp.KnifeAltFire')

    pickups(0)=(oldClass=class'KFMod.AxePickup',newClass=class'Rollback_LevelUp.AxePickup')
    pickups(1)=(oldClass=class'KFMod.ChainsawPickup',newClass=class'Rollback_LevelUp.ChainsawPickup')
    pickups(2)=(oldClass=class'KFMod.CrossbowAmmoPickup',newClass=class'Rollback_LevelUp.CrossbowAmmoPickup')
    pickups(3)=(oldClass=class'KFMod.CrossbowPickup',newClass=class'Rollback_LevelUp.CrossbowPickup')   
    pickups(4)=(oldClass=class'KFMod.KatanaPickup',newClass=class'Rollback_LevelUp.KatanaPickup')
    pickups(5)=(oldClass=class'KFMod.M14EBRPickup',newClass=class'Rollback_LevelUp.M14EBRPickup')
    pickups(6)=(oldClass=class'KFMod.M14EBRAmmoPickup',newClass=class'Rollback_LevelUp.M14EBRAmmoPickup')
    pickups(7)=(oldClass=class'KFMod.M32Pickup',newClass=class'Rollback_LevelUp.M32Pickup')
    pickups(8)=(oldClass=class'KFMod.MachetePickup',newClass=class'Rollback_LevelUp.MachetePickup')
    pickups(9)=(oldClass=class'KFMod.PipeBombPickup',newClass=class'Rollback_LevelUp.PipebombPickup')

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
    weapons(16)=Class'Rollback_LevelUp.AxePickup'
    weapons(17)=Class'Rollback_LevelUp.ChainsawPickup'
    weapons(18)=Class'Rollback_LevelUp.KatanaPickup'
    weapons(19)=Class'KFMod.FlameThrowerPickup'
    weapons(20)=Class'Rollback_LevelUp.PipebombPickup'
    weapons(21)=Class'KFMod.M79Pickup'
    weapons(22)=Class'Rollback_LevelUp.M32Pickup'
    weapons(23)=Class'KFMod.LAWPickup'
}
