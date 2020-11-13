local _MAX_WIDTH_ = 46.5

local itemLabel1 = "itemLabel1" --export
local itemMass1 = (container1 and container1.getItemsMass() or 0)
local maxInContainer1 = 0 --export
local itemDensity1 = 0 --export

local itemLabel2 = "itemLabel2" --export
local itemMass2 = (container2 and container2.getItemsMass() or 0)
local maxInContainer2 = 0 --export
local itemDensity2 = 0 --export

local itemLabel3 = "itemLabel3" --export
local itemMass3 = (container3 and container3.getItemsMass() or 0)
local maxInContainer3 = 0 --export
local itemDensity3 = 0 --export

local itemLabel4 = "itemLabel4" --export
local itemMass4 = (container4 and container4.getItemsMass() or 0)
local maxInContainer4 = 0 --export
local itemDensity4 = 0 --export

local itemsData = {
    {
        label = itemLabel1,
        mass = itemMass1,
        containerCapacity = maxInContainer1,
        density = itemDensity1
    },
    {
        label = itemLabel2,
        mass = itemMass2,
        containerCapacity = maxInContainer2,
        density = itemDensity2
    },
    {
        label = itemLabel3,
        mass = itemMass3,
        containerCapacity = maxInContainer3,
        density = itemDensity3
    },
    {
        label = itemLabel4,
        mass = itemMass4,
        containerCapacity = maxInContainer4,
        density = itemDensity4
    }
}

function getBarStatus(item)
    local width = math.ceil(item.mass / item.density) * _MAX_WIDTH_ / item.containerCapacity

    if width > _MAX_WIDTH_ then
        return _MAX_WIDTH_
    end

    return width
end

function getItemStatus(item)
    local percent = math.ceil(item.mass / item.density / item.containerCapacity * 100)

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

    if percent > 100 then
        return [[
            background: rgb(27,0,0);
            background: linear-gradient(90deg, rgba(27,0,0,1) 0%, rgba(255,0,0,1) 25%, rgba(255,0,0,1) 100%)
        ]]
    end

    return [[
        background: rgb(5,27,0);
        background: linear-gradient(90deg, rgba(5,27,0,1) 0%, rgba(38,129,23,1) 25%, rgba(34,251,0,1) 100%);
    ]]
end

local dynamicStyle = ""

for i, item in pairs(itemsData) do
    dynamicStyle = dynamicStyle .. [[
        .progress-bar-item]] .. i .. [[ {
            width: ]] .. getBarStatus(item) .. [[vw;
            ]] .. getItemStatus(item) .. [[
        }
    ]]
end

local style = [[
body {
    width: auto;
    background-color: rgba(0, 0, 0, 1);
}

em {
    font-weight: bold;
}

.item1 {
    text-shadow: 0 0vw 0.11vw rgba(146, 220, 226, 0.8);
    color: rgba(146, 220, 226, 0.8);
}

.item2 {
    text-shadow: 0 0vw 0.11vw rgba(175, 170, 165, 0.8);
    color: rgba(175, 170, 165, 0.8);
}

.item3 {
    text-shadow: 0 0vw 0.11vw rgba(235, 99, 65, 0.8);
    color: rgba(235, 99, 65, 0.8);
}

.item4 {
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

.item_container {
    justify-self: auto;
    padding: 1.03vw;
    font-size: 3.09vw;
    text-align: center;
    color: white;
}

.item_container_item1 {
      background-color: rgba(146, 220, 226, 0.4);
      border: 0.2vw solid rgba(146, 220, 226, 1);
}

.item_container_item2 {
    background-color: rgba(175, 170, 165, 0.4);
    border: 0.2vw solid rgba(175, 170, 165, 1);
}

.item_container_item3 {
    background-color: rgba(235, 99, 65, 0.4);
    border: 0.2vw solid rgba(235, 99, 65, 1);

}

.item_container_item4 {
    background-color: rgba(247, 250, 71, 0.4);
    border: 0.2vw solid rgba(247, 250, 71, 1);
    font-size: 2.58vw;
}

.item_container_item1--1 {
    background-color: rgba(0, 0, 0, 0.4);
}
.item_container_item2--1 {
    background-color: rgba(0, 0, 0, 0.4);
}
.item_container_item3--1 {
    background-color: rgba(0, 0, 0, 0.4);
}
.item_container_item4--1 {
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

]] .. dynamicStyle

local htmlStart = [[
<html>
<head>
<style>
    ]] .. style .. [[
</style>
</head>

<header>
	<div class="title">
		<h1>Storage monitor</h1>
	</div>
</header>

<body>
<div class="prime">
]]

local htmlEnd = [[
</div>
</body>
</html>
]]

function convertUnit(volume)
    if volume <= 9999 then
        return volume .. " L"
    end
    if volume >= 10000 and volume < 1000000 then
        return math.floor(volume / 1000) .. " Kl"
    end
    if volume >= 1000000 then
        return math.floor(volume / 10000) / 100 .. " Ml"
    end
end

function container(item, index)
    return [[
        <div class="container">
            <div class="container container__block--1">
                <div class="item_container item_container_]] .. index .. [[">
                    ]] .. item.label .. [[ :
                </div>
                <div class="item_container item_container_]] .. index .. [[">
                    ]] .. convertUnit(item.containerCapacity) .. [[
                </div>
                <div class="item_container item_container_]] .. index .. [[ item_container_]] .. index .. [[--1">
                    <div class="progress-bar progress-bar-]] .. index .. [[">
                        ]] .. math.ceil(((item.mass / item.density) / item.containerCapacity) * 100) .. [[ %
                    </div>
                </div>
            </div>
        </div>
    ]]
end

local containers = ""

for i, item in pairs(itemsData) do
    containers = containers .. container(item, "item" .. i)
end

local view = [[
    ]] .. htmlStart .. [[
    ]] .. containers .. [[
    ]] .. htmlEnd .. [[
]]

screen.setHTML(view)
