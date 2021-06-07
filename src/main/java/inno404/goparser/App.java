package inno404.goparser;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

import java.util.ArrayList;
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
        // Input part
        StringBuilder input = new StringBuilder();
        Scanner scanner = new Scanner(System.in);

        while (scanner.hasNextLine()) {
            input.append(scanner.nextLine()).append(System.lineSeparator());
        }

        // Init part
        CharStream cs = CharStreams.fromString(input.toString());
        GoLexer lexer = new GoLexer(cs);
        CommonTokenStream stream = new CommonTokenStream(lexer);
        GoParser parser = new GoParser(stream);


        // Visit AST nodes
        GoParser.TestLexerContext letterContext = parser.testLexer();
        GoVisitor<String> visitor = new GoVisitor<>();
        visitor.visit(letterContext);


        // Output tokens recognized
        lexer.reset();
        var tokenList = lexer.getAllTokens();
        ArrayList<String> tokens = new ArrayList<>(tokenList.size());

        tokenList.forEach(e -> tokens.add(lexer.getVocabulary().getSymbolicName(e.getType())));
        System.out.println(tokens);
    }
}
