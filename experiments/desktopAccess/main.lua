-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2015
-- =============================================================
-- SSK Sampler
-- =============================================================
-- 								License
-- =============================================================
--[[
	> SSK is free to use.
	> SSK is free to edit.
	> SSK is free to use in a free or commercial game.
	> SSK is free to use in a free or commercial non-game app.
	> SSK is free to use without crediting the author (credits are still appreciated).
	> SSK is free to use without crediting the project (credits are still appreciated).
	> SSK is NOT free to sell for anything.
	> SSK is NOT free to credit yourself with.
]]
-- =============================================================
display.setStatusBar(display.HiddenStatusBar)  -- Hide that pesky bar
io.output():setvbuf("no") -- Don't use buffer for console messages
-- =============================================================

--_G.gameFont = native.systemFont  -- optional
require "ssk.loadSSK"

-- =============================================================
-- 
-- =============================================================
-- SSK 
local isInBounds		= ssk.easyIFC.isInBounds
local newCircle 		= ssk.display.circle
local newRect 			= ssk.display.rect
local newImageRect 		= ssk.display.imageRect
local easyIFC			= ssk.easyIFC
local ternary			= _G.ternary
local quickLayers  		= ssk.display.quickLayers

local angle2Vector 		= ssk.math2d.angle2Vector
local vector2Angle 		= ssk.math2d.vector2Angle
local scaleVec 			= ssk.math2d.scale
local addVec 			= ssk.math2d.add
local subVec 			= ssk.math2d.sub
local getNormals 		= ssk.math2d.normals

-- Lua and Corona
local mAbs 				= math.abs
local mPow 				= math.pow
local mRand 			= math.random
local getInfo			= system.getInfo
local getTimer 			= system.getTimer
local strMatch 			= string.match
local strFormat 		= string.format


-- =============================================================
-- File System Experiments
-- =============================================================




timer.performWithDelay( 500,
   function()
      require "ssk.RGFiles"
      local rgFiles = ssk.rgFiles
      local lfs 			= require "lfs"
      
      --print( "system.ResourceDirectory", rgFiles.getResourceRoot() )
      --print( "system.DocumentsDirectory", rgFiles.getDocumentsRoot() )
      --print( "system.DocumentsDirectory", rgFiles.getTemporaryRoot() )
      
      local function testMyDocuments()
         -- My Documents
         local tmp = rgFiles.getMyDocuments()       
         print( tmp, "isFolder?", rgFiles.isFolder( tmp ) )      
         tmp = tmp .. "\\bob.txt"      
         print( tmp, "isFile?", rgFiles.isFile( tmp ) )
         --rgFiles.dumpAttributes( tmp )
          --tmp = tmp .. "\\bob.txt"      
         --rgFiles.dumpAttributes( tmp )
      end
      
      local function testDesktop()
         -- Desktop
         local tmp = rgFiles.getDesktop()       
         print( tmp, "isFolder?", rgFiles.isFolder( tmp ) )      
         tmp = tmp .. "\\bill.txt"      
         print( tmp, "isFile?", rgFiles.isFile( tmp ) )

         rgFiles.dumpAttributes( tmp )
      end      
      --testDesktop()
      
      --print( rgFiles.mkdir( "testFolder" ) )
      --print( rgFiles.mkdir( "testFolder/subfolder" ) )
      
      --rgFiles.DesktopDirectory = {}
      --rgFiles.MyDocumentsDirectory = {}
      
  
      local function testTableAccess()
         local bubba = { 1 , 2, 3 }
         rgFiles.saveTable( bubba, "/test.json" )
         local bill = rgFiles.loadTable( "/test.json" )
         
         table.dump(bubba)
         table.dump(bill)
      end
      
      if( not rgFiles.isFolder( "testFolder", rgFiles.MyDocumentsDirectory ) ) then
         print( rgFiles.mkdir( "testFolder", rgFiles.MyDocumentsDirectory ) )
      end
      local bubba = { 1 , 2, 3 }
      
      local path = rgFiles.getPath( "testFolder", rgFiles.MyDocumentsDirectory )
      print(path)      
      rgFiles.saveTable( bubba, "testFolder/a.json", rgFiles.MyDocumentsDirectory )
      rgFiles.saveTable( bubba, "testFolder/b.json", rgFiles.MyDocumentsDirectory )
      rgFiles.saveTable( bubba, "testFolder/c.json", rgFiles.MyDocumentsDirectory )
      
      local tmp = rgFiles.getPath( "testFolder", rgFiles.MyDocumentsDirectory )
      print(tmp)
      local tmp2 = rgFiles.getFilesInFolder( tmp )
      --table.dump(tmp2)
      
      --local tmp3 = rgFiles.findAllFiles( rgFiles.getMyDocuments() )
      --local tmp3 = rgFiles.findAllFiles( "x:/Scans" )
      local tmp3 = rgFiles.findAllFiles( rgFiles.getPath( "toImport" ) )
      --table.print_r(tmp3)      
      local tmp4 = rgFiles.flattenNames( tmp3, "/", rgFiles.getPath( "toImport" ) .. "/" )
      for k,v in pairs( tmp4 ) do
         v = string.gsub( v, "/", "\\" )
         --v = string.gsub( v, "\\", "/" )         
         tmp4[k] = v
         print(v)
         --local tmp = display.newImage( v )
         --print(tmp)
      end
      table.dump(tmp4)
      
      local tmp5 = rgFiles.keepFileTypes( tmp4, {"png"} )
      table.dump(tmp5)

      for k,v in pairs( tmp5 ) do
         local src = v
         local dst = v
         dst = string.gsub( dst, "%:", "_" )
         --dst = string.gsub( dst, "%/", "_" )
         dst = string.gsub( dst, "\\", "_" )
         print( src, dst )
         rgFiles.osCopy( src, dst )
         
         
         local pic =  display.newImage( dst, system.DocumentsDirectory )
         pic.x = centerX
         pic.y = centerY
      end
      --]]
   end )
      
--[[
local bubba = { 1 , 2, 3 }


--]]

--local path = system.pathForFile( rgFiles.getDesktop() .. "test.json", system.ResourceDirectory)
--print(path)

--table.save( bubba, rgFiles.getDesktop() .. "test.json")
--table.save( bubba, "test.json", system.TemporaryDirectory )
--[[
local vars = { "windir", "appdata", "computername", "programfiles", "systemdrive", "systemroot"}
for i = 1, #vars do
	print( vars[i], " == ", os.getenv(vars[i]))
end
--]]
