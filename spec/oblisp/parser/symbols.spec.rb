require_relative "_parser_helpers";

describe Parser do
    context "on symbols" do
        it "parses symbol literals" do
            parse("(:ok)", %Q{(new Symbol "ok")});
            parse("(:a,:b,:c)", %Q{(, (, (new Symbol "a") (new Symbol "b")) (new Symbol "c"))});
        end

        it "parses symbol messages" do
            parse("(x = :Hello)", %Q{(= x (new Symbol "Hello"))});
            parse("(y = :symb)", %Q{(= y (new Symbol "symb"))});
            # NOTE Look at ruby
        end
    end
end
