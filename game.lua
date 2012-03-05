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

-- A function to update the score

local function updateScore()

    player1PelletNumDisplay.text = player1Bullets;
    player2PelletNumDisplay.text = player2Bullets;
    player2ScoreDisplay.text = player2Score;
    player1ScoreDisplay.text = player1Score;
end
-- Define a function to place objects on screen (note: need to figure out how to track these objects for game over removal)
	
local function placeObject(whichType)
    
    --Only place an object if there are fewer than 4 on screen
    
    if (bigObjectsOnScreen < 4) then
    
        -- Type 1 is a triangle
    
   
            if(whichType == 1) then
            

                -- Draw a triangle
                local triangle = display.newLine(100,100, 300,100);
                triangle:append(200,0, 100,100);
                triangle.width = 8;
                triangle:setColor(100,255,100,255);
        
                -- Add a custom physics body shape based on the triangle shape
                triShape = {0,0, 100,-100, 200,0}
                physics.addBody( triangle, { density=3.0, friction=0.8, bounce=0.3, shape = triShape } )
                triangle.id = "triangle"
                triangle.x = 968;
                triangle.y = 550;
                triangle.isSleepingAllowed = false
                triangle.isBullet = true;
                triangle.linearDamping = 1
                triangle.angularDamping = 1;
        
        

                -- Everything must be added to the local group to be handled appropriately on 'scene changes'
                --   group:insert(triangle);
        
                --let's fire the triangle onScreen
        
                triangle:applyForce(-3500,0, triangle.x, triangle.y);
         
                bigObjectsOnScreen = bigObjectsOnScreen + 1;
            
                -- Add event listener for this thing to rotate
                
                -- Does this need to be 'returned'?
                return triangle;
        
            end
    
            -- Type 2 is an octo creature 
            if (whichType ==2) then
                -- Draw a center circle
        
                local centerOrb = display.newCircle(-200,550, 50,50);
       
                
     
                centerOrb:setStrokeColor(255,0,0,255)
                centerOrb.strokeWidth = 5;
                centerOrb:setFillColor(255,0,0,180)
        
                -- Add a custom physics body shape based on the centerOrb shape
                
                physics.addBody( centerOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 50 } )
        
                centerOrb.isSleepingAllowed = false
                centerOrb.isBullet = true;
                centerOrb.linearDamping = 1
                centerOrb.angularDamping = 1;
                centerOrb.id = "centerOrb";
        
                local leftOrb = display.newCircle(-275,550, 25,25);
                physics.addBody( leftOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 25 } )
                leftOrb.isSleepingAllowed = false
                leftOrb.isBullet = true;
                leftOrb.linearDamping = 1
                leftOrb.angularDamping = 1;
                centerOrb.leftOrb = leftOrb;
        
                local leftSmOrb = display.newCircle(-310,550, 10,10);
                physics.addBody( leftSmOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                leftSmOrb.isSleepingAllowed = false
                leftSmOrb.isBullet = true;
                leftSmOrb.linearDamping = 1
                leftSmOrb.angularDamping = 1;
                centerOrb.leftSmOrb = leftSmOrb;
        
                local rightOrb = display.newCircle(-125,550, 25,25);
                physics.addBody( rightOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 25 } )
                rightOrb.isSleepingAllowed = false
                rightOrb.isBullet = true;
                rightOrb.linearDamping = 1
                rightOrb.angularDamping = 1;
                centerOrb.rightOrb = rightOrb;
        
                local rightSmOrb = display.newCircle(-90,550, 10,10);
                physics.addBody( rightSmOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 25 } )
                rightSmOrb.isSleepingAllowed = false
                rightSmOrb.isBullet = true;
                rightSmOrb.linearDamping = 1
                rightSmOrb.angularDamping = 1;
                centerOrb.rightSmOrb = rightSmOrb;
                -- Create joints between the orbs
                
                centerOrb.myJointR = physics.newJoint( "pivot", centerOrb, rightOrb, -150,550 )
                centerOrb.myJointR.isLimitEnabled = true -- (boolean)
                centerOrb.myJointR:setRotationLimits( -45, 45 )
 
                myJointRsm = physics.newJoint( "pivot", rightOrb, rightSmOrb, -100,550 )
                myJointRsm.isLimitEnabled = true -- (boolean)
                myJointRsm:setRotationLimits( -45, 45 )
 
                myJointL = physics.newJoint( "pivot", centerOrb, leftOrb, -250,550 )
                myJointL.isLimitEnabled = true -- (boolean)
                myJointL:setRotationLimits( -45, 45 )
 
                myJointLsm = physics.newJoint( "pivot", leftOrb, leftSmOrb, -300,550 )
                myJointLsm.isLimitEnabled = true -- (boolean)
                myJointLsm:setRotationLimits( -45, 45 )
 
                rightOrb:setStrokeColor(255,0,0,255)
                rightOrb.strokeWidth = 5;
                rightOrb:setFillColor(255,0,0,180)
     
                rightSmOrb:setStrokeColor(255,0,0,255)
                rightSmOrb.strokeWidth = 5;
                rightSmOrb:setFillColor(255,0,0,180)
  
                leftOrb:setStrokeColor(255,0,0,255)
                leftOrb.strokeWidth = 5;
                leftOrb:setFillColor(255,0,0,180)
     
                leftSmOrb:setStrokeColor(255,0,0,255)
                leftSmOrb.strokeWidth = 5;
                leftSmOrb:setFillColor(255,0,0,180)
 

                centerOrb:applyForce(3500,0, centerOrb.x, centerOrb.y);
                
                centerOrb:applyTorque( 1000 )
                
                -- Add event listener here to pulse the octobeast

                bigObjectsOnScreen = bigObjectsOnScreen + 1;
                
                -- Does this need to be returned?
                return centerOrb;
            end
    end
end
    
    
-- Function that shoots a pellet - takes two arguments, which player fired, and where they fired from.

local function shootFrom(whichPlayer, loc)
    
    -- I don't think this works
    local group = scene.view;
    
    
    local ball
    local ballTimer = 0;
    -- If the first player fired ...
    if (whichPlayer == 1) then

        -- Only fire if that player has pellets available 
        if (player1Bullets > 0) then 
        
            ball = display.newCircle( 100, 100, 8 )
            physics.addBody( ball, { density=10.0, friction=0.8, bounce=0.3, radius = 11 } )
            ball.x = loc
            ball.y = 155;
        
            ball.strokeWidth = 3;
            ball:setStrokeColor(240,240,240,255);
            ball:setFillColor(240,240, 240, 200)
            ball.bodyType = "dynamic";
        
            -- Apply a force downward on the ball
            ball:applyForce( 0, 200, ball.x, ball.y )
            ball.isBullet = true;
            ball.id = "player1Bullet";
            group:insert(ball);
    
            player1Bullets = player1Bullets - 1
            player1PelletNumDisplay.text = player1Bullets;
        end
    end

    -- If the second player fired...
    
    if (whichPlayer == 2) then
  
        -- Only fire if that player has pellets available 
        if (player2Bullets > 0) then 
        
            ball = display.newCircle( 100, 100, 8 )
            physics.addBody( ball, { density=10.0, friction=0.8, bounce=0.3, radius = 11 } )
            ball.x = loc
            ball.y =  display.contentHeight - 155;
       
            ball.strokeWidth = 3;
            ball:setStrokeColor(200,200,255,255);
            ball:setFillColor(200,200, 255, 200)
            -- Apply a force upward on the ball
            ball:applyForce( 0, -200, ball.x, ball.y )
            ball.isBullet = true;
            --group:insert(ball);
            ball.id = "player2Bullet";
            player2Bullets = player2Bullets - 1
        print ("player 2 fired");
            player2PelletNumDisplay.text = player2Bullets;
        end
    end

    -- This function eventually removes a pellet from memory if it has been on the screen too long
    
    
    local function removeBall()
    
        local function reallyRemove()
            print("ball removed");
    
            ball:removeSelf();
            ball = nil
        end
    
        --fade the ball out and on completion reallyRemove
    
    
        transition.to( ball, { delay=1, time=500, alpha=0.0, onComplete=reallyRemove } )
       
    end  
    
    local function runBall()
      --  print("runBall a runnin");
        --Every frame, keep track of how long the ball has been on screen.
        ballTimer = ballTimer + 1
    
        -- If the ball has been on screen a long time, remove it.
        if (ballTimer == 1000) then
            removeBall();
        end
    end
    
    --Add an event listener to keep track of the ball every frame.
    Runtime:addEventListener( "enterFrame", runBall );
    
    -- I chose not to do it the following way because it was causing
    -- the program to crash if the ball had already been removed.
    -- In 10 seconds, remove the ball.
    -- timer.performWithDelay(10000, removeBall )
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
 


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    local whichObj = 1;


    ---------------------------
    -- Set initial variables for the game
    ---------------------------

    bigObjectsOnScreen = 0;
    player1Bullets = 20;
    player2Bullets = 20;
    player1Score = 0;
    player2Score = 0;

    -- Function that runs every frame and maintains the game

    --should this be a local function here? probably not
    local function run()
        runTimer = runTimer + 1
        updateScore();
        --print (runTimer);

        if (runTimer == 200) then
            local newObj = placeObject(whichObj);
            runTimer = 0;
    
            if (whichObj == 1) then
                whichObj = 2 
              
                else if (whichObj == 2) then
                    whichObj = 1
                end 
            end
        end
    end

    -- Start the run timer  
    runTimer = 1
    
    --create an enterFrame listener for all periodic events

    Runtime:addEventListener( "enterFrame", run );
    
    
    -- Create two goal zones
    
    local zone1 = display.newRect( 150, 0, 468, 150 )
	zone1:setFillColor(153, 0, 153, 100)
	physics.addBody(zone1, {density = 200, friction = .3, bounce = .2})
	zone1.bodyType = "static" 
	zone1.isSensor = true;
	group:insert(zone1)
	
	-- Register an event listener for touching the first goal zone
	
	zone1:addEventListener("touch", firePlayer1)
	
	
	local function onZone1Collision( self, event )
        if ( event.phase == "began" ) then
            print("collision with zone1!");
            --if you collided with the other player's bullet, remove the bullet
            --and add to current player's bullet total
        if (event.other.id == "player2Bullet") then
            print ('we got a live one sonny!');
            player1Bullets = player1Bullets + 1;
               --This is an ugly hack, I want to remove the ball but I'm just making it disappear for now
            
            transition.to( event.other, {time=.0001, alpha=0.0} )
        --event.other:removeSelf();
        --event.other = nil
        end
     if (event.other.id == "triangle") then
        print("woah");
         --This is an ugly hack, I want to remove the ball but I'm just making it disappear for now
            
            transition.to( event.other, {time=3000, alpha=0.0} )
            bigObjectsOnScreen = bigObjectsOnScreen - 1;
            player2Score = player2Score + 1;
            --add to score here
        end
         if (event.other.id == "centerOrb") then
        print("woah");
         --This is an ugly hack, I want to remove the ball but I'm just making it disappear for now
            
            transition.to( event.other, {time=1000, alpha=0.0} )
            transition.to( event.other.leftOrb, {time=1000, alpha=0.0} )
            transition.to( event.other.leftSmOrb, {time=1000, alpha=0.0} )
            transition.to( event.other.rightOrb, {time=1000, alpha=0.0} )
            transition.to( event.other.rightSmOrb, {time=1000, alpha=0.0} )
            bigObjectsOnScreen = bigObjectsOnScreen - 1;
            --add to score here
             player2Score = player2Score + 1;
        end
        updateScore();
        
        --if you collided with a big shape, remove the big shape and add to the other player's score
 
        elseif ( event.phase == "ended" ) then
 
                
        end
    end
	
	--Register an event listener for when bullets enter the first goal zone
	zone1.collision = onZone1Collision
    zone1:addEventListener( "collision", zone1 )
        

    local zone2 = display.newRect( 150, display.contentHeight - 150, 468, 150 )
    zone2:setFillColor(153, 0, 153, 100)
    physics.addBody(zone2, {density = 200, friction = .3, bounce = .2})
	zone2.bodyType = "static" 
    zone2.isSensor = true;
    -- Register an event listener for touching the second goal zone
    
    zone2:addEventListener("touch", firePlayer2)
    	
    local function onZone2Collision( self, event )
        if ( event.phase == "began" ) then
            print("collision with zone2!");
            --if you collided with the other player's bullet, remove the bullet
            --and add to current player's bullet total
        if (event.other.id == "player1Bullet") then
            print ('we got a live one sonny!');
            player2Bullets = player2Bullets + 1;
                  
                --  transition.to( event.other, { delay=1, time=500, alpha=0.0, onComplete=reallyRemove } )
            
            --This is an ugly hack, I want to remove the ball but I'm just making it disappear for now
            
            transition.to( event.other, {time=.0001, alpha=0.0} )
            
            --Runtime:removeEventListener( "enterFrame", runBall );
            --event.other:removeSelf();
            --event.other = nil
           
        end
        
        --if you collided with a big shape, remove the big shape and add to the other player's score
        
        if (event.other.id == "triangle") then
        print("woah");
         --This is an ugly hack, I want to remove the ball but I'm just making it disappear for now
            
            transition.to( event.other, {time=3000, alpha=0.0} )
            bigObjectsOnScreen = bigObjectsOnScreen - 1;
            --add to score here
             player1Score = player1Score + 1;
        end
         if (event.other.id == "centerOrb") then
        print("woah");
         --This is an ugly hack, I want to remove the ball but I'm just making it disappear for now
            
            transition.to( event.other, {time=1000, alpha=0.0} )
            transition.to( event.other.leftOrb, {time=1000, alpha=0.0} )
            transition.to( event.other.leftSmOrb, {time=1000, alpha=0.0} )
            transition.to( event.other.rightOrb, {time=1000, alpha=0.0} )
            transition.to( event.other.rightSmOrb, {time=1000, alpha=0.0} )
            bigObjectsOnScreen = bigObjectsOnScreen - 1;
             player1Score = player1Score + 1;
            --add to score here
        end
 
        elseif ( event.phase == "ended" ) then
 
                
        end
end
	--Register an event listener for when bullets enter the first goal zone
	zone2.collision = onZone2Collision
    zone2:addEventListener( "collision", zone2 )
    
    
    
    -- Draw Arena
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
        
        
-- Draw initial pellet #s
    player2PelletNumDisplay = display.newText( "20", 45,900, "Futura", 72 )
    player2PelletNumDisplay:setReferencePoint(display.CenterReferencePoint);
    player2PelletNumDisplay:setTextColor(240, 255, 240)
    
    player1PelletNumDisplay = display.newText( "20", 45,70, "Futura", 72 )
    player1PelletNumDisplay:setReferencePoint(display.CenterReferencePoint);
    player1PelletNumDisplay:setTextColor(240, 255, 240)
    player1PelletNumDisplay:rotate(180);
    
-- Draw initial scores
        player2ScoreDisplay = display.newText( "0", 705,900, "Futura", 72 )
    player2ScoreDisplay:setReferencePoint(display.CenterReferencePoint);
    player2ScoreDisplay:setTextColor(240, 255, 240)
    
    player1ScoreDisplay = display.newText( "0", 705,70, "Futura", 72 )
    player1ScoreDisplay:setReferencePoint(display.CenterReferencePoint);
    player1ScoreDisplay:setTextColor(240, 255, 240)
    player1ScoreDisplay:rotate(180);
    
    
group:insert(leftUpperExtend);
group:insert(leftUpper);
group:insert(rightUpper);
group:insert(rightUpperExtend);

group:insert(rightLower);
group:insert(rightLowerExtend);

group:insert(leftLower);
group:insert(leftLowerExtend);
end
    drawArena();
    
    
    -- Everything must be added to the local group to be handled on scene changes.
    
    group:insert(zone2)
    group:insert(zone1)
	
	
    
 
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


