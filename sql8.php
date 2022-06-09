//	----------------------------------------------------------------------------
//	Title......: WDO Web Database Objects
//	Description: Same example with php
//	Date.......: 09/06/2022
//	----------------------------------------------------------------------------

<?php

	//oConn := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
	$hLink = mysqli_connect( 'localhost', 'harbour', 'hb1234', 'dbHarbour', 3306 );

	$cSql  = "SELECT * FROM customer c " 
	$cSql .= "LEFT JOIN states s ON s.code = c.state " 
	$cSql .= "WHERE ( c.state = 'LA' OR c.state = 'AK' ) and c.age >= " + str(nMin) + " and c.age <= " + str( nMin+10) + " and c.married = 1 " 
	$cSql .= "ORDER by first "

	if ( $hRs = @mysqli_query( $hLink, $cSql ) ) {

		$nRecCount = mysqli_num_rows( $hRs );
		
		$aRow = mysqli_fetch_array( $hRes, MYSQLI_ASSOC );
	
	}
	
	

?>