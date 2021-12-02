<?php
try {
    include 'conexion.php';

    $idCita = $_POST['IdCita'];
    $fecha = $_POST['Fecha'];
    $hora = $_POST['Hora'];
    $situacion = $_POST['Situacion'];
    $precio = $_POST['Precio'];
    $idPaciente = $_POST['IdPaciente'];
    $idDoctor = $_POST['IdDoctor'];

    $stmt = $connect->prepare("INSERT INTO citas (Fecha, Hora, Situacion, Precio, IdPaciente, IdDoctor) VALUES (?, ?, ?, ?, ?, ?)");

    $stmt->bind_param("sssdii", $fecha, $hora, $situacion, $precio, $idPaciente, $idDoctor);
    $stmt->execute();

    $stmt->close();
    $connect->close();

    echo json_encode(array("status" => true, "message" => "Cita registrada"));
} catch (Exception $e) {
    echo json_encode(array("status" => false, "message" => "Error insertando: " . $e->getMessage()));
}
    
?>