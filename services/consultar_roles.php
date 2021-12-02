<?php 
    include 'conexion.php';

    $queryConsulta = $connect->query("SELECT IdRol, Nombre FROM roles");

    $resultado = array();

    while($row = $queryConsulta->fetch_assoc()){
        $resultado[] = $row;
    }

    $connect->close();
    echo json_encode($resultado);
?>