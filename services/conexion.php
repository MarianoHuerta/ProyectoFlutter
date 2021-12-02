<?php

$connect = new mysqli("localhost","vane","vane","dbtopicos");

if($connect){
	 
}else{
	echo "Fallo, revise ip o firewall";
	exit();
}