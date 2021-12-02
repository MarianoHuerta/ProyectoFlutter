<?php
try {
    include 'conexion.php';
	
	$IdRol= $_POST['IdRol'];
	$Nombre = $_POST['Nombre'];
	

     $stmt = $connect->prepare("INSERT INTO roles (Nombre) VALUES (?)");

    $stmt->bind_param("s", $Nombre );
    $stmt->execute();

    $stmt->close();
    $connect->close();

    echo json_encode(array("status" => true, "message" => "Rol registrado"));
} catch (Exception $e) {
    echo json_encode(array("status" => false, "message" => "Error insertando: " . $e->getMessage()));
}
    
?>