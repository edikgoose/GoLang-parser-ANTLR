package inno404.goparser.ast;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
public class PackageNode {
    @Getter
    @Setter
    private String name;
}
