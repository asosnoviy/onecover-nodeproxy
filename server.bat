call env.bat
start "" %v8path%dbgs.exe -a %debugAdr% -p %debugport%
start npm start
call %v8path%1cv8.exe DESIGNER /IBConnectionString%IBConnectionString% /debug -http -attach /debuggerURL%debuggerURL% /AppAutoCheckMode
exit
