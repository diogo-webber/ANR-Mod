local function ToggleOffPhysics(inst)
    inst.sg.statemem.isphysicstoggle = true
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
end

local function ToggleOnPhysics(inst)
    inst.sg.statemem.isphysicstoggle = nil
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.GIANTS)
end

local STATES = {
    State{
        name = "portal_rez",
        tags = { "busy", "nopredict", "silentmorph" },

        onenter = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end
            inst.AnimState:PlayAnimation("idle_loop", true)
            inst.HUD:Hide()
            TheCamera:SetDistance(14)
            inst.AnimState:SetMultColour(0, 0, 0, 1)
            inst:Hide()
            inst.DynamicShadow:Enable(false)
        end,

        timeline =
        {
            TimeEvent(12 * FRAMES, function(inst)
                inst:Show()
                inst.DynamicShadow:Enable(true)
            end),
            TimeEvent(72 * FRAMES, function(inst)
                inst.components.colourtweener:StartTween(
                    { 1, 1, 1, 1 },
                    14 * FRAMES,
                    function(inst)
                        if inst.sg.currentstate.name == "portal_rez" then
                            inst.sg.statemem.istweencomplete = true
                            inst.sg:GoToState("idle")
                        end
                    end)
            end),
        },

        onexit = function(inst)
            --In case of interruptions
            inst:Show()
            inst.DynamicShadow:Enable(true)
            --
            inst.HUD:Show()
            TheCamera:SetDefault()
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
            inst.components.health:SetInvincible(false)

            --In case of interruptions
            if not inst.sg.statemem.istweencomplete then
                if inst.components.colourtweener:IsTweening() then
                    inst.components.colourtweener:EndTween()
                else
                    inst.AnimState:SetMultColour(1, 1, 1, 1)
                end
            end
        end,
    },
	State{
        name = "reviver_rebirth",
        tags = { "busy", "reviver_rebirth", "silentmorph", "ghostbuild" },

        onenter = function(inst, timeout)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end
            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()
            inst:ClearBufferedAction()

            SpawnPrefab("ghost_transform_overlay_fx").entity:SetParent(inst.entity)

            inst.SoundEmitter:PlaySound("dontstarve/ghost/player_revive")
            if inst.CustomSetSkinMode ~= nil then
                inst:CustomSetSkinMode(inst.overrideghostskinmode or "ghost_skin")
            else
                inst.AnimState:SetBank("ghost")
				inst.AnimState:SetBuild("ghost_"..inst.prefab.."_build")
            end
            inst.AnimState:PlayAnimation("shudder")
            inst.AnimState:PushAnimation("brace", false)
            inst.AnimState:PushAnimation("transform", false)
            inst.components.health:SetInvincible(true)
			inst.HUD:Hide()
            TheCamera:SetDistance(14)

            inst:PushEvent("startghostbuildinstate")
        end,

        timeline =
        {
            TimeEvent(88 * FRAMES, function(inst)
                inst.DynamicShadow:Enable(true)
                if inst.CustomSetSkinMode ~= nil then
                    inst:CustomSetSkinMode(inst.overrideskinmode or "normal_skin")
                else
                    inst.AnimState:SetBank("wilson")
					inst.AnimState:SetBuild(inst.prefab)
                end
                inst.AnimState:PlayAnimation("transform_end")
                -- inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_use_bloodpump")
                inst.sg:RemoveStateTag("ghostbuild")
                inst:PushEvent("stopghostbuildinstate")
            end),
            TimeEvent(89 * FRAMES, function(inst)
                if inst:HasTag("weregoose") then
                   -- DoGooseRunFX(inst)
                end
            end),
            TimeEvent(96 * FRAMES, function(inst)
                inst.components.bloomer:PopBloom("playerghostbloom")
                inst.AnimState:SetLightOverride(0)
            end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            --In case of interruptions
            inst.DynamicShadow:Enable(true)
            if inst.CustomSetSkinMode ~= nil then
                inst:CustomSetSkinMode(inst.overrideskinmode or "normal_skin")
            else
                inst.AnimState:SetBank("wilson")
				inst.AnimState:SetBuild(inst.prefab)
            end
            inst.components.bloomer:PopBloom("playerghostbloom")
            inst.AnimState:SetLightOverride(0)
            if inst.sg:HasStateTag("ghostbuild") then
                inst.sg:RemoveStateTag("ghostbuild")
                inst:PushEvent("stopghostbuildinstate")
            end
            --
            inst.components.health:SetInvincible(false)
            if inst.components.playercontroller then
                inst.components.playercontroller:Enable(true)
            end

            inst.HUD:Show()
            TheCamera:SetDefault()
        end,
    },
}

return STATES
