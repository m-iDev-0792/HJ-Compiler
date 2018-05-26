%option noyywrap
%{
//注意:此文件更新于公元2018年3月21日 下午2:24,如果有比这新的文件,请使用新的
	#include <iostream>
	#include <vector>
	#include <string>
	#include <map>
	#include <fstream>
	using namespace std;
	enum TokenLabel{
	tok_single_op=-1,
	tok_binary_op=-2,
	tok_int=-3,
	tok_float=-4,
	tok_comma=-5,
	tok_id=-6,
	tok_single_comment=-7,
	tok_enter=-8,
	tok_type=-9,
	tok_func=-10,
	tok_if=-11,
	tok_else=-12,
	tok_while=-13,
	tok_for=-14,
	tok_return=-15,
	tok_break=-16,
	tok_continue=-17,
	tok_const=-18,
	tok_left_paren=-19,
	tok_right_paren=-20,
	tok_left_brace=-21,
	tok_right_brace=-22,
	tok_string=-23,
	tok_end=0
	};
	struct token{
		string tokenValue;
		int tokenType;
		token(string value,int type){
			tokenValue=value;
			tokenType=type;
		}
	};
	vector<token> tokens;
	static map<int,string> tokIDtoStr;
%}
SINGLE_OPERATOR !
BINARY_OPERATOR \+|\-|\*|\/|<=?|>=?|!=|==?|&|\|
INTEGER [-]?[0-9]+
COMMA ,
FLOAT [-]?[0-9]*\.[0-9]+(e[-+]?[1-9][0-9]*)*
ID [_a-zA-Z][a-zA-Z_0-9]*
SINGLE_COMMENT #.*\n
ENTER [\n]
TYPE int|float
FUNC func
IF if
ELSE else
WHILE while
FOR for 
RETURN return
BREAK break 
CONTINUE continue
CONST const
LEFT_PAREN \(
RIGHT_PAREN \)
LEFT_BRACE \{
RIGHT_BRACE \}
SPACE [ \t]
STRING \".*\"
END \$
%%
{SINGLE_OPERATOR} {
	tokens.push_back(token(string(yytext),tok_single_op));
}
{BINARY_OPERATOR} {
	tokens.push_back(token(string(yytext),tok_binary_op));
}
{INTEGER} { 
  tokens.push_back(token(string(yytext),tok_int));
}
{FLOAT} {
	tokens.push_back(token(string(yytext),tok_float));
}
{COMMA} {
	tokens.push_back(token(string(yytext),tok_comma));
}

{SINGLE_COMMENT} {
	tokens.push_back(token(string(yytext),tok_single_comment));
}

{ENTER} {
	tokens.push_back(token(string(yytext),tok_enter));
}
{TYPE} {
	tokens.push_back(token(string(yytext),tok_type));
}
{FUNC} {
	tokens.push_back(token(string(yytext),tok_func));
}
{IF} {
	tokens.push_back(token(string(yytext),tok_if));
}
{ELSE} {
	tokens.push_back(token(string(yytext),tok_else));
}
{FOR} {
	tokens.push_back(token(string(yytext),tok_for));
}
{WHILE} {
	tokens.push_back(token(string(yytext),tok_while));
}
{BREAK} {
	tokens.push_back(token(string(yytext),tok_break));
}
{CONTINUE} {
	tokens.push_back(token(string(yytext),tok_continue));
}
{RETURN} {
	tokens.push_back(token(string(yytext),tok_return));
}
{CONST} {
	tokens.push_back(token(string(yytext),tok_const));
}

{ID} { 
	 tokens.push_back(token(string(yytext),tok_id));
	}

{LEFT_BRACE} {
	tokens.push_back(token(string(yytext),tok_left_brace));
}
{RIGHT_BRACE} {
	tokens.push_back(token(string(yytext),tok_right_brace));
}
{LEFT_PAREN} {
	tokens.push_back(token(string(yytext),tok_left_paren));
}
{RIGHT_PAREN} {
	tokens.push_back(token(string(yytext),tok_right_paren));
}
{STRING} {
	tokens.push_back(token(string(yytext),tok_string));
}
{SPACE} {
//do nothing
}
{END} {
	tokens.push_back(token(string(yytext),tok_end));
	yyterminate();
}
. {
	cout<<"inputed a illegal token!!!"<<endl;
	}
%%
void initTokIDtoStr(){
	tokIDtoStr.insert(map<int, string>::value_type(-1,"Single Operator"));
	tokIDtoStr.insert(map<int, string>::value_type(-2,"Binary Operator"));
	tokIDtoStr.insert(map<int, string>::value_type(-3,"Int"));
	tokIDtoStr.insert(map<int, string>::value_type(-4,"Float"));
	tokIDtoStr.insert(map<int, string>::value_type(-5,"Comma"));
	tokIDtoStr.insert(map<int, string>::value_type(-6,"ID"));
	tokIDtoStr.insert(map<int, string>::value_type(-7,"Single Comment"));
	tokIDtoStr.insert(map<int, string>::value_type(-8,"Enter"));
	tokIDtoStr.insert(map<int, string>::value_type(-9,"Type"));
	tokIDtoStr.insert(map<int, string>::value_type(-10,"Func"));
	tokIDtoStr.insert(map<int, string>::value_type(-11,"If"));
	tokIDtoStr.insert(map<int, string>::value_type(-12,"Else"));
	tokIDtoStr.insert(map<int, string>::value_type(-13,"While"));
	tokIDtoStr.insert(map<int, string>::value_type(-14,"For"));
	tokIDtoStr.insert(map<int, string>::value_type(-15,"Return"));
	tokIDtoStr.insert(map<int, string>::value_type(-16,"Break"));
	tokIDtoStr.insert(map<int, string>::value_type(-17,"Continue"));
	tokIDtoStr.insert(map<int, string>::value_type(-18,"Const"));
	tokIDtoStr.insert(map<int, string>::value_type(-19,"Left Paren"));
	tokIDtoStr.insert(map<int, string>::value_type(-20,"Right Paren"));
	tokIDtoStr.insert(map<int, string>::value_type(-21,"Left Brace"));
	tokIDtoStr.insert(map<int, string>::value_type(-22,"Right Brace"));
	tokIDtoStr.insert(map<int, string>::value_type(-23,"String"));
	tokIDtoStr.insert(map<int, string>::value_type(0,"End of File"));
}

