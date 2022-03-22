require("map/terrain")
function Map:CanPlantAtPoint(x, y, z)
    local tile = self:GetTileAtPoint(x, y, z)
    return tile ~= GROUND.ROCKY and
        tile ~= GROUND.ROAD and
        tile ~= GROUND.UNDERROCK and
        tile < GROUND.UNDERGROUND and
        tile ~= GROUND.IMPASSABLE and
        tile ~= GROUND.INVALID
end

function Map:CanPlacePrefabFilteredAtPoint(x, y, z, prefab)
    local tile = self:GetTileAtPoint(x, y, z)
    if tile == GROUND.INVALID or tile == GROUND.IMPASSABLE then
        return false
    end

    if _G.terrain.filter[prefab] ~= nil then
        for i, v in ipairs(_G.terrain.filter[prefab]) do
            if tile == v then
                -- can't grow on this terrain
                return false
            end
        end
    end
    return true
end

function Map:IsPassableAtPoint(x, y, z)
    local tx, ty = GetWorld().Map:GetTileCoordsAtPoint(x, y, z)
	local actual_tile = GetWorld().Map:GetTile(tx, ty)

    if actual_tile == _G.GROUND.IMPASSABLE then
        return false
    end
    return true
end
