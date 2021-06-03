parser grammar GoParser;

options { tokenVocab=GoLexer; }

/*
'à'
'
'
*/

letter  :   (RUNE_LIT WHITESPACE*)*;

