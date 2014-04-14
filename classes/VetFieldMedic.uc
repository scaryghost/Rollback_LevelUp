class VetFieldMedic extends KFVetFieldMedic;

static function float GetMovementSpeedModifier(KFPlayerReplicationInfo KFPRI) {
    if (KFPRI.ClientVeteranSkillLevel <= 1) {
        return 1.0;
    }

    return 1.05 + (0.05 * float(KFPRI.ClientVeteranSkillLevel - 2)); // Moves up to 25% faster
}
