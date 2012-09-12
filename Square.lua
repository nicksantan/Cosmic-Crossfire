--Square CLASS
  module(..., package.seeall)
local Square = {}
 
function Square.new(xLoc, yLoc)
        
        -- Draw a square
                local square = display.newRect(0,0, 100,100);
                local pauser = 0;
                square.hasTouched = false;
                local randRot = math.random(-30,30);
              
                --square.width = 8;
               -- square:setColor(100,255,100,255);
               square:setStrokeColor(0,0,0,255);
               square.strokeWidth = 8;
               square:setFillColor(0,0,255,0);
        
              
                physics.addBody( square, { density=3.0, friction=0.8, bounce=0.3} )
                square.id = "square"
                square.x = xLoc;
                square.y = yLoc;
                square.isSleepingAllowed = false
                square.isBullet = true;
                square.linearDamping = 1
                square.angularDamping = 1;
        
          local sinCounter = 0;
          
          local function eachFrame()
           -- sinCounter = sinCounter + .01;
            
            --Generate a random number to determine the chance of a 'pulse'
           -- print("square enterframe");
               -- square:applyTorque(math.sin(sinCounter)*10);
                square:applyTorque(randRot);
              
                square:attract();
                square:drawTrail();
            
        end
        local function checkBoundary()
            if (square.y < 0 or square.y > 768) then
                print (square.y)
                square:fadeOut();
                bigObjectsOnScreen = bigObjectsOnScreen - 1;
            end
       end
       
       local function addBoundaryListener( event )
            Runtime:addEventListener( "enterFrame", checkBoundary )
       end
 
        timer.performWithDelay(500, addBoundaryListener )
        
        Runtime:addEventListener( "enterFrame", eachFrame )
        
        function square:attract()
            if (attractorPresent == true) then
                --print ("square wants to go to the attractor");
                local dirX, dirY = getDirection(square.x,square.y,attractor.x,attractor.y);
                square:applyForce(dirX*10,dirY*10,square.x,square.y);
            --    print ("dir X is " .. dirX);
            --    print ("dir Y is " .. dirY);
            end
        end
        
        function square:drawTrail()
            local trail;
            pauser = pauser + 1
           
            local function trailErase()
                trail:removeSelf();
                trail = nil;
            end
        
            --  print("is this shit running?");
        
        
        
            local sqX = square.x - ((1/2) * square.width)
            local sqY = square.y - ((1/2) * square.width)
           if (pauser > 3) then
          trail = display.newRect(sqX, sqY, 100, 100);
            trail:setStrokeColor(0,0,0,255);
            trail.strokeWidth = 8;
            trail:setReferencePoint(display.CenterReferencePoint);
               trail:setFillColor(0,0,255,0);
               trail.rotation = square.rotation;
                transition.to(trail, {alpha = 0.0, time=500, onComplete = trailErase});
            pauser = 0;
            end
       end
      
        
        function square:destroy()
        print("square gone");
                square:removeSelf()
                square = nil
        end
        
        function square:fadeOut()
        print("fading out")
            local function goAway()
            print("...and going away");
             Runtime:removeEventListener("enterFrame", eachFrame);
              Runtime:removeEventListener("enterFrame", checkBoundary);
            square:removeSelf()
                square = nil
            end
            if (square.hasTouched == false) then
                transition.to( square, {delay=1, time=1000, alpha=0.0, onComplete=goAway} )
                square.hasTouched = true;
            end
        end
        
                
        return square
        
end
 
return Square
