call env.bat
call %v8path%1cv8.exe ENTERPRISE /IBConnectionString%IBConnectionString% /TESTMANAGER /Execute ./tools/vanessa-automation-single.epf /C"StartFeaturePlayer;VBParams=./VBParams.json" /AppAutoCheckMode
