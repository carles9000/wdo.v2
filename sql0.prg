//	--------------------------------------------------------------
//	Title......: WDO Web Database Objects
//	Description: Test WDO
//	Date.......: 28/07/2019
//
//	{% mh_LoadHRB( '/lib/wdo/wdo.hrb' ) %}						//	Loading WDO lib
//	{% HB_SetEnv( 'WDO_PATH_MYSQL', "c:/xampp/htdocs/" ) %}	//	Usuarios Xampp
//	--------------------------------------------------------------

FUNCTION Main()

	LOCAL o			
		
		o := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
		
		IF o:lConnect
		
			? 'Connected !'
			? '<b>Version RDBMS MySql</b>', o:VersionName(), o:Version()
			
		ELSE 
		
			? 'Error : ', o:cError
			
		ENDIF

RETU NIL
