<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<title>Presupuestos</title>
<style type="text/css">
	#fsCeros{ 
		display: block;
		margin: 0 auto;
		width:70%;
	  	border-radius: 5px;
  		background-color: #f2f2f2;
  		padding: 40px; 
  		margin-top: 40px;
  	}
	#fsDisponible{ 
		display: none;
		margin: 0 auto;
		width:70%;
	  	border-radius: 5px;
  		background-color: #f2f2f2;
  		padding: 40px; 
  		margin-top: 40px;
	 }
</style>
</head>
<body>
	<input type="hidden" id="hdnSaldo" value="0" />
	<form id="fsCeros">
		<div class="form-group">
			<h1>Administrador de Presupuestos</h1>
		</div>
		<div class="form-group">
			<label for="iSaldo">Presupuesto máximo</label>
			<input type="number" id="iSaldo" class="form-control" value="0" style="width: 40%;" />
		</div>
		<div class="form-group">
			<input type="text" id="iDescripcion" class="form-control" placeholder="Captura una descripción.." /><br />
		</div>
		<div class="form-group">
			<input id="btnDefinir" type="button" class="btn btn-primary" value="Aceptar" />
		</div>
	</form>
	<form id="fsDisponible">
		<div class="form-group">
			<h1>Administrador de Presupuestos</h1>
		</div>
		<div class="form-group">
			<legend>  <span id="spnSaldo"></span></legend>
		</div>
		<div class="form-group">
			<input type="number" id="iCantidad" value="0" placeholder="Cantidad" />&nbsp;
		</div>
		<div class="form-group">
			<input type="radio" name="rdTipo" id="rdCargo" value="C" checked /><label for="rdCargo">Cargo</label>&nbsp;
			<input type="radio" name="rdTipo" id="rdAbono" value="A" /><label for="rdAbono">Abono</label><br />
		</div>
				<div class="form-group">
			<input type="text" id="iFechaMovimiento" class="form-control" placeholder="Fecha.." style="width: 40%;" /><br />
		</div>
		<div class="form-group">
			<input type="text" id="iDescripcionMovimiento" class="form-control" placeholder="Descripción.." style="width: 40%;" /><br />
		</div>
		<div class="form-group">
			<input type="text" id="iReferenciaMovimiento" class="form-control" placeholder="Referencia.." style="width: 40%;" /><br />
		</div>
		<div class="form-group">
			<input type="button" id="btnOk" class="btn btn-primary" value="Agregar movimiento" />
		</div>
		<table id="tabla" class="table table-hover">
			<thead>
				<tr>
					<th scope="col">Fecha de Registro</th>
		    		<th scope="col">Descripción</th>
		    		<th scope="col">Referencia</th>
		    		<th scope="col">Tipo</th>
		    		<th scope="col">Cantidad</th>
	  			</tr>
  			</thead>
		</table>
			
	</form>
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
					console.error(info);rdTipo
				}
			});
		});


		
		$("#btnOk").click(function(){
			$.ajax({
				url: 'PresupuestosControl',	
				data: {
					'tipo': $("input[name='rdTipo']:checked").val(),
					'cantidad': $("#iCantidad").val(),
					'saldo': $("#hdnSaldo").val(),
					'fecha': $("#iFechaMovimiento").val(),
					'descripcion': $('#iDescripcionMovimiento').val(),
					'referencia': $('#iReferenciaMovimiento').val()
					},
				type: "post",
				dataType: "text",
				async: true,
				success: function(responseText){
					
					var tipo = $("input[name='rdTipo']:checked").val();
					var fecha = "fechadefault";
					var tipoMov = "Abono";
					if (tipo == 'C'){
						tipoMov= "Cargo"
					} 
					$('#tabla').html($('#tabla').html() + "<tr>" + "<th>" +$('#iFechaMovimiento').val() + "</th>" + "<th>" + $('#iDescripcionMovimiento').val() + "</th>" + "<th>" + $('#iReferenciaMovimiento').val()+ "</th>" +"<th>" + tipoMov + "</th>"   +"<th>" + $("#iCantidad").val() + "</th>"  + "<tr />")
					
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