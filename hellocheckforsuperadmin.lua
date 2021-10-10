local sa = 0

for k,v in ipairs(player.GetAll())
do
    if( v:IsSuperAdmin() )--Why ':' and not '.' because the colon if or implementing methods that pass 'self' as the first parameter ->
    -- -> so for example x:IsSuperAdmin(3,4) should be the same as x.bar(x,3,4) ->
    -- -> so if you dont put ':' it wont pass the self('v' in this case) and in turn wont pass any parameter and not work
    then
        sa = sa+1
        print("There is "..sa.." Super-Admin on the server! Now you Die!(And get respawned)")
        v:Kill()
        v:Spawn()
        --v:Ignite(10,1)
        --Could make it also ignite the player after respawn
    end
end