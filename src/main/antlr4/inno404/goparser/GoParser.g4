parser grammar GoParser;

options { tokenVocab=GoLexer; }

/*
'à'
'
'
*/

letter  :   (STRING_LIT WHITESPACE*)*;

