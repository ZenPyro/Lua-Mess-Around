--USE A LIST INSTEAD: Any time you need to save distinct data in an unordered table
--normal sequential table
--below setting up a table constructor
local table = {
    "a",
    "b",
    "c"
}

--Checking if a value is in a normal table(sequential table):
--function is checking if the table 'table' has a value at its self 'table'(this means the first parameter is the tbale to check)->
-- ->  and the value ("a","b","c") is stored at the key (checking if a value is stored at the key is done through the iteration below)
-- -> the parameters of the HasValue function are the 1st parameter: the table youre searching ->
-- -> second parameter: the value you are checking to see if the table holds
-- HasValue returns a boolean value (true or false)
local i = 0
function table.HasValue(table, value) --O(n) worst-case complexity
    for k,v in ipairs(table) --use of iteration is required to check whether a value is stored in the table
   --v is the equivalent to saying 'table[key]' which in this case 'table[1]'(key being the 1) is "a" ->
   -- -> so v = "a"
   --If you see '[key]' this is equivalent to just saying the value, so [1] = "a" where a is the value at that key of 1 ->
   -- -> (keep in mind there has to be a table infront of the [key] for it to work/make sense,
   -- -> I just didnt include it this time, so it could conceptually make more sense this time)
    do
        i = i+1
        if v == value then
            print(i.." iter.") --Using the first iteration as an example: it checks to see if v == value ->
            -- -> (value being literally anything, so for this to hold true all v has to be is anything but nil ->
            -- -> because we know the first conceptual property of v being in the table is satisified
            -- -> (due to v being the result of using ipairs to loop through the table))
            -- -> and v is "a" in the first iteration because ipairs sets 'v = table[1]' and the value of table[1] is "a"
            return true -- v does == any value at all so it returns true for the first iteration (Key: 1 (table[1]))
        end
        print(i.." iter.")
    end

    return false
end
table.HasValue(table,table[1]) -- == table.HasValue(table,"a")
local list = {
     --In a list you just make the "value" into the "key" and store a value into that "value" ->
     -- -> basically making the value into a key, and making a nested key (a key within a key that has a value) ->
     -- -> Conceptual EX) Value:(true) -> Key:("a") -> Highest Key: (["a"]) ->
     -- -> I.e. Using the actual value we intend to store as the key itself
     -- -> For example if you call list["a"] you will get true ->
     -- -> This is important because with a regular table if we call table[1] we would get "a" ->
     -- -> Then to get its boolean value we would have to iterate through it while also using the HasValue() function ->
     -- -> With a list we can go straight to just using the function with no iteration required ->
     -- -> because when the key is called its also a built in value so the boolean value is spit out too ->
     -- -> EX) 
     
    ["a"] = true, --Same as putting a = true
    ["b"] = true, --Same as putting b = true
    ["c"] = true,  --Same as putting c = true
        d = true,  --Same as putting ["d"] = true
        --I put this here as an example of them being the exact same ->
        -- -> you would want to use this method if you wanted to use something like 'list.d'
    l = {
            f = true
        },
                        -- The key/value pair above and below this comment are equivalent if they used the same letters
    ["p"] = {
        ["j"] = true
    },
    o = {}
} --this is a value-indexed version of that table

--Two ways to do this next part: 1. Could add 'o = {}' to line 65 or ->
-- -> 2. Could add 'list.o = {"t"}' to line 70
--list.o = {"t"}
list.o.t = true --Like tablePrime.StringKey = "Mitlos?" (i.e. adding a new key/value pair to the table(list))

--Checking if a value is in a value-indexed table:
--Function is check if the value in a table(this case the table is a list) has a value and returning a boolean ->
-- -> list.ListHasValue(table,value) stores the list(a fancy type of table(a non-numerical key table)) ->
-- -> as the 1st parameter: 'table' and the second parameter the value you are checking to see table[value] hold ->
-- -> table[value] is like saying list["a"] or list[a] because value = "a" or value = a
-- -> and since ["a"] = true or a = true then value = true ->
-- -> so when it says 'return table[value]' it is like saying 'return true' ->
-- -> so the first iteration of the list returns true
local count = 0
function ListHasValue(table,value) --O(1) worst case complexity (if: function list.ListHasValue(table,value) go to line 89 and 96)
    count = count+1
    return table[value]
end
local valuee = "a"
print(list[valuee]) -- == print(list["a"])
print(list["a"]) -- == print(list[valuee])
print(ListHasValue(list,"a")) --If comment is true then this has to be 'print(list.ListHasValue(list,"a"))'
print(count.." iteration(s) to get [[a]]")

local valueee = "d"
print(list[valueee])
print(list.d) -- !== print(list[d])  (does not equal)
-- list.d == list["d"]
print(ListHasValue(list,"d")) --If comment is true then this has to be 'print(list.ListHasValue(list,"d"))' ->
-- -> == print(list.d) == list:ListHasValue("d")
print(count.." iteration(s) to get [[d]]")
print(list.l.f) -- == print(list.l["f"]) == print(list["l"]["f"]) == print(ListHasValue(list.l,"f"))
print(ListHasValue(list.l,"f")) -- == print(list.l.f)
print(list.p.j)
print(list.o.t)
print(list.l["f"])
print(list["l"]["f"])
--To do 'print(ListHasValue(list,"f"))' would have to change function at line 82 to ->
-- -> 'function ListHasValue(table,value1,value2)' and change line 84 to ->
-- -> 'return table[value1][value2]'

--Can be taken one step further with 2D lists
--A 2D sequential table holding players' friends as {guy=player, friends={their friends}}
local friendTable ={
{
    guy = Entity(1),
    friends = 
    {
        Entity(2),
        Entity(3)
    }
},
    {
        guy = Entity(2),
        friends =
        {
            Entity(1)
        }
},
    {
        guy = Entity(3),
        friends = 
        {
            Entity(1)
        }
    }

}

function TwoPlayersAreFriends(ply1,ply2)
    for k,v in ipairs(friendTable)
    do
        if v.guy == ply1 then
            for k,friend in ipairs(v.friends)
            do
                if friend == ply2 then
                    return true
                end
            end
        end
    end
    return false
end

--And this is a 2D list which holds the same data as above
local friendList = {
    Entityp1 = {
       Entity2 = true,
        Entity3 = true
    },
    Entityp2 = {
        Entity1 = true
    },
    Entityp3 = {
        Entity1 = true
    }
}

--Checking if a value is in a value-indexed table:
function TwoPlayersAreFriends(ply1,ply2)
    return friendList[ply1][ply2]
end

print("\nNow doing friendList function")
   
    print(TwoPlayersAreFriends("Entityp2","Entity1"))
    print(TwoPlayersAreFriends("Entityp1","Entity2"))
    print(TwoPlayersAreFriends("Entityp2","Entity2"))
    if TwoPlayersAreFriends("Entityp2","Entity2") == nil then
        print(false)
    end
     --Below all three are the SAME
    print(friendList.Entityp1.Entity2)
    print(friendList.Entityp1["Entity2"])
    print(friendList["Entityp1"]["Entity2"])
    