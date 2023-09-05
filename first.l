%{
int string_number = 1; 
%}
SELECT				(?i:select)
ALLCOLUMNS			"*"
FROM				(?i:from)
AS					(?i:as)
BY					(?i:by)
ORDERBY				(?i:order){SPACE}{BY}
ASC					(?:asc)
DESC				(?:desc)
WHERE				(?i:where)
SPACE				[\t ]+
GROUPBY				((?i:group){SPACE}{BY})
JOIN				(?i:join)
INNERJOIN			((?i:inner){SPACE}{JOIN})
RIGHTJOIN			((?i:right){SPACE}{JOIN})
LEFTJOIN			((?i:left){SPACE}{JOIN})
ON					(?:on)
NATURALJOIN			((?i:natural){SPACE}{JOIN})|((?i:natural){SPACE}{INNERJOIN})|((?i:natural){SPACE}{RIGHTJOIN})|((?i:natural){SPACE}{LEFTJOIN})
USING				(?i:using)
DISTINCT			(?i:distinct)
HAVING				(?i:having)
DIG					[0-9]
LET					[A-Za-z]
LINE				(\n)|(\r\n)
COMMA				","
SEMICOLON			";"
EQ					"="
DOT					"."
SIGN				{COMMA}|"!"|{DOT}|"?"|":"
OPENBRACKETS		"("
CLOSEBRACKETS		")"
NUMOP				"-"|"+"|"/"|{ALLCOLUMNS}|"%"|"^"|"|/"|"||/"|"!"|"!!"
COMPAR				">"|"<"|"<>"|"!="|">="|"<="|{EQ}
LOGIC				(?i:and)|(?:or)
NOT					(?i:not)
NUMBER				"-"?{DIG}+("."{DIG}+)?
SYMB				{SIGN}|{COMPAR}|{NUMOP}|{LET}|{DIG}
IDENTIF				{LET}({LET}|{DIG}|"_"|".")*|(\"{LET}({LET}|{DIG}|"_")*\")
SUM 				(?i:sum)
COUNT 				(?i:count)
AVG 				(?i:avg)
FUN 				{SUM}\({IDENTIF}\)|{COUNT}\({IDENTIF}\)|{AVG}\({IDENTIF}\)
STR					\'{SYMB}+\'
LINECOMM			"--"
COMBEGIN			"/*"
COMEND				"*/"
%%
{SELECT}			{ printf("SELECT\n"); }
{SPACE}				{ }
{OPENBRACKETS}		{ printf("OPENBRACKETS\n"); }
{CLOSEBRACKETS}		{ printf("CLOSEBRACKETS\n"); }
{DOT}				{ printf("DOT\n"); }
{AS}				{ printf("AS\n"); }
{ON}				{ printf("ON\n"); }
{USING}				{ printf("USING\n"); }
{DISTINCT}			{ printf("DISTINCT\n"); }
{HAVING} 			{ printf("HAVING\n"); }
{FUN}				{ printf("FUN\n"); }
{ORDERBY}			{ printf("ORDERBY\n"); }
{ASC}				{ printf("ASC\n"); }
{DESC}				{ printf("DESC\n"); }
{ALLCOLUMNS}			{ printf("*\n"); }
{FROM}				{ printf("FROM\n"); }
{WHERE}				{ printf("WHERE\n"); }
{GROUPBY}			{ printf("GROUP BY\n"); }
{INNERJOIN}			{ printf("INNER JOIN\n"); }
{RIGHTJOIN}			{ printf("RIGHT JOIN\n"); }
{LEFTJOIN}			{ printf("LEFT JOIN\n"); }
{NATURALJOIN}		{ printf("NATURAL JOIN\n"); }
{NUMBER}			{ printf("NUMBER\n"); }
{LOGIC}				{ printf("LOGIC\n"); }
{EQ}				{ printf("EQ\n"); }
{SEMICOLON}			{ printf("SEMICOLON\n"); }
{COMMA}				{ printf("COMMA\n"); }
{LINE}				{ string_number++; }
{NUMOP}				{ printf("NUMOP\n"); }
{COMPAR}			{ printf("COMPAR\n"); }
{IDENTIF}			{ printf("IDENTIF\n"); }
{STR}				{ printf("STR\n"); }
.					{ printf("Error: %d ", string_number); exit(1); }
