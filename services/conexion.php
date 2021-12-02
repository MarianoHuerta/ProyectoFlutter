<?php

$connect = new mysqli("localhost","root","","dbtopicos");

if($connect->connect_error){
	echo "Fallo, revise ip o firewall";
    die("Conexión fallida: " . $connect->connect_error);
	exit();
}