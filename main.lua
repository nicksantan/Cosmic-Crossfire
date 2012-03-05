-----------------------------------------------------------------------------------------
--
-- main.lua
-- Main scene for "Crossfire" - for now, it loads the game screen.
-----------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )
local physics = require "physics"
--  a class I created using different method that works
 

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
local widget = require "widget"


-- some global variables

local player1Bullets;
local player2Bullets;
local bigObjectsOnScreen;


--define some global functions


-- load first screen
storyboard.gotoScene( "game" )

