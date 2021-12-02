<?php
try {
    include 'conexion.php';
	
	$IdPaciente= $_POST['IdPaciente'];
	$Nombres = $_POST['Nombres'];
	$Apellidos = $_POST['Apellidos'];
	$Edad = $_POST['Edad'];
	$FechaNaci = $_POST['FechaNaci'];
	

     $stmt = $connect->prepare("INSERT INTO pacientes (Nombres, Apellidos, Edad, FechaNaci) VALUES (?, ?, ?, ?)");

    $stmt->bind_param("ssis",$Nombres, $Apellidos, $Edad, $FechaNaci );
    $stmt->execute();

    $stmt->close();
    $connect->close();

    echo json_encode(array("status" => true, "message" => "Paciente registrado"));
} catch (Exception $e) {
    echo json_encode(array("status" => false, "message" => "Error insertando: " . $e->getMessage()));
}
    
?>