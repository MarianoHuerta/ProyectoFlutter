<?php 
    include 'conexion.php';

    $queryConsulta = $connect->query("SELECT IdCita, Fecha, Hora, Situacion, Precio, IdPaciente, IdDoctor FROM citas");

    $resultado = array();

    while($row = $queryConsulta->fetch_assoc()){
        $resultado[] = $row;
    }

    echo json_encode($resultado);
?>