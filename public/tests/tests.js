var assert = chai.assert; 

suite( 'Parser', function(){
  test('Titulo: ', function(){
	var entrada = "TITULO Prueba;.";
    var result = FilmInfo.parse(entrada);
	var esperado = "<!DOCTYPE html> <br> <html>         <br> <head>          <br> <title> FilmInfo </title> <br> <meta http-equiv='Content-type' content='text/html' ;='' charset='UTF-8'> <br> <style> <br> body {background-color:'#FFC77D';} <br> h1 {text-align:center;} <br> </style> </head> <br> <body> <br>   <h1>Prueba</h1> <br> </body> <br> </html> ";
	assert.deepEqual(JSON.stringify(result,undefined,2), esperado);
  });
  
  test('Informacion: ', function(){
	var entrada = "INFORMACION; * nombre:prueba;.";
    var result = FilmInfo.parse(entrada);
	var esperado = "<!DOCTYPE html> <br> <html>         <br> <head>          <br> <title> FilmInfo </title> <br> <meta http-equiv='Content-type' content='text/html' ;='' charset='UTF-8'> <br> <style> <br> body {background-color:'#FFC77D';} <br> h1 {text-align:center;} <br> </style> </head> <br> <body> <br>   <br><div class='separator' style='clear: both; text-align: center;'><a href='http://imageshack.us/a/img46/6905/fichatecnicax.png' imageanchor='1' style='margin-left: 1em; margin-right: 1em;'><img src='http://imageshack.us/a/img46/6905/fichatecnicax.png' border='0'></a></div> <br> <b>nombre:</b> nombre<br>  <br> </body> <br> </html> ";
	assert.deepEqual(JSON.stringify(result,undefined,2), esperado);
  });
  
  test('Sinopsis: ', function(){
	var entrada = "SINOPSIS; * Esto es una prueba.;.";
    var result = FilmInfo.parse(entrada);
	var esperado = "<!DOCTYPE html> <br> <html>         <br> <head>          <br> <title> FilmInfo </title> <br> <meta http-equiv='Content-type' content='text/html' ;='' charset='UTF-8'> <br> <style> <br> body {background-color:'#FFC77D';} <br> h1 {text-align:center;} <br> </style> </head> <br> <body> <br>   <div class='separator' style='clear: both; text-align: center;'><a href='http://imageshack.us/a/img32/4840/sinopsisz.png' imageanchor='1' style='margin-left: 1em; margin-right: 1em;'><img src='http://imageshack.us/a/img32/4840/sinopsisz.png' border='0'></a></div> <br>  Esto es una prueba.<br>  <br> </body> <br> </html> ";
	assert.deepEqual(JSON.stringify(result,undefined,2), esperado);
  });
  
  test('Enlace: ', function(){
	var entrada = "ENLACE; * prueba.com;.";
    var result = FilmInfo.parse(entrada);
	var esperado = "<!DOCTYPE html> <br> <html>         <br> <head>          <br> <title> FilmInfo </title> <br> <meta http-equiv='Content-type' content='text/html' ;='' charset='UTF-8'> <br> <style> <br> body {background-color:'#FFC77D';} <br> h1 {text-align:center;} <br> </style> </head> <br> <body> <br>   <div class='separator' style='clear: both; text-align: center;'><a href='http://img198.imageshack.us/img198/3383/descargawp.png' imageanchor='1' style='margin-left: 1em; margin-right: 1em;'><img src='http://img198.imageshack.us/img198/3383/descargawp.png' border='0'></a></div> <br>  <a href='http://prueba.com'>prueba.com</a> <br>  <br> </body> <br> </html> ";
	assert.deepEqual(JSON.stringify(result,undefined,2), esperado);
  });
  
  test('Error: ', function(){
	var entrada = "SINOPSIS; Esto es un error;.";
    var result = FilmInfo.parse(entrada);
	var esperado = "<div class='error'<pre>Error: Parse error on line 1:\nSINOPSIS; Esto es un error;.\n----------^\nExpecting 'DOT', 'TITULO', 'INFORMACION', 'SINOPSIS', 'ENLACE', 'ENTRANCE', got 'LITERALTEXT'\n</pre></div>";
	assert.deepEqual(JSON.stringify(result,undefined,2), esperado);
  });
  
});