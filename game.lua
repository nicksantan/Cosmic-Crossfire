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
local Snake = require("Snake")
local Attractor = require("Attractor");
local storyboard = require( "storyboard" )
local widget = require "widget"
require("displayex")
require("mathlib")

local scene = storyboard.newScene()

-- create a display group
local group1 = display.newGroup()

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
end

-------------------------------------------------------------------------------
-- Custom functions for use later in the game
-------------------------------------------------------------------------------
local function showGameOver()

 local function onButtonRelease( event )
            local btn = event.target
            print( "User has pressed and released the button with id: " .. btn.id )
            if (btn.id == "playAgain") then
                -- gameMode = "points"
                gameOn = true;
                   playAgainButton:removeSelf();
            mainMenuButton:removeSelf();
            playAgainButton = nil;
            mainMenuButton = nil;
                -- reset all game variables here
            end
    
            if (btn.id == "mainMenu") then
                -- go to title
                   playAgainButton:removeSelf();
            mainMenuButton:removeSelf();
            playAgainButton = nil;
            mainMenuButton = nil;
                storyboard.gotoScene( "title" )
    
            end
    
        end
            playAgainButton = widget.newButton{
            label = "Play Again",
            font = "HelveticaNeue-Bold",
            fontSize = 16,
            id = "playAgain",
            onRelease = onButtonRelease
        }       
           mainMenuButton = widget.newButton{
            label = "Main Menu",
            font = "HelveticaNeue-Bold",
            fontSize = 16,
            id = "mainMenu",
            onRelease = onButtonRelease
        }

        playAgainButton.x = 300
        playAgainButton.y = 400
        mainMenuButton.x = 600
        mainMenuButton.y = 400
end

local function gameOver(whoWon)
    gameOn = false;
    --remove all enemies
    for i=group1.numChildren,1,-1 do
        local child = group1[i]
        attractorPresent = false;
        if (child ~=nil) then
            child:fadeOut()
        end
    end
    showGameOver();    
    print ("game over, player "..whoWon.." won!");
end

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
    player1PelletNumDisplay.text = player1Bullets .. " pellets";
    player2PelletNumDisplay.text = player2Bullets .. " pellets";
    player2ScoreDisplay.text = player2Score .. " - " .. player1Score;
    player1ScoreDisplay.text = player1Score .. " - " .. player2Score;
    
    -- 
    --check for game over conditions
    
    if (gameMode == "points") then
 --   print (pointLimit);
        -- check for score win
        if (gameOn) then
        if (player1Score >= pointLimit) then
            gameOver(1);
        
        elseif (player2Score >= pointLimit) then
            gameOver(2);
        end
        end
    end
end
-- Define a function to place objects on screen (note: need to figure out how to track these objects for game over removal)
	
local function placeObject(whichType, whichDir)
    
    --Only place an object if there are fewer than 4 on screen, the exception being the 'attractor'and the snake
    
    --Snake
    if(whichType == 4) then
            
                if (whichDir == 1) then
                xLoc = 550;
                yLoc = 988;
                end
                
                if (whichDir == 2) then
                xLoc = 550;
                yLoc = -200;
                end
                
                local snake = Snake.new(xLoc, yLoc, whichDir) -- plenty of joy
                group1:insert( snake )
                
                if (whichDir == 1) then
                    snake:applyForce(0,-1000, snake.x, snake.y);
                end
                if (whichDir == 2) then
                    snake:applyForce(-1000,0, snake.x, snake.y);
                end
    end
    -- Attractor
    if(whichType == 5) then
            
                if (whichDir == 1) then
                xLoc = 550;
                yLoc = 788;
                end
                
                if (whichDir == 2) then
                xLoc = 550;
                yLoc = -20;
                end
                
                attractor = Attractor.new(xLoc, yLoc) -- plenty of joy
                group1:insert( attractor )
                
                if (whichDir == 1) then
                    attractor:applyForce(0,-1000, attractor.x, attractor.y);
                end
                if (whichDir == 2) then
                    attractor:applyForce(0,1000, attractor.x, attractor.y);
                end
    end
    
    if (bigObjectsOnScreen < 4) then
    
      
    
        print(whichType .. " is the whichtype");
        local xLoc
        local yLoc
        --Factor this down in the future
        if(whichType == 3) then
            
                if (whichDir == 1) then
                xLoc = 550;
                yLoc = 968;
                end
                
                if (whichDir == 2) then
                xLoc = 550;
                yLoc = -200;
                end
                
                local square = Square.new(xLoc, yLoc) -- plenty of joy
                group1:insert( square )
                -- Everything must be added to the local group to be handled appropriately on 'scene changes'
                --   group:insert(triangle);
        
                --let's fire the triangle onScreen
                
                if (whichDir == 1) then
                    square:applyForce(0,-3500, square.x, square.y);
                end
                if (whichDir == 2) then
                    square:applyForce(0,3500, square.x, square.y);
                end
                
                bigObjectsOnScreen = bigObjectsOnScreen + 1;
            
                -- Add event listener for this thing to rotate
                
                -- Does this need to be 'returned'?
                --return triangle;
        
            end
            if(whichType == 1) then
            
                if (whichDir == 1) then
                xLoc = 550;
                yLoc = 968;
                end
                
                if (whichDir == 2) then
                xLoc = 550;
                yLoc = -200;
                end
                
                local triangle = Triangle.new(xLoc, yLoc) -- plenty of joy
                group1:insert( triangle )
                -- Everything must be added to the local group to be handled appropriately on 'scene changes'
                --   group:insert(triangle);
        
                --let's fire the triangle onScreen
                
                if (whichDir == 1) then
                    triangle:applyForce(0,-3400, triangle.x, triangle.y);
                end
                if (whichDir == 2) then
                    triangle:applyForce(0,3400, triangle.x, triangle.y);
                end
                
                bigObjectsOnScreen = bigObjectsOnScreen + 1;
            
                -- Add event listener for this thing to rotate
                
                -- Does this need to be 'returned'?
                --return triangle;
        
            end
    
            -- Type 2 is an octo creature 
            if (whichType ==2) then
                if (whichDir == 1) then
                xLoc = 550;
                yLoc = 968;
                end
                
                if (whichDir == 2) then
                xLoc = 550;
                yLoc = -200;
                end
 
              local octoOrb = OctoOrb.new(xLoc,yLoc) -- plenty of joy
              group1:insert( octoOrb )
                if (whichDir == 1) then
                    octoOrb:applyForce(0,-3500, octoOrb.x, octoOrb.y);
                end
                if (whichDir == 2) then
                    octoOrb:applyForce(0,3500, octoOrb.x, octoOrb.y);
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
    --only fire if the game is on.
    if (gameOn) then
    
        -- I don't think this works
        local group = scene.view;
    
    
        -- local ball
        --  local ballTimer = 0;
        -- If the first player fired ...
        if (whichPlayer == 1) then

            -- Only fire if that player has pellets available 
            if (player1Bullets > 0) then 
        
                local ball = Ball.new(155, loc, 1,totalTime) 
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
            --  group:insert(ball);
            --  group1:insert( ball )
                print(group1.numChildren .. " is your number of NumChildren");
                player1Bullets = player1Bullets - 1
                player1PelletNumDisplay.text = player1Bullets;
            end
        end

        -- If the second player fired...
    
        if (whichPlayer == 2) then
  
        -- Only fire if that player has pellets available 
        if (player2Bullets > 0) then 
            local theX = display.contentWidth - 155;
            local ball = Ball.new(869, loc, 2, totalTime) 
            print("player 2 fired");
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
    if (startTime ~= nil) then
    print("again, start time is " .. startTime);
    totalTime =  (system.getTimer() - startTime) / 1000;
    print("fire!");
    print("total time was " .. totalTime .. " seconds");
    --normalize this
    local multX;
    local multY;
    
    -- (Note, this runs when a finger is 'lifted' from the screen)
    
    -- Hacky workaround to account for negative distance values and inverted y-coord system
    
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
    
    -- Get the absolute value of the distance between where the swipe ended and where it began
    
    magX = math.abs(event.x - event.xStart);
    magY = math.abs(event.y - event.yStart);
    
    -- print("magX is " .. magX);
    -- print("magY is " .. magY);
       
    -- Get the angle of the shot by taking the inverse tangent of the y 'distance' over the x 'distance' (TOA = Tangent: Opposite over Adjacent!)
    
    local angle = math.atan(magY/magX)
    
    local constantForce = 500;
    
    -- Normalize the force using cosine and sine and multiplying by the desired constant force. Also, multiply by multX and multY, my hacky 'direction' handlers.
    
    local xPower = math.cos(angle)*constantForce*multX
    local yPower = math.sin(angle)*constantForce*multY
        
    -- print("angle is... " .. angle);
   
    -- If the distance of y is zero (user taps rather than swipes), angle can return 'undefined' and crash the program. Only fire if the distance between y-values is not zero. (Note that '~=' in Lua is the equivalent of '!=' in other languages).
    
    if (magX ~= 0) then 
        shootFrom(1,event.y, xPower, yPower, totalTime) 
    end
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
    if (startTime ~=nil) then
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
     if (magX ~= 0) then
    print ("it ain't nan");
    print("are we tryin to shoot from 2?");
        shootFrom(2,event.y, a, b, totalTime) --add charge up time, and an normalized x y vector
        end
    end
    
    -- Note that other event.phases could be "began", "moved", "stationary", "cancelled"
end
 

end
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    local whichObj = 1;


    ---------------------------
    -- Set initial variables for the game
    ---------------------------
    testGlobal = 0;
    bigObjectsOnScreen = 0;
    player1Bullets = 40;
    player2Bullets = 40;
    player1Score = 0;
    player2Score = 0;
    pointLimit = 2;
    local startTime;
    attractorPresent = false;
    mono = {0,0,0,255};
    gameOn = true;

    -- Function that runs every frame and maintains the game

    --should this be a local function here? probably not
    local function run()
    
    -- only run if the game is on
   -- print (gameOn);
    if (gameOn == true) then
    
        runTimer = runTimer + 1
         if (attractorPresent == true) then
        if (attractor ~= nil) then
        if (attractor.y < -21 or attractor.y > 789) then
                print (attractor.x)
                attractorPresent = false;
                attractor:fadeOut();
                
            end
            end
        end
        updateScore();
     
       -- print(bigObjectsOnScreen);
       -- print(runTimer);
      
       
        --print (runTimer);
       -- print("bigObjectsOnScreen = " .. bigObjectsOnScreen);
        if (runTimer % 1000 == 0) then
             bigObjectsOnScreen = bigObjectsOnScreen - 1;
        end
        if (runTimer % 200 == 0) then
          -- local whichObject = 5;
           local whichObject = math.random(3);
            print("whichObject is " .. whichObject);
            local whichDir = math.random(2);
            placeObject(whichObject, whichDir); --wasWhichObject
          --  runTimer = 0;    
        end
        if (runTimer % 300 == 0) then
            -- only fire an attractor if there isn't one on screen
            print(attractorPresent);
            if (attractorPresent == false) then
                print("checking for an attractor")
                local randomChance = math.random(100);
                if (randomChance < 80) then
                    print("fire an attractor!")
                    attractorPresent = true;
                    local whichDir = math.random(2);
                    placeObject(5, whichDir);
                end
            end
        end
         if (runTimer % 100 == 0) then
         --put in a regen rate here
            addToPellets(1,1)
            addToPellets(2,1);
          --  runTimer = 0;    
        end
          if (bigObjectsOnScreen < 0 ) then
        bigObjectsOnScreen = 0;
        end
    end

end
    -- Start the run timer  
    runTimer = 1
    
    --create an enterFrame listener for all periodic events

    Runtime:addEventListener( "enterFrame", run );
    
    
    -- Create two goal zones
    
    local zone1 = display.newRect( 0, 150, 150, 468 )
	zone1:setFillColor(101, 101, 101, 120)
	physics.addBody(zone1, {density = 200, friction = .3, bounce = .2})
	zone1.bodyType = "static" 
	zone1.isSensor = true;
	group:insert(zone1)
	
	local zone1Shadow = display.newRect(0,150,450,468)
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
        if (event.other.id == "attractor") then
            attractorPresent = false;
            event.other:fadeOut();
            
            player2Score = player2Score + 1;
        end
     if (event.other.id == "triangle" or event.other.id == "square") then
        print("triangle collided with goal 1");
       if (event.other ~= nil) then
       event.other:fadeOut();
            
            bigObjectsOnScreen = bigObjectsOnScreen - 1;
            player2Score = player2Score + 1;
            --add to score here
        end
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
        

    local zone2 = display.newRect( 874, 150, 150, 468 )
    zone2:setFillColor(101, 101, 101, 120)
    physics.addBody(zone2, {density = 200, friction = .3, bounce = .2})
	zone2.bodyType = "static" 
    zone2.isSensor = true;
    -- Register an event listener for touching the second goal zone
    	local zone2Shadow = display.newRect(574,150,450,468)
    	--(0,150,450,468)
	zone2Shadow:setFillColor(255,0,0,0);
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
          if (event.other.id == "attractor") then
            attractorPresent = false;
            event.other:fadeOut();
            
            player1Score = player1Score + 1;
        end
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

-- Draw a background

local bg = display.newRect(0, 0, 1024, 768)
bg.strokeWidth = 1
bg:setFillColor(196, 233, 111)

 -- Draw the left upper segment 
        local leftUpper = display.newLine(0,0, 0,150);
        leftUpper:append(150,150);
        leftUpper:append(275,25);
        leftUpper:append(394,25);
        leftUpper:append(394,0);
        leftUpper.width = 3;
       -- local white = (240, 240, 255, 255);
        leftUpper:setColor(0,0,0,255);
        
       
local fillLeftUpper = display.newGroup()
local widthheight, isclosed, isperpixel = 1, false, false
local points = {0,0, 0,150, 150,150, 275,25, 394,25, 394,0}   
                -- polygonFill( points, closed, perPixel, width, height )
                local p = polygonFill( table.listToNamed(points,{'x','y'}), isclosed, isperpixel, widthheight, widthheight )
                fillLeftUpper:insert(p)
  
        
     --   leftUpper:setFillColor(0, 0, 0,255)
        -- Box2d doesn't allow convex shapes, so I create a second shape to represent the physics object
        local leftUpperExtend = display.newRect(275,0,119,25)
        leftUpperExtend.strokeWidth = 3
        leftUpperExtend:setFillColor(0, 0, 0,255)
        leftUpperExtend:setStrokeColor(0, 0, 255,0)
        
         -- Add a custom physics body shape based on the left upper shape
        --local leftUpperShape = {0,-25, 0,150, 150,150, 275,25, 275,0}
        local leftUpperShape = {0,0, 275,0, 275,25, 150,150, 0,150}
        physics.addBody( leftUpper, { density=10.0, friction=0, bounce=0.3, shape = leftUpperShape } )
        leftUpper.bodyType = "static";
        leftUpper.id = "wall";
        leftUpper.isSleepingAllowed = false;
       -- leftUpper:setFillColor(0, 0, 0,255)
      -- local leftUpperShapeExtend = {0,0,0,119,-25,119,0,0}
        physics.addBody( leftUpperExtend, { density=10.0, friction=0, bounce=0.3 } )
        leftUpperExtend.bodyType = "static";
        leftUpperExtend.isSleepingAllowed = false;
leftUpperExtend.id = "wall";
         -- Draw the right upper segment 
        local rightUpper = display.newLine(0,768, 0,618);
        rightUpper:append(150,618);
        rightUpper:append(275,743);
        rightUpper:append(394,743);
        rightUpper:append(394,768);
        rightUpper.width = 3;
        rightUpper:setColor(0, 0, 0,255);
        
        local fillRightUpper = display.newGroup()
        local widthheightR, isclosedR, isperpixelR = 1, false, false
local pointsR = {0,768, 0,618, 150,618, 275,743, 394,743, 394,768}   
                -- polygonFill( points, closed, perPixel, width, height )
                local pR = polygonFill( table.listToNamed(pointsR,{'x','y'}), isclosed, isperpixel, widthheight, widthheight )
                fillRightUpper:insert(pR)
  
        
        -- Box2d doesn't allow convex shapes, so I create a second shape to represent the physics object
        local rightUpperExtend = display.newRect(275,743,119,25)
        rightUpperExtend.strokeWidth = 3
        rightUpperExtend:setFillColor(0, 0, 0,255)
        rightUpperExtend:setStrokeColor(0, 0, 0,255)
      
         -- Add a custom physics body shape based on the right upper shape
        local rightUpperShape = {0,-150, 150,-150, 275,-25, 275,0, 0,0}
        --local rightUpperShape = {0,-150, 0,0,  275,0, 275,-25, 150, -150}
        physics.addBody( rightUpper, { density=10.0, friction=0, bounce=0.3, shape=rightUpperShape } )
        rightUpper.bodyType = "static";
        rightUpper.isSleepingAllowed = false;
        rightUpper.id = "wall";
       -- Add a second physics body to represent the extension of the upper right shape
        physics.addBody( rightUpperExtend, { density=10.0, friction=0, bounce=0.3 } )
        rightUpperExtend.bodyType = "static";
        rightUpperExtend.isSleepingAllowed = false;
        rightUpperExtend.id = "wall";
         -- Draw the left lower segment 
        local leftLower = display.newLine(1024,0, 1024,150);
        leftLower:append(874,150);
        leftLower:append(749,25);
        leftLower:append(630,25);
        leftLower:append(630,0);
        leftLower.width = 3;
        leftLower:setColor(0, 0, 0,255);
        
          local fillLeftLower = display.newGroup()
      
local pointsLL = {1024,0, 1024,150, 874,150, 749,25, 630,25, 630,0}   
                -- polygonFill( points, closed, perPixel, width, height )
                local pLL = polygonFill( table.listToNamed(pointsLL,{'x','y'}), isclosed, isperpixel, widthheight, widthheight )
                fillLeftLower:insert(pLL)
        -- Box2d doesn't allow convex shapes, so I create a second shape to represent the physics object
        local leftLowerExtend = display.newRect(630,0,119,25)
        leftLowerExtend.strokeWidth = 3
        leftLowerExtend:setFillColor(0, 0, 0,255)
        leftLowerExtend:setStrokeColor(0, 0, 0,255)
      
         -- Add a custom physics body shape based on the left lower shape
         local leftLowerShape = {-275,0, 150,0, 150,150, -150,150, -275,25}
        -- local leftLowerShape = {-275,0, -275,25,  -150,150, 0,150, 0, 0}
        physics.addBody( leftLower, { density=10.0, friction=0, bounce=0.3, shape=leftLowerShape} )
        leftLower.bodyType = "static";
        leftLower.isSleepingAllowed = false;
        leftLower.id = "wall";
       -- Add a second physics body to represent the extension of the upper right shape
        physics.addBody( leftLowerExtend, { density=10.0, friction=0, bounce=0.3 } )
        leftLowerExtend.bodyType = "static";
        leftLowerExtend.isSleepingAllowed = false;
        leftLowerExtend.id = "wall";
        -- Draw the right lower segment 
        local rightLower = display.newLine(1024,768, 1024,768-150);
        rightLower:append(874,768-150);
        rightLower:append(749,743);
        rightLower:append(630,743);
        rightLower:append(630,768);
        rightLower.width = 3;
        rightLower:setColor(0, 0, 0,255);
        
          local fillRightLower = display.newGroup()
   
local pointsRL = {1024,768, 1024,768-150, 874,768-150, 749,743, 630,743, 630,768}   
                -- polygonFill( points, closed, perPixel, width, height )
                local pRL = polygonFill( table.listToNamed(pointsRL,{'x','y'}), isclosed, isperpixel, widthheight, widthheight )
                fillRightLower:insert(pRL)
        -- Box2d doesn't allow convex shapes, so I create a second shape to represent the physics object
        local rightLowerExtend = display.newRect(630,743,119,25)
        rightLowerExtend.strokeWidth = 3
        rightLowerExtend:setFillColor(0, 0, 0,255)
        rightLowerExtend:setStrokeColor(0, 0, 0,255)
      
         -- Add a custom physics body shape based on the right lower shape
         local rightLowerShape = {-275,-25, -150,-150, 0,-150, 0,0, -275,0}
         --local rightLowerShape = {-275,-25, -275,0,  0,0, 0,-150, -150,-150}
        physics.addBody( rightLower, { density=10.0, friction=0, bounce=0.3, shape=rightLowerShape} )
        rightLower.bodyType = "static";
        rightLower.isSleepingAllowed = false;
        rightLower.id = "wall";
       -- Add a second physics body to represent the extension of the upper right shape
        physics.addBody( rightLowerExtend, { density=10.0, friction=0, bounce=0.3 } )
        rightLowerExtend.bodyType = "static";
        rightLowerExtend.isSleepingAllowed = false;
        rightLowerExtend.id = "wall";
        
-- Draw initial pellet #s

    player2PelletNumDisplay = display.newText( "20 Pellets", 1000,55, "Eurostile", 24 )
    player2PelletNumDisplay:setReferencePoint(display.CenterReferencePoint);
        player2PelletNumDisplay.x = 1000;
    player2PelletNumDisplay.y = 700;
    player2PelletNumDisplay:setTextColor(255, 255, 255,255)
    player2PelletNumDisplay:rotate(-90);
    

    player1PelletNumDisplay = display.newText( "20 Pellets", 70,55, "Eurostile", 24)
    player1PelletNumDisplay:setReferencePoint(display.CenterReferencePoint);
    player1PelletNumDisplay.x = 24;
    player1PelletNumDisplay.y = 68;
    
    player1PelletNumDisplay:setTextColor(255, 255, 255,255)
    player1PelletNumDisplay:rotate(90);
    
-- Draw initial scores
    player2ScoreDisplay = display.newText( "0 - 0", 900,85, "Eurostile", 60 )
    player2ScoreDisplay:setReferencePoint(display.CenterReferencePoint);
  
    player2ScoreDisplay:setTextColor(255, 255, 255,255)
    player2ScoreDisplay:rotate(-90);
      player2ScoreDisplay.x=990;
    player2ScoreDisplay.y=70;
    player1ScoreDisplay = display.newText( "0 - 0", 70,675, "Eurostile", 60 )
    player1ScoreDisplay:setReferencePoint(display.CenterReferencePoint);
    player1ScoreDisplay:setTextColor(255, 255, 255,255)
     player1ScoreDisplay.x=34;
    player1ScoreDisplay.y=698;
    player1ScoreDisplay:rotate(90);
  
  group:insert(bg);
  
group:insert(fillRightLower);
group:insert(fillRightUpper);
group:insert(fillLeftLower);
group:insert(fillLeftUpper);
group:insert(player1ScoreDisplay);
group:insert(player2ScoreDisplay);
group:insert(player2PelletNumDisplay);
group:insert(player1PelletNumDisplay);

    
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


