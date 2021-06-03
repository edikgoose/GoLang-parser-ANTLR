parser grammar GoParser;

options { tokenVocab=GoLexer; }

letter  :   (IMAGINARY_LIT WHITESPACE*)*;

