(function(){var c=[[/RhoSimulator/,"rhosimulator"],[/Android/,"android"],[/iPhone|iPod|iPad/,"ios"],[/Windows\s+Phone/,"wp8"],[/Windows\s+(?:Mobile|CE)|WM [0-9]/,"wm"],[/Windows/,"win32"]];var b="";for(var a=0;a<c.length;++a){if(c[a][0].test(navigator.userAgent)){b=c[a][1];break}}if((b=="rhosimulator")||(b=="win32")){String.prototype.toLowerCase=function(d){return __rhoNativeApi.toLowerCase(this)}}})();