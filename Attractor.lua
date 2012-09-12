--Attractor CLASS


  module(..., package.seeall)
local Attractor = {}
 
function Attractor.new(xLoc, yLoc)
        
                local trailTimer = 0;
                
                 local attractorGroup = display.newGroup();
                 
        -- Draw a attractor
                local trail;
                local attractor = display.newCircle( 100, 100, 20 );
                
               
                attractorGroup:insert(attractor);
                physics.addBody( attractor, { density=10.0, friction=0.8, bounce=0.3, radius = 20 } )
                -- attractor:setColor(100,255,100,255);
                       attractor:setStrokeColor(mono[0],mono[1],mono[2],255);
               attractor.strokeWidth = 8;
              --attractor:setFillColor(mono[0],mono[1],mono[2],0);
        attractor:setFillColor(255, 255, 255, 255) --was 196 233, 111, 
                attractor.id = "attractor"
                attractor.x = xLoc;
                attractor.y = yLoc;
                attractor.isSleepingAllowed = false
                attractor.isBullet = true;
                attractor.linearDamping = 1
                attractor.angularDamping = 1;
                attractor.hasTouched = false;
        

          local function drawTrail()
            trailTimer = trailTimer + 1;
          
        local function removeMe()
            if (trail ~= nil) then
                trail:removeSelf();
                trail = nil;
        
            end
        end
            if (trailTimer > 30) then
          
                print ("trail timer is " .. trailTimer);
                trail = display.newCircle( attractor.x, attractor.y, 20 );
                 attractorGroup:insert(trail);
                trail.xScale = 4.0;
                trail.alpha = 0.8
                trail:toBack();
                
                 trail:setFillColor(mono[0],mono[1],mono[2],255);
                trail.yScale = 4.0;
                 trail:toBack();
                attractor:toFront();
               
                transition.to(trail, {time=250, xScale = 1.0, yScale = 1.0, alpha=0.0, onComplete = removeMe});
                                 trail:setStrokeColor(mono[0],mono[1],mono[2],255);
                                  attractor:toFront();
               trail.strokeWidth = 0;
              
                trailTimer = 0;
            end
          end
          
          local function eachFrame()
           -- need to figure out a way to 'broadcast' this location more globally
          -- testGlobal = testGlobal + 1;
         --  print ("anything happening?");
          attractor:toFront();
         drawTrail();
            
        end
       local function onLocalPreCollision( self, event )
        -- The preCollision  event type fires shortly before a collision occurs, so you can use this if you want
        -- to override some collisions in your game logic. For example, you might have a platform game
        -- where the character should jump "through" a platform on the way up, but land on the platform
        -- as they fall down again.
 
        if (event.other.id ~= "player2Bullet" and event.other.id ~="wall" and event.other.id ~="snake" and event.other.id ~= "player1Bullet") then
    print ("pre collision happened");
        -- Note that this event is very "noisy", since it fires whenever any objects are somewhat close!
 local theX = self.x;
 local theY = self.y;
 local otherX = event.other.x;
 local otherY = event.other.y;
local power = 1000;

local dirX, dirY = getDirection(theX,theY,otherX,otherY);
 event.other:applyForce(dirX*power, dirY*power, event.other.x, event.other.y);
 
        local function removeMe()
            if (trail ~= nil) then
                trail:removeSelf();
                trail = nil;
        
            end
        end
 local trail;
 trail = display.newCircle( attractor.x, attractor.y, 20 );
                 attractorGroup:insert(trail);
                trail.xScale = 1.0;
                  trail.yScale = 1.0;
                trail.alpha = 0.8
                trail:toBack();
                
                 trail:setFillColor(mono[0],mono[1],mono[2],255);
              
                 trail:toBack();
                attractor:toFront();
               
                transition.to(trail, {time=200, xScale = 5.0, yScale = 5.0, alpha=0.0, onComplete = removeMe});
                                 trail:setStrokeColor(mono[0],mono[1],mono[2],255);
                                  attractor:toFront();
               trail.strokeWidth = 0;
 
 end
end
 
-- Here we assign the above two functions to local listeners within crate1 only, using table listeners:
 
attractor.preCollision = onLocalPreCollision
attractor:addEventListener( "preCollision", attractor )
        Runtime:addEventListener( "enterFrame", eachFrame )
    local function checkBoundary()
    if (attractor ~= nil) then
            if (attractor.y < -200 or attractor.y > 968) then
              --  print (square.x)
                attractor:fadeOut();
                bigObjectsOnScreen = bigObjectsOnScreen - 1;
            end
       end
       end
       
       local function addBoundaryListener( event )
            Runtime:addEventListener( "enterFrame", checkBoundary )
       end
 
        timer.performWithDelay(3000, addBoundaryListener )
        
      
        
        function attractor:destroy()
        print("attractor gone");
                attractor:removeSelf()
                attractor = nil
        end
        
        function attractor:fadeOut()
        print("fading out")
            local function goAway()
            print("...and going away");
                         Runtime:removeEventListener("enterFrame", checkBoundary);
             Runtime:removeEventListener("enterFrame", eachFrame);
             attractorPresent = false;
            attractor:removeSelf()
                attractor = nil
            end
            if (attractor.hasTouched == false) then
                transition.to( attractor, {delay=1, time=1000, alpha=0.0, onComplete=goAway} )
                attractor.hasTouched = true;
            end
        end
        
                
        return attractor
        
end
 
return Attractor