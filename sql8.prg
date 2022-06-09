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
	//	Sobre MySql
	//	-----------------------------------------------------------------------
	//	El cliente C de mysql tiene una limitacion que NO es thread safe, o sea 
	//	no puede ser concurrente. En el caso de que en algun momento haya mas 
	//	de alguna accion con el mismo identificador de la conexion nos puede 
	//	dar error. 
	//
	//	Afortunadamente con V2 podemos tener nuestra persistencia entre VMs. 
	//	Esto nos permite tener un control por ejemplo con un pool de conexiones.
	//	Para poder gestionar nuestra conexion de mysql, usaremos la funcion:
	//
	//	mh_Pool( <cPool_Name>, <bInit> )
	//
	//	Esta funciona buscará en nuestro pool de conexiones <cPool_Name>, si esta
	//	vacio ejecutará en codeblock <bInit> para inicializar la conexion o lo 
	//	que deseemos.
	//	-----------------------------------------------------------------------	

		o := mh_Pool( 'mysql_dbharbour', {|| MyOpen() } )
		
	//	-----------------------------------------------------------------------	
	
		? '<b>Version WDO:</b> ', wdo_version()
		
		cSql := "SELECT * FROM customer c " +;
		        "LEFT JOIN states s ON s.code = c.state " +;
				"WHERE ( c.state = 'LA' OR c.state = 'AK' ) and c.age >= " + str(nMin) + " and c.age <= " + str( nMin+10) + " and c.married = 1 " +;
				"ORDER by first	"										
				
		? '<br><b>Sql: </b>' , cSql
		
		IF !empty( hRes := o:Query( cSql  ) )
		
			? '<br><b>Total Select: </b>', o:Count( hRes )
		
			//o:View( o:DbStruct(),	aData )
			
			while ! empty( aData := o:Fetch( hRes ) )			
			
				? aData
				
			end 
		
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
