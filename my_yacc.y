%{
	#include <stdio.h>
%}
%token SELECT ALLCOLUMNS FROM WHERE SPACE ORDERBY JOIN INNERJOIN LEFTJOIN RIGHTJOIN NATURALJOIN ON DISTINCT HAVING LINE COMMA SEMICOLON SIGN NUMOP COMPAR LOGIC NOT NUMBER IDENTIF STR LINECOMM COMBEGIN COMEND AS SUM COUNT AVG USING ASC DESC OPENBRACKETS CLOSEBRACKETS DOT GROUPBY
%%
main: | main_query;
main_query: query | SEMICOLON main_query
	| error{
     	printf ("Syntax error: ");
	};
iden: IDENTIF;
full_iden: iden | full_iden DOT iden;
column_name: full_iden | ALLCOLUMNS | full_iden AS full_iden
column_names: column_name | column_names COMMA column_name;
distinct_rule: | DISTINCT;
groupby_rule: | GROUPBY full_iden;
table: full_iden | OPENBRACKETS query CLOSEBRACKETS;
tables: table | tables COMMA table;
where_rule: | WHERE conditions;
condition: full_iden COMPAR value | full_iden COMPAR full_iden | NOT full_iden COMPAR value | NOT full_iden COMPAR full_iden;
conditions: condition | conditions LOGIC condition;
value: STR | NUMBER | OPENBRACKETS query CLOSEBRACKETS
regular_joins: INNERJOIN | RIGHTJOIN | LEFTJOIN;
using_rule: | USING full_iden;
join_condition: condition | OPENBRACKETS conditions CLOSEBRACKETS;
join_rule: regular_joins table ON join_condition where_rule | NATURALJOIN full_iden using_rule;
join_rules: join_rule | join_rules join_rule;
asc_rule: | ASC | DESC;
order_rule: ORDERBY asc_rule;
query: SELECT distinct_rule column_names FROM tables where_rule groupby_rule order_rule | SELECT distinct_rule column_names FROM tables where_rule join_rules groupby_rule order_rule;