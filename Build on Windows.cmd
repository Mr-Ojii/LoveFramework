if not exist bin mkdir bin
powershell compress-archive src\* LoveFramework
move LoveFramework.zip bin\LoveFramework.love