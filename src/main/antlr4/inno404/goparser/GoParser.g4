parser grammar GoParser;

options {
    tokenVocab=GoLexer;
 }

/*
'à'
'
'
*/

sourceFile          :   packageClause ( END ) ( importDecl ( END ) )* ( topLevelDecl ( END ) )* EOF;


packageClause       :   PACKAGE packageName;
packageName         :   IDENTIFIER;

importDecl          :   IMPORT ( importSpec | '(' ( (importSpec END) (importSpec (END)?)? )* ')' );
importSpec          :   ( '.' | packageName )? importPath;
importPath          :   STRING_LIT;


topLevelDecl        :   declaration | functionDecl | methodDecl;

declaration         :   constDecl | typeDecl | varDecl;


functionDecl        :   FUNC functionName signature ( functionBody )?;
functionName        :   IDENTIFIER;
functionBody        :   block;


methodDecl          :   FUNC receiver methodName signature ( functionBody )?;
receiver            :   parameters;


constDecl           :   CONST ( constSpec | '(' ( (constSpec END) (constSpec (END)?)?  )* ')' );
constSpec           :   identifierList ( ( type )? '=' expressionList )?;


typeDecl            :   TYPE ( typeSpec | '(' ( (typeSpec END) (typeSpec (END)?)?  )* ')' );
typeSpec            :   aliasDecl | typeDef;
aliasDecl           :   IDENTIFIER '=' type;
typeDef             :   IDENTIFIER type;


varDecl             :   VAR ( varSpec | '(' ( (varSpec END) (varSpec (END)?)? )* ')' );
varSpec             :   identifierList ( type ( '=' expressionList )? | '=' expressionList );




type                :   typeName | typeLit | '(' type ')';
typeName            :   IDENTIFIER | qualifiedIdent;
typeLit             :   arrayType | structType | pointerType | functionType |
                    interfaceType | sliceType | mapType | channelType;

qualifiedIdent      :   packageName '.' IDENTIFIER;

arrayType           :   '[' arrayLength ']' elementType;
arrayLength         :   expression;
elementType         :   type;

structType          :   STRUCT '{' ( fieldDecl END )* '}';
fieldDecl           :   (identifierList type | embeddedField) ( tag )?;
embeddedField       :   ( '*' )? typeName;
tag                 :   STRING_LIT;

pointerType         :   '*' baseType;
baseType            :   type;

functionType        :   FUNC signature;
signature           :   parameters ( result )?;
result              :   parameters | type;
parameters          :   '(' ( parameterList ( ',' )? )? ')';
parameterList       :   parameterDecl ( ',' parameterDecl )*;
parameterDecl       :   ( identifierList )? ( '...' )? type;

interfaceType       :   INTERFACE '{' ( ( methodSpec | interfaceTypeName ) END )* '}';
methodSpec          :   methodName signature;
methodName          :   IDENTIFIER;
interfaceTypeName   :   typeName;

sliceType           :   '[' ']' elementType;
mapType             :   MAP '[' keyType ']' elementType;
keyType             :   type;
channelType         :   ( CHAN | CHAN '<-' | '<-' CHAN ) elementType;




identifierList      :   IDENTIFIER ( ',' IDENTIFIER )* ;
expressionList      :   expression ( ',' expression )* ;


expression          :   unaryExpr | expression binary_op expression;


unaryExpr           :   primaryExpr | unary_op unaryExpr;

binary_op           :   '||' | '&&' | rel_op | add_op | mul_op;
rel_op              :   '==' | '!=' | '<' | '<=' | '>' | '>=';
add_op              :   '+' | '-' | '|' | '^';
mul_op              :   '*' | '/' | '%' | '<<' | '>>' | '&' | '&^';

unary_op            :   '+' | '-' | '!' | '^' | '*' | '&' | '<-';


primaryExpr         :   operand | conversion | methodExpr | primaryExpr selector
                    |   primaryExpr index | primaryExpr slice | primaryExpr typeAssertion
	                |   primaryExpr arguments;

conversion          :   type '(' expression ( ',' )? ')';

methodExpr          :   receiverType '.' methodName;
receiverType        :   type;

selector            :   '.' IDENTIFIER;
index               :   '[' expression ']';
slice               :   '[' ( expression )? ':' ( expression ?) ']' |
                        '[' ( expression )? ':' expression ':' expression ']';
typeAssertion       :   '.' '(' type ')';
arguments           :   '(' ( ( expressionList | type ( ',' expressionList )? ) ( '...' )? ( ',' )? )? ')';

operand             :   literal | operandName | '(' expression ')';
literal             :   basicLit | compositeLit | functionLit;
basicLit            :   INT_LIT | FLOAT_LIT | IMAGINARY_LIT | RUNE_LIT | STRING_LIT;
operandName         :   IDENTIFIER | qualifiedIdent;

compositeLit        :   literalType literalValue;
literalType         :   structType | arrayType | '[' '...' ']' elementType
                    |   sliceType | mapType | typeName;
literalValue        :   '{' ( elementList ( ',' )? )? '}';
elementList         :   keyedElement ( ',' keyedElement )*;
keyedElement        :   ( key ':' )? element;
key                 :   fieldName | expression | literalValue;
fieldName           :   IDENTIFIER;
element             :   expression | literalValue;

functionLit         :   FUNC signature functionBody;




block               :   '{' statementList '}';
statementList       :   ( statement END )* (statement (END)?)?;


statement           :   declaration | labeledStmt | simpleStmt
                    |   goStmt | returnStmt | breakStmt | continueStmt
                    |   gotoStmt | fallthroughStmt | block | ifStmt
                    |   switchStmt | selectStmt | forStmt | deferStmt;

simpleStmt          :   emptyStmt | expressionStmt | sendStmt
                    |   incDecStmt | assignment | shortVarDecl;


labeledStmt         :   label ':' statement;
label               :   IDENTIFIER;


goStmt              :   GO expression;


gotoStmt            :   GOTO label;


returnStmt          :   RETURN ( expressionList )?;


breakStmt           :   BREAK ( label )?;


continueStmt        :   CONTINUE ( label )?;


fallthroughStmt     :   FALLTHROUGH;

ifStmt              :   IF ( simpleStmt END )? expression block ( ELSE ( ifStmt | block ) )?;


switchStmt          :   exprSwitchStmt | typeSwitchStmt;

exprSwitchStmt      :   SWITCH ( simpleStmt END )? ( expression )? '{' ( exprCaseClause )* '}';
exprCaseClause      :   exprSwitchCase ':' statementList;
exprSwitchCase      :   CASE expressionList | DEFAULT;

typeSwitchStmt      :   SWITCH ( simpleStmt END )? typeSwitchGuard '{' ( typeCaseClause )* '}';
typeSwitchGuard     :   ( IDENTIFIER ':=' )? primaryExpr '.' '(' TYPE ')';
typeCaseClause      :   typeSwitchCase ':' statementList;
typeSwitchCase      :   CASE typeList | DEFAULT;
typeList            :   type ( ',' type )*;


selectStmt          :   SELECT '{' ( commClause )* '}';
commClause          :   commCase ':' statementList;
commCase            :   CASE ( sendStmt | recvStmt ) | DEFAULT;
recvStmt            :   ( expressionList '=' | identifierList ':=' )? recvExpr;
recvExpr            :   expression;


forStmt             :   FOR ( condition | forClause | rangeClause )? block;
condition           :   expression;

forClause           :   ( initStmt )? END ( condition )? END ( postStmt )?;
initStmt            :   simpleStmt;
postStmt            :   simpleStmt;

rangeClause         :   ( expressionList '=' | identifierList ':=' )? RANGE expression;


deferStmt           :   DEFER expression;


emptyStmt           :   ; // empty string


expressionStmt      :   expression;


sendStmt            :   channel RECEIVE expression;
channel             :   expression;


incDecStmt          :   expression ( PLUS_PLUS | MINUS_MINUS );


assignment          :   expressionList assign_op expressionList;
assign_op           :   ( add_op | mul_op )? '=';


shortVarDecl        :   identifierList ':=' expressionList;
