format PE console
include '%fasminc%/win32wxp.inc'
entry Start
section '.idata' import readable writeable
library kernel32, 'KERNEL32.DLL', \
 msvcrt, 'MSVCRT.DLL'
import kernel32, ExitProcess, 'ExitProcess'
import msvcrt, printf, 'printf', scanf, 'scanf'
section '.data' data readable writeable
dSpec db '%d',0
sSpec db '%s',0
Stroka db 100 dup(?)
Privet db "Vvedite Stroku Bez Probelov: ", 0x0D,
0x0A, 0
section '.text' code readable executable
proc GetStrNum uses ebx ecx, strAddr:Dword
 mov ebx, [strAddr]
 xor eax, eax
 xor ecx, ecx
 dec ebx
Cycle:
 inc ebx
 cmp byte[ebx],0
 je Ending
 cmp byte[ebx],'0'
 jae Shag
 loop Cycle
Shag:
 cmp byte[ebx],'9'
 jbe Incr
 loop Cycle
Incr:
 inc eax
 loop Cycle
Ending:
 ret
 endp
Start:
 cinvoke printf, Privet
 cinvoke scanf, sSpec, Stroka
 stdcall GetStrNum, Stroka
 cinvoke printf, dSpec, eax
 invoke ExitProcess, dword 0