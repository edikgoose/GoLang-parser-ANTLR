package inno404.goparser;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;



public class App
{
    private static class GoVisitor<T> extends GoParserBaseVisitor<T>{

        @Override
        public T visitSourceFile(GoParser.SourceFileContext ctx) {
            System.out.println("I started");
            var to_return = super.visitSourceFile(ctx);
            System.out.println("I finished");

            return to_return;
        }

        @Override
        public T visitTypeDecl(GoParser.TypeDeclContext ctx) {
            var to_return = super.visitTypeDecl(ctx);
            System.out.println("typeDecl");

            return to_return;
        }

        @Override
        public T visitConstDecl(GoParser.ConstDeclContext ctx) {
            var to_return = super.visitConstDecl(ctx);
            System.out.println("constDecl");

            return to_return;
        }

        @Override
        public T visitVarDecl(GoParser.VarDeclContext ctx) {
            var to_return = super.visitVarDecl(ctx);
            System.out.println("varDecl");

            return to_return;
        }
    }



    public static void main( String[] args ) throws IOException {
        // Init part
        CharStream cs = CharStreams.fromStream(System.in);
        GoLexer lexer = new GoLexer(cs);
        CommonTokenStream stream = new CommonTokenStream(lexer);
        GoParser parser = new GoParser(stream);


        // Visit Parser Tree
        var sourceFileContext = parser.sourceFile();
        GoVisitor<Void> visitor = new GoVisitor<>();
        visitor.visit(sourceFileContext);


        // Output tokens recognized
        lexer.reset();
        var tokenList = lexer.getAllTokens();
        ArrayList<String> tokens = new ArrayList<>(tokenList.size());

        tokenList.forEach(e -> tokens.add(lexer.getVocabulary().getSymbolicName(e.getType())));
        tokens.removeIf(e -> e.equals("WHITESPACE"));
        System.out.println(tokens.size());

        System.out.println(tokens);
    }
}
