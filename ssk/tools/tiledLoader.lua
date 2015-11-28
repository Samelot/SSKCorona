local public = {}
local private = {}

-- Forward Declarations

-- Useful Localizations
-- SSK
--
local isValid 			= display.isValid

-- Corona & Lua
--
local mAbs              = math.abs
local mRand             = math.random
local mSqrt             = math.sqrt
local mCeil             = math.ceil
local mFloor            = math.floor

local getInfo           = system.getInfo
local getTimer          = system.getTimer
local strMatch          = string.match
local strFormat         = string.format
local pairs             = pairs

function public.load( levelName, layers, makers, params )
   local level = require( "levels." .. levelName )
   params = params or {}

   -- Auto-center level based on grid width and height?
   --
   local tw = level.tilewidth
   local th = level.tileheight
   local ox = tonumber( centerX - (level.width * tw)/2 ) + tw
   local oy = tonumber( centerY - (level.height * th)/2 ) - th
   if( params.centerLevel ~= true ) then
      ox = 0
      oy = 0
   end

   -- Exclude objects not in bounds of grid?
   --
   local excludeObject
   if( params.excludeOutOfBounds == true ) then
      local minX = -tw
      local maxX = (level.width * level.tilewidth) + tw
      local minY = -th
      local maxY = (level.height * level.tileheight)  + th

      print( minX, minY, maxX, maxY )

      excludeObject = function( obj )
         return ( obj.x < minX or obj.x > maxX or obj.y < minY or obj.y > maxY )
      end
   else
      excludeObject = function( ) return false end
   end


   -- Show center?
   --
   if( params.showCenter ) then
      display.newLine( layers.background, centerX - 40, centerY, centerX + 40, centerY )
      display.newLine( layers.background, centerX, centerY - 40, centerX, centerY + 40 )
   end

   for i = 1, #level.layers do 
      local layerData = level.layers[i]

      if( layerData.type == "tilelayer" ) then
         -- Nothing yet
      
      elseif( layerData.type == "objectgroup" ) then
         local layerName = layerData.name
         local layer = layers[layerName]
         local objects = layerData.objects
         for j = 1, #objects do
            --table.dump(objects[j])
            local otype = objects[j].type
            local gid = tonumber(objects[j].gid)
            local maker = makers[gid]
            if( maker and not excludeObject( objects[j]) ) then 
               maker( layer, objects[j], { ox = ox, oy = oy } )
            end
         end
      end
   end
end

return public
