class WinchesterFire extends KFMod.WinchesterFire;

event ModeDoFire()
{
    local float Rec;

    if (!AllowFire())
        return;

    if( Instigator==None || Instigator.Controller==none )
        return;

    Rec = GetFireSpeed();

// KFTODO - Slomo compensation R&D, finish later if I have time - Ramm
//    if( bDoSlomoCompensation && Weapon.Level.TimeDilation != 1.1 )
//    {
//      FireRate = default.FireRate * ((Weapon.Level.TimeDilation /** 1.75*/)/1.1);
//      TweenTime = default.TweenTime * ((Weapon.Level.TimeDilation /** 1.75*/)/1.1);
//      log("default.FireRate = "$default.FireRate$" FireRate = "$FireRate$" Dilation Factor "$((Weapon.Level.TimeDilation * 2.0)/1.1));
//      //FireRate = default.FireRate/Rec * (Weapon.Level.TimeDilation/1.1);
//      FireAnimRate = default.FireAnimRate*Rec / ((Weapon.Level.TimeDilation /** 1.75*/)/1.1);
//      //ReloadAnimRate = default.ReloadAnimRate*Rec / ((Weapon.Level.TimeDilation * 2.0)/1.1);
//  }
//  else
//  {
        FireRate = default.FireRate/Rec;
        FireAnimRate = default.FireAnimRate;
        ReloadAnimRate = default.ReloadAnimRate*Rec;
//  }

    Rec = 1;

    LastFireTime = Level.TimeSeconds;

    if ( KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo) != none && KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill != none )
    {
        Spread *= KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill.Static.ModifyRecoilSpread(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo), self, Rec);
    }


    if (MaxHoldTime > 0.0)
        HoldTime = FMin(HoldTime, MaxHoldTime);

    // server
    if (Weapon.Role == ROLE_Authority)
    {
        Weapon.ConsumeAmmo(ThisModeNum, Load);
        DoFireEffect();
        HoldTime = 0;   // if bot decides to stop firing, HoldTime must be reset first
        if ( (Instigator == None) || (Instigator.Controller == None) )
            return;

        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);

        Instigator.DeactivateSpawnProtection();
    }

    // client
    if (Instigator.IsLocallyControlled())
    {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
    }
    else // server
    {
        ServerPlayFiring();
    }

    Weapon.IncrementFlashCount(ThisModeNum);

    // set the next firing time. must be careful here so client and server do not get out of sync
    if (bFireOnRelease)
    {
        if (bIsFiring)
            NextFireTime += MaxHoldTime + FireRate;
        else NextFireTime = Level.TimeSeconds + FireRate;
    }
    else
    {
        NextFireTime += FireRate;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }

    Load = AmmoPerFire;
    HoldTime = 0;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }

	if (Weapon.Owner != none && AllowFire())
	{
		if (FireRate > 0.25)
			Weapon.Owner.Velocity *= 0.1;
		else Weapon.Owner.Velocity *= 0.5;
	}

    // client
    if (Instigator.IsLocallyControlled())
    {
        if( bDoClientRagdollShotFX && Weapon.Level.NetMode == NM_Client &&
            Weapon.Level.TimeDilation != Weapon.Level.default.TimeDilation )
        {
            DoClientOnlyFireEffect();
        }
        HandleRecoil(1.0);
    }

    // KFTODO - Slomo compensation R&D, finish later if I have time - Ramm
    //SetTimer(0.2,False);
}
