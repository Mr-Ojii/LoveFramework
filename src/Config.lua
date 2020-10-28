local ConfigFilePath=love.filesystem.getSourceBaseDirectory().."/Config.ini"

Config={

Width=1280,
Height=720,
X=0,
Y=0,
FullScreen=false,
FullScreenType="desktop",
VSync=1,
}


Config.import=function()
	if(not exists(ConfigFilePath))then
		return 0
	end

	local file=io.open(ConfigFilePath,"r")
	io.input(file)
	

	local nowsection=""

	for line in io.lines() do
		--remove comment out
		if(string.find(line,";")~=nil)then
			line=string.sub(line,1,string.find(line,";")-1)
		end
		-------------------
		
		--find section
		if(string.find(line,"%[")==1)then

			nowsection=string.sub(line , 2 , string.len(line) - 1)
		--------------
		--find name and value
		elseif(string.find(line,"=")~=nil)then

			--extract name and value
			local name,value=string.sub(line ,1,string.find(line,"=")-1),string.sub(line,string.find(line,"=")+1, string.len(line))


			if(nowsection=="System")then

				if(name=="Version")then
					--if the version of config file is different from the software version,show message box
					if(value~=Info.Version)then
						love.window.showMessageBox("WARNING","The version of the config file is not the supported version,\nso there may be a loading problem.","warning")
					end
				elseif(name=="FullScreen")then
					Config.FullScreen=IntToBool(tonumber(value))
				elseif(name=="FullScreenType")then
					if(value=="exclusive" or value == "desktop")then
						Config.FullScreenType=value
					end
				elseif(name=="VSync")then
					Config.VSync=minmax(tonumber(value),-1,1)
				end

			elseif(nowsection=="PlayOption")then

			end
		end
	end


	local inistr=io.read("*all")
	io.close(file)



	return 0
end

Config.export=function()

	local file=io.open(ConfigFilePath,"w")
	io.output(file)
	io.write("[System]","\n","\n")
	io.write(";The version of the config file.(Not recommended to change.)","\n")
	io.write("Version=",Info.Version,"\n")
	io.write("\n")
	io.write("FullScreen=",BoolToInt(Config.FullScreen),"\n")
	io.write("FullScreenType=",Config.FullScreenType,"\n")
	io.write("VSync=",tostring(Config.VSync),"\n")
	io.close(file)

	return 0

end