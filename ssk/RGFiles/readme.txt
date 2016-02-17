
ssk.RGFiles.* Quick Docs (Last updated: 10 FEB 2016)
========================
[x] means I tested the function.

Mobile OS - system.DocumentsDirectory
-------------------------------------
[ ] docs.getRoot() - Get full root path to system.DocumentsDirectory.
[ ] docs.getPath( path ) - Prefix 'path' with full system.DocumentsDirectory root for a complete path.

Mobile OS - system.ResourceDirectory
------------------------------------
[ ] rsrc.getRoot() - Get full root path to system.DocumentsDirectory.
[ ] rsrc.getPath( path ) - Prefix 'path' with full system.ResourceDirectory root for a complete path.

Mobile OS - system.TemporaryDirectory
-------------------------------------
[ ] temp.getRoot() - Get full root path to system.DocumentsDirectory.
[ ] temp.getPath( path ) - Prefix 'path' with full system.TemporaryDirectory root for a complete path.


Desktop OS
----------
[ ] desktop.getDesktopRoot() - Get full root path to OS dependent 'Desktop' folder.
[ ] desktop.getDesktopPath( path ) - Prefix 'path' with full OS-dependent 'Desktop' folder path.
[ ] desktop.getMyDocumentsRoot() - Get full root path to OS dependent 'My Documents' folder.
[ ] desktop.getMyDocumentsPath( path ) - Prefix 'path' with full OS-dependent 'My Documents' folder path.
[ ] desktop.getDrivePath( path ) - Treat path as direct path to OS drive and clean it up to be consumable by current OS.
[ ] desktop.explore( path ) - Open path in OS explorer utility

General - Utilities
-------------------
[ ] util.exists( path )
[ ] util.dumpAttributes()


File - Utilities
----------------
[ ] util.isFile( path ) - Verify path points to a 'file'.
[ ] util.readFile( path ) - Read file at path into string.
[ ] util.readFileToTable( path ) - Read file at path into numerically indexed table, where each newline starts a new table entry.
[ ] util.writeFile( data,  path ) - Write 'data' string to file at path.
[ ] util.appendFile( data,  path ) - Append 'data' string to existing file at path (or create it).
[ ] util.rmFile( path ) - Remove file at path.
[ ] util.mvFile( src, dst ) - Move file from src to dst.
[ ] util.cpFile( src, dst ) - Copy file src to dst.


Folder - Utilities
------------------
[ ] util.isFolder( path ) - Verify path points to a 'folder'. 
[ ] util.repairPath( path ) - Fix 'path' to conform to current OS slash style (forward or back)
[ ] util.rmFolder( path ) - Remove folder at path (only empty folders can currently be removed on Mobile devices.)
[ ] util.mkFolder( path ) - Make folder at path.
[ ] util.mvFolder( src, dst ) - Move folder from src to dst.
[ ] util.cpFolder( src, dst ) - Copy folder src to dst.

Table - Utilities
-----------------
[ ] util.saveTable( tbl, path ) -- Save 'tbl' table to file at path.
[ ] util.loadTable( path ) -- Load JSON contents of file at path and convert to a table.


Misc - Utilities
----------------
[ ] util.getFilesInFolder()
[ ] util.keepFileTypes()
[ ] util.getLuaFiles()
[ ] util.getResourceFiles()
[ ] util.flattenNames()
[ ] util.findAllFiles()
