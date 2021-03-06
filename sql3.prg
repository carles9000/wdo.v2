//	--------------------------------------------------------------
//	Title......: WDO Web Database Objects
//	Description: Test WDO
//	Date.......: 28/07/2019
//
//	{% mh_LoadHRB( '/lib/wdo/wdo.hrb' ) %}							//	Loading WDO lib
//	{% HB_SetEnv( 'WDO_PATH_MYSQL', "c:/xampp/htdocs/" ) %}	//	Usuarios Xampp
//	--------------------------------------------------------------

FUNCTION Main()

	LOCAL o, oRs
	
		o := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )		

		
		IF ! o:lConnect		
			? 'Error : ', o:cError
			RETU NIL
		ENDIF

		
		IF !empty( hRes := o:Query( 'select * from sellers' ) )
		
			aData := o:FetchAll( hRes )
			
			o:View( o:DbStruct(),	aData )
			
			o:Free_Result( hRes )
		
		ENDIF			

RETU NIL