-- mathlib
 
-- References:
-- http://community.topcoder.com/tc?module=Static&d1=tutorials&d2=geometry2#reflection
-- http://gmc.yoyogames.com/index.php?showtopic=433577
-- http://local.wasp.uwa.edu.au/~pbourke/geometry/
-- http://alienryderflex.com/polygon/
-- http://alienryderflex.com/polygon_fill/
-- http://local.wasp.uwa.edu.au/~pbourke/geometry/lineline2d/
 
-- Functions:
-- lengthOf( a, b )
-- convertDegreesToRadians( degrees )
-- convertRadiansToDegrees( radians )
-- rotateTo( point, degrees )
-- rotateAboutPoint( point, centre, degrees, round )
-- angleOfPoint( pt )
-- angleBetweenPoints( a, b )
-- angleOf( a, b )
-- extrudeToLen( origin, point, lenOrMin, max )
-- smallestAngleDiff( target, source )
-- angleAt( centre, first, second )
-- isPointInAngle( centre, first, second, point )
-- fractionOf( a, b )
-- percentageOf( a, b )
-- midPoint( pts )
-- isOnRight( north, south, point )
-- reflect( north, south, point )
-- doLinesIntersect( a, b, c, d )
-- GetClosestPoint( A,  B,  P, segmentClamp )
-- pointInPolygon( points, dot )
-- pointInPolygons( polygons, dot )
-- pixelFill( points, closed, perPixel, width, height )
-- clamp( val, low, high )
-- forcesByAngle(totalForce, angle)
 
-- returns the distance between points a and b
function lengthOf( a, b )
    local width, height = b.x-a.x, b.y-a.y
    return (width*width + height*height)^0.5 -- math.sqrt(width*width + height*height)
        -- nothing wrong with math.sqrt, but I believe the ^.5 is faster
end
 
-- converts degree value to radian value, useful for angle calculations
function convertDegreesToRadians( degrees )
--  return (math.pi * degrees) / 180
        return math.rad(degrees)
end
 
function convertRadiansToDegrees( radians )
        return math.deg(radians)
end
 
-- rotates a point around the (0,0) point by degrees
-- returns new point object
function rotateTo( point, degrees )
        local x, y = point.x, point.y
 
        local theta = convertDegreesToRadians( degrees )
 
        local pt = {
                x = x * math.cos(theta) - y * math.sin(theta),
                y = x * math.sin(theta) + y * math.cos(theta)
        }
 
        return pt
end
 
-- rotates point around the centre by degrees
-- rounds the returned coordinates using math.round() if round == true
-- returns new coordinates object
function rotateAboutPoint( point, centre, degrees, round )
        local pt = { x=point.x - centre.x, y=point.y - centre.y }
        pt = rotatePoint( pt, degrees )
        pt.x, pt.y = pt.x + centre.x, pt.y + centre.y
        if (round) then
                pt.x = math.round(pt.x)
                pt.y = math.round(pt.y)
        end
        return pt
end
 
-- returns the degrees between (0,0) and pt
-- note: 0 degrees is 'east'
function angleOfPoint( pt )
        local x, y = pt.x, pt.y
        local radian = math.atan2(y,x)
        --print('radian: '..radian)
        local angle = radian*180/math.pi
        --print('angle: '..angle)
        if angle < 0 then angle = 360 + angle end
        --print('final angle: '..angle)
        return angle
end
 
-- returns the degrees between two points
-- note: 0 degrees is 'east'
function angleBetweenPoints( a, b )
        local x, y = b.x - a.x, b.y - a.y
        return angleOfPoint( { x=x, y=y } )
end
 
local PI = (4*math.atan(1))
local quickPI = 180 / PI
function angleOf( a, b )
        return math.atan2( b.y - a.y, b.x - a.x ) * quickPI -- 180 / PI -- math.pi
end
 
-- Extends the point away from or towards the origin to the length of len
-- If param max is nil the lenOrMin value is a the distance to calculate the point's location
-- If param max is not nil the lenOrMin value is the minimum clamping distance to extrude to
-- param lenOrMin: the length or the minimum length to extrude the point's distance to
-- param max: the maximum length to extrude to
function extrudeToLen( origin, point, lenOrMin, max )
        local length = lengthOf( origin, point )
        local len = lenOrMin
        if (max ~= nil) then
                if (length < lenOrMin) then
                        len = lenOrMin
                elseif (length > max) then
                        len = max
                else -- the point is within the min/max clamping range
                        return point.x, point.y
                end
        end
        local factor = len / length
        local x, y = (point.x - origin.x) * factor, (point.y - origin.y) * factor
        return x + origin.x, y + origin.y
end
 
-- returns the smallest angle between the two angles
-- ie: the difference between the two angles via the shortest distance
-- returned value is signed: clockwise is negative, anticlockwise is positve
-- returned value wraps at +/-180
-- Example code to rotate a display object by touch:
--[[
        -- called in the "moved" phase of touch event handler
        local a = mathlib.angleBetweenPoints( target, target.prevevent )
        local b = mathlib.angleBetweenPoints( target, event )
        local d = mathlib.smallestAngleDiff( a, b )
        target.prev = event
        target.rotation = target.rotation - d
]]--
function smallestAngleDiff( target, source )
        local a = target - source
 
        if (a > 180) then
                a = a - 360
        elseif (a < -180) then
                a = a + 360
        end
 
        return a
end
 
-- Returns the angle in degrees between the first and second points, measured at the centre
-- Always a positive value
function angleAt( centre, first, second )
        local a, b, c = centre, first, second
        local ab = lengthOf( a, b )
        local bc = lengthOf( b, c )
        local ac = lengthOf( a, c )
        local angle = math.deg( math.acos( (ab*ab + ac*ac - bc*bc) / (2 * ab * ac) ) )
        return angle
end
 
-- Returns true if the point is within the angle at centre measured between first and second
function isPointInAngle( centre, first, second, point )
        local range = angleAt( centre, first, second )
        local a = angleAt( centre, first, point )
        local b = angleAt( centre, second, point )
        -- print(range,a+b)
        return math.round(range) >= math.round(a + b)
end
 
-- Returns b represented as a fraction of a.
-- Eg: If a is 1000 and b is 900 the returned value is 0.9
-- Often the returned value would be used in a multiplication of another value, usually a distance value.
function fractionOf( a, b )
        return b / a
end
 
-- Returns b represented as a percentage of a.
-- Eg: If a is 1000 and b is 900 the returned value is 90
-- Use: This is useful in determining how far something should be moved to complete a certain distance.
-- Often the returned value would be used in a division of another value, usually a distance value.
function percentageOf( a, b )
        return fractionOf(a, b) * 100
end
 
-- calculates the average of all the x's and all the y's and returns the average centre of all points
function midPoint( pts )
        local x, y, c = 0, 0, #pts
        if (pts.numChildren and pts.numChildren > 0) then c = pts.numChildren end
        for i=1, c do
                x = x + pts[i].x
                y = y + pts[i].y
        end
        return { x=x/c, y=y/c }
end
 
-- returns true when the point is on the right of the line formed by the north/south points
function isOnRight( north, south, point )
        local a, b, c = north, south, point
        local factor = (b.x - a.x)*(c.y - a.y) - (b.y - a.y)*(c.x - a.x)
        return factor > 0, factor
end
 
-- reflect point across line from north to south
function reflect( north, south, point )
        local x1, y1, x2, y2 = north.x, north.y, south.x, south.y
        local x3, y3 = point.x, point.y
        local x4, y4 = 0, 0 -- reflected point
        local dx, dy, t, d
 
        dx = y2 - y1
        dy = x1 - x2
        t = dx * (x3 - x1) + dy * (y3 - y1)
        t = t / (dx * dx  +  dy * dy)
 
        x = x3 - 2 * dx * t
        y = y3 - 2 * dy * t
 
        return { x=x, y=y }
end
 
-- This is based off an explanation and expanded math presented by Paul Bourke:
-- It takes two lines as inputs and returns true if they intersect, false if they don't.
-- If they do, ptIntersection returns the point where the two lines intersect.
-- param L1: The first line
-- param L2: The second line
-- param ptIntersection: The point where both lines intersect (if they do)
-- http://local.wasp.uwa.edu.au/~pbourke/geometry/lineline2d/
function doLinesIntersect( a, b, c, d )
        -- parameter conversion
        local L1 = {X1=a.x,Y1=a.y,X2=b.x,Y2=b.y}
        local L2 = {X1=c.x,Y1=c.y,X2=d.x,Y2=d.y}
        
        -- Denominator for ua and ub are the same, so store this calculation
        local d = (L2.Y2 - L2.Y1) * (L1.X2 - L1.X1) - (L2.X2 - L2.X1) * (L1.Y2 - L1.Y1)
        
        -- Make sure there is not a division by zero - this also indicates that the lines are parallel.
        -- If n_a and n_b were both equal to zero the lines would be on top of each
        -- other (coincidental).  This check is not done because it is not
        -- necessary for this implementation (the parallel check accounts for this).
        if (d == 0) then
                return false
        end
        
        -- n_a and n_b are calculated as seperate values for readability
        local n_a = (L2.X2 - L2.X1) * (L1.Y1 - L2.Y1) - (L2.Y2 - L2.Y1) * (L1.X1 - L2.X1)
        local n_b = (L1.X2 - L1.X1) * (L1.Y1 - L2.Y1) - (L1.Y2 - L1.Y1) * (L1.X1 - L2.X1)
        
        -- Calculate the intermediate fractional point that the lines potentially intersect.
        local ua = n_a / d
        local ub = n_b / d
        
        -- The fractional point will be between 0 and 1 inclusive if the lines
        -- intersect.  If the fractional calculation is larger than 1 or smaller
        -- than 0 the lines would need to be longer to intersect.
        if (ua >= 0 and ua <= 1 and ub >= 0 and ub <= 1) then
                local x = L1.X1 + (ua * (L1.X2 - L1.X1))
                local y = L1.Y1 + (ua * (L1.Y2 - L1.Y1))
                return true, {x=x, y=y}
        end
        
        return false
end
 
-- returns the closest point on the line between A and B from point P
function GetClosestPoint( A,  B,  P, segmentClamp )
    local AP = { x=P.x - A.x, y=P.y - A.y }
    local AB = { x=B.x - A.x, y=B.y - A.y }
    local ab2 = AB.x*AB.x + AB.y*AB.y
    local ap_ab = AP.x*AB.x + AP.y*AB.y
    local t = ap_ab / ab2
 
    if (segmentClamp or true) then
         if (t < 0.0) then
                t = 0.0
         elseif (t > 1.0) then
                t = 1.0
         end
    end
 
    local Closest = { x=A.x + AB.x * t, y=A.y + AB.y * t }
 
    return Closest
end
 
-- Returns true if the dot { x,y } is within the polygon defined by points table { {x,y},{x,y},{x,y},... }
function pointInPolygon( points, dot )
        local i, j = #points, #points
        local oddNodes = false
 
        for i=1, #points do
                if ((points[i].y < dot.y and points[j].y>=dot.y
                        or points[j].y< dot.y and points[i].y>=dot.y) and (points[i].x<=dot.x
                        or points[j].x<=dot.x)) then
                        if (points[i].x+(dot.y-points[i].y)/(points[j].y-points[i].y)*(points[j].x-points[i].x)<dot.x) then
                                oddNodes = not oddNodes
                        end
                end
                j = i
        end
 
        return oddNodes
end
 
-- Return true if the dot { x,y } is within any of the polygons in the list
function pointInPolygons( polygons, dot )
        for i=1, #polygons do
                if (pointInPolygon( polygons[i], dot )) then
                        return true
                end
        end
        return false
end
 
-- Returns true if the points in the polygon wind clockwise
-- Does not consider that the vertices may intersect (lines between points might cross over)
function isPolyClockwise( pointList )
        local area = 0
        
        for i = 1, #pointList-1 do
                local pointStart = { x=pointList[i].x - pointList[1].x, y=pointList[i].y - pointList[1].y }
                local pointEnd = { x=pointList[i + 1].x - pointList[1].x, y=pointList[i + 1].y - pointList[1].y }
                area = area + (pointStart.x * -pointEnd.y) - (pointEnd.x * -pointStart.y)
        end
        
        return (area < 0)
end
 
-- returns a display group with the pixels of the polygon filled in
-- values in the points table need to be {x,y} tables
-- polygon does not need to be anti/clockwise winding
-- param points: the polygon points
-- param closed: true to cut the polygon out of the screen, false to fill it in
-- param perPixel: true to fill each pixel individually
-- param width, height: width and height of each pixel or height of each row
-- param col: table containing {r,g,b} to set the polygon colour and override the default random colours
function polygonFill( points, closed, perPixel, width, height, col )
        local fill = display.newGroup()
        local nodes, nodeX, pixelX, pixelY, i, j, swap = 0, {}, 0, 0, 0, 0, 0
        local IMAGE_BOT, IMAGE_TOP, IMAGE_LEFT, IMAGE_RIGHT = 0, display.contentHeight, display.contentWidth, 0
        local closestPoint, shortestDist, closestIndex = {x=0,y=0}, 5000, 0
 
        -- if the polygon is closed then encase it in a rect the size of the screen
        -- the starting point needs to be closest to the closestPoint
        if (closed) then
                for i=1, #points do
                        if (closed) then
                                local len = lengthOf( points[i], closestPoint )
                                if (len < shortestDist) then
                                        closestIndex = i
                                        shortestDist = len
                                end
                        end
                end
                -- insert bounding box
                table.insert(points,closestIndex+0,{x=points[closestIndex].x,y=points[closestIndex].y})
                table.insert(points,closestIndex+1,closestPoint)
                table.insert(points,closestIndex+2,{x=display.contentWidth,y=0})
                table.insert(points,closestIndex+3,{x=display.contentWidth,y=display.contentHeight})
                table.insert(points,closestIndex+4,{x=0,y=display.contentHeight})
                table.insert(points,closestIndex+5,closestPoint)
        end
 
        -- find highest, lowest, left-most and right-most points on screen (and their indices)
        for i=1, #points do
                if (points[i].y > IMAGE_BOT) then IMAGE_BOT = points[i].y end
                if (points[i].y < IMAGE_TOP) then IMAGE_TOP = points[i].y end
                if (points[i].x > IMAGE_RIGHT) then IMAGE_RIGHT = points[i].x end
                if (points[i].x < IMAGE_LEFT) then IMAGE_LEFT = points[i].x end
        end
 
        -- Loop through the rows of the image.
        for pixelY=IMAGE_TOP, IMAGE_BOT, height do
                -- Build a list of nodes.
                nodes = 1
                j=#points
 
                for i=1, #points do
                        if (points[i].y<pixelY and points[j].y>=pixelY or points[j].y<pixelY and points[i].y>=pixelY) then
                                nodeX[nodes] = (points[i].x+(pixelY-points[i].y)/(points[j].y-points[i].y)*(points[j].x-points[i].x))
                                nodes = nodes + 1
                        end
                        j = i
                end
 
                -- Sort the nodes, via a simple “Bubble sort.
                i = 1
                while (i < nodes-1) do
                        if (nodeX[i]>nodeX[i+1]) then
                                swap=nodeX[i]
                                nodeX[i]=nodeX[i+1]
                                nodeX[i+1]=swap
 
                                if (i > 1) then
                                        i = i - 1
                                end
                        else
                                i = i + 1
                        end
                end
 
                -- Fill the pixels between node pairs.
                for i=1, nodes-1, 2 do
                        if (nodeX[i  ] >= IMAGE_RIGHT) then
                                break
                        end
                        if (nodeX[i+1] > IMAGE_LEFT) then
                                if (nodeX[i  ]< IMAGE_LEFT ) then nodeX[i  ] = IMAGE_LEFT end
                                if (nodeX[i+1]> IMAGE_RIGHT) then nodeX[i+1] = IMAGE_RIGHT end
 
                                if (perPixel or false) then
                                        for j=nodeX[i], nodeX[i+1], width do
                                                local rect = display.newRect( fill, 0, 0, width, height )
                                                rect.x, rect.y = j, pixelY
                                                if (col) then
                                                        rect:setFillColor( col.r, col.g, col.b )
                                                else
                                                        rect:setFillColor( math.random( 100,255 ), math.random( 100,255 ), math.random( 100,255 ) )
                                                end
                                        end
                                else
                                        local rwidth = nodeX[i+1]-nodeX[i]
                                        local rect = display.newRect( fill, 0, 0, rwidth, height )
                                        rect.x, rect.y = nodeX[i]+rwidth/2, pixelY
                                        if (col) then
                                                rect:setFillColor( col.r, col.g, col.b )
                                        else
                                                rect:setFillColor(0,0,0 )
                                        end
                                end
                        end
                end
        end
 
        return fill
end
 
-- return a value clamped between a range
function clamp( val, low, high )
        if (val < low) then return low end
        if (val > high) then return high end
        return val
end
 
-- Forces to apply based on total force and desired angle
-- http://developer.anscamobile.com/code/virtual-dpadjoystick-template
function forcesByAngle(totalForce, angle)
        local forces = {}
        local radians = -math.rad(angle)
 
        forces.x = math.cos(radians) * totalForce
        forces.y = math.sin(radians) * totalForce
 
        return forces
end