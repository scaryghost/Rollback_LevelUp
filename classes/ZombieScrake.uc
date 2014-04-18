class ZombieScrake extends KFChar.ZombieScrake;

function RangedAttack(Actor A) {
    if (bShotAnim || Physics == PHYS_Swimming)
        return;
    else if (CanAttack(A)) {
        bShotAnim = true;
        SetAnimAction(MeleeAnims[Rand(2)]);
        CurrentDamType = ZombieDamType[0];
        //PlaySound(sound'Claw2s', SLOT_None); KFTODO: Replace this
        GoToState('SawingLoop');
    }

    if (!bShotAnim && !bDecapitated && float(Health) / HealthMax < 0.5) {
        GoToState('RunningState');
    }
}

function TakeDamage(int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex) {
    Super(KFMonster).takeDamage(Damage, instigatedBy, hitLocation, momentum, damageType, HitIndex);

    // Added in Balance Round 3 to make the Scrake "Rage" more reliably when his health gets low(limited to Suicidal and HoE in Round 7)
    if (!IsInState('SawingLoop') && !IsInState('RunningState') && float(Health) / HealthMax < 0.5 )
        RangedAttack(InstigatedBy);
}

function PlayTakeHit(vector HitLocation, int Damage, class<DamageType> DamageType) {
    local int StunChance;

    StunChance = rand(5);

    if( Level.TimeSeconds - LastPainAnim < MinTimeBetweenPainAnims )
        return;

    if(Damage>=150 || (DamageType.name=='DamTypeStunNade' && StunChance>3) || (DamageType.name=='DamTypeCrossbowHeadshot' && Damage>=200))
        PlayDirectionalHit(HitLocation);

    LastPainAnim = Level.TimeSeconds;

    if (Level.TimeSeconds - LastPainSound < MinTimeBetweenPainSounds)
        return;

    LastPainSound = Level.TimeSeconds;
    PlaySound(HitSound[0], SLOT_Pain,1.25,,400);
}
