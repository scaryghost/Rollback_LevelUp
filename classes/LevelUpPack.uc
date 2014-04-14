class LevelUpPack extends RollbackPack;

var array<class<Pickup> > weapons;

function array<class<Pickup> > getWeaponPickups() {
    return weapons;
}

function class<KFMonstersCollection> getMonstersCollection() {
    return class'LUMonstersCollection';
}

defaultproperties {
    weapons(0)=Class'KFMod.MP7MPickup'
    weapons(1)=Class'KFMod.ShotgunPickup'
    weapons(2)=Class'KFMod.BoomStickPickup'
    weapons(3)=Class'KFMod.LAWPickup'
    weapons(4)=Class'KFMod.AA12Pickup'
    weapons(5)=Class'KFMod.SinglePickup'
    weapons(6)=Class'KFMod.DualiesPickup'
    weapons(7)=Class'KFMod.DeaglePickup'
    weapons(8)=Class'KFMod.DualDeaglePickup'
    weapons(9)=Class'KFMod.WinchesterPickup'
    weapons(10)=Class'Rollback_LevelUp.CrossbowPickup'
    weapons(11)=Class'Rollback_LevelUp.M14EBRPickup'
    weapons(12)=Class'KFMod.BullpupPickup'
    weapons(13)=Class'KFMod.AK47Pickup'
    weapons(14)=Class'KFMod.SCARMK17Pickup'
    weapons(15)=Class'KFMod.KnifePickup'
    weapons(16)=Class'KFMod.MachetePickup'
    weapons(17)=Class'KFMod.AxePickup'
    weapons(18)=Class'KFMod.ChainsawPickup'
    weapons(19)=Class'KFMod.KatanaPickup'
    weapons(20)=Class'KFMod.FlameThrowerPickup'
    weapons(21)=Class'KFMod.MAC10Pickup'
    weapons(22)=Class'KFMod.PipeBombPickup'
    weapons(23)=Class'KFMod.M79Pickup'
    weapons(24)=Class'KFMod.M32Pickup'
}
