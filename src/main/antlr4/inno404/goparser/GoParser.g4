parser grammar GoParser;

options { tokenVocab=GoLexer; }

letter  :   (RUNE_LIT WHITESPACE*)*;

