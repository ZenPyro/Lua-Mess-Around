--Eventually create a tool that allows me to lay rock scenery to look nice
SWEP.PrintName = "Wall Thrower"--shown in the spawn menua and the weapon selection menu
SWEP.Author = "ZenPyro"
SWEP.Instructions = "Use left mouse to fire off some walls!"
SWEP.Category = "Zen's Weapon Tool-Box"
SWEP.Spawnable = true--defines whether players can spawn this weapon from the spawnmenu
SWEP.AdminOnly = true

--local reloadCooldown = 1--Time before player can reload again
--local lastreloadCooldown = 0

--infinite ammo and clip size so 'ammo = "none"' and 'clipsize = -1'
SWEP.Primary.ClipSize = -1 --just practice: This is a table 'SWEP' that has a table 'Primary' ->
-- -> in it that has a key/value pair that has an integer that gives the 'ClipSize'(key)
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5--the higher the weight the more likely you are to switch to it
SWEP.AutoSwtitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

--view-model and world-model used
SWEP.ViewModel = "models/weapons/v_rpg.mdl"
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"

--Precache sounds - by defining them as locals or SWEP variables using the Sound function ->
-- -> this is to prevent sound loading when you first shoot the weapon - causing a hitch
SWEP.LShootSound = Sound("Metal.SawbladeStick")
SWEP.RShootSound = Sound("Weapon_Pistol.Single")
SWEP.ReloadSound = Sound("Weapon_Crossbow.Reload")--precached reload sound
--actual wall throwing code

--Called when the left mouse button is pressed
function SWEP:PrimaryAttack()
    --This weapon is 'automatic'. This function call below defines the rate of fire ->
    -- ->  here we set it to shoot every 0.5 seconds
    self:SetNextPrimaryFire(CurTime() + 0.5)--the self here is the SWEP sent as 'self' because ->
    -- -> the ':' was used in 'SWEP:PrimaryAttack()' meaning its sending its 'self' and the variable ->
    -- -> will be called 'self'
    
    --'CurTime()' returns the uptime of the server in seconds(to at least 4 decimal places)

    --Call 'ThrowWall' on self with this model
    --self:LThrowWall("models/paynamia/bms/gordon_survivor.mdl")
    self:LThrowWall("models/props_junk/wood_crate001a.mdl")
    --"models/props_forest/cliff_wall_02c.mdl"
end

--Called when the rightmouse button is pressed
function SWEP:SecondaryAttack()
    --Though the secondary fire isnt automatic, players shouldnt be able to fire too fast
    self:SetNextSecondaryFire(CurTime()+0.1)
    --self:ThrowWall("models/prop_headcrabforwalllauncher/fc87f0bbdb3fdfc16a645cbf2e9fd7bb.dupe")
    self:RThrowWall("models/props_building_details/Storefront_Template001a_Bars.mdl")
    
end

--A custom function we added. When you call this the player will fire the model!
function SWEP:LThrowWall(model_file)
    local owner = self:GetOwner()--returns owner of the tool(i.e. player using the tool)
    --which is 'owner' being a 'table' that is a 'string'
    --Make sure the weapon is being held before trying to throw a wall
    if(not owner:IsValid()) then--Returns whether an object is valid or not(i.e. checks that an ->
        -- -> object such as an Entity, Panel, or custom table are not nil, has an IsValid method ->
        -- -> and if this method returns true)
        return
    end

    --Play the shoot sound we precached earlier
    self:EmitSound(self.LShootSound)

    --If were the client then this as much as we want to do
    --We play the sound above on the client due to prediction (if we didnt they would feel a ->
    -- -> ping delay during multiplayer)
    if(CLIENT)then
        return
    end

    --Create a prop_physics entity
    local ent = ents.Create("prop_physics")

    --Always make sure that created entities are actually created
    if(not ent:IsValid())then
        return
    end

    --Set the entitys model to the passed in model
    ent:SetModel(model_file)

    --This is the same as owner:EyePos() + (self.Owner:GetAimVector()*16)
    --but the vector methods prevent duplicitous objects from being created
    --which is faster and more memory efficient
    --AimVector is not directly modified as it is used again later in the function
    local aimvec = owner:GetAimVector()--Returns the direction that the player is aiming(as a vector)
    local pos = aimvec * 16 --This creates a new(copy) vector object(so we dont modify the vector ->
    -- -> 'aimvec' variable that we need to keep the same for later)
    pos:Add(owner:EyePos())--This translates the local aimvector to world coordinates
    --'EyePos()' returns the orgin of the current render context as calculated by 'GM:CalcView' ->
    -- -> (i.e. it gives the vector of the camera position)

    --Set the positon of the players eye position plus 16 units forward
    ent:SetPos(pos)--'SetPos()' Moves the entity to the specificed position ->
    -- -> this being the eyes entity's position(this is because we set up the variable 'pos' ->
    -- -> as the 'owner:EyePos()' earlier making it the Eye's Position)

    --Set the angles to the player's eye angles, then spawn it
    ent:SetAngles(owner:EyeAngles())
    ent:Spawn()--Spawns the string/table entity that we named ent when we did ->
    -- -> 'local ent = ents.Create("prop_physics")' and passed the rock model into the table ->
    -- -> when we did 'ent:SetModel(model_file)'

    --Now get the physics object, whenever we get a physics object we need to test to make ->
    -- -> sure its valid before using it, if it isnt then well remove the entity

    local phys = ent:GetPhysicsObject()--makes a physics object variable that is the entity 'ent'
    if(not phys:IsValid())then
        ent:Remove()
        return
    end

    --Now we apply the force - so the wall actually throws instead of just falling to the ->
    -- -> ground, you can play with this value to adjust how fast we throw it
    --Now that this is the last use of the aimvector vector we created, we can ->
    -- -> directly modify it instead of creating another copy
    aimvec:Mul(10000)--Mutliplies the scalar to all the values of the original angle ->
    -- -> (the function 'Mul' is the same as 'num * angle' without creating a new angle object ->
    -- -> skipping object construction and garbage collection)

    --IMPORTANT: Also making 'aimvec:Mul()' have a big # in it like '10000' makes it fly straighter ->
    -- -> vs a smaller number like '10'(flies speratically) and this is because ->
    -- -> below we add a random angle vector('VectorRand(-10,10)') below and a bigger # ->
    -- -> for vector variable angle 'aimvec' is effected less by the randomness of the #'s ->
    -- -> '(-10,10)' ->
    -- -> I.E.: 10000-10 = 9990 or 10000+10 = 10010 vs 20-10 = 10 or 20+10 = 30 ->
    -- -> the small vector has its angle changed by up to 50%!

    aimvec:Add(VectorRand(-10,10))--Add a random vector with elements [-10, 10) (min and max)
    phys:ApplyForceCenter(aimvec*10000)--Applies the specified force('aimvec') to the physics object ->
    -- ->(in this case its the center of the physics object('phys'))
    
    --Assuming were playing in sanbox mode we want to add this entity to cleanup and undo lists ->
    -- -> this is done like so
    cleanup.Add(owner,"props",ent)--'cleanup.Add(Player pl, string type, Entity ent)'

    --this is so you can undo(delete) the entity using the keyboard key "z" in game
    undo.Create("Thrown_Model")
        undo.AddEntity(ent)
        undo.SetPlayer(owner)
    undo.Finish()
end

--A custom function we added. When you call this the player will fire the wall!
function SWEP:RThrowWall(model_file)
    local owner = self:GetOwner() 
    if(not owner:IsValid())then
        return
    end

    self:EmitSound(self.RShootSound)

    if(CLIENT)then
        return
    end

    local ent = ents.Create("prop_physics")

    if(not ent:IsValid())then
        return
    end

    ent:SetModel(model_file)

    local aimvec = owner:GetAimVector()
    local pos = aimvec * 16 
    pos:Add(owner:EyePos())

    ent:SetPos(pos)
    ent:SetAngles(owner:EyeAngles())
    ent:Spawn()
    local phys = ent:GetPhysicsObject()
    if(not phys:IsValid())then
        ent:Remove()
        return
    end

    aimvec:Mul(10000)

    aimvec:Add(VectorRand(-10,10))
    phys:ApplyForceCenter(aimvec*10000)
    cleanup.Add(owner,"props",ent)

    undo.Create("Thrown_Wall")
        undo.AddEntity(ent)
        undo.SetPlayer(owner)
    undo.Finish()
end

function SWEP:ReloadWatermelon(model_file)
    local owner = self:GetOwner()

    if(not owner:IsValid())then
        return
    end

    self:EmitSound(self.ReloadSound)--using precached reload sound

    if(CLIENT)then--This is used when not mutliplayer(multiplayer needs steps to keep from lag)
        return
    end
    local ent = ents.Create("prop_physics")

    if(not ent:IsValid())then
        return
    end
    ent:SetModel(model_file)

    local aimvec = owner:GetAimVector()
    local pos = aimvec*16

    pos:Add(owner:EyePos())

    ent:SetPos(pos)
    ent:SetAngles(owner:EyeAngles())

    ent:Spawn()

    --Now we have to set up the physics of the object(entity)
    local phys = ent:GetPhysicsObject()

    if(not phys:IsValid())then
        ent:Remove()
        return
    end

    --aimvec:Mul(10) --dont need to change angle for reload melon

    aimvec:Add(VectorRand(-10,10))
    phys:ApplyForceCenter(aimvec)

    cleanup.Add(owner,"props",ent)--'cleanup.Add': cleanup is a table that hold a function 'Add' ->
    -- -> that adds an entity to a players cleanup list
    
    undo.Create("Reload_Melon")
        undo.AddEntity(ent)--funtion 'AddEntity' from the undo library(table): Adds ->
        -- -> an entity to the current undo block
        undo.SetPlayer(owner)-- function 'SetPlayer' from the undo library(table): Sets ->
        -- -> the player which the current undo block belongs to
    undo.Finish()--function 'Finish' from the undo library(table): Completes an undo ->
    -- -> entry and registers it with the players client(shows the pop up that says ->
    -- -> "deleted Reload_Melon" when the keyboard key "z" is hit by the player)

end

--Using this function call below to reach 'self:ReloadWatermelon("models/props_junk/watermelon01.mdl")' ->
-- -> is useless but I thought it was cool so I kept it

function SWEP:CanReloadAgain()
    self:ReloadWatermelon("models/props_junk/watermelon01.mdl")
end

function SWEP:Reload()
    timer.Create("timest",1,1,function() self:CanReloadAgain() end)
    --IMPORTANT: timer repetitions is the third parameter(second 1) in the timer.Create function

    --Below is was my orginal idea of thinking(is nonsense), realized much easier way to do it(above)
    
    --timer:Start()
    --for k,v in pairs(timer)
    --do
    --    if(5 == timer.Start(timer))then
    --        return
    --    end
    --end
    --timer:Stop()
    
end

--BELOW: The code below is a different(allbeit longer) way of doing the same code I did above ->
-- -> that being said I think its important to keep as a reference due to the use of ->
-- -> the 'os.time()' function as a way to see if reload time is up and could help me in the future

--function SWEP:CanReloadAgain()
--    self:ReloadWatermelon("models/props_junk/watermelon01.mdl")
--end

--function SWEP:Reload()--Reload function with cooldown(for cooldown parameters check: line 9 and 10)
--    if((os.time()-lastreloadCooldown)>reloadCooldown)then
--        timer.Create("timest",1,1,function() self:CanReloadAgain() end)--used timer instead of ->
        -- -> just putting 'self:ReloadWatermelon("models/props_junk/watermelon01.mdl")' to ->
        -- -> act kind of as a reminder to add an animation there one day that will take ->
        -- -> one second to play out just like how the timer takes one second to go through ->
        -- -> plus timers are cool and I wanted to use one!
        --IMPORTANT: timer repeitions is the second 1 in the timer.Create function
--    end
--    lastreloadCooldown = os.time()--Sets this time as last using time of reload
--end

