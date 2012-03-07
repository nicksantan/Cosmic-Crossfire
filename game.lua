----------------------------------------------------------------------------------
--
-- game.lua
-- Game Screen for 'Crossfire'
--
----------------------------------------------------------------------------------
 local Triangle = require("Triangle") 
  local Square = require("Square") 
 local OctoOrb = require("OctoOrb")
  local Ball = require("Ball")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
end

-------------------------------------------------------------------------------
-- Custom functions for use later in the game
-------------------------------------------------------------------------------


local function addToPellets(whichPlayer, howMany)
    if (whichPlayer == 1) then

        if (player1Bullets < 50) then
            player1Bullets = player1Bullets + howMany;
        end
    end

    if (whichPlayer ==2) then
        if (player2Bullets < 50) then
            player2Bullets = player2Bullets + howMany;
        end
    end

end

-- A function to update the score

local function updateScore()

    player1PelletNumDisplay.text = player1Bullets;
    player2PelletNumDisplay.text = player2Bullets;
    player2ScoreDisplay.text = player2Score;
    player1ScoreDisplay.text = player1Score;
end
-- Define a function to place objects on screen (note: need to figure out how to track these objects for game over removal)
	
local function placeObject(whichType, whichDir)
    
    --Only place an object if there are fewer than 4 on screen
    
    if (bigObjectsOnScreen < 4) then
    
        -- Type 1 is a triangle
    
        print(whichType .. " is the whichtype");
        local xLoc
        local yLoc
        --Factor this down in the future
        if(whichType == 3) then
            
                if (whichDir == 1) then
                xLoc = 968;
                yLoc = 550;
                end
                
                if (whichDir == 2) then
                xLoc = -200;
                yLoc = 550;
                end
                
                local square = Square.new(xLoc, yLoc) -- plenty of joy

                -- Everything must be added to the local group to be handled appropriately on 'scene changes'
                --   group:insert(triangle);
        
                --let's fire the triangle onScreen
                
                if (whichDir == 1) then
                    square:applyForce(-3500,0, square.x, square.y);
                end
                if (whichDir == 2) then
                    square:applyForce(3500,0, square.x, square.y);
                end
                
                bigObjectsOnScreen = bigObjectsOnScreen + 1;
            
                -- Add event listener for this thing to rotate
                
                -- Does this need to be 'returned'?
                --return triangle;
        
            end
            if(whichType == 1) then
            
                if (whichDir == 1) then
                xLoc = 968;
                yLoc = 550;
                end
                
                if (whichDir == 2) then
                xLoc = -200;
                yLoc = 550;
                end
                
                local triangle = Triangle.new(xLoc, yLoc) -- plenty of joy

                -- Everything must be added to the local group to be handled appropriately on 'scene changes'
                --   group:insert(triangle);
        
                --let's fire the triangle onScreen
                
                if (whichDir == 1) then
                    triangle:applyForce(-3500,0, triangle.x, triangle.y);
                end
                if (whichDir == 2) then
                    triangle:applyForce(3500,0, triangle.x, triangle.y);
                end
                
                bigObjectsOnScreen = bigObjectsOnScreen + 1;
            
                -- Add event listener for this thing to rotate
                
                -- Does this need to be 'returned'?
                --return triangle;
        
            end
    
            -- Type 2 is an octo creature 
            if (whichType ==2) then
                if (whichDir == 1) then
                xLoc = 968;
                yLoc = 550;
                end
                
                if (whichDir == 2) then
                xLoc = -200;
                yLoc = 550;
                end
 
              local octoOrb = OctoOrb.new(xLoc,yLoc) -- plenty of joy
if (whichDir == 1) then
                    octoOrb:applyForce(-3500,0, octoOrb.x, octoOrb.y);
                end
                if (whichDir == 2) then
                    octoOrb:applyForce(3500,0, octoOrb.x, octoOrb.y);
                end
             
                local randTorque = math.random (-1000,1000)
                octoOrb:applyTorque( randTorque )
                
                -- Add event listener here to pulse the octobeast

                bigObjectsOnScreen = bigObjectsOnScreen + 1;
                
                -- Does this need to be returned?
               -- return centerOrb;
            end
    end
end
    
    
-- Function that shoots a pellet - takes two arguments, which player fired, and where they fired from.

local function shootFrom(whichPlayer, loc, magX, magY, totalTime)
    
    -- I don't think this works
    local group = scene.view;
    
    
   -- local ball
  --  local ballTimer = 0;
    -- If the first player fired ...
    if (whichPlayer == 1) then

        -- Only fire if that player has pellets available 
        if (player1Bullets > 0) then 
        
            local ball = Ball.new(loc, 155, 1,totalTime) 
            ball.id = "player1Bullet";
            -- Apply a force downward on the ball
            local chargeUpPower = totalTime; 
            print("chargeUp Power is... " .. chargeUpPower);
             if (chargeUpPower > 3) then
            chargeUpPower = 3
            end
           if (chargeUpPower > 1) then
            ball:applyForce( magX*chargeUpPower*4, magY*chargeUpPower*4, ball.x, ball.y )
           else
            ball:applyForce( magX, magY, ball.x, ball.y )
           end
            group:insert(ball);
    
            player1Bullets = player1Bullets - 1
            player1PelletNumDisplay.text = player1Bullets;
        end
    end

    -- If the second player fired...
    
    if (whichPlayer == 2) then
  
        -- Only fire if that player has pellets available 
        if (player2Bullets > 0) then 
            local theY = display.contentHeight - 155;
            local ball = Ball.new(loc, theY, 2, totalTime) 
            
            -- Apply a force upward on the ball
            local chargeUpPower = totalTime - 1;
               print("chargeUp Power is.... " .. chargeUpPower);
            if (chargeUpPower > 3) then
            chargeUpPower = 3
            end
            if (chargeUpPower > 0) then
            ball:applyForce( magX*chargeUpPower*4, magY*chargeUpPower*4, ball.x, ball.y )
           else
            ball:applyForce( magX, magY, ball.x, ball.y )
           end
        ball.id = "player2Bullet";
            player2Bullets = player2Bullets - 1
        print ("player 2 fired");
            player2PelletNumDisplay.text = player2Bullets;
        end
    end

    -- This function eventually removes a pellet from memory if it has been on the screen too long
    
    
 end
-- These are the event listeners for tapping in the 'fire zones'

local function firePlayer1(event)

 local startX;
 local startY;
 local endX;
 local endY;

local totalTime;
 
    -- Note how pellet fires when the finger is lifted. Later, I will implement a 'charge up' that will change the size of the pellet based on how long the finger has been on the screen.

   if (event.phase == "began") then
   startTime = event.time;
   print(startTime);
    --start recording time
    startX =  event.xStart;
    startY = event.yStart;
    end

 

 
   
    if (event.phase == "ended") then
    print("again, start time is " .. startTime);
    totalTime =  (system.getTimer() - startTime) / 1000;
    print("fire!");
    print("total time was " .. totalTime .. " seconds");
    --normalize this
    local multX;
    local multY;
    if (event.x - event.xStart < 0) then
    multX = -1;
    end
    
    if (event.x - event.xStart >= 0) then
    multX = 1;
    end
    
    if (event.y - event.yStart < 0) then
    multY = -1;
    end
    
    if (event.y - event.yStart >= 0) then
    multY = 1;
    end
    
    magX = math.abs(event.x - event.xStart);
    magY = math.abs(event.y - event.yStart);
     local newMagY = -magY
     print("magX is " .. magX);
     print("magY is " .. magY);
       local angle = math.atan(magY/magX)
       local a, b = math.cos(angle)*500*multX, math.sin(angle)*500*multY
       print("a " .. a);
       print("b " .. b);
    print("angle is... " .. angle);
   if (magY ~= 0) then
    print ("it ain't nan");
        shootFrom(1,event.x, a, b, totalTime) --add charge up time, and an normalized x y vector
        end
    end
    
    -- Note that other event.phases could be "began", "moved", "stationary", "cancelled"
end

local function firePlayer2(event)

 local startX;
 local startY;
 local endX;
 local endY;

local totalTime;
 
    -- Note how pellet fires when the finger is lifted. Later, I will implement a 'charge up' that will change the size of the pellet based on how long the finger has been on the screen.

   if (event.phase == "began") then
   startTime = event.time;
   print(startTime);
    --start recording time
    startX =  event.xStart;
    startY = event.yStart;
    end

 

 
   
    if (event.phase == "ended") then
    print("again, start time is " .. startTime);
    totalTime =  (system.getTimer() - startTime) / 1000;
    print("fire!");
    print("total time was " .. totalTime .. " seconds");
    --normalize this
    local multX;
    local multY;
    if (event.x - event.xStart < 0) then
    multX = -1;
    end
    
    if (event.x - event.xStart >= 0) then
    multX = 1;
    end
    
    if (event.y - event.yStart < 0) then
    multY = -1;
    end
    
    if (event.y - event.yStart >= 0) then
    multY = 1;
    end
    
    magX = math.abs(event.x - event.xStart);
    magY = math.abs(event.y - event.yStart);
     local newMagY = -magY
     print("magX is " .. magX);
     print("magY is " .. magY);
       local angle = math.atan(magY/magX)
       local a, b = math.cos(angle)*500*multX, math.sin(angle)*500*multY
       print("a " .. a);
       print("b " .. b);
    print("angle is... " .. angle);
     if (magY ~= 0) then
    print ("it ain't nan");
        shootFrom(2,event.x, a, b, totalTime) --add charge up time, and an normalized x y vector
        end
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
    player1Bullets = 40;
    player2Bullets = 40;
    player1Score = 0;
    player2Score = 0;

    -- Function that runs every frame and maintains the game

    --should this be a local function here? probably not
    local function run()
        runTimer = runTimer + 1
        updateScore();
        --print (runTimer);
print("bigObjectsOnScreen = " .. bigObjectsOnScreen);
        if (runTimer % 200 == 0) then
            local whichObject = math.random(3);
            print("whichObject is " .. whichObject);
            local whichDir = math.random(2);
            placeObject(whichObject, whichDir);
          --  runTimer = 0;    
        end
         if (runTimer % 100 == 0) then
            addToPellets(1,1)
            addToPellets(2,1);
          --  runTimer = 0;    
        end
    end


    -- Start the run timer  
    runTimer = 1
    
    --create an enterFrame listener for all periodic events

    Runtime:addEventListener( "enterFrame", run );
    
    
    -- Create two goal zones
    
    local zone1 = display.newRect( 150, 0, 468, 150 )
	zone1:setFillColor(100, 100, 255, 120)
	physics.addBody(zone1, {density = 200, friction = .3, bounce = .2})
	zone1.bodyType = "static" 
	zone1.isSensor = true;
	group:insert(zone1)
	
	local zone1Shadow = display.newRect(150,0,468,450)
	zone1Shadow:setFillColor(0,0,0,0);
	group:insert(zone1Shadow);
	-- Register an event listener for touching the first goal zone
	
	zone1Shadow:addEventListener("touch", firePlayer1)
	
	
	local function onZone1Collision( self, event )
        if ( event.phase == "began" ) then
          --  print("collision with zone1!");
            --if you collided with the other player's bullet, remove the bullet
            --and add to current player's bullet total
        if (event.other.id == "player2Bullet") then
       --     print ('we got a live one sonny!');
            player1Bullets = player1Bullets + 1;
               --This is an ugly hack, I want to remove the ball but I'm just making it disappear for now
                transition.to( event.other, { delay=1, time=500, alpha=0.0 } )
            print("fading out because we hit a goal");
            
          --  event.other:fadeOut();
        --event.other:removeSelf();
        --event.other = nil
        end
     if (event.other.id == "triangle" or event.other.id == "square") then
        print("triangle collided with goal 1");
         event.other:fadeOut();
            
            bigObjectsOnScreen = bigObjectsOnScreen - 1;
            player2Score = player2Score + 1;
            --add to score here
        end
         if (event.other.id == "octoOrb") then
        print("woah");
         --This is an ugly hack, I want to remove the ball but I'm just making it disappear for now
            
         event.other:fadeOut();
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
    zone2:setFillColor(100, 100, 255, 120)
    physics.addBody(zone2, {density = 200, friction = .3, bounce = .2})
	zone2.bodyType = "static" 
    zone2.isSensor = true;
    -- Register an event listener for touching the second goal zone
    	local zone2Shadow = display.newRect(150,display.contentHeight-450,468,450)
	zone2Shadow:setFillColor(0,0,0,0);
	group:insert(zone2Shadow);
	-- Register an event listener for touching the first goal zone
	
	
    zone2Shadow:addEventListener("touch", firePlayer2)
    	
    local function onZone2Collision( self, event )
        if ( event.phase == "began" ) then
          --  print("collision with zone2!");
            --if you collided with the other player's bullet, remove the bullet
            --and add to current player's bullet total
        if (event.other.id == "player1Bullet") then
            --print ('we got a live one sonny!');
            player2Bullets = player2Bullets + 1;
                  
                 transition.to( event.other, { delay=1, time=500, alpha=0.0 } )
            
       -- This is an ugly hack, I want to remove the ball but I'm just making it disappear for now
            
            print("fading out because we hit a goal");
          --  event.other:fadeOut();
            --Runtime:removeEventListener( "enterFrame", runBall );
            --event.other:removeSelf();
            --event.other = nil
           
        end
        
        --if you collided with a big shape, remove the big shape and add to the other player's score
        
        if (event.other.id == "triangle" or event.other.id == "square") then
        print("woah");
        
            
            event.other:fadeOut();
            bigObjectsOnScreen = bigObjectsOnScreen - 1;
            --add to score here
             player1Score = player1Score + 1;
        end
         if (event.other.id == "octoOrb") then
    event.other:fadeOut()
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
        leftUpper:setColor(240,240,255,255);
        
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
        leftLower:setColor(240,240,255,255);
        
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
        rightLower:setColor(240,240,255,255);
        
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

    player2PelletNumDisplay = display.newText( "20", 35,900, "Eurostile", 72 )
    player2PelletNumDisplay:setReferencePoint(display.CenterReferencePoint);
    player2PelletNumDisplay:setTextColor(240, 240, 255)
    
    player1PelletNumDisplay = display.newText( "20", 25,70, "Eurostile", 72 )
    player1PelletNumDisplay:setReferencePoint(display.CenterReferencePoint);
    player1PelletNumDisplay:setTextColor(240, 240, 255)
    player1PelletNumDisplay:rotate(180);
    
-- Draw initial scores
        player2ScoreDisplay = display.newText( "0", 675,900, "Eurostile", 72 )
    player2ScoreDisplay:setReferencePoint(display.CenterReferencePoint);
    player2ScoreDisplay:setTextColor(240, 240, 255)
    
    player1ScoreDisplay = display.newText( "0", 675,70, "Eurostile", 72 )
    player1ScoreDisplay:setReferencePoint(display.CenterReferencePoint);
    player1ScoreDisplay:setTextColor(240, 240, 255)
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


