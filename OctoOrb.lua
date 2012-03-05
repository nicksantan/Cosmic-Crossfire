--OctoOrb class
 module(..., package.seeall)
local OctoOrb = {}
 
function OctoOrb.new()
              
                local octoOrb = display.newCircle(-200,550, 50,50);
       
                
     
                octoOrb:setStrokeColor(255,0,0,255)
                octoOrb.strokeWidth = 5;
                octoOrb:setFillColor(255,0,0,180)
        
                -- Add a custom physics body shape based on the octoOrb shape
                
                physics.addBody( octoOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 50 } )
        
                octoOrb.isSleepingAllowed = false
                octoOrb.isBullet = true;
                octoOrb.linearDamping = 1
                octoOrb.angularDamping = 1;
                octoOrb.id = "octoOrb";
        
                local leftOrb = display.newCircle(-275,550, 25,25);
                physics.addBody( leftOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 25 } )
                leftOrb.isSleepingAllowed = false
                leftOrb.isBullet = true;
                leftOrb.linearDamping = 1
                leftOrb.angularDamping = 1;
                octoOrb.leftOrb = leftOrb;
        
                local leftSmOrb = display.newCircle(-310,550, 10,10);
                physics.addBody( leftSmOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 10 } )
                leftSmOrb.isSleepingAllowed = false
                leftSmOrb.isBullet = true;
                leftSmOrb.linearDamping = 1
                leftSmOrb.angularDamping = 1;
                octoOrb.leftSmOrb = leftSmOrb;
        
                local rightOrb = display.newCircle(-125,550, 25,25);
                physics.addBody( rightOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 25 } )
                rightOrb.isSleepingAllowed = false
                rightOrb.isBullet = true;
                rightOrb.linearDamping = 1
                rightOrb.angularDamping = 1;
                octoOrb.rightOrb = rightOrb;
        
                local rightSmOrb = display.newCircle(-90,550, 10,10);
                physics.addBody( rightSmOrb, { density=3.0, friction=0.8, bounce=0.3, radius = 25 } )
                rightSmOrb.isSleepingAllowed = false
                rightSmOrb.isBullet = true;
                rightSmOrb.linearDamping = 1
                rightSmOrb.angularDamping = 1;
                octoOrb.rightSmOrb = rightSmOrb;
                -- Create joints between the orbs
                
                octoOrb.myJointR = physics.newJoint( "pivot", octoOrb, rightOrb, -150,550 )
                octoOrb.myJointR.isLimitEnabled = true -- (boolean)
                octoOrb.myJointR:setRotationLimits( -45, 45 )
 
                myJointRsm = physics.newJoint( "pivot", rightOrb, rightSmOrb, -100,550 )
                myJointRsm.isLimitEnabled = true -- (boolean)
                myJointRsm:setRotationLimits( -45, 45 )
 
                myJointL = physics.newJoint( "pivot", octoOrb, leftOrb, -250,550 )
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
 

        local function eachFrame()
     
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