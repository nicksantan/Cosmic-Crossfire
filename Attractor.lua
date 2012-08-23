--Attractor CLASS


  module(..., package.seeall)
local Attractor = {}
 
function Attractor.new(xLoc, yLoc)
        
        -- Draw a attractor
              
                local attractor = display.newCircle( 100, 100, 20 );
                physics.addBody( attractor, { density=10.0, friction=0.8, bounce=0.3, radius = 20 } )
                -- attractor:setColor(100,255,100,255);
                       attractor:setStrokeColor(mono[0],mono[1],mono[2],255);
               attractor.strokeWidth = 8;
               attractor:setFillColor(mono[0],mono[1],mono[2],0);
        
                attractor.id = "attractor"
                attractor.x = xLoc;
                attractor.y = yLoc;
                attractor.isSleepingAllowed = false
                attractor.isBullet = true;
                attractor.linearDamping = 1
                attractor.angularDamping = 1;
                attractor.hasTouched = false;
        

          
          local function eachFrame()
           -- need to figure out a way to 'broadcast' this location more globally
          -- testGlobal = testGlobal + 1;
         --  print ("anything happening?");
            
        end
       local function onLocalPreCollision( self, event )
        -- The preCollision  event type fires shortly before a collision occurs, so you can use this if you want
        -- to override some collisions in your game logic. For example, you might have a platform game
        -- where the character should jump "through" a platform on the way up, but land on the platform
        -- as they fall down again.
 
        if (event.other.id ~= "player2Bullet" and event.other.id ~= "player1Bullet") then
    print ("pre collision happened");
        -- Note that this event is very "noisy", since it fires whenever any objects are somewhat close!
 local theX = self.x;
 local theY = self.y;
 local otherX = event.other.x;
 local otherY = event.other.y;
local power = 1000;

local dirX, dirY = getDirection(theX,theY,otherX,otherY);
 event.other:applyForce(dirX*power, dirY*power, event.other.x, event.other.y);
 end
end
 
-- Here we assign the above two functions to local listeners within crate1 only, using table listeners:
 
attractor.preCollision = onLocalPreCollision
attractor:addEventListener( "preCollision", attractor )

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