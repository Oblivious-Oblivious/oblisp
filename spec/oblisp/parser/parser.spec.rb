require_relative "_parser_helpers";

describe Parser do
    it "creates a Parser object with Lexer as a parameter" do
        l = Lexer.new "file.obl", "(42 factorial)".chars;
        p = Parser.new l.make_tokens;
        expect(p).to be_kind_of Parser;
    end

    it "traverses through the token table" do
        l = Lexer.new "file.obl", "(42 factorial)".chars;
        p = Parser.new l.make_tokens;
        expect(p.table.consume.value).to eq "(";
        expect(p.table.consume.value).to eq "42";
        expect(p.table.consume.value).to eq "factorial";
        expect(p.table.consume.value).to eq ")";
        expect(p.table.consume.value).to eq "eof";
    end

    it "peeks on top of the token table" do
        l = Lexer.new "file.obl", "(42 factorial)".chars;
        p = Parser.new l.make_tokens;
        expect(p.table.peek.value).to eq "(";
        expect(p.table.peek.value).to eq "(";
        expect(p.table.peek.value).to eq "(";
        expect(p.table.peek.value).to eq "(";
        expect(p.table.peek.value).to eq "(";
    end

    it "has an error message for syntax errors" do
        l = Lexer.new "file.obl", "(42 factorial)".chars;
        p = Parser.new l.make_tokens;
        p.table.consume;

        begin
            p.table.error "This is a random syntax error";
        rescue Exception => e
            expect(e.message).to eq "This is a random syntax error";
        end
    end
end
