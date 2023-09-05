%{
#include "my_yacc.tab.h"
#include <stdio.h>
%}
%{
int string_number = 1;
%}
SELECT				(?i:select)
ALLCOLUMNS			"*"
FROM				(?i:from)
AS					(?i:as)
BY					(?i:by)
ORDERBY				(?i:order){SPC}{BY}
ASC					(?:asc)
DESC				(?:desc)
WHERE				(?i:where)
SPC					[\t ]+
GROUPBY				((?i:group){SPC}{BY})
JOIN				(?i:join)
INNERJOIN			((?i:inner){SPC}{JOIN})
RIGHTJOIN			((?i:right){SPC}{JOIN})
LEFTJOIN			((?i:left){SPC}{JOIN})
ON					(?:on)
NATURALJOIN			((?i:natural){SPC}{JOIN})|((?i:natural){SPC}{INNERJOIN})|((?i:natural){SPC}{RIGHTJOIN})|((?i:natural){SPC}{LEFTJOIN})
USING				(?i:using)
DISTINCT			(?i:distinct)
HAVING				(?i:having)
DIG					[0-9]
LET					[A-Za-z]
LINE				(\n)|(\r\n)
COMMA				","
SEMICOLON			";"
DOT					"."
SIGN				{COMMA}|"!"|{DOT}|"?"|":"
OPENBRACKETS		"("
CLOSEBRACKETS		")"
NUMOP				"-"|"+"|"/"|"*"|"%"|"^"|"|/"|"||/"|"!"|"!!"
COMPAR				">"|"<"|"<>"|"!="|">="|"<="|"="
LOGIC				(?i:and)|(?:or)
NOT					(?i:not)
NUMBER				"-"?{DIG}+("."{DIG}+)?
SYMB				{SIGN}|{COMPAR}|{NUMOP}|{LET}|{DIG}
IDENTIF				{LET}({LET}|{DIG}|"_"|".")*|(\"{LET}({LET}|{DIG}|"_")*\")
SUM 				(?i:sum)
COUNT 				(?i:count)
AVG 				(?i:avg)
STR					\'{SYMB}+\'
LINECOMM			"--"
COMBEGIN			"/*"
COMEND				"*/"
%%
{SELECT}			{ printf("SELECT\n"); return SELECT;}
{SPC}				{ }
{OPENBRACKETS}		{ printf("OPENBRACKETS\n"); return OPENBRACKETS;}
{CLOSEBRACKETS}		{ printf("CLOSEBRACKETS\n"); return CLOSEBRACKETS;}
{DOT} 				{ printf("DOT\n"); return DOT;}
{AS}				{ printf("AS\n"); return AS;}
{ON}				{ printf("ON\n"); return ON;}
{USING}				{ printf("USING\n"); return USING;}
{DISTINCT}			{ printf("DISTINCT\n"); return DISTINCT;}
{HAVING} 			{ printf("HAVING\n"); return HAVING;}
{ORDERBY}			{ printf("ORDERBY\n"); return ORDERBY;}
{ASC}				{ printf("ASC\n"); return ASC;}
{DESC}				{ printf("DESC\n"); return DESC;}
{ALLCOLUMNS}		{ printf("*\n"); return ALLCOLUMNS;}
{FROM}				{ printf("FROM\n"); return FROM;}
{WHERE}				{ printf("WHERE\n"); return WHERE;}
{GROUPBY}			{ printf("GROUP BY\n"); return GROUPBY;}
{INNERJOIN}			{ printf("INNER JOIN\n"); return INNERJOIN;}
{RIGHTJOIN}			{ printf("RIGHT JOIN\n"); return RIGHTJOIN;}
{LEFTJOIN}			{ printf("LEFT JOIN\n"); return LEFTJOIN;}
{NATURALJOIN}		{ printf("NATURAL JOIN\n"); return NATURALJOIN; }
{NUMBER}			{ printf("NUMBER\n"); return NUMBER;}
{LOGIC}				{ printf("LOGIC\n"); return LOGIC;}
{SEMICOLON}			{ printf("SEMICOLON\n"); return SEMICOLON; }
{COMMA}				{ printf("COMMA\n"); return COMMA; }
{LINE}				{ string_number++; return LINE; }
{NUMOP}				{ printf("NUMOP\n"); return NUMOP; }
{COMPAR}			{ printf("COMPAR\n"); return COMPAR;}
{IDENTIF}			{ printf("IDENTIF\n"); return IDENTIF; }
{STR}				{ printf("STR\n"); return STR;}
.					{ printf("Error: %d ", string_number); exit(1); }
