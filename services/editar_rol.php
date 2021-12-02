<?php
try {
    include 'conexion.php';
    
    
    $idRol = $_POST['IdRol'];
    $nombre = $_POST['Nombre'];

    $stmt = $connect->prepare("UPDATE roles SET Nombre = ? WHERE IdRol = ?");

    $stmt->bind_param("si", $nombre, $idRol);
    $stmt->execute();

    $stmt->close();
    $connect->close();

    echo json_encode(array("status" => true, "message" => "Rol actualizada"));
} catch (Exception $e) {
    echo json_encode(array("status" => false, "message" => "Error editando: " . $e->getMessage()));
}
    
?>