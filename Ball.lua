--Ball CLASS
  module(..., package.seeall)
local Ball = {}
 
function Ball.new(locX, locY, whichPlayer)
        print("new ball");
        -- Draw a ball
            local ball = display.newCircle( 100, 100, 8 )
            local ballTimerOn = true;
            physics.addBody( ball, { density=10.0, friction=0.8, bounce=0.3, radius = 11 } )
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
                print("...and going away");
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