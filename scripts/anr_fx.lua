local function FinalOffset1(inst)
    inst.AnimState:SetFinalOffset(1)
end

local function FinalOffset2(inst)
    inst.AnimState:SetFinalOffset(2)
end

local function FinalOffset3(inst)
    inst.AnimState:SetFinalOffset(3)
end

local function FinalOffsetNegative1(inst)
    inst.AnimState:SetFinalOffset(-1)
end


local function GroundOrientation(inst)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
end

local function Bloom(inst)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(1)
end

local function BloomOrange(inst)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
--    inst.AnimState:SetMultColour(204/255,131/255,57/255,1)
    inst.AnimState:SetMultColour(219/255,168/255,117/255,1)
    inst.AnimState:SetFinalOffset(1)
end

local fx =
{
    {
        name = "attune_out_fx",
        bank = "attune_fx",
        build = "attune_fx",
        anim = "attune_out",
        sound = "dontstarve/ghost/ghost_haunt",
    },
    {
        name = "attune_in_fx",
        bank = "attune_fx",
        build = "attune_fx",
        anim = "attune_in",
        sound = "dontstarve/ghost/ghost_haunt",
    },
    {
        name = "attune_ghost_in_fx",
        bank = "attune_fx",
        build = "attune_fx",
        anim = "attune_ghost_in",
        sound = "dontstarve/ghost/ghost_haunt",
    },
}

FinalOffset1 = nil
FinalOffset2 = nil

return fx
