local emptyTable = {} --making an empty table using the table constructor ({})

local tablePrime = --creating an table with predefined values using the table constructor
{
    [1] = "Mordisimus", --Would have to be ["count"] = "Mordisimus" for print(tablePrime.count) to work
    [2] = "Primus",
    [3] = "Flinganto",
}
--remember to put a comma after every "key = value" line, [1] = "Mordisimus",

for count = 1, 3, 1
do
    print(tablePrime[count]) --CANT do 'tablePrime.count' because ->
    -- -> tablePrime.count == tablePrime["count"] , and ["count"] DOES NOT EQUAL [count] ->
    -- -> which means for the first iteration to give "Mordisimus" , line 5 would have to be ->
    -- -> ["count"] = "Mordisimus" or count = "Mordisimus" 
end

print("\n")

--we can also have lua fill in numeric order values automatically, as in you put certain values in the constructor and it will automatically know to put it for the first key, second key, and so on
local tablePrime={"Milreek","Mitlos","Moritania"}
for count = 1, 3, 1
do
    print(tablePrime[count])
end

--two ways to define string keys on our table
tablePrime.SomeStringKey = "Primus" --1st way: shorthandway

print(tablePrime["SomeStringKey"])--testing to see if it prints the value: "Primus"

tablePrime["SomeStringKey"] = "Primus" --2nd way: long way

print(tablePrime["SomeStringKey"])--testing to see if it prints the value: "Primus"

--these are methods are like saying, "tablePrime AT SomeStringKey EQUALS Primus"

print("\n")

tablePrime = {"Mordisimus","Primus","Flinganto"}
tablePrime.StringKey = "Mitlos?" --defining a string key on the table

--using pairs() (forloop) to loop over the numeric values
--the variable 'i' is acting as our key, and we can get the corresponding value by referncing 'tablePrime[i]'
for i=1,#tablePrime
do
    print(i.." == "..tablePrime[i])
end