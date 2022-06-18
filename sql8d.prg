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
	//	Forzar reconexion 
	//	-----------------------------------------------------------------------
	//	El objetivo es crear una reconexion en caso de caida de una conexion 
	//	de nuestro pool. El 3 parametro de la funcion a .T. fuerza una reconexion
	//	para esta VM.
	//	Para comprobar el sistema:
	//		- Ejecutamos el ejemplo y nos aparecera un resultado
	//		- Apagamos el server mysql y lo volvemos a conectar. (en persistencia
	//			tenemos una conexion antigua)
	//		- Ejecutamos de nuevo y el sistema nos tiene de mostrar el error, y en 
	//			este caso volvemos a forzar la reconexion
	//		- La siguiente peticion habria de funcionar
	//	Podemos gestionar este error de la manera que queramos. Quizas no queremos
	//	hacer nada, reconectar y en el mismo request responder, solo reconectar,...
	//	-----------------------------------------------------------------------	

		o := mh_Pool( 'mysql_dbharbour', {|| MyOpen() } )
		
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
	
			//o:View( o:DbStruct(),	aData )			
			
			while ! empty( aData := o:Fetch_Assoc( hRes ) )		//	o:Fetch( hRes )	
			
				? aData
				//ap_echo( hb_JsonEncode( aData, .T. ) )								
			end 
			
		ELSE
		
			//	Si yo tengo un error usando el pool de conexiones, forzaré una nueva conexion
			//	If I have an error using the connection pool, I will force a new connection
			
			if !empty( o:cError )
			
				? '<hr><h3>' + o:cError + '</h3>Reconnected system mysql...'
				
				mh_Pool( 'mysql_dbharbour', {|| MyOpen() }, .t. )
				
				//	Si la conexion se ha realizado con exito, en la proxima conexion se usara correctamente
				//	If the connection has been made successfully, in the next connection it will be used correctly
				
			endif 

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
