/* description: Parses end executes mathematical expressions. */

%lex
%%

\s+|\#.*                         /* skip whitespace and comments */
\b\d+("."\d*)?([eE][-+]?\d+)?\b  return 'NUMBER'
TITULO                           return 'TITULO'
INFORMACION                      return 'INFORMACION'
SINOPSIS                         return 'SINOPSIS'
ENLACE                         	 return 'ENLACE'
\[\]                             return 'CUADROTEXTO'                                  
[*]                              return 'ENTRANCE'    
[;]                              return 'DOTCOMMA'
[.]                              return 'DOT'
<<EOF>>                          return 'EOF'
([A-Za-z_,]\w*\s*)+\??           return 'LITERALTEXT'
.                                return 'INVALID'

/lex

%right TITULO
%right INFORMACION
%right SINOPSIS
%right ENLACE
%left NUMBER
%left ENTRANCE


%start html

%% /* language grammar */
html
    :ficha DOT EOF
        {            
          $$ = "&lt!DOCTYPE html&gt <br> " +
               "&lthtml&gt         <br> " +
               "&lthead&gt          <br> " +
               "&lttitle&gt Ficha &lt/title&gt <br> " +
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
    : /* empty */
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
	  $$ = " " + $2 + " " + $4 + " <br> ";
        }
    ;
    
info
    : INFORMACION LITERALTEXT DOTCOMMA op
	{ 
	  $$ = "&ltdiv class="separator" style="clear: both; text-align: center;"&gt&lta href="http://imageshack.us/a/img46/6905/fichatecnicax.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"&gt&ltimg border="0" src="http://imageshack.us/a/img46/6905/fichatecnicax.png" /&gt&lt/a&gt&lt/div&gt" + $2 + " &ltbr&gt " + $4 + " &ltbr&gt ";
        }
    ;
    
sinop
    :  SINOPSIS LITERALTEXT DOTCOMMA op
       {
          $$ = "&ltdiv class="separator" style="clear: both; text-align: center;"&gt&lta href="http://imageshack.us/a/img32/4840/sinopsisz.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"&gt&ltimg border="0" src="http://imageshack.us/a/img32/4840/sinopsisz.png" /&gt&lt/a&gt&lt/div&gt" + $2 + " &ltinput type='text'&gt &ltbr&gt";
       }
    ;

link
    : ENLACE LITERALTEXT DOTCOMMA op
	{ 
	  $$ = "&ltdiv class="separator" style="clear: both; text-align: center;"&gt&lta href="http://img198.imageshack.us/img198/3383/descargawp.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"&gt&ltimg border="0" src="http://img198.imageshack.us/img198/3383/descargawp.png" /&gt&lt/a&gt&lt/div&gt" + $2 + " &ltbr&gt " + $4 + " &ltbr&gt ";
        }
    ;

op
    : /* empty */
    | ENTRANCE LITERALTEXT DOTCOMMA op
       {
            $$ = "&ltinput type='radio'&gt " + $2 + " &ltbr&gt ";
          if($4)
	    $$ = "&ltinput type='radio'&gt " + $2 + " &ltbr&gt " + $4 ;
       }
    ;