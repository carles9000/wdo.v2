/*
 * Harbour 3.2.0dev (r2104281802)
 * Microsoft Visual C 19.27.29112 (64-bit)
 * Generated C source from "z.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( XXX );
HB_FUNC_EXTERN( TIME );


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_Z )
{ "XXX", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( XXX )}, NULL },
{ "TIME", {HB_FS_PUBLIC}, {HB_FUNCNAME( TIME )}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_Z, "z.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_Z
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_Z )
   #include "hbiniseg.h"
#endif

HB_FUNC( XXX )
{
	static const HB_BYTE pcode[] =
	{
		36,2,0,176,1,0,20,0,7
	};

	hb_vmExecute( pcode, symbols );
}

