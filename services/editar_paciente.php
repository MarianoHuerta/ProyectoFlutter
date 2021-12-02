<?php
try {
    include 'conexion.php';

    $idPaciente = $_POST['IdPaciente'];
    $nombres = $_POST['Nombres'];
    $apellidos = $_POST['Apellidos'];
    $edad = $_POST['Edad'];
    $fechaNaci = $_POST['FechaNaci'];

    $stmt = $connect->prepare("UPDATE pacientes SET Nombres = ?, Apellidos = ?, Edad = ?, FechaNaci = ? WHERE IdPaciente = ?");

    $stmt->bind_param("sssdii", $nombres, $apellidos, $edad, $fechaNaci);
    $stmt->execute();

    $stmt->close();
    $connect->close();

    echo json_encode(array("status" => true, "message" => "Paciente actualizada"));
} catch (Exception $e) {
    echo json_encode(array("status" => false, "message" => "Error editando: " . $e->getMessage()));
}
    
?>