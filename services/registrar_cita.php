<?php
    include 'conexion.php';

    $idCita = $_POST['idCita'];
    $fecha = $_POST['fecha'];
    $hora = $_POST['hora'];
    $situacion = $_POST['situacion'];
    $precio = $_POST['precio'];
    $idPaciente = $_POST['idPaciente'];
    $idDoctor = $_POST['idDoctor'];

    $stmt = $connect->prepare('INSERT INTO cita (Fecha, Hora, Situacion, Precio, IdPaciente, IdDoctor)
    VALUES (?, ?, ?, ?, ?, ?)');

    $stmt->bind_param("sssdii", $fecha, $hora, $situacion, $precio, $idPaciente, $idDoctor);
    $stmt->execute()();

    $stmt->close();

    echo json_encode('{msg: Cita registrada}');
?>