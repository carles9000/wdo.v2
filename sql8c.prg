//	----------------------------------------------------------------------------
//	Title......: WDO Web Database Objects
//	Description: Test WDO
//	Date.......: 28/07/2019
//
//	{% mh_LoadHRB( '/lib/wdo/wdo.hrb' ) %}					//	Loading WDO lib
//	{% HB_SetEnv( 'WDO_PATH_MYSQL', "c:/xampp/htdocs/" ) %}	//	Usuarios Xampp
//	----------------------------------------------------------------------------

FUNCTION Main()

	LOCAL o, cSql, oRs, hRes
	LOCAL nMin := HB_RandomInt( 1, 100 )


		o := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
		
	//	-----------------------------------------------------------------------	
	
		? '<b>Version V2:</b> ', mh_modversion()
		? '<b>Version WDO:</b> ', wdo_version()
		
		cSql := "SELECT * FROM customer c " +;
		        "LEFT JOIN states s ON s.code = c.state " +;
				"WHERE ( c.state = 'LA' OR c.state = 'AK' ) and c.age >= " + str(nMin) + " and c.age <= " + str( nMin+10) + " and c.married = 1 " +;
				"ORDER by first	"										
				
		? '<br><b>Sql: </b>' , cSql
		
		IF !empty( hRes := o:Query( cSql  ) )
	
			? '<br><b>Total Select: </b>', o:Count( hRes )		
			
			while ! empty( aData := o:Fetch_Assoc( hRes ) )		//	o:Fetch( hRes )	
			
				? aData										
			end 

		ENDIF

		o:exit()
		
RETU NIL

//	--------------------------------------------------------------------------------------	//
