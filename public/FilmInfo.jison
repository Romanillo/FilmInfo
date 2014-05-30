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
[:]								 return 'DOUBLEDOT'
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
          $$ = "&lt!DOCTYPE html&gt &ltbr&gt " +
               "&lthtml&gt         &ltbr&gt " +
               "&lthead&gt          &ltbr&gt " +
               "&lttitle&gt FilmInfo &lt/title&gt &ltbr&gt " +
               "&ltmeta http-equiv='Content-type' content='text/html'; charset='UTF-8' /&gt &ltbr&gt " +
               "&lt/head&gt &ltbr&gt " +
               "&ltbody&gt &ltbr&gt  " +
                    
               " " + $1 + " &ltbr&gt " +
                 
               "&lt/body&gt &ltbr&gt " +
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
	  $$ = "&lth1&gt" + $2 + "&lt/h1&gt" + $4 + " &ltbr&gt ";
        }
    ;
    
info
    : INFORMACION LITERALTEXT DOTCOMMA op
	{ 
	  $$ = "Informacion " + $2 + " &ltbr&gt " + $4 + " &ltbr&gt ";
        }
    ;
    
sinop
    :  SINOPSIS LITERALTEXT DOTCOMMA op
       {
          $$ = "Sinopsis " + $2 + " &ltinput type='text'&gt &ltbr&gt";
       }
    ;

link
    : ENLACE LITERALTEXT DOTCOMMA op
	{
	  $$ = "Enlace " + $2 + " &ltbr&gt " + $4 + " &ltbr&gt ";
        }
    ;

op
    : /* empty */
    | ENTRANCE LITERALTEXT DOUBLEDOT LITERALTEXT DOTCOMMA op
       {
            $$ = "&ltb&gt" + $2 + ":&lt/b&gt" + $4 + "&ltbr&gt ";
          if($6)
	    $$ = "&ltb&gt" + $2 + ":&lt/b&gt" + $4 + "&ltbr&gt " + $6 ;
       }
    ;