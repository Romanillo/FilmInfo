/* description: Parses end executes mathematical expressions. */

%lex
%%

\s+|\#.*                         /* skip whitespace and comments */
\b\d+("."\d*)?([eE][-+]?\d+)?\b 	 	return 'NUMBER'
TITULO                           		return 'TITULO'
INFORMACION                      		return 'INFORMACION'
SINOPSIS                         		return 'SINOPSIS'
ENLACE                         	 		return 'ENLACE'
\[\]                             		return 'CUADROTEXTO'                                  
[*]                              		return 'ENTRANCE'    
[;]                             		return 'DOTCOMMA'
[:]								 		return 'DOUBLEDOT'
[.]                              		return 'DOT'
<<EOF>>                          		return 'EOF'
([A-Za-z_,.\|áéíóúäëïöüñ\/-]\w*\s*)+\??    return 'LITERALTEXT'
.                                		return 'INVALID'

/lex

%right TITULO
%right INFORMACION
%right SINOPSIS
%right ENLACE
%left NUMBER
%left ENTRANCE

%start html

%% /* lenguaje generado por la gramática */
html
    :ficha DOT EOF
        {            
          $$ = "<!DOCTYPE html> <br> " +
               "<html>         <br> " +
               "<head>          <br> " +
               "<title> FilmInfo </title> <br> " +
               "<meta http-equiv='Content-type' content='text/html'; charset='UTF-8' /> <br> " +
               "<style> <br> " +
			   "body {background-color:'#FFC77D';} <br> " +
			   "h1 {text-align:center;} <br> " +
			   "</style> " +
			   "</head> <br> " +
               "<body> <br> " +
                    
               " " + $1 +
                 
               "</body> <br> " +
               "</html> ";
          return $$;
        }
    ;
    
ficha
    : /* cadena vacia */
    | title ficha
      { $$ = " " + $1;
	if ($2)
	  $$ = " " + $1 + " " + $2;}
    | info ficha
      { $$ = " " + $1;
	if ($2)
	  $$ = " " + $1 + " " + $2;}
    | sinop ficha
      { $$ = " " + $1;
	if ($2)
	  $$ = " " + $1 + " " + $2;}
    | link ficha
      { $$ = " " + $1;
	if ($2)
	  $$ = " " + $1 + " " + $2;}
    ;
    
title
    : TITULO LITERALTEXT DOTCOMMA op 
	{
	  $$ = "<h1>" + $2 + "</h1>" + " <br> ";
        }
    ;
    
info
    : INFORMACION DOTCOMMA op
	{ 
	  $$ = "<br><div class='separator' style='clear: both; text-align: center;'><a href='http://imageshack.us/a/img46/6905/fichatecnicax.png' imageanchor='1' style='margin-left: 1em; margin-right: 1em;'><img border='0' src='http://imageshack.us/a/img46/6905/fichatecnicax.png' /></a></div>" + " <br> " + $3 + " <br> ";
        }
    ;
    
sinop
    :  SINOPSIS DOTCOMMA op
       {
          $$ = "<div class='separator' style='clear: both; text-align: center;'><a href='http://imageshack.us/a/img32/4840/sinopsisz.png' imageanchor='1' style='margin-left: 1em; margin-right: 1em;'><img border='0' src='http://imageshack.us/a/img32/4840/sinopsisz.png' /></a></div>" + " <br> " + $3 + " <br> ";
       }
    ;

link
    : ENLACE DOTCOMMA op2
	{
	  $$ = "<div class='separator' style='clear: both; text-align: center;'><a href='http://img198.imageshack.us/img198/3383/descargawp.png' imageanchor='1' style='margin-left: 1em; margin-right: 1em;'><img border='0' src='http://img198.imageshack.us/img198/3383/descargawp.png' /></a></div>" + " <br> " + $3 + " <br> ";
        }
    ;

op
    : /* cadena vacia */
    | ENTRANCE LITERALTEXT DOUBLEDOT LITERALTEXT DOTCOMMA op
       {
          $$ = "<b>" + $2 + ":</b> " + $4 + "<br> ";
          if($6)
	        $$ = "<b>" + $2 + ":</b> " + $4 + "<br> " + $6 ;
       }
	| ENTRANCE LITERALTEXT DOUBLEDOT NUMBER DOTCOMMA op
		{
			$$ = "<b>" + $2 + ":</b> " + $4 + "<br> ";
          if($6)
	        $$ = "<b>" + $2 + ":</b> " + $4 + "<br> " + $6 ;
		}
    | ENTRANCE LITERALTEXT DOTCOMMA op
		{
			$$ = " " + $2 + "<br> ";
			if($4)
				$$ = " " + $2 + "<br> " + $4 ;
		}
	;
	
op2
	: /* cadena vacia */
	| ENTRANCE LITERALTEXT DOTCOMMA op2
		{
			$$ = " <a href='http://" + $2 + "'>" + $2 + "</a> <br> ";
			if($4)
				$$ = " <a href='http://" + $2 + "'>" + $2 + "</a> <br> " + $4;
		}
	;

