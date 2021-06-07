parser grammar GoParser;

options { tokenVocab=GoLexer; }

/*
'à'
'
'
*/

testLexer   :   STRING_LIT*;

