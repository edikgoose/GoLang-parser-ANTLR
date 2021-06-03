parser grammar GoParser;

options { tokenVocab=GoLexer; }

letter  :   (FLOAT_LIT WHITESPACE*)*;

