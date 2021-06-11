package inno404.goparser;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.Lexer;


public abstract class GoLexerBase extends Lexer {

    private int lastTokenType;


    public GoLexerBase(CharStream input) {
        super(input);
        lastTokenType = -1;
    }


    @Override
    public void emit(Token token) {
        super.emit(token);
        lastTokenType = token.getType();
    }

    public int getLastTokenType() {
        return lastTokenType;
    }
}
