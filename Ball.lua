--Ball CLASS
  module(..., package.seeall)
local Ball = {}
 
function Ball.new(locX, locY, whichPlayer, touchDuration)
        print("new ball");
        -- Draw a ball
        --get how long the ball was touched over 1 second
        local chargeUp = touchDuration - 1; 
     
   print("1 + chargeup is " .. 1 +chargeUp)
   if (chargeUp > 3) then
   chargeUp = 3
   end
   local ball
     if (chargeUp > 0) then
            ball = display.newCircle( 100, 100, 8*(1+chargeUp) )
            physics.addBody( ball, { density=10.0, friction=0.8, bounce=0.3, radius = (8*(1+chargeUp)+3) } )
            end
            
            if (chargeUp <= 0) then
            ball = display.newCircle( 100, 100, 8 )
            physics.addBody( ball, { density=10.0, friction=0.8, bounce=0.3, radius = 11 } )
            end
            
            
            local ballTimerOn = true;
            
            ball.x = locX
            ball.y = locY;
        
            ball.strokeWidth = 3;
            ball:setStrokeColor(240,240,240,255);
            if (whichPlayer == 1) then
            ball:setFillColor(240,240, 240, 200)
            end
             if (whichPlayer == 1) then
            ball:setFillColor(220,220, 255, 200)
            end
            
            ball.bodyType = "dynamic";
            
               ball.isBullet = true;
            local ballTimer = 0;  
          
        local function eachFrame()
            
            --Every frame, keep track of how long the ball has been on screen.
            
 
            
            
            
            
            if (ballTimerOn == true) then
            ballTimer = ballTimer + 1
            end
    
            -- If the ball has been on screen a long time, remove it.
            if (ballTimer == 200) then
            print ("fading out because we've been on screen too long");
          ball:fadeOut();
          ballTimer = 0;
            end
        end
    
      
      
      
      
      
      --Add an event listener to keep track of the ball every frame.
        Runtime:addEventListener( "enterFrame", eachFrame );
      
        
        function ball:destroy()
                print("ball gone");
                ball:removeSelf()
                ball = nil
        end
        
        function ball:fadeOut()
            print("fading out")
            local function goAway()
              --  print("...and going away");
                Runtime:removeEventListener("enterFrame", eachFrame);
                ball:removeSelf()
                ball = nil
            end
            ballTimerOn = false;
            transition.to( ball, {delay=1, time=1000, alpha=0.0, onComplete=goAway} )
        end
        
                
        return ball
        
end
 
return Ball