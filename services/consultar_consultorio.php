<?php 
    include 'conexion.php';

    $queryConsulta = $connect->query("SELECT IdConsultorio, Numero FROM Consultorios");

    $resultado = array();

    while($row = $queryConsulta->fetch_assoc()){
        $resultado[] = $row;
    }

    $connect->close();
    echo json_encode($resultado);
?>