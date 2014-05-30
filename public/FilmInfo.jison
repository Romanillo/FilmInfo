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
([A-Za-z_,.\|áéíóúäëïöüñ]\w*\s*)+\??    return 'LITERALTEXT'
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
          $$ = "&lt!DOCTYPE html&gt <br> " +
               "&lthtml&gt         <br> " +
               "&lthead&gt          <br> " +
               "&lttitle&gt FilmInfo &lt/title&gt <br> " +
               "&ltmeta http-equiv='Content-type' content='text/html'; charset='UTF-8' /&gt <br> " +
               "&lt/head&gt <br> " +
               "&ltbody&gt <br>  " +
                    
               " " + $1 + " <br> " +
                 
               "&lt/body&gt <br> " +
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
	  $$ = "&lth1&gt" + $2 + "&lt/h1&gt" + $4 + " <br> ";
        }
    ;
    
info
    : INFORMACION DOTCOMMA op
	{ 
	  $$ = "<br><br>&ltdiv class=&quotseparator&quot style=&quotclear: both; text-align: center;&quot&gt&lta href=&quothttp://imageshack.us/a/img46/6905/fichatecnicax.png&quot imageanchor=&quot1&quot style=&quotmargin-left: 1em; margin-right: 1em;&quot&gt&ltimg border=&quot0&quot src=&quothttp://imageshack.us/a/img46/6905/fichatecnicax.png&quot /&gt&lt/a&gt&lt/div&gt" + " <br> " + $3 + " <br> ";
        }
    ;
    
sinop
    :  SINOPSIS DOTCOMMA op
       {
          $$ = "&ltdiv class=&quotseparator&quot style=&quotclear: both; text-align: center;&quot&gt&lta href=&quothttp://imageshack.us/a/img32/4840/sinopsisz.png&quot imageanchor=&quot1&quot style=&quotmargin-left: 1em; margin-right: 1em;&quot&gt&ltimg border=&quot0&quot src=&quothttp://imageshack.us/a/img32/4840/sinopsisz.png&quot /&gt&lt/a&gt&lt/div&gt" + " <br> " + $3 + " <br> ";
       }
    ;

link
    : ENLACE DOTCOMMA op
	{
	  $$ = "&ltdiv class=&quotseparator&quot style=&quotclear: both; text-align: center;&quot&gt&lta href=&quothttp://img198.imageshack.us/img198/3383/descargawp.png&quot imageanchor=&quot1&quot style=&quotmargin-left: 1em; margin-right: 1em;&quot&gt&ltimg border=&quot0&quot src=&quothttp://img198.imageshack.us/img198/3383/descargawp.png&quot /&gt&lt/a&gt&lt/div&gt" + " <br> " + $3 + " <br> ";
        }
    ;

op
    : /* cadena vacia */
    | ENTRANCE LITERALTEXT DOUBLEDOT LITERALTEXT DOTCOMMA op
       {
          $$ = "&ltb&gt" + $2 + ":&lt/b&gt " + $4 + "<br> ";
          if($6)
	        $$ = "&ltb&gt" + $2 + ":&lt/b&gt " + $4 + "<br> " + $6 ;
       }
	| ENTRANCE LITERALTEXT DOUBLEDOT NUMBER DOTCOMMA op
		{
			$$ = "&ltb&gt" + $2 + ":&lt/b&gt " + $4 + "<br> ";
          if($6)
	        $$ = "&ltb&gt" + $2 + ":&lt/b&gt " + $4 + "<br> " + $6 ;
		}
    | ENTRANCE LITERALTEXT DOTCOMMA op
		{
			$$ = " " + $2 + "<br> ";
			if($4)
				$$ = " " + $2 + "<br> " + $4 ;
		}
	;
