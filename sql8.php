<?php

/*	----------------------------------------------------------------------------
	Title......: WDO Web Database Objects
	Description: Same example with php
	Date.......: 09/06/2022
	---------------------------------------------------------------------------- */


	$nAge  = random_int( 1, 99 );

	//oConn := WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )
	$hLink = mysqli_connect( 'localhost', 'harbour', 'hb1234', 'dbHarbour', 3306 );
	

	$cSql  = "SELECT * FROM customer c " ;
	$cSql .= "LEFT JOIN states s ON s.code = c.state " ;
	$cSql .= "WHERE ( c.state = 'LA' OR c.state = 'AK' ) and c.age >= " . $nAge .  " and c.age <= " . ( $nAge+10) . " and c.married = 1 " ;
	$cSql .= "ORDER by first ";
	
	echo '<b>Sql: </b>' . $cSql;

	if ( $hRs = @mysqli_query( $hLink, $cSql ) ) {

		$nRecCount = mysqli_num_rows( $hRs );		
		
		echo '<br><b>Total Select: </b>' . $nRecCount . '<br>';				
		
		while ( $aRow = mysqli_fetch_array( $hRs, MYSQLI_ASSOC ) ) {
		
			echo print_r( $aRow, true );
			echo '<br>';
			
		}		
	
	}
	
	

?>