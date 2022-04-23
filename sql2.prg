//	--------------------------------------------------------------
//	Title......: WDO Web Database Objects
//	Description: Test WDO
//	Date.......: 28/07/2019
//
//	{% mh_LoadHRB( '/lib/wdo/wdo.hrb' ) %}							//	Loading WDO lib
//	{% HB_SetEnv( 'WDO_PATH_MYSQL', "c:/xampp/htdocs/" ) %}		//	Usuarios Xampp
//	--------------------------------------------------------------

FUNCTION Main()

	LOCAL o, oRs
	LOCAL n, j
	
		o := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )		
		o:bError := {|cError| MyError( cError ) }
		
		IF ! o:lConnect					
			RETU NIL
		ENDIF
		
		? "MySQL version: " + o:mysql_get_server_info() 
		
		//	Generate error
		
		? "<hr><b>==> Generate error</b>"
		? "<b>==> Fetch  Query( 'select * from customerZZZ where age > 98 and state = 'NY' ') </b>"
		
		IF !empty( hRes := o:Query( "select * from customerzzz where age > 98 and state = 'NY' " ) )
		
			WHILE ( !empty( oRs := o:Fetch( hRes ) ) )
				? mh_valtochar( oRs )
			END
			
			o:Free_Result( hRes )
		
		ENDIF			
		
		? "<hr><b>==> Fetch_Assoc  Query( 'select * from customer where age > 98 and state = 'NY' ')</b>"
		
		IF !empty( hRes := o:Query( "select * from customer where age > 98 and state = 'NY' "  ) )
		
			WHILE ( !empty( oRs := o:Fetch_Assoc( hRes ) ) )
				? mh_valtochar( oRs )
			END
			
			o:Free_Result( hRes )
		
		ENDIF		
		
		
		? "<hr><b>==> DbStruct()</b>"
		
			aSt := o:DbStruct()
			
			for n := 1 TO len( aSt )
				? aSt[n][1], aSt[n][2]
			next		
		
		
		? "<hr><b>==> Error  Query( 'select * from ZZZ' )</b>"
		
		o:Query( 'select * from ZZZ' ) 		// ERROR 			

		? "<hr><b>==> FetchAll Query( 'select * from customer where age > 98 and state = 'NY' ') </b>"
		
		IF !empty( hRes := o:Query( "select * from customer where age > 98 and state = 'NY' "  ) )
		
			aData := o:FetchAll( hRes )
			

			for n := 1 to len( aData )
			
				? 'Reg: ' + ltrim(str(n))
			
				for j := 1 to len( aData[n] )
					?? aData[n][j]
				next			
			
			next
			
			o:Free_Result( hRes )
			
			//	Nice print...
			
			o:View( aSt, aData )
		
		ENDIF			
		
RETU NIL


FUNCTION MyError( cError ) 

	?  '<br>'
	?? '<div style="background-color:lightgray;border:1px solid gray">'
	?? '<h3><b>Mi Gestor de Error</b></h3>'
	?? '<h4>' + cError + '</h4>'
	?? '</div>'

RETU NIL