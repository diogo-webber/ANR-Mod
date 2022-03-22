COLLISION.SMALLOBSTACLES    = 8192	-- collide with characters but not giants
COLLISION.GIANTS            = 16384	-- collide with obstacles but not small obstacles

function _G.MakeFlyingGiantCharacterPhysics(inst, mass, rad)
    local phys = inst.entity:AddPhysics()
    phys:SetMass(mass)
    phys:SetFriction(0)
    phys:SetDamping(5)
    phys:SetCollisionGroup(COLLISION.GIANTS)
    phys:ClearCollisionMask()
    phys:CollidesWith(COLLISION.WORLD)
    --phys:CollidesWith(COLLISION.OBSTACLES)
    phys:CollidesWith(COLLISION.CHARACTERS)
    phys:CollidesWith(COLLISION.GIANTS)
    phys:SetCapsule(rad, 1)
    return phys
end
