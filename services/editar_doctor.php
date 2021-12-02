<?php
try {
    include 'conexion.php';

    $idDoctor = $_POST['IdDoctor'];
    $nombres = $_POST['Nombres'];
    $apellidos = $_POST['Apellidos'];
    $edad = $_POST['Edad'];
    $fechaNaci = $_POST['FechaNaci'];
    $idConsultorio = $_POST['IdConsultorio'];

    $stmt = $connect->prepare("UPDATE doctores SET Nombres = ?, Apellidos = ?, Edad = ?, FechaNaci = ?, IdConsultorio = ? WHERE IdDoctor = ?");

    $stmt->bind_param("sssdii", $nombres, $apellidos, $edad, $fechaNaci, $idConsultorio);
    $stmt->execute();

    $stmt->close();
    $connect->close();

    echo json_encode(array("status" => true, "message" => "Doctor actualizada"));
} catch (Exception $e) {
    echo json_encode(array("status" => false, "message" => "Error editando: " . $e->getMessage()));
}
    
?>