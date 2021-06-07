package inno404.goparser;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

import java.util.Scanner;

public class App
{
    public static class GoVisitor<T> extends GoParserBaseVisitor<T> {
        @Override
        public T visitTestLexer(GoParser.TestLexerContext ctx) {
            System.out.println(ctx.getText());
            return super.visitTestLexer(ctx);
        }
    }

    public static void main( String[] args ) {
        String input = "";
        Scanner scanner = new Scanner(System.in);

        while (scanner.hasNextLine()) {
            input += scanner.nextLine() + "\n";
        }

        CharStream cs = CharStreams.fromString(input);
        GoLexer lexer = new GoLexer(cs);
        CommonTokenStream stream = new CommonTokenStream(lexer);
        GoParser parser = new GoParser(stream);

        var tokenList = lexer.getAllTokens();

        for (var token : tokenList)
            System.out.println(token.getType());

//        GoParser.TestLexerContext letterContext = parser.testLexer();
//        GoVisitor<String> visitor = new GoVisitor<>();
//        visitor.visit(letterContext);
    }
}
