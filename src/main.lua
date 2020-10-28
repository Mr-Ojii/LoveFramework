function loadluafiles()
	require("Functions")
	require("Information")
	require("Config")
end

function setsetting()
	love.window.setMode( Config.Width, Config.Height )
	love.window.setTitle("LoveFramework(Ver."..Info.Version..")")
	love.window.setVSync( Config.VSync )
	love.window.setFullscreen( Config.FullScreen, Config.FullScreenType )
end

function love.quit()
	Config.export()
end

function love.load()
	--set icon
	local imagedata = love.image.newImageData( "Icon/Icon.png" )
	love.window.setIcon( imagedata )
	imagedata:release()

	loadluafiles()
	Config.import()
	setsetting()
	getFilelist(love.filesystem.getSourceBaseDirectory().."/Songs")
end

function love.draw()
end

function love.keypressed(key)

    if (key == "f12") then

        love.graphics.captureScreenshot(SaveScreenshot)

	elseif(key == "escape")then

		love.event.quit(0)

    end
	
end

function love.conf(t)
	t.console = true
end


function SaveScreenshot(image)

	local ScreenShotFolder=love.filesystem.getSourceBaseDirectory().."/ScreenShot"
	if(not exists(ScreenShotFolder))then
		makedir(ScreenShotFolder)
	end
	local d = os.date("*t")
	local Name="ScreenShot_"..d["year"]..d["month"]..d["day"]..d["hour"]..d["min"]..d["sec"]..".png"
	image:encode("png",Name)
	os.rename(love.filesystem.getSaveDirectory().."/"..Name,ScreenShotFolder.."/"..Name)
end
