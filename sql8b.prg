//	----------------------------------------------------------------------------
//	Title......: WDO Web Database Objects
//	Description: Test WDO
//	Date.......: 28/07/2019
//
//	{% mh_LoadHRB( '/lib/wdo/wdo.hrb' ) %}					//	Loading WDO lib
//	{% HB_SetEnv( 'WDO_PATH_MYSQL', "c:/xampp/htdocs/" ) %}	//	Usuarios Xampp
//	----------------------------------------------------------------------------
//	Test Persistence V2 
//	Check DbWin console
//
//	You can test persistence of this way:
//	c:\xampp\apache\bin\ab -n100 -c10 -l localhost/master/wdo.v2/sql8.prg
//	----------------------------------------------------------------------------


FUNCTION Main()

	LOCAL o, cSql, oRs, hRes
	LOCAL nMin := HB_RandomInt( 1, 100 )
	
	//	-----------------------------------------------------------------------
	//	Este ejemplo complementa el sql8.prg
	//	El onjetivo es ver como este programa puede usar el mismo pool que otro
	//	sin ningún problema. 
	//	Lo único ha saber es que si quieres usar el mismo pool, la conexión 
	//	apunta a una BD. En el caso de que necesitaras tener acceso a otra BD
	//	habrias de crear otra conexión o pool
	//	-----------------------------------------------------------------------
	
		o := mh_Pool( 'mysql_dbharbour', {|| MyOpen() } )
		
	//	-----------------------------------------------------------------------	

		? '<b>Version WDO:</b> ', wdo_version()
	
		cSql := "SELECT * FROM customer where age = " + str( nMin ) 

		? '<br><b>Sql: </b>' , cSql
		
		IF !empty( hRes := o:Query( cSql  ) )
		
			? '<br><b>Total Select: </b>', o:Count( hRes )					
		
		ENDIF						
		
RETU NIL

//	--------------------------------------------------------------------------------------	//

function MyOpen() 

	local oConn := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
	
	IF ! oConn:lConnect
		? 'Error: ', oConn:mysql_error()		
		retu nil
	ENDIF			
	
retu oConn  
