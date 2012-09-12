-----------------------------------------------------------------------------------------
--
-- main.lua
-- Main scene for "Crossfire" - for now, it loads the game screen.
-----------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )
local physics = require "physics"

-- Enable Physics and Multitouch

system.activate( "multitouch" )
physics.start();
physics.setVelocityIterations( 30 )
physics.setPositionIterations( 30)
physics.setScale( 60 ) 
physics.setGravity(0,0);
--physics.setDrawMode ( "hybrid" )	 -- Uncomment if you want to see all the physics bodies

-- require controller module
local storyboard = require "storyboard"
storyboard.purgeOnSceneChange = true
local widget = require "widget"
local stopwatch = require "stopwatch"

-- some global variables
local gameMode;
local pointLimit = 2;
local player1Bullets;
local player2Bullets;
local bigObjectsOnScreen;
local attractorPresent = false;
local attractor;

local gameOn = true;
--print (gameOn);
--define some global functions
function getDirection(objX, objY, otherObjX, otherObjY)

--    local xdir = otherObjX - objX;
 --   local ydir = otherObjY - objY;
    
 --   local mag = math.sqrt(xdir*xdir + ydir*ydir);
    
  --  if (mag != 0) {
  --    xdir = xdir/mag;
  --    ydir = ydir/mag;
  --  }
    
  --  return xdir,ydir;
    
    



    local multX;
    local multY;
    local magX;
    local magY;
      
    -- Hacky workaround to account for negative distance values and inverted y-coord system
    
    if (otherObjX- objX < 0) then
        multX = -1;
    end
    if (otherObjX- objX >= 0) then
        multX = 1;
    end
    if (otherObjY- objY < 0) then
        multY = -1;
    end
    if (otherObjY- objY >= 0) then
        multY = 1;
    end
    
    -- Get the absolute value of the distance between the two objects
    
    magX = math.abs(otherObjX- objX);
    magY = math.abs(otherObjY- objY);
    
    -- print("magX is " .. magX);
    -- print("magY is " .. magY);
       
    -- Get the angle of the distance by taking the inverse tangent of the y 'distance' over the x 'distance' (TOA = Tangent: Opposite over Adjacent!)
    
    local angle = math.atan(magY/magX)
    
    --local constantForce = 500;
    
    -- Normalize the force using cosine and sine. Also, multiply by multX and multY, my hacky 'direction' handlers.
    
    local xDir = math.cos(angle)*multX
    local yDir = math.sin(angle)*multY
        
    -- print("angle is... " .. angle);
    if (magY ~= 0 or magY ~=0) then 
        return xDir, yDir;
    else
        return 0,0;
    end
end

-- load first screen
storyboard.gotoScene( "title" )

