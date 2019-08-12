# Original Mod

- [ESX_CarThief](https://github.com/KlibrDM/esx_carthief)

# Description

This mod adds the following:

- An improved version of the car thief mod
- Damage based payout
- Jammer available for Dirty Cash
- Cooldown period to avoid spamming

# Installation
Add to resource folder `[esx]` or `[disc]`

Start using `start disc-carthief`

##Steps

- Insert Drug Items into `essentialmode.items`
- Configure with your drug items

# Usage
If you have drugs you can walk up to an NPC and sell them the drugs.

# Configuration

Cops Needed
```
Config.CopsNeeded = 2 --Amount of cops needed to be able to sell
```

Blip Update Time
```
Config.BlipUpdateTime = 1000 --Time in ms to update vehicle blip to police
```

Jammer Time
```
Config.JammerTime = 5 --Time the Jammer is Active in Minutes
```

Vehicle Spawn Point
```
Config.VehicleSpawnPoint --Where does the vehicle spawn
```

Vehicle Delivery Points
```
Config.Delivery
```

Cars Models Available for this Delivery Point
```
Cars = {'fxxk','18performante','488lb','c7r','pista', 'senna', 'rmodmustang', 'rmodm4'},
```

Payment for delivery
```
Payment  = 18000
```

Cooldown Time
```
Config.CooldownTime = 20 --Time in Minutes allowed between robberies
```

Completion Time
```
Config.FinishTime = 15 --Time in Minutes before car despawns and robbery fails
```

# Requirements

- [Disc-Base](https://github.com/DiscworldZA/gta-resources/tree/master/disc-base)