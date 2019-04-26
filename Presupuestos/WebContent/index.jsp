<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Presupuestos</title>

<style type="text/css">
	#fsCeros{ display: block; }
	#fsDisponible{ display: none; }
</style>
</head>
<body>
	<input type="hidden" id="hdnSaldo" value="0" />
	<fieldset id="fsCeros">
		<legend>Presupuesto máximo</legend>
		
		<input type="number" id="iSaldo" value="0" placeholder="Cantidad" /><br />
		<input type="button" id="btnDefinir" value="Aceptar" />
	</fieldset>
	<fieldset id="fsDisponible">
		<legend>Saldo: <span id="spnSaldo"></span></legend>
		<input type="number" id="iCantidad" value="0" placeholder="Cantidad" /><br />
		<input type="radio" name="rdTipo" id="rdCargo" value="C" checked /><label for="rdCargo">Cargo</label>&nbsp;
		<input type="radio" name="rdTipo" id="rdAbono" value="A" /><label for="rdAbono">Abono</label><br />
		<input type="button" id="btnOk" value="Aceptar" />
	</fieldset>
</body>
	
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(document).ready(function(){
		$("#btnDefinir").click(function(){
			$.ajax({
				url: 'PresupuestosControl',	
				data: {
					'tipo': 'A',
					'saldo': $("#hdnSaldo").val(),
					'cantidad': $("#iSaldo").val()
				},
				type: "post",
				dataType: "text",
				async: true,
				success: function(responseText){
					var Obj = JSON.parse(responseText);

					$("#hdnSaldo").val(Obj.saldo);
					$('#spnSaldo').html(Obj.mensaje);
					$("#fsCeros").hide();
					$("#fsDisponible").show();
				},
				error: function(info){
					console.error(info);
				}
			});
		});
		
		$("#btnOk").click(function(){
			$.ajax({
				url: 'PresupuestosControl',	
				data: {
					'tipo': $("input[name='rdTipo']:checked").val(),
					'cantidad': $("#iCantidad").val(),
					'saldo': $("#hdnSaldo").val()
				},
				type: "post",
				dataType: "text",
				async: true,
				success: function(responseText){
					var Obj = JSON.parse(responseText);
					
					$('#spnSaldo').html(Obj.mensaje);
					$('#hdnSaldo').val(Obj.saldo);
					$("#iCantidad").val('0');
				},
				error: function(info){
					console.error(info);
				}
			});
		});
	});
</script>
</html>