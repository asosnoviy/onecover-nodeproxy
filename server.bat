call env.bat
start "" %v8path%dbgs.exe -a %DEBUG_ADR% -p %DEBUG_PORT%
start npm start
start "" %v8path%1cv8.exe DESIGNER /IBConnectionString%IBConnectionString% /debug -http -attach /debuggerURL%PROXY_URL% /AppAutoCheckMode
