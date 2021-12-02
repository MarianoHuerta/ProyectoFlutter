<?php 
    include 'conexion.php';

    $queryConsulta = $connect->query("SELECT IdCita, Fecha, Hora, Situacion, Precio, c.IdPaciente, IdDoctor, p.Nombres as 'NombresP', p.Apellidos as 'ApellidosP', p.Edad as 'EdadP' FROM citas c INNER JOIN pacientes p ON c.IdPaciente = p.IdPaciente");

    $resultado = array();

    while($row = $queryConsulta->fetch_assoc()){
        $resultado[] = $row;
    }

    $connect->close();
    echo json_encode($resultado);
?>