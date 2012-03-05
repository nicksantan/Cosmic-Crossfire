----------------------------------------------------------------------------------
--
-- game.lua
-- Game Screen for 'Crossfire'
--
----------------------------------------------------------------------------------
 
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
end

-------------------------------------------------------------------------------
-- Custom functions for use later in the game
-------------------------------------------------------------------------------

-- Function that shoots a pellet - takes two arguments, which player fired, and where they fired from.
local function shootFrom(whichPlayer, loc)
    local group = scene.view;
    local ball

    -- If the first player fired ...
    if (whichPlayer == 1) then

        ball = display.newCircle( 100, 100, 10 )
        physics.addBody( ball, { density=10.0, friction=0.8, bounce=0.3, radius = 10 } )
        ball.x = loc
        ball.y = 10
        ball:setFillColor(255,30, 30, 255)
        ball.bodyType = "dynamic";
        -- Apply a force downward on the ball
        ball:applyForce( 0, 1000, ball.x, ball.y )
        ball.isBullet = true;
        group:insert(ball);
    
    end

    -- If the second player fired...
    
    if (whichPlayer == 2) then
  
        ball = display.newCircle( 100, 100, 10 )
        physics.addBody( ball, { density=10.0, friction=0.8, bounce=0.3, radius = 10 } )
        ball.x = loc
        ball.y =  display.contentHeight - 10;
        ball:setFillColor(30,30, 255, 255)
        
        -- Apply a force upward on the ball
        ball:applyForce( 0, -1000, ball.x, ball.y )
        ball.isBullet = true;
        group:insert(ball);

    end

    -- This function eventually removes a pellet from memory if it has been on the screen too long
    -- (In the future add a 'fade out')
    
    local function removeBall()
        print("ball removed");
        ball:removeSelf();
        ball = nil
    end  
    
    -- In 10 seconds, remove the ball.
    timer.performWithDelay(10000, removeBall )
end

-- These are the event listeners for tapping in the 'fire zones'

local function firePlayer1(event)

    -- Note how pellet fires when the finger is lifted. Later, I will implement a 'charge up' that will change the size of the pellet based on how long the finger has been on the screen.
    
    if (event.phase == "ended") then
        print (event.x);
        shootFrom(1, event.x)
    end
end

local function firePlayer2(event)

    -- Note how pellet fires when the finger is lifted. Later, I will implement a 'charge up' that will change the size of the pellet based on how long the finger has been on the screen.
    print (event.x);
    if (event.phase == "ended") then
        shootFrom(2,event.x)
    end
    
    -- Note that other event.phases could be "began", "moved", "stationary", "cancelled"
end
 
local function drawArena()

 -- Draw the left upper segment 
        local leftUpper = display.newLine(0,0, 150,0);
        leftUpper:append(150,150);
        leftUpper:append(25,275);
        leftUpper:append(25,394);
        leftUpper:append(0,394);
        leftUpper.width = 3;
        leftUpper:setColor(255,255,255,255);
        
        -- Box2d doesn't allow convex shapes, so I create a second shape to represent the physics object
        local leftUpperExtend = display.newRect(0,275,25,119)
        leftUpperExtend.strokeWidth = 3
        leftUpperExtend:setFillColor(0, 0, 255,0)
        leftUpperExtend:setStrokeColor(0, 0, 255,0)
      
         -- Add a custom physics body shape based on the left upper shape
        local leftUpperShape = {-25,0, 150,0, 150,150, 25,275, 0,275}
        physics.addBody( leftUpper, { density=10.0, friction=0, bounce=0.3, shape = leftUpperShape } )
        leftUpper.bodyType = "static";
        leftUpper.isSleepingAllowed = false;
        
      -- local leftUpperShapeExtend = {0,0,0,119,-25,119,0,0}
        physics.addBody( leftUpperExtend, { density=10.0, friction=0, bounce=0.3 } )
        leftUpperExtend.bodyType = "static";
        leftUpperExtend.isSleepingAllowed = false;

         -- Draw the right upper segment 
        local rightUpper = display.newLine(768,0, 618,0);
        rightUpper:append(618,150);
        rightUpper:append(743,275);
        rightUpper:append(743,394);
        rightUpper:append(768,394);
        rightUpper.width = 3;
        rightUpper:setColor(255,255,255,255);
        
        -- Box2d doesn't allow convex shapes, so I create a second shape to represent the physics object
        local rightUpperExtend = display.newRect(743,275,25,119)
        rightUpperExtend.strokeWidth = 3
        rightUpperExtend:setFillColor(0, 0, 255,0)
        rightUpperExtend:setStrokeColor(0, 0, 255,0)
      
         -- Add a custom physics body shape based on the right upper shape
        local rightUpperShape = {-150,0, 0,0,  0,275, -25,275, -150, 150}
        physics.addBody( rightUpper, { density=10.0, friction=0, bounce=0.3, shape=rightUpperShape } )
        rightUpper.bodyType = "static";
        rightUpper.isSleepingAllowed = false;
        
       -- Add a second physics body to represent the extension of the upper right shape
        physics.addBody( rightUpperExtend, { density=10.0, friction=0, bounce=0.3 } )
        rightUpperExtend.bodyType = "static";
        rightUpperExtend.isSleepingAllowed = false;
        
         -- Draw the left lower segment 
        local leftLower = display.newLine(0,1024, 150,1024);
        leftLower:append(150,874);
        leftLower:append(25,749);
        leftLower:append(25,630);
        leftLower:append(0,630);
        leftLower.width = 3;
        leftLower:setColor(255,255,255,255);
        
        -- Box2d doesn't allow convex shapes, so I create a second shape to represent the physics object
        local leftLowerExtend = display.newRect(0,630,25,119)
        leftLowerExtend.strokeWidth = 3
        leftLowerExtend:setFillColor(0, 0, 255,0)
        leftLowerExtend:setStrokeColor(0, 0, 255,0)
      
         -- Add a custom physics body shape based on the left lower shape
         local leftLowerShape = {0,-275, 25,-275,  150,-150, 150,0, 0, 0}
        physics.addBody( leftLower, { density=10.0, friction=0, bounce=0.3, shape=leftLowerShape} )
        leftLower.bodyType = "static";
        leftLower.isSleepingAllowed = false;
        
       -- Add a second physics body to represent the extension of the upper right shape
        physics.addBody( leftLowerExtend, { density=10.0, friction=0, bounce=0.3 } )
        leftLowerExtend.bodyType = "static";
        leftLowerExtend.isSleepingAllowed = false;
        
        -- Draw the right lower segment 
        local rightLower = display.newLine(768,1024, 768-150,1024);
        rightLower:append(768-150,874);
        rightLower:append(743,749);
        rightLower:append(743,630);
        rightLower:append(768,630);
        rightLower.width = 3;
        rightLower:setColor(255,255,255,255);
        
        -- Box2d doesn't allow convex shapes, so I create a second shape to represent the physics object
        local rightLowerExtend = display.newRect(743,630,25,119)
        rightLowerExtend.strokeWidth = 3
        rightLowerExtend:setFillColor(0, 0, 255,0)
        rightLowerExtend:setStrokeColor(0, 0, 255,0)
      
         -- Add a custom physics body shape based on the right lower shape
         local rightLowerShape = {-25,-275, 0,-275,  0,0, -150,0, -150,-150}
        physics.addBody( rightLower, { density=10.0, friction=0, bounce=0.3, shape=rightLowerShape} )
        rightLower.bodyType = "static";
        rightLower.isSleepingAllowed = false;
        
       -- Add a second physics body to represent the extension of the upper right shape
        physics.addBody( rightLowerExtend, { density=10.0, friction=0, bounce=0.3 } )
        rightLowerExtend.bodyType = "static";
        rightLowerExtend.isSleepingAllowed = false;
        

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
    -- Create two goal zones
    
    local zone1 = display.newRect( 150, 0, 468, 150 )
	zone1:setFillColor(153, 0, 153, 100)
	group:insert(zone1)
	
	-- Register an event listener for touching the first goal zone
	
	zone1:addEventListener("touch", firePlayer1)
	
	local zone2 = display.newRect( 150, display.contentHeight - 150, 468, 150 )
    zone2:setFillColor(153, 0, 153, 100)
    
    -- Register an event listener for touching the second goal zone
    
    zone2:addEventListener("touch", firePlayer2)
    
    -- Draw Arena
    local tester = drawArena();
    drawArena();
    
    -- Everything must be added to the local group to be handled on scene changes.
    
    group:insert(zone2)
    group:insert(zone1)
	
	-- Define a function to place the initial objects on screen. For now, it's just a triangle.
	
	local function placeObject()

        -- Draw a triangle
        local triangle = display.newLine(100,100, 300,100);
        triangle:append(200,0, 100,100);
        triangle.width = 3;
        triangle:setColor(100,100,100,255);
        

        -- Add a custom physics body shape based on the triangle shape
        triShape = {0,0, 100,-100, 200,0, 0, 0}
        physics.addBody( triangle, { density=3.0, friction=0.8, bounce=0.3, shape = triShape } )
        triangle.x = -200;
        triangle.y = 550;
        triangle.isSleepingAllowed = false
        triangle.linearDamping = 1
        triangle.angularDamping = 1;
        
        

        -- Everything must be added to the local group to be handled appropriately on 'scene changes'
        group:insert(triangle);
        
        --let's fire the triangle onScreen
        
        triangle:applyForce(20000,0,triangle.x,triangle.y);
        
    end
    
    -- Place an object on screen
    
    placeObject();
end
 
 -- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
end
 
-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view
end
 

---------------------------------------------------------------------------------
-- Listeners required for Storyboard API.
---------------------------------------------------------------------------------
 
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
 
-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )
 
-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )
 
-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )
 
---------------------------------------------------------------------------------
 
return scene

----


