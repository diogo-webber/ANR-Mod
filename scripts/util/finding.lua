function _G.GetClosest(target, entities)
    local max_dist = nil
    local min_dist = nil

    local closest = nil

    local tpos = target:GetPosition()

    for k,v in pairs(entities) do
        local epos = v:GetPosition()
        local dist = distsq(tpos, epos)

        if not max_dist or dist > max_dist then
            max_dist = dist
        end

        if not min_dist or dist < min_dist then
            min_dist = dist
            closest = v
        end
    end

    return closest
end
