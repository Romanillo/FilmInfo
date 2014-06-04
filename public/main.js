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

var WriteToFile = (function(){ WriteToFile(){
var fso = new ActiveXObject("Scripting.FileSystemObject");
var s = fso.CreateTextFile("C:\\FilmInfo.html", true);
var text = document.getElementById("OUTPUT").innerText;
s.WriteLine(text);
s.Close();
}});
