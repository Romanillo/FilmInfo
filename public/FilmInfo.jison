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
          $$ = "&lt!DOCTYPE html&gt &ltbr&gt " +
               "&lthtml&gt         &ltbr&gt " +
               "&lthead&gt          &ltbr&gt " +
               "&lttitle&gt FilmInfo &lt/title&gt &ltbr&gt " +
               "&ltmeta http-equiv='Content-type' content='text/html'; charset='UTF-8' /&gt &ltbr&gt " +
               "&ltstyle&gt " +
			   "body {background-color:'#FFC77D';} " +
			   "h1 {text-align:center;} " +
			   "&lt/style&gt " +
			   "&lt/head&gt &ltbr&gt " +
               "&ltbody&gt &ltbr&gt  " +
                    
               " " + $1 + " &ltbr&gt " +
                 
               "&lt/body&gt &ltbr&gt " +
               "&lt/html&gt ";
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
	  $$ = "&lth1&gt" + $2 + "&lt/h1&gt" + " &ltbr&gt ";
        }
    ;
    
info
    : INFORMACION DOTCOMMA op
	{ 
	  $$ = "&ltbr&gt&ltdiv class='separator' style='clear: both; text-align: center;'&gt&lta href='http://imageshack.us/a/img46/6905/fichatecnicax.png' imageanchor='1' style='margin-left: 1em; margin-right: 1em;'&gt&ltimg border='0' src='http://imageshack.us/a/img46/6905/fichatecnicax.png' /&gt&lt/a&gt&lt/div&gt" + " &ltbr&gt " + $3 + " &ltbr&gt ";
        }
    ;
    
sinop
    :  SINOPSIS DOTCOMMA op
       {
          $$ = "&ltdiv class='separator' style='clear: both; text-align: center;'&gt&lta href='http://imageshack.us/a/img32/4840/sinopsisz.png' imageanchor='1' style='margin-left: 1em; margin-right: 1em;'&gt&ltimg border='0' src='http://imageshack.us/a/img32/4840/sinopsisz.png' /&gt&lt/a&gt&lt/div&gt" + " &ltbr&gt " + $3 + " &ltbr&gt ";
       }
    ;

link
    : ENLACE DOTCOMMA op2
	{
	  $$ = "&ltdiv class='separator' style='clear: both; text-align: center;'&gt&lta href='http://img198.imageshack.us/img198/3383/descargawp.png' imageanchor='1' style='margin-left: 1em; margin-right: 1em;'&gt&ltimg border='0' src='http://img198.imageshack.us/img198/3383/descargawp.png' /&gt&lt/a&gt&lt/div&gt" + " &ltbr&gt " + $3 + " &ltbr&gt ";
        }
    ;

op
    : /* cadena vacia */
    | ENTRANCE LITERALTEXT DOUBLEDOT LITERALTEXT DOTCOMMA op
       {
          $$ = "&ltb&gt" + $2 + ":&lt/b&gt " + $4 + "&ltbr&gt";
          if($6)
	        $$ = "&ltb&gt" + $2 + ":&lt/b&gt " + $4 + "&ltbr&gt" + $6 ;
       }
	| ENTRANCE LITERALTEXT DOUBLEDOT NUMBER DOTCOMMA op
		{
			$$ = "&ltb&gt" + $2 + ":&lt/b&gt " + $4 + "&ltbr&gt";
          if($6)
	        $$ = "&ltb&gt" + $2 + ":&lt/b&gt " + $4 + "&ltbr&gt" + $6 ;
		}
    | ENTRANCE LITERALTEXT DOTCOMMA op
		{
			$$ = " " + $2 + "&ltbr&gt";
			if($4)
				$$ = " " + $2 + "&ltbr&gt" + $4 ;
		}
	;
	
op2
	: /* cadena vacia */
	| ENTRANCE LITERALTEXT DOTCOMMA op2
		{
			$$ = " &lta href='" + $2 + "'&gt" + $2 + "&lt/a&gt&ltbr&gt";
			if($4)
				$$ = " &lta href='" + $2 + "'&gt" + $2 + "&lt/a&gt&ltbr&gt" + $4;
		}
	;

