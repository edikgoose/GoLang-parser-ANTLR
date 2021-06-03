lexer grammar GoLexer;


//* ===== Fragments ===== *//


/* Unicode */
fragment NEW_LINE                   :   [\u000A];   // \n
fragment UNICODE_LETTER             :   [\p{L}\p{M}*];
fragment UNICODE_DIGIT              :   [\p{Nd}];
fragment UNICODE_CHAR               :   .[\p{M}]*;


/* Letters and digits */
fragment LETTER                     :   UNICODE_LETTER | '_';
fragment DECIMAL_DIGIT              :   [0-9];
fragment BINARY_DIGIT               :   [01];
fragment OCTAL_DIGIT                :   [0-7];
fragment HEX_DIGIT                  :   [0-9] | [A-F] | [a-f];




//* ===== Lexical Elements ===== *//

/* Comments */
GENERAL_COMMENT                     : '/*' .*? '*/' -> channel(HIDDEN);
LINE_COMMENT                        : '//' ~[\r\n]* -> channel(HIDDEN);


/* Whitespace symbols */
WHITESPACE                          : NEW_LINE
                                    | [\u0009] // '\t'
                                    | [\u0020] // ' '
                                    | [\u000D]; // '\r'


IDENTIFIER                          : LETTER (LETTER | UNICODE_DIGIT)*;


/* Keywords */
BREAK                               : 'break';
DEFAULT                             : 'default';
FUNC                                : 'func';
INTERFACE                           : 'interface';
SELECT                              : 'select';
CASE                                : 'case';
DEFER                               : 'defer';
GO                                  : 'go';
MAP                                 : 'map';
STRUCT                              : 'struct';
CHAN                                : 'chan';
ELSE                                : 'else';
GOTO                                : 'goto';
PACKAGE                             : 'package';
SWITCH                              : 'switch';
CONST                               : 'const';
FALLTHROUGH                         : 'fallthrough';
IF                                  : 'if';
RANGE                               : 'range';
TYPE                                : 'type';
CONTINUE                            : 'continue';
FOR                                 : 'for';
IMPORT                              : 'import';
RETURN                              : 'return';
VAR                                 : 'var';


/* Punctuations & Operators */
L_PAREN                             : '(';
R_PAREN                             : ')';
L_CURLY                             : '{';
R_CURLY                             : '}';
L_BRACKET                           : '[';
R_BRACKET                           : ']';
ASSIGN                              : '=';
COMMA                               : ',';
SEMI                                : ';';
COLON                               : ':';
DOT                                 : '.';
PLUS_PLUS                           : '++';
MINUS_MINUS                         : '--';
DECLARE_ASSIGN                      : ':=';
ELLIPSIS                            : '...';
LOGICAL_OR                          : '||';
LOGICAL_AND                         : '&&';
EQUALS                              : '==';
NOT_EQUALS                          : '!=';
LESS                                : '<';
LESS_OR_EQUALS                      : '<=';
GREATER                             : '>';
GREATER_OR_EQUALS                   : '>=';
PLUS                                : '+';
MINUS                               : '-';
CARET                               : '^';
ASTERISK                            : '*';
AMPERSAND                           : '&';
OR                                  : '|';
DIV                                 : '/';
MOD                                 : '%';
LSHIFT                              : '<<';
RSHIFT                              : '>>';
BIT_CLEAR                           : '&^';
EXCLAMATION                         : '!';
RECEIVE                             : '<-';


/* Integer literals */
INT_LIT                             : DECIMAL_LIT | BINARY_LIT | OCTAL_LIT | HEX_LIT;

DECIMAL_LIT                         : '0' | [1-9] ('_'? DECIMAL_DIGITS)?;
BINARY_LIT                          : '0' [bB] '_'? BINARY_DIGITS;
OCTAL_LIT                           : '0' [oO]? '_'?  OCTAL_DIGITS;
HEX_LIT                             : '0' [xX] '_'? HEX_DIGITS;

DECIMAL_DIGITS                      : DECIMAL_DIGIT ('_'? DECIMAL_DIGIT)*;
BINARY_DIGITS                       : BINARY_DIGIT ('_'? BINARY_DIGIT)*;
OCTAL_DIGITS                        : OCTAL_DIGIT ('_'? OCTAL_DIGIT)*;
HEX_DIGITS                          : HEX_DIGIT ('_'? HEX_DIGIT)*;


/* Floating point literals */
FLOAT_LIT                           : DECIMAL_FLOAT_LIT | HEX_FLOAT_LIT;

DECIMAL_FLOAT_LIT                   : DECIMAL_DIGITS '.' DECIMAL_DIGITS? DECIMAL_EXPONENT?
                                    | DECIMAL_DIGITS DECIMAL_EXPONENT
                                    | '.' DECIMAL_DIGITS DECIMAL_EXPONENT?;

/*
decimal_float_lit                    decimal_digits "." [ decimal_digits ] [ decimal_exponent ] |
                                     decimal_digits decimal_exponent |
                                     "." decimal_digits [ decimal_exponent ] .
*/


DECIMAL_EXPONENT                    : [eE] [+-] DECIMAL_DIGITS;

HEX_FLOAT_LIT                       : '0' [xX] HEX_MANTISSA HEX_EXPONENT;

HEX_MANTISSA                        : ('_')? HEX_DIGITS '.' (HEX_DIGITS)?
                                    | ('_')? HEX_DIGITS
                                    | '.' HEX_DIGITS;

HEX_EXPONENT                        : [pP] ('+' | '-' )? DECIMAL_DIGITS;