var assert = chai.assert; 

suite( 'Parser', function(){

  test('Titulo: ', function(){
    var result = FilmInfo.parse("TITULO Prueba;.");
    assert.deepEqual(result, "'<!DOCTYPE html> <br> <html>         <br> <head>          <br> <title> FilmInfo </title> <br> <meta http-equiv='Content-type' content='text/html' ;='' charset='UTF-8'> <br> <style> <br> body {background-color:'#FFC77D';} <br> h1 {text-align:center;} <br> </style> </head> <br> <body> <br>   <h1>Prueba</h1> <br> </body> <br> </html> '");
  });

});