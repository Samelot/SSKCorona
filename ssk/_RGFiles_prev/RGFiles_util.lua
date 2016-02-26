
-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2016
-- =============================================================
-- RG Files Module Library - Loader and Initializer
-- =============================================================
--                         License
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
local lfs         = require "lfs"
local json        = require "json"

local strGSub     = string.gsub
local strSub      = string.sub
local strFormat   = string.format
local strFind     = string.find

local pathSep = ( onWin ) and "\\" or "/"

local RGFiles

local util = {}

--
-- isFolder( path ) -- Returns 'true' if path is a folder.
--
function util.isFolder( path )
   if not path then
      return false
   end
   return lfs.attributes( path, "mode" ) == "directory"
end

--
-- isFile( path ) -- Returns 'true' if path is a file.
--
function util.isFile( path )
   if not path then
      return false
   end
   return lfs.attributes( path, "mode" ) == "file"
end

--
-- dumpAttributes( path ) -- Returns 'true' if path is a file.
--
function util.dumpAttributes( path )
   table.print_r( lfs.attributes( path  ) or { result = tostring( path ) .. " : not found?" }  )
end

-- 
-- repairPath( path ) -- Converts path to 'OS' correct style of back- or forward- slashes
-- 
function util.repairPath( path, forceForward )
   if( onOSX or onAndroid or forceForward == true) then
      path = strGSub( path, "\\", "/" )
      --path = path strGSub( path, "//", "/" )
   elseif( onWin ) then
      path = strGSub( path, "/", "\\" )
   end
   return path
end

-- =====================================================
-- File Operations
-- =====================================================
util.mvFile   = os.rename  -- Move File
util.rmFile   = os.remove  -- Remove File
function util.cpFile( src, dst ) -- Copy File
   local retVal
   if(onWin) then
      local command = "copy /Y " .. '"' .. src  .. '" "' .. dst .. '"'      
      retVal =  (os.execute( command ) == 0)
         
   elseif( onOSX ) then
      local command = "cp " .. '"' .. src  .. '" "' .. dst .. '"'
      retVal =  (os.execute( command ) == 0)
   
   else -- Must be on Mobile device...
      retVal = RGFiles.util.writeFile( RGFiles.util.readFile( src ) or "", dst ) 
   end      
   return retVal
end

-- =====================================================
-- Folder Operations
-- =====================================================
util.mvFolder = os.rename
util.mkFolder = lfs.mkdir -- Make Folder
function util.cpFolder( src, dst ) -- Copy Folder
   local retVal = false
   if(onWin) then
      local command = "xcopy /Y /S " .. '"' .. src  .. '" "' .. dst .. '\\"'
      retVal =  (os.execute( command ) == 0)
   
   elseif( onOSX ) then
      local command = "cp -r" .. '"' .. src  .. '" "' .. dst .. '"'
      retVal =  (os.execute( command ) == 0)
   
   else -- Must be on Mobile device
      error("Mobile folder to folder copies not supported yet!")
      -- EFM NO SOLUTION YET
      retVal = false
   end      
   return retVal
end
-- EFM https://forums.coronalabs.com/topic/29387-deleting-all-files-in-documents-directory/
function util.rmFolder( path ) -- Remove Folder
   local retVal = false
   if(onWin) then
      local command = "rmdir /q /s " .. '"' .. path .. '" 1>NUL'
      retVal =  (os.execute( command ) == 0)
   
   elseif( onOSX ) then
      local command = "rm -rf " .. '"' .. path .. '"'
      retVal =  (os.execute( command ) == 0)
   
   else -- Must be on Mobile device
      error("Sorry mobile folder to folder copies not supported yet!")      
      retVal = lfs.rmdir( path ) -- EFM only works for empty folders
   end      
   return retVal
end   



-- =====================================================
-- Table Save & Load
-- =====================================================
--
-- saveTable( tbl, path ) -- Save a table to a fixed path.
--
function util.saveTable( tbl, path )
   local fh = io.open( path, "w" )
   if( fh ) then
      fh:write(json.encode( tbl ))
      io.close( fh )
      return true    
   end
   return false
end

--
-- loadTable( path, base ) -- Load a table from a fixed path.
--
function util.loadTable( path )
   local fh = io.open( path, "r" )
   if( fh ) then
      local contents = fh:read( "*a" )
      io.close( fh )
      local newTable = json.decode( contents )
      return newTable
   else
      return nil
   end
end


-- =====================================================
-- File Exists, Read, Write, Append, ReadFileTable
-- =====================================================

--
-- exists( path ) - Verify file at path exists.
--
function util.exists( path )
   if not path then return false end
   path = RGFiles.util.repairPath( path )
   local attr = lfs.attributes( path )
   return (attr and (attr.mode == "file" or attr.mode == "directory") )
end

--
-- readFile( path ) - Read from file at path.
--
function util.readFile( path ) 
   local file = io.open( path, "rb" )  
   if file then
      local data = file:read( "*all" )
      io.close( file )
      return data
   end
   return nil
end

--
-- writeFile( dataToWrite, path ) - Write 'dataToWrite' to file at path.
--
function util.writeFile( content, path )
   local file = io.open( path, "wb" )
   if file then
      file:write( content )
      io.close( file )
      file = nil
   end
end

--
-- appendFile( dataToWrite, path ) - Append 'dataToWrite' to file at path.
--
function util.appendFile( dataToWrite, path )
   path = RGFiles.getPath( path, base )
   --print(path)

   local f=io.open(path,"a")
   if (f == nil) then 
      return nil
   end

   f:write( dataToWrite )

   io.close(f)
end

--
-- readFileToTable( path ) - Read file at path into numerically indexed table, where each newline starts a new table entry.
--
function util.readFileToTable( path )
   local fileContents = {}
   local f=io.open(path,"r")
   if (f == nil) then 
      return fileContents
   end
   for line in f:lines() do
      fileContents[ #fileContents + 1 ] = line
   end
   io.close( f )
   return fileContents
end




-- =====================================================
-- Folder Scanners
-- =====================================================
--
-- getFilesInFolder( path ) -- Returns table of file names in folder
--
function util.getFilesInFolder( path )
   if path then      
      local files = {}     
      for file in lfs.dir( path ) do      
         if file ~= "." and file ~= ".." and file ~= ".DS_Store" then
            files[ #files + 1 ] = file
         end         
      end
      return files      
   end   
end

--
-- findAllFiles( path ) -- Returns table of all files in folder.
--
function util.findAllFiles( path )
   local tmp = util.getFilesInFolder( path )
   local files = {}
   for k,v in pairs( tmp ) do
      files[v] = v
   end
   for k,v in pairs( files ) do
      local newPath =  path and (path .. "/" .. v) or v
      local isDir = util.isFolder( newPath )
      if( isDir ) then
         files[v] = util.findAllFiles( newPath )
      else
      end
   end
   return files
end

--
-- flattenNames -- EFM
--
function util.flattenNames( t, sep, prefix ) 
   local flatNames = {}
   local function flatten(t,indent,_prefix)
      local path 
      if (type(t)=="table") then
         for k,v in pairs(t) do
            if (type(v)=="table") then
               path = (_prefix) and (_prefix .. indent .. tostring(k)) or tostring(k)
               path = flatten(v,indent,path) 
               path = (prefix) and (prefix .. path) or path
            else
               path = (_prefix) and (_prefix .. indent .. tostring(k)) or tostring(k)
               path = (prefix) and (prefix .. path) or path
               flatNames[path] = path
            end
         end
      else
         path = (_prefix) and (_prefix .. indent .. tostring(t)) or tostring(t)
         path = (prefix) and (prefix .. path) or path
         flatNames[path] = path
      end
      return _prefix or ""
   end
   if (type(t)=="table") then
      flatten(t,sep)
   else
      flatten(t,sep)
   end
   return flatNames
end

--
-- getLuaFiles - EFM
--
function util.getLuaFiles( files )
   local luaFiles = util.flattenNames( files, "." )
   for k,v in pairs(luaFiles) do
      if( string.match( k, "%.lua" ) ) then
         luaFiles[k] = v:gsub( "%.lua", "" )
      else
         luaFiles[k] = nil
      end
   end
   local tmp = luaFiles
   luaFiles = {}
   for k,v in pairs(tmp) do
      luaFiles[v] = v
   end
   return luaFiles
end

--
-- getResourceFiles - EFM could be better...
--
function util.getResourceFiles( files )
   local resourceFiles = util.flattenNames( files, "/" )
   for k,v in pairs(resourceFiles) do
      if( string.match( k, "%.lua" ) ) then        
         resourceFiles[k] = nil
      end
   end
   local tmp = resourceFiles
   resourceFiles = {}
   for k,v in pairs(tmp) do
      resourceFiles[v] = v
   end
   return resourceFiles
end

--
-- keepFileTypes - EFM ??
--
function util.keepFileTypes( files, extensions )
   for i = 1, #extensions do
      extensions[i] = strGSub( extensions[i], "%.", "" ) 
   end   
   local filesToKeep = {}
   for k,v in pairs(files) do
      local isMatch = false
      for i = 1, #extensions do
         if( string.match( v, "%." .. extensions[i] ) ) then
            isMatch = true    
            --print(v)
         end
      end
      if( isMatch ) then
         filesToKeep[k] = v         
      end
   end
   return filesToKeep
end





-- =============================================================
-- =============================================================
function util.attach( module )
   RGFiles = module
   module.util = util
end
return util


