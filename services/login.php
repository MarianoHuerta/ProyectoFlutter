<?php

    include 'conexion.php';

    $username = $_REQUEST['Nombre'];
    $password = $_REQUEST['Contrasenia'];

    $consultar=$connect->query("SELECT * FROM usuarios WHERE Nombre='".$username."' and Contrasenia='".$password."'");

    $resultado=array();

    while($extraerDatos=$consultar->fetch_assoc()){
        $resultado[]=$extraerDatos;
    }

    echo json_encode($resultado);

    ?>