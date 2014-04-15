// Zombie Monster for KF Invasion gametype
class ZombieBoss extends KFChar.ZombieBoss;

function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex)
{
	local float DamagerDistSq;
	local bool bDidRadialAttack;

    if ( class<DamTypeCrossbow>(damageType) == none && class<DamTypeCrossbowHeadShot>(damageType) == none )
    {
    	bOnlyDamagedByCrossbow = false;
    }

    Super(KFMonster).TakeDamage(Damage,instigatedBy,hitlocation,Momentum,damageType);

    if( Level.TimeSeconds - LastDamageTime > 10 )
    {
        ChargeDamage = 0;
    }
    else
    {
        LastDamageTime = Level.TimeSeconds;
        ChargeDamage += Damage;
    }

    if( ShouldChargeFromDamage() && ChargeDamage > 200 )
    {
        // If someone close up is shooting us, just charge them
        if( InstigatedBy != none )
        {
            DamagerDistSq = VSizeSquared(Location - InstigatedBy.Location);

            if( DamagerDistSq < (700 * 700) )
            {
                SetAnimAction('transition');
        		ChargeDamage=0;
        		LastForceChargeTime = Level.TimeSeconds;
        		GoToState('Charging');
        		return;
    		}
        }
    }

	if( Health<=0 || SyringeCount==3 || IsInState('Escaping') || IsInState('KnockDown') || IsInState('RadialAttack') || bDidRadialAttack/*|| bShotAnim*/ )
		Return;

	if( (SyringeCount==0 && Health<HealingLevels[0]) || (SyringeCount==1 && Health<HealingLevels[1]) || (SyringeCount==2 && Health<HealingLevels[2]) )
	{
	    //log(GetStateName()$" Took damage and want to heal!!! Health="$Health$" HealingLevels "$HealingLevels[SyringeCount]);

    	bShotAnim = true;
		Acceleration = vect(0,0,0);
		SetAnimAction('KnockDown');
		HandleWaitForAnim('KnockDown');
		KFMonsterController(Controller).bUseFreezeHack = True;
		GoToState('KnockDown');
	}
}
