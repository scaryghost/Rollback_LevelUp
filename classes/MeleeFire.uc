class MeleeFire extends KFMeleeFire;

simulated function Timer()
{
    local Actor HitActor;
    local vector StartTrace, EndTrace, HitLocation, HitNormal;
    local rotator PointRot;
    local int MyDamage;
    local bool bBackStabbed;

    MyDamage = MeleeDamage;

    If( !KFWeapon(Weapon).bNoHit )
    {
        MyDamage = MeleeDamage;
        StartTrace = Instigator.Location + Instigator.EyePosition();

        if( Instigator.Controller!=None && PlayerController(Instigator.Controller)==None && Instigator.Controller.Enemy!=None )
        {
            PointRot = rotator(Instigator.Controller.Enemy.Location-StartTrace); // Give aimbot for bots.
        }
        else
        {
            PointRot = Instigator.GetViewRotation();
        }

        EndTrace = StartTrace + vector(PointRot)*weaponRange;
        HitActor = Instigator.Trace( HitLocation, HitNormal, EndTrace, StartTrace, true);

        //Instigator.ClearStayingDebugLines();
        //Instigator.DrawStayingDebugLine( StartTrace, EndTrace,0, 255, 0);

        if (HitActor!=None)
        {
            ImpactShakeView();

            if( HitActor.IsA('ExtendedZCollision') && HitActor.Base != none &&
                HitActor.Base.IsA('KFMonster') )
            {
                HitActor = HitActor.Base;
            }

            if ( (HitActor.IsA('KFMonster') || HitActor.IsA('KFHumanPawn')) && KFMeleeGun(Weapon).BloodyMaterial!=none )
            {
                Weapon.Skins[KFMeleeGun(Weapon).BloodSkinSwitchArray] = KFMeleeGun(Weapon).BloodyMaterial;
                Weapon.texture = Weapon.default.Texture;
            }
            if( Level.NetMode==NM_Client )
            {
                Return;
            }

            if( HitActor.IsA('Pawn') && !HitActor.IsA('Vehicle')
             && (Normal(HitActor.Location-Instigator.Location) dot vector(HitActor.Rotation)) < 0 ) // Change backstabbing to be what it was before
            {
                bBackStabbed = true;

                MyDamage*=2; // Backstab >:P
            }

            if( (KFMonster(HitActor)!=none) )
            {
            //  log(VSize(Instigator.Velocity));

                KFMonster(HitActor).bBackstabbed = bBackStabbed;

                HitActor.TakeDamage(MyDamage, Instigator, HitLocation, vector(PointRot), hitDamageClass) ;

                if(MeleeHitSounds.Length > 0)
                {
                    Weapon.PlaySound(MeleeHitSounds[Rand(MeleeHitSounds.length)],SLOT_None,MeleeHitVolume,,,,false);
                }

                if(VSize(Instigator.Velocity) > 300 && KFMonster(HitActor).Mass <= Instigator.Mass)
                {
                    KFMonster(HitActor).FlipOver();
                }

            }
            else
            {
                HitActor.TakeDamage(MyDamage, Instigator, HitLocation, vector(PointRot), hitDamageClass) ;
                Spawn(HitEffectClass,,, HitLocation, rotator(HitLocation - StartTrace));
                //if( KFWeaponAttachment(Weapon.ThirdPersonActor)!=None )
                //  KFWeaponAttachment(Weapon.ThirdPersonActor).UpdateHit(HitActor,HitLocation,HitNormal);

                //Weapon.IncrementFlashCount(ThisModeNum);
            }
        }
    }
}
