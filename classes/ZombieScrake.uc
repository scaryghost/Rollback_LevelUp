class ZombieScrake extends KFChar.ZombieScrake;

function TakeDamage(int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex) {
    Super(KFMonster).takeDamage(Damage, instigatedBy, hitLocation, momentum, damageType, HitIndex);

    // Added in Balance Round 3 to make the Scrake "Rage" more reliably when his health gets low(limited to Suicidal and HoE in Round 7)
    if (Level.Game.GameDifficulty >= 5.0 && !IsInState('SawingLoop') && !IsInState('RunningState') && float(Health) / HealthMax < 0.75 )
        RangedAttack(InstigatedBy);
}
