parser grammar GoParser;

options { tokenVocab=GoLexer; }

plus : NUMBER NUMBER;
