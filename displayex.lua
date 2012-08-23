-- DISPLAY LIBRARY
 
 
-- provides a generic reference to the stage display group
stage = display.getCurrentStage()
 
 
-- list of colours
black = {r=0,g=0,b=0,a=255}
white = {r=255,g=255,b=255,a=255}
red = {r=255,g=0,b=0,a=255}
green = {r=0,g=255,b=0,a=255}
blue = {r=0,g=0,b=255,a=255}
pink = {r=255,g=105,b=180,a=255}
mediumvioletred = { r=199, g=21, b=133 }
 
 
-- regular indexOf method to find the index position of objects within a display group, returns nil or nf param if not found
-- param t: display group to look in
-- param obj: display object to look for
-- param nf: value to return when the obj is not found within the t display group
display.indexOf = function( t, obj, nf )
        for i=1, t.numChildren do
                if (t[i] == obj) then
                        return i
                end
        end
        if (nf) then
                return nf
        else
                return nil
        end
end
 
 
-- calls display.getCurrentStage():setFocus
function setFocus( target, id )
        if (id) then
                stage:setFocus( target, id )
        else
                stage:setFocus( target )
        end
end
 
 
-- calls display.getCurrentStage():setFocus( nil ) or ( nil, nil )
-- param id: optional and the id of the touch event if provided
function unsetFocus( id )
        setFocus( nil, id )
end
 
 
-- set a colour
function setStrokeColor( target, col )
        if (target.setStrokeColor) then
                target:setStrokeColor( col.r, col.g, col.b, col.a or 255 )
        end
end
 
function setColor( target, col )
        if (target.setColor) then
                target:setColor( col.r, col.g, col.b, col.a or 255 )
        elseif (target.setFillColor) then
                target:setFillColor( col.r, col.g, col.b, col.a or 255 )
        elseif (target.setTextColor) then
                target:setTextColor( col.r, col.g, col.b, col.a or 255 )
        end
end
 
 
-- removes all display objects from a display group, but not the group itself
-- param keepgroups: when true the display groups will simply be cleared of non-display groups
function clear( group, keepgroups )
        local index = 1
        while (group.numChildren ~= nil and group.numChildren>0 and index<=group.numChildren) do
                if (group[index].numChildren ~= nil and group[index].numChildren>0) then
                        clear(group[index])
                end
                if (group[index].numChildren == nil) then
                        group[index]:removeSelf()
                else
                        index = index + 1
                end
        end
end
 
-- appends the contents of one table onto the first
-- similar to table.copy except this only appends one table and will copy the maxn elements, not #tbl elements
table.append = function( tbl, append )
        local size, appendsize = table.maxn(tbl), table.maxn(append)
        for i=1, appendsize do
                tbl[ size + i ] = append[ i ]
        end
end
 
-- returns a new table containing the elements between the first and last index elements
table.range = function( tbl, first, last )
        local index, source, copy = 1, first, {}
        for source=first, last do
                copy[ index ] = tbl[ source ]
                index = index + 1
        end
        return copy
end
 
-- the order of entries in a table, sectioned into ranges
-- this can be used to invert the list of points as passed into display.newLine, to reverse the points
-- note: the number of elements in the table must be equally divisable by the rangesize
table.invert = function( tbl, rangesize )
        rangesize = rangesize or 1
        local reversed = {}
        for i=1, #tbl-rangesize+1, rangesize do
                for t=rangesize-1, 0, -1 do
                        table.insert( reversed, 1, tbl[ i+t ] )
                end
        end
        return reversed
end
 
-- converts a newLine style { 34,3 , 23,66 , 56,5 } table into a table of { { x,y }, { x,y }, { x,y } } style
table.listToNamed = function( tbl, keys )
        local named = {}
        for i=1, #tbl-#keys+1, #keys do
                local collection = {}
                for k=0, #keys-1 do
                        local name = keys[ 1+k ]
                        local value = tbl[ i+k ]
                        collection[ name ] = value
                end
                named[ #named+1 ] = collection
        end
        return named
end
 
-- converts a { { x,y }, { x,y }, { x,y } } style table into a newLine { 34,3 , 23,66 , 56,5 } style list table
table.namedToList = function( tbl, keys )
        local list = {}
        for i=1, #tbl do
                for k=1, #keys do
                        local key = keys[k]
                        local collection = tbl[i]
                        list[ #list+1 ] = collection[ key ]
                end
        end
        return list
end