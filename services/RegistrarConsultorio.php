<?php
try {
    include 'conexion.php';
	
	$IdConsultorio= $_POST['IdConsultorio'];
	$Numero = $_POST['Numero'];
	

     $stmt = $connect->prepare("INSERT INTO consultorios (Numero) VALUES (?)");

    $stmt->bind_param("i", $Numero );
    $stmt->execute();

    $stmt->close();
    $connect->close();

    echo json_encode(array("status" => true, "message" => "consultorios registrado"));
} catch (Exception $e) {
    echo json_encode(array("status" => false, "message" => "Error insertando: " . $e->getMessage()));
}
    
?>