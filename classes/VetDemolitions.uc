class VetDemolitions extends KFVetDemolitions;

// Change the cost of particular ammo
static function float GetAmmoCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item) {
    if (Item == class'PipeBombPickup') {
        // Todo, this won't need to be so extreme when we set up the system to only allow him to buy it perhaps
        return 0.25 - (0.03 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 93% discount on PipeBomb
    }

    return 1.0;
}
