--[[
Guarma Beach (Shipwreck Beach) : 1997.57, -4499.807, 41.77455
Guarma Fort : 999.9134, -6749.735, 63.12267
]]

local PreviousWorldType = nil

---Return true if the coords is in guarma, or false
---@return bool
local function IsCoordsInGuarma(coords)
    return GetMapZoneAtCoords(coords, 0) == `Guarma` or GetMapZoneAtCoords(coords, 10) == `GuarmaD`
end

---Return true if the player is in guarma, or false
---@return bool
local function IsPlayerInGuarma()
    if (DoesEntityExist(PlayerPedId())) then
        return IsCoordsInGuarma(GetEntityCoords(PlayerPedId()))
    end
    return false
end

---Return the world where the player is
---@return string
local function GetWorldType()
    return IsPlayerInGuarma() and "guarma" or "world"
end

---Init the world
local function InitWorld()
    local worldType = GetWorldType()
    if (worldType ~= PreviousWorldType) then
        if (worldType == "world") then
            if (GetWorldWaterType() ~= 0) then
                SetWorldWaterType(0)
            end
            SetGuarmaWorldhorizonActive(false)
            SetMinimapZone(`world`)
            --SetMinimapHideFow(false)
            SetFowUpdatePlayerOverride(true, 0)
        elseif (worldType == "guarma") then
            if (GetWorldWaterType() ~= 1) then
                SetWorldWaterType(1)
            end
            SetGuarmaWorldhorizonActive(true)
            SetMinimapZone(`guarma`)
            SetMinimapHideFow(true)
            SetFowUpdatePlayerOverride(false, 0)
        end
        PreviousWorldType = worldType
    end
end

---Main thread
CreateThread(function()
    while true do
        InitWorld()
        Wait(1000)
    end
end)