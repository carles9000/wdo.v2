/*
	cName - Name pool connect, ex. "mysql" 
	bInit - If connect don't exist, you can execute bInit to initialitate...
	
	example: sql8.prg
*/


function mh_Pool( cName, bInit )

	local nVM 	:= mh_UsedVm()
	local o		:= nil
	local cVM, hPool 
	
	DEFAULT cName TO ''
	DEFAULT bInit TO {|| nil }
	
	if empty( cName )
		retu nil 
	endif		

//_d( 'VM ' + str(nVM+1) )	

	if nVM >= 0 
	
		nVM++
	
		cVM 	:= 'VM' + ltrim(str( nVM ))

		hPool 	:= mh_HashGet( cName )
		
		//	Si no es un hash inicializamos...

			if valtype( hPool ) <> 'H'
				hPool := {=>}
				mh_HashSet( cName, hPool )
//_d( 'Inicio HASH para => ' + cVM)				
			endif	

		//	Si no existe objeto en la VM daremos de alta
		
			if HB_HHasKey( hPool, cVM )
			
//_d( 'Recupera objeto de => ' + cVM )			

				o := hPool[ cVM ]
				
			else 
			
//_d( 'Inicio conexion => ' + cVM )	

				o := eval( bInit )
				
				if !( o == NIL )
				
					hPool[ cVM ] := o					
				
					mh_HashSet( cName, hPool )										

				else 
				
//_d( 'error 2')
				
				endif
				
			endif				
	
	else 
	
	//	Si VM es -1 crearemos conexion pero no la guardamos
	
//_d( 'Creamos Conexion fuera de VM => ' + cVM )	

		o := eval( bInit )		

	endif 

retu o