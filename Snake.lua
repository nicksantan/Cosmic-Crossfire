--Snake class
 module(..., package.seeall)
local Snake = {}
 
function Snake.new(xLoc, yLoc, dir)
              
                local snake = display.newCircle(550,yLoc, 30,30);
                
                local alreadyFadedOut = false;
                --local behaviorType = math.random(2);
                --local randRot = math.random(-30,30);
     
                snake:setStrokeColor(0,0,0,255)
                snake.strokeWidth = 5;
                snake:setFillColor(0,0,0,180)
        
                -- Add a custom physics body shape based on the snake shape
                
                physics.addBody( snake, { density=3.0, friction=0.8, bounce=0.3, radius = 30 } )
        
                snake.isSleepingAllowed = false
                snake.isBullet = true;
                snake.linearDamping = 1
                snake.angularDamping = 1;
                snake.id = "snake";
                snake.bodyType = "kinematic";
        
                local trailOne = display.newCircle(550,yLoc - 40, 10,10);
                physics.addBody( trailOne, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                trailOne.isSleepingAllowed = false
                trailOne.isBullet = true;
                trailOne.linearDamping = 1
                trailOne.angularDamping = 1;
                snake.trailOne = trailOne;
                
                 local trailTwo = display.newCircle(550,yLoc - 60, 10,10);
                physics.addBody( trailTwo, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                trailTwo.isSleepingAllowed = false
                trailTwo.isBullet = true;
                trailTwo.linearDamping = 1
                trailTwo.angularDamping = 1;
                snake.trailTwo = trailTwo;
                
                local trailThree = display.newCircle(550,yLoc - 80, 10,10);
                physics.addBody( trailThree, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                trailThree.isSleepingAllowed = false
                trailThree.isBullet = true;
                trailThree.linearDamping = 1
                trailThree.angularDamping = 1;
                snake.trailThree = trailThree;
        
        local trailFour = display.newCircle(550,yLoc - 100, 10,10);
                physics.addBody( trailFour, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                trailFour.isSleepingAllowed = false
                trailFour.isBullet = true;
                trailFour.linearDamping = 1
                trailFour.angularDamping = 1;
                snake.trailFour = trailFour;
                
                local trailFive = display.newCircle(550,yLoc - 120, 10,10);
                physics.addBody( trailFive, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                trailFive.isSleepingAllowed = false
                trailFive.isBullet = true;
                trailFive.linearDamping = 1
                trailFive.angularDamping = 1;
                snake.trailFive = trailFive;
                
                    local trailSix = display.newCircle(550,yLoc - 140, 10,10);
                physics.addBody( trailSix, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                trailSix.isSleepingAllowed = false
                trailSix.isBullet = true;
                trailSix.linearDamping = 1
                trailSix.angularDamping = 1;
                snake.trailSix = trailSix;
                
                    local trailSeven = display.newCircle(550,yLoc - 160, 10,10);
                physics.addBody( trailSeven, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                trailSeven.isSleepingAllowed = false
                trailSeven.isBullet = true;
                trailSeven.linearDamping = 1
                trailSeven.angularDamping = 1;
                snake.trailSeven = trailSeven;
                
                
                    local trailEight = display.newCircle(550,yLoc - 180, 10,10);
                physics.addBody( trailEight, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                trailEight.isSleepingAllowed = false
                trailEight.isBullet = true;
                trailEight.linearDamping = 1
                trailEight.angularDamping = 1;
                snake.trailEight = trailEight;
                
                   local trailNine = display.newCircle(550,yLoc - 200, 10,10);
                physics.addBody( trailNine, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                trailNine.isSleepingAllowed = false
                trailNine.isBullet = true;
                trailNine.linearDamping = 1
                trailNine.angularDamping = 1;
                snake.trailNine = trailNine;
                
                       local trailTen = display.newCircle(550,yLoc - 220, 10,10);
                physics.addBody( trailTen, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                trailTen.isSleepingAllowed = false
                trailTen.isBullet = true;
                trailTen.linearDamping = 1
                trailTen.angularDamping = 1;
                snake.trailTen = trailTen;
        
                trailOne.id = "snake"
                trailTwo.id = "snake"
                 trailThree.id = "snake"
                  trailFour.id = "snake"
                   trailFive.id = "snake"
                    trailSix.id = "snake"
                     trailSeven.id = "snake"
                      trailEight.id = "snake"
                       trailNine.id = "snake"
                        trailTen .id = "snake"
                      
                -- Create joints between the orbs
              
 
                snake.myJointL = physics.newJoint( "pivot", snake, trailOne, 550,yLoc-40 )
              snake.myJointL.isLimitEnabled = true -- (boolean)
              snake.myJointL:setRotationLimits(-180,180)
 
                
                trailOne:setStrokeColor(0,0,0,255)
                trailOne.strokeWidth = 5;
                trailOne:setFillColor(0,0,0,180)
                
                    snake.myJointL2 = physics.newJoint( "pivot", trailOne, trailTwo, 550,yLoc-60 )
              snake.myJointL2.isLimitEnabled = true -- (boolean)
              snake.myJointL2:setRotationLimits(-180,180)
 
                
                trailTwo:setStrokeColor(0,0,0,255)
                trailTwo.strokeWidth = 5;
                trailTwo:setFillColor(0,0,0,180)
                
                                snake.myJointL3 = physics.newJoint( "pivot", trailTwo, trailThree, 550,yLoc-80 )
              snake.myJointL3.isLimitEnabled = true -- (boolean)
              snake.myJointL3:setRotationLimits(-180,180)
 
                
                trailThree:setStrokeColor(0,0,0,255)
                trailThree.strokeWidth = 5;
                trailThree:setFillColor(0,0,0,180)
                
                            snake.myJointL4 = physics.newJoint( "pivot", trailThree, trailFour, 550,yLoc-100 )
              snake.myJointL4.isLimitEnabled = true -- (boolean)
              snake.myJointL4:setRotationLimits(-180,180)
 
                
                trailFour:setStrokeColor(0,0,0,255)
                trailFour.strokeWidth = 5;
                trailFour:setFillColor(0,0,0,180)
                
                
                      
                            snake.myJointL5 = physics.newJoint( "pivot", trailFour, trailFive, 550,yLoc-120 )
              snake.myJointL5.isLimitEnabled = true -- (boolean)
              snake.myJointL5:setRotationLimits(-180,180)
 
                
                trailFive:setStrokeColor(0,0,0,255)
                trailFive.strokeWidth = 5;
                trailFive:setFillColor(0,0,0,180)
                
                snake.myJointL6 = physics.newJoint( "pivot", trailFive, trailSix, 550,yLoc-140 )
                snake.myJointL6.isLimitEnabled = true -- (boolean)
                snake.myJointL6:setRotationLimits(-180,180)
 
                
                trailSix:setStrokeColor(0,0,0,255)
                trailSix.strokeWidth = 5;
                trailSix:setFillColor(0,0,0,180)
                               trailSeven:setStrokeColor(0,0,0,255)
                trailSeven.strokeWidth = 5;
                trailSeven:setFillColor(0,0,0,180)
                 trailEight:setStrokeColor(0,0,0,255)
                trailEight.strokeWidth = 5;
                trailEight:setFillColor(0,0,0,180)
                  trailNine:setStrokeColor(0,0,0,255)
                trailNine.strokeWidth = 5;
                trailNine:setFillColor(0,0,0,180)
                       trailTen:setStrokeColor(0,0,0,255)
                trailTen.strokeWidth = 5;
                trailTen:setFillColor(0,0,0,180)
                
                 
                snake.myJointL7 = physics.newJoint( "pivot", trailSix, trailSeven, 550,yLoc-160 )
                snake.myJointL7.isLimitEnabled = true -- (boolean)
                snake.myJointL7:setRotationLimits(-180,180)
                
                               snake.myJointL8 = physics.newJoint( "pivot", trailSeven, trailEight, 550,yLoc-180 )
                snake.myJointL8.isLimitEnabled = true -- (boolean)
                snake.myJointL8:setRotationLimits(-180,180)
                
                  snake.myJointL9 = physics.newJoint( "pivot", trailEight, trailNine, 550,yLoc-200 )
                snake.myJointL9.isLimitEnabled = true -- (boolean)
                snake.myJointL9:setRotationLimits(-180,180)
                
                  snake.myJointL10 = physics.newJoint( "pivot", trailNine, trailTen, 550,yLoc-220 )
                snake.myJointL10.isLimitEnabled = true -- (boolean)
                snake.myJointL10:setRotationLimits(-180,180)
 
 
 
                
 
                
    if (dir == 1) then
        snake.rotation = -180;
    end

    local function eachFrame()
       -- print ("dir is ".. dir);
        local x0=500
        local speed = 35
        local amp= 50
        local rate;

        if (dir == 1) then
            rate = -3
        end

        if (dir == 2) then
            rate = 3
        end

        local x=x0+math.sin(snake.y/speed)*amp
        snake.y = snake.y +rate;
        snake.x = x
        --print("happenin");
    end
    local function checkBoundary()
           if (snake ~= nil) then
            if (snake.y < -2000 or snake.y > 2000) then
              --  print (square.x)
                snake:fadeOut();
                bigObjectsOnScreen = bigObjectsOnScreen - 1;
            end
            end
       end
       
       local function addBoundaryListener( event )
            Runtime:addEventListener( "enterFrame", checkBoundary )
       end
 
        timer.performWithDelay(3000, addBoundaryListener )
        
    Runtime:addEventListener( "enterFrame", eachFrame )
    
    function snake:destroy()
        print("snake gone");
            
        snake:removeSelf()
        snake = nil
    end
        
    function snake:fadeOut()
        print("fading out")
        local function goAway()
            print("...and going away");
            Runtime:removeEventListener("enterFrame", checkBoundary);
            Runtime:removeEventListener("enterFrame", eachFrame);
                
            if (trailOne ~= nil) then
                
                trailOne:removeSelf();
                trailOne = nil;
                
                trailTwo:removeSelf();
                trailTwo = nil;
                
                trailThree:removeSelf();
                trailThree = nil;
                
                trailFour:removeSelf();
                trailFour = nil;
                
                trailFive:removeSelf();
                trailFive = nil;
                
                trailSix:removeSelf();
                trailSix = nil;
                
                trailSeven:removeSelf();
                trailSeven = nil;
                
                trailEight:removeSelf();
                trailEight = nil;
                
                trailNine:removeSelf();
                trailNine = nil;
                
                trailTen:removeSelf();
                trailTen = nil;
               
                snake:removeSelf()
                snake = nil
            end
            
             
        end
        
         
        transition.to( snake.trailOne, {time=1000, alpha=0.0} )
        transition.to( snake, {delay=1, time=1002, alpha=0.0, onComplete=goAway} )
        
    end
        
                
    return snake
        
end
 
return Snake