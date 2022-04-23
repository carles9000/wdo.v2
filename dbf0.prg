//	--------------------------------------------------------------
//	Title......: WDO Web Database Objects
//	Description: Test WDO
//	Date.......: 28/07/2019
//
//	{% mh_LoadHRB( '/lib/wdo/wdo.hrb' ) %}	//	Loading WDO lib
//	--------------------------------------------------------------

FUNCTION Main()

	LOCAL o
	
		? "<b>==> Test Error de conexion...</b><br>"
	
		o := WDO():Dbf( 'customer.dbf' )
		
		IF o:lConnect
		
			? 'Connected !'
			
		ENDIF

RETU NIL
