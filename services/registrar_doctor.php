<?php
    include 'conexion.php';

    $idDoctor = $_POST['idDoctor'];
    $nombres = $_POST['nombres'];
    $apellidos = $_POST['apellidos'];
    $edad = $_POST['edad'];
    $fechaNaci = $_POST['fechaNaci'];
    $idConsultorio = $_POST['idConsultorio'];

    $stmt = $connect->prepare('INSERT INTO Doctor (nombres, apellidos, edad, fechaNaci, idConsultorio)
    VALUES (?, ?, ?, ?, ?, ?)');

    $stmt->bind_param("sssdii", $nombres, $apellidos, $edad, $fechaNaci, $idConsultorio);
    $stmt->execute()();

    $stmt->close();

    echo json_decode('{msg: Doctor registrada}');
?>