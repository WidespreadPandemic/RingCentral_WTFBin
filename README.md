# RingCentral_WTFBin
Writeup on RingCentral as a WTFBin

Writeup for RingCentral being a WTFBin (https://wtfbins.wtf/). When you install/run RingCentral, it drops the .vbs script in this repo deep in Appdata under the installed user's profile that runs via cmd.exe calling cscript //Nologo to query, create, and modify registry entries to associate/register RingCentral with calls, faxes, videos, etc. Based on my experience, AVs/EDRs can and will trigger on this for things like AMSI/fileless malware, temporary file pointers, etc. 
