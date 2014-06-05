$(document).ready(function() {
  $('#parse').click(function() {
    try {
      var result = FilmInfo.parse($('#input').val());
      $('#OUTPUT').html(JSON.stringify(result,undefined,2));
    } catch (e) {
      $('#OUTPUT').html('<div class="error"><pre>\n' + String(e) + '\n</pre></div>');
    }
  });

  $("#examples").change(function(ev) {
    var f = ev.target.files[0]; 
    var r = new FileReader();
    r.onload = function(e) { 
      var contents = e.target.result;
      
      input.innerHTML = contents;
    }
    r.readAsText(f);
  });

});

function descargarArchivo(contenidoEnBlob, nombreArchivo) {
    var reader = new FileReader();
    reader.onload = function (event) {
        var save = document.createElement('a');
        save.href = event.target.result;
        save.target = '_blank';
        save.download = nombreArchivo || 'archivo.dat';
        var clicEvent = new MouseEvent('click', {
            'view': window,
                'bubbles': true,
                'cancelable': true
        });
        save.dispatchEvent(clicEvent);
        (window.URL || window.webkitURL).revokeObjectURL(save.href);
    };
    reader.readAsDataURL(contenidoEnBlob);
};
/*
//Función de ayuda: reúne los datos a exportar en un solo objeto
function obtenerDatos() {
    return {
        document.getElementById('OUTPUT').value
    };
};

//Genera un objeto Blob con los datos en un archivo TXT
function generarTexto(datos) {
    var texto = [];
    texto.push(datos);
    return new Blob(texto, {
        type: 'text/plain'
    });
};
	
document.getElementById('Descarga').addEventListener('click', function () {
    var datos = obtenerDatos();
    descargarArchivo(generarTexto(datos), 'FilmInfo.html');
}, false);*/