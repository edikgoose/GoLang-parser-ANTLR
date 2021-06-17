package inno404.goparser;

import org.antlr.v4.runtime.BufferedTokenStream;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.TokenStream;


public abstract class GoParserBase extends Parser {

    public GoParserBase(TokenStream input) {
        super(input);
    }

    protected boolean isNextTokenType(int tokenType) {
        BufferedTokenStream stream = (BufferedTokenStream)_input;
        return stream.LT(1).getType() == tokenType;
    }
}
