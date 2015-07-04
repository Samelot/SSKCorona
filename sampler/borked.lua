local composer = require( "composer" )
local physics  = require("physics" )

local scene    = composer.newScene()

local _W = display.contentWidth
local _H = display.contentHeight

local cw = display.contentWidth * 0.2
local ch = display.contentWidth * 0.8

local function onCollision( self, event )
   return true
end

local maxCircles = 5
local circles = {}
local function spawnCircles( group )
  if( #circles >= maxCircles) then return end
  
  --local circle =  display.newImageRect( group, "circles.png", 31, 31 )
  local circle =  display.newCircle( group, 31, 31, 10 )
  circles[#circles+1] = circle

  circle.x = math.random( cw, ch )
  circle.y = -70
  
  physics.addBody( circle, "dynamic", { density = .01, friction = 0.5, bounce = 0.1 })
  circle.gravityScale = 0.1 

  timer.performWithDelay( 2000, function() spawnCircles( group ) end ) 

  circle.collision = onCollision
  circle:addEventListener( "collision" )
end

function scene:create( event )
  local sceneGroup = self.view

  physics.setScale( 30 )
  physics.setGravity( 0, 10 )
  physics.start( )
  physics.setDrawMode( "hybrid" ) 

end


function scene:show( event )
  local sceneGroup = self.view
  local willDid    = event.phase
  
  if( willDid == "will" ) then
  
  elseif( willDid == "did" ) then
    timer.performWithDelay( 2000, function() spawnCircles( sceneGroup ) end ) 
  end

end

-- -------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -------------------------------------------------------------------------------
return scene