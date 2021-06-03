parser grammar GoParser;

options { tokenVocab=GoLexer; }

letter  :   (FLOAT_LIT WHITESPACE*)* | WHITESPACE*;

exp     :   DECIMAL_EXPONENT;
