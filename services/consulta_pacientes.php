<?php 
    include 'conexion.php';

    $queryConsulta = $connect->query("SELECT IdPaciente, Nombres, Apellidos, Edad, FechaNaci FROM pacientes");

    $resultado = array();

    while($row = $queryConsulta->fetch_assoc()){
        $resultado[] = $row;
    }

    $connect->close();
    echo json_encode($resultado);
?>