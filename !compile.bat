set name=Open-GTO Compile
compiler\pawncc.exe -;+ -(+ -icompiler/includes -isources -isources/lib/protection -d2 -ogamemodes/%name%.amx sources/%name%.pwn
pause
