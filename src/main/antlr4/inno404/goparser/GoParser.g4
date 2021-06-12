parser grammar GoParser;

options { tokenVocab=GoLexer; }
/*
'à'
'
'
*/

// Testing Lexer
testLexer       :   END*;

sourceFile      :   packageClause END ( importDecl END )* ( topLevelDecl END )* ;


packageClause   :   PACKAGE packageName;
packageName     :   IDENTIFIER;

importDecl      :   IMPORT ( importSpec | '(' ( importSpec END )* ')' );
importSpec      :   ( '.' | packageName )? importPath;
importPath      :   STRING_LIT;


topLevelDecl    :   declaration | functionDecl | methodDecl;

declaration     :   constDecl | typeDecl | varDecl;


functionDecl    :   FUNC functionName signature ( functionBody )?;
functionName    :   IDENTIFIER;
functionBody    :   block;


methodDecl      :   FUNC receiver methodName signature ( functionBody )?;
receiver        :   parameters;


constDecl       :   CONST ( constSpec | '(' ( constSpec END )* ')' );
constSpec       :   identifierList ( ( type )? '=' expressionList )?;


typeDecl        :   TYPE ( typeSpec | '(' ( typeSpec END )* ')' );
typeSpec        :   aliasDecl | typeDef;
aliasDecl       :   IDENTIFIER '=' type;
typeDef         :   IDENTIFIER type;


varDecl         :   VAR ( varSpec | '(' ( varSpec END )* ')' );
varSpec         :   identifierList ( type ( '=' expressionList )? | '=' expressionList );




functionType    :   FUNC signature;
signature       :   parameters ( result )?;
result          :   parameters | type;
parameters      :   '(' ( parameterList ( ',' )? )? ')';
parameterList   :   parameterDecl ( ',' parameterDecl )*;
parameterDecl   :   ( identifierList )? ( '...' )? type;



identifierList  :   IDENTIFIER ( ',' IDENTIFIER )* ;
expressionList  :   expression ( ',' expression )* ;


block           :   '{' statementList '}';
statementList   :   ( statement END )*;


statement       :   declaration | labeledStmt | simpleStmt
                |   goStmt | returnStmt | breakStmt | continueStmt
                |   gotoStmt | fallthroughStmt | block | ifStmt
                |   switchStmt | selectStmt | forStmt | deferStmt;

simpleStmt      :   emptyStmt | expressionStmt | sendStmt
                |   incDecStmt | assignment | shortVarDecl;



labeledStmt     :   label ':' statement;
label           :   IDENTIFIER;


goStmt          :   GO expression;


gotoStmt        :   GOTO label;


returnStmt      :   RETURN ( expressionList )?;


breakStmt       :   BREAK ( label )?;


continueStmt    :   CONTINUE ( label )?;


fallthroughStmt :   FALLTHROUGH;

ifStmt          :   IF ( simpleStmt END )? expression block ( ELSE ( ifStmt | block ) )?;


switchStmt      :   exprSwitchStmt | typeSwitchStmt;

exprSwitchStmt  :   SWITCH ( simpleStmt END )? ( expression )? '{' ( exprCaseClause )* '}';
exprCaseClause  :   exprSwitchCase ':' statementList;
exprSwitchCase  :   CASE expressionList | DEFAULT;

typeSwitchStmt  :   SWITCH ( simpleStmt END )? typeSwitchGuard '{' ( typeCaseClause )* '}';
typeSwitchGuard :   ( IDENTIFIER ':=' )? primaryExpr '.' '(' TYPE ')';
typeCaseClause  :   typeSwitchCase ':' statementList;
typeSwitchCase  :   CASE typeList | DEFAULT;
typeList        :   type ( ',' type )*;


selectStmt      :   SELECT '{' ( commClause )* '}';
commClause      :   commCase ':' statementList;
commCase        :   CASE ( sendStmt | recvStmt ) | DEFAULT;
recvStmt        :   ( expressionList '=' | identifierList ':=' )? recvExpr;
recvExpr        :   expression;


forStmt         :   FOR ( condition | forClause | rangeClause )? block;
condition       :   expression;


deferStmt       :   DEFER expression;


emptyStmt       :   ; // empty string


expressionStmt  :   expression;


sendStmt        :   channel RECEIVE expression;
channel         :   expression;


incDecStmt      :   expression ( PLUS_PLUS | MINUS_MINUS );


assignment      :   expressionList assign_op expressionList;
assign_op       :   ( add_op | mul_op )? '=';


shortVarDecl    :   identifierList ':=' expressionList;

