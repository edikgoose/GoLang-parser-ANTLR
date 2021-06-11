parser grammar GoParser;

options { tokenVocab=GoLexer; }
/*
'à'
'
'
*/


//sourceFile      :   packageClause ';' (importDecl ';')* ( topLevelDecl ';')*;

packageClause   :   PACKAGE packageName;
packageName     :   IDENTIFIER;

importDecl      :   IMPORT ( importSpec | '(' ( importSpec ';' )* ')' );
importSpec      :   ( '.' | packageName )? importPath;
importPath      :   STRING_LIT;

testLexer       :   END*;