Config = {}

Config.SellDistance = 1050 -- The distance before you can press e and negotiate.
Config.DiscussTime = 5000 -- Seconds of the ped waiting for answer of purchase or not.

Config.CopsNeeded = 2

Config.DrugItems = {
    meth = {
        name = 'Meth',
        priceMin = 25000,
        priceMax = 40000,
        sellCountMin = 1,
        sellCountMax = 2
    },
    weed = {
        name = 'weed',
        priceMin = 200,
        priceMax = 500,
        sellCountMin = 1,
        sellCountMax = 5
    },
    marijuana = {
        name = 'marijuana',
        priceMin = 500,
        priceMax = 1000,
        sellCountMin = 1,
        sellCountMax = 5
    }
}