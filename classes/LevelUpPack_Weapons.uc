class LevelUpPack_Weapons extends LevelUpPack;

function class<KFMonstersCollection> getMonstersCollection() {
    return class'KFMonstersCollection';
}

defaultproperties {
    perks(0)=Class'KFMod.KFVetFieldMedic'
    perks(1)=Class'KFMod.KFVetSupportSpec'
    perks(2)=Class'KFMod.KFVetSharpshooter'
    perks(3)=Class'KFMod.KFVetCommando'
    perks(4)=Class'KFMod.KFVetBerserker'
    perks(5)=Class'KFMod.KFVetFirebug'
    perks(6)=Class'KFMod.KFVetDemolitions'
}
