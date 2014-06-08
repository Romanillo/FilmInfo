var assert = chai.assert; 

suite( 'Parser', function(){
alert("Suite!");
  test('Titulo: ', function(){
  alert("test!");
	var entrada = 'TITULO Prueba;.';
	alert("entrada!");
    var result = FilmInfo.parse(entrada);
	alert("result!");
	var esperado = '<!DOCTYPE html> <br> <html>         <br> <head>          <br> <title> FilmInfo </title> <br> <meta http-equiv="Content-type" content="text/html" ;="" charset="UTF-8"> <br> <style> <br> body {background-color:"#FFC77D";} <br> h1 {text-align:center;} <br> </style> </head> <br> <body> <br>   <h1>Prueba</h1> <br> </body> <br> </html> ';
    alert("esperado!");
	assert.deepEqual(JSON.stringify(result,undefined,2), esperado);
	alert("json!");
  });
  alert("test!");

});

alert("Acaban los test!");