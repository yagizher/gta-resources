# Description

This mod adds the following:

- Teleporters
- Allows Vehicles (configurable)

# Installation
Add to resource folder `[esx]` or `[disc]`

Start using `start disc-teleport`

# Configuration

Config.Teleporters
```
{
    name = 'Test Teleport', -- Teleport Name
    coords = vector3(-1995.75, 288.11, 91.6), --Location
    destination = vector3(1463.97, 1129.19, 114.32), --Destination
    heading = 245.0, --Heading
    colour = { r = 255, g = 0, b = 0 }, --Marker Colour
    allowVehicles = true, --Allow Vehicles to Teleport
    job = 'all' --Job allowed or 'all'
}
```

# Requirements

- [Disc-Base](https://github.com/DiscworldZA/gta-resources/tree/master/disc-base)