//	Test de Diego Fazio

//	{% LoadHRB( '/lib/wdo/wdo.hrb' ) %}							//	Loading WDO lib
//	{% HB_SetEnv( 'WDO_PATH_MYSQL', "c:/xampp/htdocs/" ) %}	//	Usuarios Xampp

REQUEST DBFCDX

FUNCTION Main()
	local h, u, cHeader, cValues, cSql  
	local cDbf := hb_getenv( 'PRGPATH') + '/data/db.dbf'



   o := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "password", "harbourdb", 3306 )						   
	o:lLog := .t.
	o:lWeb := .f.	
	
   IF !o:lConnect

      ? o:cError
      QUIT

   ENDIF

   ? "Connecting DBF..."
   a =  hb_MilliSeconds()
   
   dbSelectArea( 1 )
   dbUseArea( .F., "DBFCDX", cDbf,, .T. )

   ?? 'OK ', hb_MilliSeconds() - a, 'ms' 

   
   ? "Connecting MySQL..."
   a =  hb_MilliSeconds()
   
   o := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "password", "harbourdb", 3306 )

   IF !o:lConnect

      ? o:cError
      QUIT

   ENDIF

   ?? 'OK ', hb_MilliSeconds() - a, 'ms' 
   
   dbGoTop()

   ? "Importing DBF..."
   a =  hb_MilliSeconds()
   
      cHeader := 'INSERT INTO db2 (KAR_RUBRO,KAR_FECHA,KAR_CLIE,KAR_TIPO,KAR_NUMERO,'
      cHeader += 'KAR_DEPO,KAR_CANT,KAR_PRECIO,KAR_DESCTO,KAR_VENDED,KAR_PIEZAS,'
      cHeader += 'KAR_ENTSAL,KAR_ARTIC ) VALUES '
	  
    DO WHILE !Eof()	  
	  
	  cValues := ''
	  n := 0 
	  
	  while n < 1000 .and. !Eof()
		cValues += '('	  	  	  
		  cValues += '"' + AllTrim( valtochar( Field->KAR_RUBRO ) ) + '",'
		  cValues += '"' + AllTrim( valtochar( hb_DtoC(Field->KAR_FECHA,'YYYY-MM-DD') ) )  + '",'
		  cValues += '"' + AllTrim( valtochar( Field->KAR_CLIE ) )   + '",'
		  cValues += '"' + AllTrim( valtochar( Field->KAR_TIPO ) )   + '",'
		  cValues += '"' + AllTrim( valtochar( Field->KAR_NUMERO ) ) + '",'
		  cValues += '"' + AllTrim( valtochar( Field->KAR_DEPO ) )   + '",'
		  cValues += '"' + AllTrim( valtochar( Field->KAR_CANT ) )   + '",'
		  cValues += '"' + AllTrim( valtochar( Field->KAR_PRECIO ) ) + '",'
		  cValues += '"' + AllTrim( valtochar( Field->KAR_DESCTO ) ) + '",'
		  cValues += '"' + AllTrim( valtochar( Field->KAR_VENDED ) ) + '",'
		  cValues += '"' + AllTrim( valtochar( Field->KAR_PIEZAS ) ) + '",'
		  cValues += '"' + AllTrim( valtochar( Field->KAR_ENTSAL ) ) + '",'
		  cValues += '"' + AllTrim( valtochar( Field->KAR_ARTIC )  ) + '" '
		cValues += '),'
		  n++ 
		  dbSkip()
	   end
	   
	   cValues := Substr( cValues, 1, len(cValues)-1 )
	   
	   cSql := cHeader + cValues 
	  
      o:Query( cSql ) 

    END DO


   ?? 'OK '
   ? "Total Importing time:" , hb_MilliSeconds() - a, "ms"

   cSql := "select count(*) as total from db2 "
   
   ? "Counting records with", cSql
   
   a =  hb_MilliSeconds()
   
   IF !Empty( hRes := o:Query( cSql) )

      ? 'Count(): ', o:Fetch_Assoc( hRes )[ 'total' ]
      ? "Total Counting time:" , hb_MilliSeconds() - a, "ms"

   ELSE

      ? "ERROR"

   ENDIF
   
retu    
   
   
   
   
   
   