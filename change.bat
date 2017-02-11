@if (@CodeSection == @Batch) @then
@echo off
setlocal
del tim.txt
echo START %TIME%>>tim.txt
del full.bak
del full2.bak
del full3.bak
for %%A in (*.vnt) do (
type %%A>>full.bak
Copy %%A alreadyread\%%A
del %%A

)
echo end of copy %TIME%>>tim.txt
findstr /R "=[0-9][0-9]" full.bak>>full2.bak
  @cscript //Nologo //E:jscript "%~f0" %CD% %* >>full3.bak
 
findstr /R "\-" full3.bak>>out.txt

del full.bak
del full2.bak
del full3.bak
echo Koniec %TIME%>>tim.txt
endlocal
pause

  exit
@end
function hex2a(hexx) {

    var hex = hexx.toString();//force conversion
	if (hex==""){return "";}
    var str = '';
    for (var i = 0; i < hex.length; i += 2)
        str += String.fromCharCode(parseInt(hex.substr(i, 2), 16));
    return str;
}

for (var i = 0, n = WScript.Arguments.Length, args = []; i < n; ++i){
    args.push(WScript.Arguments(i));}
var out="";

var fsoForReading=1
var filename=args[0]+"\\full2.bak"

var fso = new ActiveXObject("Scripting.FileSystemObject");
var f2 = fso.OpenTextFile(filename,fsoForReading,0);
var LoadStringFromFile = f2.ReadAll();

LoadStringFromFile = LoadStringFromFile.match(/=[0-9A-F][0-9A-F]/g);
var Tablen=LoadStringFromFile.length;
for(var j=0;j<Tablen;j+=1){

out=out+hex2a(LoadStringFromFile[j].replace(/=|(0A)|(0D)/g,""));
}

out=out.replace(/([0-9]+\s?\-)/g,"\r\n000$1");
out=out.replace(/000([0-9]{2}\s?\-)/g,"00$1");
out=out.replace(/000([0-9]{3}\s?\-)/g,"0$1");
out=out.replace(/000([0-9]{4}\s?\-)/g,"$1");
out=out.split("\r\n");

out=out.sort();
var Tabout=out.length;
for(var j=0;j<Tabout;j+=1){
//if (out[j]==""){continue;}
WScript.Echo(out[j]);
}

f2.Close();


