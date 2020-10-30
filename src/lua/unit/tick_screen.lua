local maxWidth = 46.5

local oreType = { [1] = "Cobaltite", [2] = "Cryolite", [3] = "Kolbeckite", [4] = "Gold nuggets" }
local oreWeight = { [1] = 6.33, [2] = 2.95, [3] = 2.37, [4] = 19.30 }
local maxContainerVolume = 153600 --export

function round(number, decimal)
    local multiple = 10 ^ (decimal or 0)
    return math.floor(number * multiple + 0.5) / multiple
end

function convertUnit(oreStock)
    if oreStock <= 9999 then
        return oreStock .. " L"
    end
    if oreStock >= 10000 and oreStock < 1000000 then
        return math.floor(oreStock / 1000) .. " Kl"
    end
    if oreStock >= 1000000 then
        return round(oreStock / 1000000, 2) .. " Ml"
    end
end

function messagePrint(a, b, c, d)
    if a > 26 and b > 26 and c > 26 and d > 26 then
        return [[ 0;]]
    end

    return [[ 1;]]
end

function resourcesStatus(percent)
    if percent <= 25 then
        return [[
            background: rgb(27,0,0);
            background: linear-gradient(90deg, rgba(27,0,0,1) 0%, rgba(129,23,23,1) 25%, rgba(251,0,0,1) 100%);
        ]]
    end

    if percent > 25 and percent < 60 then
        return [[
            background: rgb(27,0,0);
            background: linear-gradient(90deg, rgba(27,0,0,1) 0%, rgba(129,101,23,1) 25%, rgba(251,202,0,1) 100%)
        ]]
    end

    return [[
        background: rgb(5,27,0);
        background: linear-gradient(90deg, rgba(5,27,0,1) 0%, rgba(38,129,23,1) 25%, rgba(34,251,0,1) 100%);
    ]]
end

function cobaltiteStock(percent)
    local cobaltiteType = oreType[1] .. ", "
    local cobaltiteOk = ""
    if percent <= 25 then
        return cobaltiteType
    else
        return cobaltiteOk
    end
end

function cryoliteStock(percent)
    local cryoliteType = oreType[2] .. ", "
    local cryoliteTypeOk = ""
    if percent <= 25 then
        return cryoliteType
    else
        return cryoliteTypeOk
    end
end

function kolbeckiteStock(percent)
    local kolbeckiteType = oreType[3] .. ", "
    local kolbeckiteOk = ""
    if percent <= 25 then
        return kolbeckiteType
    else
        return kolbeckiteOk
    end
end

function gold_nuggetsStock(percent)
    local gold_nuggetsType = oreType[4]
    local gold_nuggetsOk = ""
    if percent <= 25 then return
        gold_nuggetsType
    else
        return gold_nuggetsOk
    end
end

-- Container_1
local containerMass_cobaltite = math.ceil(container_cobaltite.getItemsMass() / oreWeight[1])
local percentCobaltite = math.ceil((containerMass_cobaltite / maxContainerVolume) * 100)
local cobaltiteStatus = resourcesStatus(percentCobaltite)
local cobaltiteFactor = maxWidth / maxContainerVolume
local cobaltiteBarStatus = containerMass_cobaltite * cobaltiteFactor
local cobaltiteStockStatus = cobaltiteStock(percentCobaltite)
local containerVolumeCobaltite = convertUnit(containerMass_cobaltite)

-- Container_2
local containerMass_cryolite = math.ceil(container_cryolite.getItemsMass() / oreWeight[2])
local percentCryolite = math.ceil((containerMass_cryolite / maxContainerVolume) * 100)
local cryoliteStatus = resourcesStatus(percentCryolite)
local cryoliteFactor = maxWidth / maxContainerVolume
local cryoliteBarStatus = containerMass_cryolite * cryoliteFactor
local cryoliteStockStatus = cryoliteStock(percentCryolite)
local containerVolumeCryolite = convertUnit(containerMass_cryolite)

-- Container_3
local containerMass_kolbeckite = math.ceil(container_kolbeckite.getItemsMass() / oreWeight[3])
local percentKolbeckite = math.ceil((containerMass_kolbeckite / maxContainerVolume) * 100)
local kolbeckiteStatus = resourcesStatus(percentKolbeckite)
local kolbeckiteFactor = maxWidth / maxContainerVolume
local kolbeckiteBarStatus = containerMass_kolbeckite * kolbeckiteFactor
local kolbeckiteStockStatus = kolbeckiteStock(percentKolbeckite)
local containerVolumeKolbeckite = convertUnit(containerMass_kolbeckite)

-- Container_4
local containerMass_gold_nuggets = math.ceil(container_gold_nuggets.getItemsMass() / oreWeight[4])
local percentGold_nuggets = math.ceil((containerMass_gold_nuggets / maxContainerVolume) * 100)
local gold_nuggetsStatus = resourcesStatus(percentGold_nuggets)
local gold_nuggetsFactor = maxWidth / maxContainerVolume
local gold_nuggetsBarStatus = containerMass_gold_nuggets * gold_nuggetsFactor
local gold_nuggetsStockStatus = gold_nuggetsStock(percentGold_nuggets)
local containerVolumeGold_nuggets = convertUnit(containerMass_gold_nuggets)

message = messagePrint(percentCobaltite, percentCryolite, percentKolbeckite, percentGold_nuggets)

local view = [[
<html>
<head>
<style>
body {
    width: auto;
    background-color: rgba(0, 0, 0, 1);
}

em {
    font-weight: bold;
}

.cobaltite {
    text-shadow: 0 0vw 0.11vw rgba(146, 220, 226, 0.8);
    color: rgba(146, 220, 226, 0.8);
}

.cryolite {
    text-shadow: 0 0vw 0.11vw rgba(175, 170, 165, 0.8);
    color: rgba(175, 170, 165, 0.8);
}

.kolbeckite {
    text-shadow: 0 0vw 0.11vw rgba(235, 99, 65, 0.8);
    color: rgba(235, 99, 65, 0.8);
}

.gold_nuggets {
    text-shadow: 0 0vw 0.11vw rgba(247, 250, 71, 0.8);
    color: rgba(247, 250, 71, 0.8);
    font-size: 2.58vw;
}

.weak {
    animation: faible 1s infinite alternate;
}

.progress-bar {
    overflow: visible;
    white-space: nowrap;
    height: auto;
    box-shadow: 0 0vw 0.2vw rgba(0, 0, 0, 0.8);
}

.progress-bar-cobaltite {
    width: ]] .. cobaltiteBarStatus .. [[vw;
    ]] .. cobaltiteStatus .. [[
}

.progress-bar-cryolite {
    width: ]] .. cryoliteBarStatus .. [[vw;
    ]] .. cryoliteStatus .. [[
}

.progress-bar-kolbeckite {
    width: ]] .. kolbeckiteBarStatus .. [[vw;
    ]] .. kolbeckiteStatus .. [[
}

.progress-bar-gold_nuggets {
    width: ]] .. gold_nuggetsBarStatus .. [[vw;
    ]] .. gold_nuggetsStatus .. [[
}

.prime {
    witdh : auto;
    position: absolute;
    left: 2.58vw;
    animation: show 1s ease-in;
}

.title h1 {
    font-size: 8vw;
    text-align: center;
    padding: 0.26vw;
}

.container {
    text-align: center;
    width: 50vw;
    display: grid;
    grid-template-columns: 25.8vw 20.64vw 100%;
    align-items: center;
    padding: 0.51vw;
}

.container_message {
    opacity:  ]] .. message .. [[ ;
    text-align: center;
    width: 100vw;
    display: inherit flex;
    align-items: center;
    padding-right: 2.58vw;
    padding-top: 2.58vw;
}

.item_container {
    justify-self: auto;
    padding: 1.03vw;
    font-size: 3.09vw;
    text-align: center;
    color: white;
}

.item_container_cobaltite {
      background-color: rgba(146, 220, 226, 0.4);
      border: 0.2vw solid rgba(146, 220, 226, 1);
}

.item_container_cryolite {
    background-color: rgba(175, 170, 165, 0.4);
    border: 0.2vw solid rgba(175, 170, 165, 1);
}

.item_container_kolbeckite {
    background-color: rgba(235, 99, 65, 0.4);
    border: 0.2vw solid rgba(235, 99, 65, 1);

}

.item_container_gold_nuggets {
    background-color: rgba(247, 250, 71, 0.4);
    border: 0.2vw solid rgba(247, 250, 71, 1);
    font-size: 2.58vw;
}

.item_container_cobaltite--1 {
    background-color: rgba(0, 0, 0, 0.4);
}
.item_container_cryolite--1 {
    background-color: rgba(0, 0, 0, 0.4);
}
.item_container_kolbeckite--1 {
    background-color: rgba(0, 0, 0, 0.4);
}
.item_container_gold_nuggets--1 {
    background-color: rgba(0, 0, 0, 0.4);
}

.infos_title {
    position: relative;
    left: 34.83vw;
    color: red;
    margin-bottom: 3.09vw;
    width: 25.8vw;
    font-weight: bold;
    border-bottom: 0.31vw solid red;
    font-size: 3.92vw;
    animation: urgent 2s infinite alternate;
}
.item_container_message {
    justify-self: center;
    align-items: center;
    font-size: 3.09vw;
    text-align: center;
    color: white;
    padding-right: 0.16vw;
}

@keyframes show {
    0% {
        opacity: 0;
    }
    100% {
        opacity: 1;
    }
}

@keyframes faible {
    0% {
        transform: scale(0.95);
    }
    100% {
        transform: scale(1);
    }
}

@keyframes urgent {
    0% {
        transform: scale(1.25);
    }
    100% {
        transform: scale(1.5);
    }
}

</style>
</head>

<header>
	<div class="title">
		<h1>Tier 4 ores</h1>
	</div>
</header>

<body>
<div class="prime">
    <div class="container">
        <div class="container container__block--1">
            <div class="item_container item_container_cobaltite">
                ]] .. oreType[1] .. [[ :
            </div>
            <div class="item_container item_container_cobaltite">
                ]] .. containerVolumeCobaltite .. [[
            </div>
            <div class="item_container item_container_cobaltite item_container_cobaltite--1">
                <div class="progress-bar progress-bar-cobaltite">
                    ]] .. percentCobaltite .. [[ %
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="container container__block--2">
            <div class="item_container item_container_cryolite">
                ]] .. oreType[2] .. [[ :
            </div>
            <div class="item_container item_container_cryolite">
                ]] .. containerVolumeCryolite .. [[
            </div>
            <div class="item_container item_container_cryolite item_container_cryolite--1">
                <div class="progress-bar progress-bar-cryolite">
                    ]] .. percentCryolite .. [[ %
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="container container__block--3">
            <div class="item_container item_container_kolbeckite">
                ]] .. oreType[3] .. [[ :
            </div>
            <div class="item_container item_container_kolbeckite">
                ]] .. containerVolumeKolbeckite .. [[
            </div>
            <div class="item_container item_container_kolbeckite item_container_kolbeckite--1">
                <div class="progress-bar progress-bar-kolbeckite">
                    ]] .. percentKolbeckite .. [[ %
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="container container__block--4">
            <div class="item_container item_container_gold_nuggets">
                ]] .. oreType[4] .. [[ :
            </div>
            <div class="item_container item_container_gold_nuggets">
                ]] .. containerVolumeGold_nuggets .. [[
            </div>
            <div class="item_container item_container_gold_nuggets item_container_gold_nuggets--1">
                <div class="progress-bar progress-bar-gold_nuggets">
                    ]] .. percentGold_nuggets .. [[ %
                </div>
            </div>
        </div>
    </div>

    <div class="container_message">
        <div class="item_container">
            <div class="infos_title">
                ALERT
            </div>
            <div class="item_container_message">
                <div class="infos_message">
                    <div class="weak">
                    Low stock of
                    <em class="cobaltite">]] .. cobaltiteStockStatus .. [[</em>
                    <em class="cryolite">]] .. cryoliteStockStatus .. [[</em>
                    <em class="kolbeckite">]] .. kolbeckiteStockStatus .. [[</em>
                    <em class="gold_nuggets">]] .. gold_nuggetsStockStatus .. [[</em>
                    <br>
                    Miners have to work !
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
]]

screen_T4_ores.setHTML(view)
