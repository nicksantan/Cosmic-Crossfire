--Triangle CLASS
  module(..., package.seeall)
local Triangle = {}
 
function Triangle.new(xLoc, yLoc)
        
        -- Draw a triangle
                local triangle = display.newLine(100,100, 100,300);
                
                triangle.hasTouched = false;
                local randRot = math.random(-30,30);
                triangle:append(0,200, 100,100);
                triangle.width = 8;
               -- triangle:setColor(100,255,100,255);
               triangle:setColor(mono[0],mono[1],mono[2],255);
        
                -- Add a custom physics body shape based on the triangle shape
                triShape = {0,0,0,200,-100,100}
                physics.addBody( triangle, { density=3.0, friction=0.8, bounce=0.3, shape = triShape } )
                triangle.id = "triangle"
                triangle.x = xLoc;
                triangle.y = yLoc;
                triangle.isSleepingAllowed = false
                triangle.isBullet = true;
                triangle.linearDamping = 1
                triangle.angularDamping = 1;
        
          local sinCounter = 0;
          
          local function eachFrame()
           -- sinCounter = sinCounter + .01;
            
            --Generate a random number to determine the chance of a 'pulse'
           -- print("triangle enterframe");
               -- triangle:applyTorque(math.sin(sinCounter)*10);
               triangle:applyTorque(randRot);
               triangle:attract();
            
        end
       local function checkBoundary()
        if (triangle ~= nil) then
            if (triangle.y < 0 or triangle.y > 768) then
                print (triangle.y .. " is the triangle.y")
                triangle:fadeOut();
                bigObjectsOnScreen = bigObjectsOnScreen - 1;
            end
            end
       end
       
       local function addBoundaryListener( event )
            Runtime:addEventListener( "enterFrame", checkBoundary )
       end
 
        timer.performWithDelay(5000, addBoundaryListener )
       
        
        
        local function onTriangleCollision(self, event)
          
          if ( event.phase == "began" ) then
          print("triangle collided");
          end
        
        end
        triangle.collision = onTriangleCollision
    triangle:addEventListener( "collision", triangle )
        
        
        
        
        Runtime:addEventListener( "enterFrame", eachFrame )
        
         function triangle:attract()
            if (attractorPresent == true) then
                --print ("triangle wants to go to the attractor");
                local dirX, dirY = getDirection(triangle.x,triangle.y,attractor.x,attractor.y);
                triangle:applyForce(dirX*10,dirY*10,triangle.x,triangle.y);
               -- print ("dir X is " .. dirX);
               -- print ("dir Y is " .. dirY);
            end
        end
        
        function triangle:destroy()
        print("triangle gone");
            if (triangle ~= nil) then
                triangle:removeSelf()
                triangle = nil
            end
        end
        
        function triangle:fadeOut()
        print("fading out")
            local function goAway()
            print("...and going away");
             Runtime:removeEventListener("enterFrame", eachFrame);
           Runtime:removeEventListener("enterFrame", checkBoundary);
            triangle:removeSelf()
                triangle = nil
            end
            if (triangle.hasTouched == false) then
                transition.to( triangle, {delay=1, time=1000, alpha=0.0, onComplete=goAway} )
                triangle.hasTouched = true;
            end
        end
        
                
        return triangle
        
end
 
return Triangle