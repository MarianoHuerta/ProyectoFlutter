<?php
try {
    include 'conexion.php';

    $fecha = $_POST['Fecha'];
    $hora = $_POST['Hora'];
    $situacion = $_POST['Situacion'];
    $precio = $_POST['Precio'];
    $idPaciente = $_POST['IdPaciente'];
    $idCita = $_POST['IdCita'];

    $stmt = $connect->prepare("UPDATE citas SET Fecha = ?, Hora = ?, Situacion = ?, Precio = ?, IdPaciente = ? WHERE IdCita = ?");

    $stmt->bind_param("sssdii", $fecha, $hora, $situacion, $precio, $idPaciente, $idCita);
    $stmt->execute();

    $stmt->close();
    $connect->close();

    echo json_encode(array("status" => true, "message" => "Cita actualizada"));
} catch (Exception $e) {
    echo json_encode(array("status" => false, "message" => "Error editando: " . $e->getMessage()));
}
    
?>