<?php
try {
    include 'conexion.php';
    
    
    $idConsultorio = $_POST['IdConsultorio'];
    $numero = $_POST['Numero'];

    $stmt = $connect->prepare("UPDATE consultorios SET Numero = ? WHERE IdConsultorio = ?");

    $stmt->bind_param("si", $numero, $idConsultorio);
    $stmt->execute();

    $stmt->close();
    $connect->close();

    echo json_encode(array("status" => true, "message" => "Consultorio actualizada"));
} catch (Exception $e) {
    echo json_encode(array("status" => false, "message" => "Error editando: " . $e->getMessage()));
}
    
?>