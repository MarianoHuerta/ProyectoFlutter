<?php
try {
    include 'conexion.php';
	
	
	$IdUsuario = $_POST['IdUsuario'];
	$Nombre = $_POST['Nombre'];
	$Contrasenia = $_POST['Contrasenia'];
	$IdRol = $_POST['IdRol'];

     $stmt = $connect->prepare("INSERT INTO Usuarios (Nombre,Contrasenia,IdRol) VALUES (?, ?, ?)");

    $stmt->bind_param("ssi",$Nombre , $Contrasenia , $IdRol );
    $stmt->execute();

    $stmt->close();
    $connect->close();

    echo json_encode(array("status" => true, "message" => "Usuario registrado"));
} catch (Exception $e) {
    echo json_encode(array("status" => false, "message" => "Error insertando: " . $e->getMessage()));
}
    
?>