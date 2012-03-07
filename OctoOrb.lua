--OctoOrb class
 module(..., package.seeall)
local OctoOrb = {}
 
function OctoOrb.new(xLoc, yLoc)
              
                local octoOrb = display.newCircle(xLoc,550, 50,50);
                
                
                local behaviorType = math.random(2);
                local randRot = math.random(-30,30);
     
                octoOrb:setStrokeColor(240,240,255,255)
                octoOrb.strokeWidth = 5;
                octoOrb:setFillColor(220,220,255,180)
        
                -- Add a custom physics body shape based on the octoOrb shape
                
                physics.addBody( octoOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 50 } )
        
                octoOrb.isSleepingAllowed = false
                octoOrb.isBullet = true;
                octoOrb.linearDamping = 1
                octoOrb.angularDamping = 1;
                octoOrb.id = "octoOrb";
        
                local leftOrb = display.newCircle(xLoc - 75,550, 25,25);
                physics.addBody( leftOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 25 } )
                leftOrb.isSleepingAllowed = false
                leftOrb.isBullet = true;
                leftOrb.linearDamping = 1
                leftOrb.angularDamping = 1;
                octoOrb.leftOrb = leftOrb;
        
                local leftSmOrb = display.newCircle(xLoc-110,550, 10,10);
                physics.addBody( leftSmOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                leftSmOrb.isSleepingAllowed = false
                leftSmOrb.isBullet = true;
                leftSmOrb.linearDamping = 1
                leftSmOrb.angularDamping = 1;
                octoOrb.leftSmOrb = leftSmOrb;
        
                local rightOrb = display.newCircle(xLoc+75,550, 25,25);
                physics.addBody( rightOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 25 } )
                rightOrb.isSleepingAllowed = false
                rightOrb.isBullet = true;
                rightOrb.linearDamping = 1
                rightOrb.angularDamping = 1;
                octoOrb.rightOrb = rightOrb;
        
                local rightSmOrb = display.newCircle(xLoc+110,550, 10,10);
                physics.addBody( rightSmOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 25 } )
                rightSmOrb.isSleepingAllowed = false
                rightSmOrb.isBullet = true;
                rightSmOrb.linearDamping = 1
                rightSmOrb.angularDamping = 1;
                octoOrb.rightSmOrb = rightSmOrb;
                -- Create joints between the orbs
                
                octoOrb.myJointR = physics.newJoint( "pivot", octoOrb, rightOrb, xLoc + 50,550 )
                octoOrb.myJointR.isLimitEnabled = true -- (boolean)
                octoOrb.myJointR:setRotationLimits( -60, 60 )
 
                myJointRsm = physics.newJoint( "pivot", rightOrb, rightSmOrb, xLoc+100,550 )
                myJointRsm.isLimitEnabled = true -- (boolean)
                myJointRsm:setRotationLimits( -60, 60 )
 
                myJointL = physics.newJoint( "pivot", octoOrb, leftOrb, xLoc-50,550 )
                myJointL.isLimitEnabled = true -- (boolean)
                myJointL:setRotationLimits( -60, 60 )
 
                myJointLsm = physics.newJoint( "pivot", leftOrb, leftSmOrb, xLoc-100,550 )
                myJointLsm.isLimitEnabled = true -- (boolean)
                myJointLsm:setRotationLimits( -60, 60 )
 
                rightOrb:setStrokeColor(240,240,255,255)
                rightOrb.strokeWidth = 5;
                rightOrb:setFillColor(220,220,255,180)
     
                rightSmOrb:setStrokeColor(240,240,255,255)
                rightSmOrb.strokeWidth = 5;
                rightSmOrb:setFillColor(220,220,255,180)
  
                leftOrb:setStrokeColor(220,220,255,255)
                leftOrb.strokeWidth = 5;
                leftOrb:setFillColor(220,220,255,180)
     
                leftSmOrb:setStrokeColor(240,240,255,255)
                leftSmOrb.strokeWidth = 5;
                leftSmOrb:setFillColor(220,220,255,180)
 

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
            end
            -- If behaviorType is 2, this is a spinner
            if (behaviorType == 2) then
            octoOrb:applyTorque(randRot);
            end
        end
        Runtime:addEventListener( "enterFrame", eachFrame )
        
    
        function octoOrb:destroy()
            print("octoOrb gone");
            
            octoOrb:removeSelf()
            octoOrb = nil
        end
        
        function octoOrb:fadeOut()
            print("fading out")
            local function goAway()
                print("...and going away");
                Runtime:removeEventListener("enterFrame", eachFrame);
                octoOrb.leftOrb = nil;
                octoOrb.leftSmOrb = nil;
                octoOrb.rightOrb = nil;
                octoOrb.rightSmOrb = nil;
            
                octoOrb:removeSelf()
                octoOrb = nil
            end
        
            transition.to( octoOrb, {delay=1, time=1002, alpha=0.0, onComplete=goAway} )
            transition.to( octoOrb.leftOrb, {time=1000, alpha=0.0} )
            transition.to( octoOrb.leftSmOrb, {time=1000, alpha=0.0} )
            transition.to( octoOrb.rightOrb, {time=1000, alpha=0.0} )
            transition.to( octoOrb.rightSmOrb, {time=1000, alpha=0.0} )
        end
        
                
        return octoOrb
        
end
 
return OctoOrb