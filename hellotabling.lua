local emptyTable = {} --making an empty table using the table constructor ({})

local tablePrime = --creating an table with predefined values using the table constructor
{
    [1] = "Mordisimus",
    [2] = "Primus",
    [3] = "Flinganto",
}
--remember to put a comma after every "key = value" line, [1] = "Mordisimus",
--using a for loop to see if it prints correctly, note I am using 3 as the length instead of ->
-- -> using the '#' operator for length of since I know the exact length of the table
for count = 1, 3, 1
do
    print(tablePrime[count])
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

--using forloop to loop over the numeric values
--the variable 'i' is acting as our key, and we can get the corresponding value by refrencing 'tablePrime[i]'
--the length operator is denoted by '#'
print("Using forloop.\n")
for i=1,#tablePrime
do
    print(i.." == "..tablePrime[i])
end

print("\n")

--using pairs() to loop through
--k for keys and v for value
print("Using pairs().\n")
for k,v in pairs(tablePrime)
do
    print(k.." == "..v)
end
--see how unlike the forloop the pairs prints the "Mitlos?"

print("\n")

--practice with the table library
--table.Merge
local tableFruits = 
{
    "Apple",
    "Orange",
    "Banana",
    "Pineapple"
}

local tableVeggies = 
{
    "Potato",
    "Carrot"
}

--now using the table.Merge function we merge the values in the table 'Veggies' into the 'Fruits' table
table.Merge(tableFruits, tableVeggies) --remember the args go: to, from (so to fruits from veggies, as in veggies goes into fruits)
--the "Potato" value will replace the "Apple" value in Fruits(key '1'), and: ->
-- -> the "Carrot" value will replace the "Orange" value in Fruits(key '2')

--Printing values in the table Fruits after the merge between the two tables
--could use ipairs function for this since all the keys are numeric but will learn about that a little later
for k,v in pairs(tableFruits)
do
    print(k.." == ".. v)
end

print("\n")

--now using the function table.concat to print the values
--table.concat - concatenates the contents(values) of a table to a string
print(table.concat(tableFruits," "))

print("\n")

--now using the table.Add function
tableFruits = 
{
    "Apple",
    "Orange"
}

tableVeggies = 
{
    "Potato",
    "Veggies"
}
--Add all the values in Veggies to the END of the Fruits table:
table.Add(tableFruits,tableVeggies)--remember the args go: to, from (so to fruits from veggies, as in the veggies are added to the END of the fruits table)

--Printing values usinh pairs()
for k,v in pairs(tableFruits)
do
    print(k.." == "..v)
end

print("\n")

--Printing using table.concat
print(table.concat(tableFruits, " "))

--Using ipairs to loop through the key/value pairs(indexes) with numeric keys, and print them out
local tableNames =
{
    [1] = "Primus",
    [2] = "Mordisimus",
    [3] = "Moritania"
}

for k,v in ipairs(tableNames)
do
    print(k.." == "..v)
end

print("\n")

--Using the RandomPairs function to loop through the values and output them, but in a random order each time
for k,v in RandomPairs(tableNames)
do
    print(v)
end

print("\n")

--Using SortedPairs to loop through the table and sort the KEYS alphabetically
tableNames =
{
    E = 5,
    B = 4,
    A = 2,
    D = 3,
    C = 1
}

for k,v in SortedPairs(tableNames)
do
    print(k.." == "..v)
end
--Keys should be sorted alphabetically
