require_relative "_parser_helpers";

describe Parser do
    context "on tuples" do
        it "parses tuple literals" do
            parse("([])", "(new Tuple ())");
            parse("([[] []])", "(new Tuple (new Tuple () new Tuple ()))");
            parse("([41 42])", "(new Tuple (41 42))");
            parse(%Q{([42, "str", var])}, %Q{(new Tuple (, (, 42 "str") var))});
            error("([)", "missing closing bracket on tuple");
            error("(])", "missing closing parenthesis on list");
        end
    end
end
