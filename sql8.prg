//	--------------------------------------------------------------
//	Title......: WDO Web Database Objects
//	Description: Test WDO
//	Date.......: 28/07/2019
//
//	{% mh_LoadHRB( '/lib/wdo/wdo.hrb' ) %}							//	Loading WDO lib
//	{% HB_SetEnv( 'WDO_PATH_MYSQL', "c:/xampp/htdocs/" ) %}	//	Usuarios Xampp
//	--------------------------------------------------------------

//	Test Persistence V2 
//	Check DbWin console


FUNCTION Main()

	LOCAL o, oRs, hRes

		o := MyConnect()
	
		o := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )		
		
		
		IF ! o:lConnect		
			RETU NIL
		ENDIF
		
		?? '<h3>Data Base Customer</h3><hr>'
		
		cSql 	:= "SELECT count(*) as total FROM customer"
		
		hRes 	:= o:Query( cSql  )
		oRs 	:= o:Fetch_Assoc( hRes )
		
		? '<b>Registros Totales: </b>', oRs[ 'total' ]		
	

		cSql := "SELECT * FROM customer c " +;
		        "LEFT JOIN states s ON s.code = c.state " +;
				"WHERE ( c.state = 'LA' OR c.state = 'AK' ) and c.age >= 58 and c.age <= 60 and c.married = 1 " +;
				"ORDER by first	"		
				
				
		? '<br><b>Sql: </b>' , cSql
		
		IF !empty( hRes := o:Query( cSql  ) )
		
			? '<br><b>Total Select: </b>', o:Count( hRes )
		
			aData := o:FetchAll( hRes )

			o:View( o:DbStruct(),	aData )
		
		ENDIF				
		
		
RETU NIL

function MyConnect()

	local oConn 

    IF mh_HashGet( 'oMySql' ) != NIL

		oConn := mh_HashGet( 'oMySql' )
		
		_d( 'Recover connexion from persistence system' )
				
    ELSE			
		
		oConn := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
		
		IF ! oConn:lConnect
			? 'Error: ', oConn:mysql_error()		
			RETU NIL
		ENDIF
		
		mh_HashSet( 'oMySql', oConn )	
		
		_d( 'Create connexion and save in persistence' )
		
    ENDIF	

retu oConn 