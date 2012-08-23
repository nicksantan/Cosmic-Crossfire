--OctoOrb class
 module(..., package.seeall)
local OctoOrb = {}
 
function OctoOrb.new(xLoc, yLoc)
              
                local octoOrb = display.newCircle(550,yLoc, 50,50);
                
                local alreadyFadedOut = false;
                local behaviorType = math.random(2);
                local randRot = math.random(-30,30);
     
                octoOrb:setStrokeColor(mono[0],mono[1],mono[2],255)
                octoOrb.strokeWidth = 5;
                octoOrb:setFillColor(mono[0],mono[1],mono[2],180)
        
                -- Add a custom physics body shape based on the octoOrb shape
                
                physics.addBody( octoOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 50 } )
        
                octoOrb.isSleepingAllowed = false
                octoOrb.isBullet = true;
                octoOrb.linearDamping = 1
                octoOrb.angularDamping = 1;
                octoOrb.id = "octoOrb";
        
                local leftOrb = display.newCircle(550,yLoc - 75, 25,25);
                physics.addBody( leftOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 25 } )
                leftOrb.isSleepingAllowed = false
                leftOrb.isBullet = true;
                leftOrb.linearDamping = 1
                leftOrb.angularDamping = 1;
                octoOrb.leftOrb = leftOrb;
        
                local leftSmOrb = display.newCircle(550,yLoc-110, 10,10);
                physics.addBody( leftSmOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                leftSmOrb.isSleepingAllowed = false
                leftSmOrb.isBullet = true;
                leftSmOrb.linearDamping = 1
                leftSmOrb.angularDamping = 1;
                octoOrb.leftSmOrb = leftSmOrb;
        
                local rightOrb = display.newCircle(550,yLoc+75, 25,25);
                physics.addBody( rightOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 25 } )
                rightOrb.isSleepingAllowed = false
                rightOrb.isBullet = true;
                rightOrb.linearDamping = 1
                rightOrb.angularDamping = 1;
                octoOrb.rightOrb = rightOrb;
        
                local rightSmOrb = display.newCircle(550,yLoc+110, 10,10);
                physics.addBody( rightSmOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                rightSmOrb.isSleepingAllowed = false
                rightSmOrb.isBullet = true;
                rightSmOrb.linearDamping = 1
                rightSmOrb.angularDamping = 1;
                octoOrb.rightSmOrb = rightSmOrb;
                -- Create joints between the orbs
                
                local myJointR = physics.newJoint( "pivot", octoOrb, rightOrb,550, yLoc + 50 )
                myJointR.isLimitEnabled = true -- (boolean)
                myJointR:setRotationLimits( -60, 60 )
 
                local myJointRsm = physics.newJoint( "pivot", rightOrb, rightSmOrb, 550,yLoc+100 )
                myJointRsm.isLimitEnabled = true -- (boolean)
                myJointRsm:setRotationLimits( -60, 60 )
 
                local myJointL = physics.newJoint( "pivot", octoOrb, leftOrb, 550,yLoc-50 )
                myJointL.isLimitEnabled = true -- (boolean)
                myJointL:setRotationLimits( -60, 60 )
 
                local myJointLsm = physics.newJoint( "pivot", leftOrb, leftSmOrb, 550,yLoc-100 )
                myJointLsm.isLimitEnabled = true -- (boolean)
                myJointLsm:setRotationLimits( -60, 60 )
 
                rightOrb:setStrokeColor(mono[0],mono[1],mono[2],255)
                rightOrb.strokeWidth = 5;
                rightOrb:setFillColor(mono[0],mono[1],mono[2],180)
     
                rightSmOrb:setStrokeColor(mono[0],mono[1],mono[2],255)
                rightSmOrb.strokeWidth = 5;
                rightSmOrb:setFillColor(mono[0],mono[1],mono[2],180)
  
                leftOrb:setStrokeColor(mono[0],mono[1],mono[2],255)
                leftOrb.strokeWidth = 5;
                leftOrb:setFillColor(mono[0],mono[1],mono[2],180)
     
                leftSmOrb:setStrokeColor(mono[0],mono[1],mono[2],255)
                leftSmOrb.strokeWidth = 5;
                leftSmOrb:setFillColor(mono[0],mono[1],mono[2],180)
 

        local function eachFrame()
         
            -- If behaviorType is 1, this is a 'pulser'
            if (behaviorType == 1) then
                --Generate a random number to determine the chance of a 'pulse'
                local randChance = math.random(1,100);
                if (randChance < 2) then
                    --choose a random direction
                    local randX = math.random(-1000,1000);
                    local randY = math.random(-1000,1000);
                    print("randX was "..randX);
                    print("randY was "..randY);
                    octoOrb:applyForce(randX,randY,octoOrb.x,octoOrb.y);
                    
                end
                   if (attractorPresent) then 
             --print ("square wants to go to the attractor");
                local dirX, dirY = getDirection(octoOrb.x,octoOrb.y,attractor.x,attractor.y);
                octoOrb:applyForce(dirX*10,dirY*10,octoOrb.x,octoOrb.y);
            end
            end
            -- If behaviorType is 2, this is a spinner
            if (behaviorType == 2) then
                octoOrb:applyTorque(randRot);
            end
        
         --   octoOrb:attract();
        end
         local function checkBoundary()
            if (octoOrb.y < 0 or octoOrb.y > 768) then
                print (octoOrb.y)
                if (alreadyFadedOut == false) then
                octoOrb:fadeOut();
                bigObjectsOnScreen = bigObjectsOnScreen - 1;
                alreadyFadedOut = true;
                end
            end
       end
       
       local function addBoundaryListener( event )
            Runtime:addEventListener( "enterFrame", checkBoundary )
       end
 
        timer.performWithDelay(500, addBoundaryListener )
        Runtime:addEventListener( "enterFrame", eachFrame )
        
  --   function octoOrb:attract()
   --         if (attractorPresent == true) then
              
    --            print ("dir X is " .. dirX);
     --           print ("dir Y is " .. dirY);
      --      end
      --  end
        
        function octoOrb:destroy()
            print("octoOrb gone");
            
            octoOrb:removeSelf()
            octoOrb = nil
        end
        
        function octoOrb:fadeOut()
            print("fading out")
            local function goAway()
                print("...and going away");
                 Runtime:removeEventListener("enterFrame", checkBoundary);
                Runtime:removeEventListener("enterFrame", eachFrame);
                if (leftOrb ~= nil) then
                leftOrb:removeSelf();
                leftSmOrb:removeSelf();
                rightOrb:removeSelf();
                rightSmOrb:removeSelf();
                --myJointR:removeSelf();
                myJointRsm:removeSelf(); 
                myJointL:removeSelf();
                myJointLsm:removeSelf(); 
                
                leftOrb = nil;
                leftSmOrb = nil;
                rightOrb = nil;
                rightSmOrb = nil;
               --  myJointR = nil;
                myJointRsm = nil ;
                myJointL= nil;
                myJointLsm= nil;
                
                
                octoOrb:removeSelf()
                octoOrb = nil
                end
            end
        
         
            transition.to( octoOrb.leftOrb, {time=1000, alpha=0.0} )
            transition.to( octoOrb.leftSmOrb, {time=1000, alpha=0.0} )
            transition.to( octoOrb.rightOrb, {time=1000, alpha=0.0} )
            transition.to( octoOrb.rightSmOrb, {time=1000, alpha=0.0} )
               transition.to( octoOrb, {delay=1, time=1002, alpha=0.0, onComplete=goAway} )
        end
        
                
        return octoOrb
        
end
 
return OctoOrb