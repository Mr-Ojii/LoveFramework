function exists(name)
	return os.rename(name,name)
end

function makedir(filepath)
	local command="mkdir "..filepath
	if(love.system.getOS( )=="Windows")then
		command = string.gsub(command, "/", "\\")
	end
	os.execute(command)
end

function BoolToInt(bool)

	if(bool)then
		return 1
	else
		return 0
	end

end

function IntToBool(int)

	if(int==1)then
		return true
	else
		return false
	end

end


function minmax(int,min,max)
	return math.min(math.max(int,min),max)
end


function getFilelist( folder )
	if(folder == nil)then
		folder=love.filesystem.getSourceBaseDirectory().."/Songs"
	end

	local fp
	local str
	local t={}
	local i = 0
	local tmpFile = love.filesystem.getSourceBaseDirectory().."/files.tmp" 
	local fname={}
	local isls=false

	if(love.system.getOS( )=="Windows")then
		
		os.execute( "dir /b \""..string.gsub(folder, "/", "\\").."\" > "..string.gsub(tmpFile, "/", "\\"))
		isls=false
	else
		--using ls -1 and output to file.
		os.execute( "ls -1 \""..folder.."\" > "..tmpFile )
		isls=true
	end

	fp = io.open( tmpFile, "r")

	if( not(fp) )then
		return
	end

	love.window.showMessageBox( "title", folder, "info" )

	while(true)do
	
		str = fp:read("*l")
		if( str==nil )then break end
		str = string.gsub(str,"\r","")
		str = string.gsub(str,"\n","")

		if(isls and string.find(str,"'")==1)then
			str=string.gsub(str,2,string.len(str) - 1)
		end

		love.window.showMessageBox( "title", str, "info" )

		fname[i]=str
		i=i+1
	end

	io.close(fp)
	os.remove(tmpFile)

	return fname
end