<?php
try {
    include 'conexion.php';

    $idDoctor = $_POST['IdDoctor'];
    $nombres = $_POST['Nombres'];
    $apellidos = $_POST['Apellidos'];
    $edad = $_POST['Edad'];
    $fechaNaci = $_POST['FechaNaci'];
    $idConsultorio = $_POST['IdConsultorio'];

    $stmt = $connect->prepare("INSERT INTO doctores (Nombres, Apellidos, Edad, FechaNaci, IdConsultorio) VALUES (?, ?, ?, ?, ?)");

    $stmt->bind_param("ssisi", $nombres, $apellidos, $edad, $fechaNaci, $idConsultorio);
    $stmt->execute();

    $stmt->close();
    $connect->close();

    echo json_encode(array("status" => true, "message" => "Doctor registrado"));
} catch (Exception $e) {
    echo json_encode(array("status" => false, "message" => "Error insertando: " . $e->getMessage()));
}
    
?>