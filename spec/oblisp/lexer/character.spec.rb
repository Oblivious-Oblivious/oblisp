describe Character do
    it "stores a single character" do
        c = Character.new 'r';
        expect("#{c}").to eq 'r';
    end

    it "can store a nil" do
        c = Character.new nil;
        expect(c.c).to eq nil;
    end

    it "responds to #is_(any_objext_literal)" do
        c = Character.new '4';
        expect(c).to respond_to :is_integer;
        expect(c).to respond_to :is_big_integer;
        expect(c).to respond_to :is_float;
        expect(c).to respond_to :is_big_float;
        expect(c).to respond_to :is_binary;
        expect(c).to respond_to :is_hexadecimal;
        expect(c).to respond_to :is_octal;
        expect(c).to respond_to :is_string;
        # expect(c).to respond_to :is_symbol;
    end

    it "finds a valid integer" do
        c = Character.new "4";
        expect(c.is_integer).to be true;

        c = Character.new "42";
        expect(c.is_integer).to be true;

        c = Character.new "-241";
        expect(c.is_integer).to be true;
    end

    it "finds an invalid integer" do
        c  = Character.new "";
        expect(c.is_integer).to be false;

        c = Character.new "tezt";
        expect(c.is_integer).to be false;

        # Too big for INTEGER class (max is 2_147_483_647)
        c = Character.new "2147483648";
        expect(c.is_integer).to be false;

        # TODO Multiple ints in same string
        # c = Character.new "42 42 42";
        # expect(c.is_integer).to be false;

        c = Character.new "-2147483648";
        expect(c.is_integer).to be false;
    end

    it "finds a valid big integer" do
        c = Character.new "2147483648";
        expect(c.is_big_integer).to be true;

        # TODO underscore integers
        # c = Character.new "10_000_000_000_000";
        # expect(c.is_big_integer).to be true;

        # c = Character.new "-10_000_000_000_000";
        # expect(c.is_big_integer).to be true;
    end

    it "finds an invalid big integer" do
        c = Character.new "";
        expect(c.is_big_integer).to be false;

        c = Character.new "42";
        expect(c.is_big_integer).to be false;

        c = Character.new "2147483647";
        expect(c.is_big_integer).to be false;
    end

    it "finds a valid float" do
        c = Character.new "0.58";
        expect(c.is_float).to be true;

        c = Character.new "1242.1242";
        expect(c.is_float).to be true;

        c = Character.new "124.0";
        expect(c.is_float).to be true;
    end

    it "finds an invalid float" do
        c  = Character.new "";
        expect(c.is_float).to be false;

        c = Character.new "12";
        expect(c.is_float).to be false;

        c = Character.new "12.";
        expect(c.is_float).to be false;
        
        c = Character.new ":sagfqwgq3";
        expect(c.is_float).to be false;

        c = Character.new "1237g9hu3ivbjk";
        expect(c.is_float).to be false;

        c  = Character.new ".42";
        expect(c.is_float).to be false;

        c = Character.new "..1254";
        expect(c.is_float).to be false;

        # TODO multiple floats in same string
        # c = Character.new "1.1.5";
        # expect(c.is_float).to be false;

        c = Character.new ".2...4";
        expect(c.is_float).to be false;

        c = Character.new "0.2..4";
        expect(c.is_float).to be false;
    end

    xit "finds a valid big float" do
    end
    xit "finds an invalid big float" do
    end

    it "finds a valid binary" do
        c = Character.new "0b01010";
        expect(c.is_binary).to be true;

        c = Character.new "0B01010";
        expect(c.is_binary).to be true;

        c = Character.new "0b1";
        expect(c.is_binary).to be true;
    end

    it "finds an invalid binary" do
        c = Character.new "0b";
        expect(c.is_binary).to be false;

        c = Character.new "0B";
        expect(c.is_binary).to be false;

        c = Character.new "asfsqf";
        expect(c.is_binary).to be false;

        c = Character.new "0bwr12";
        expect(c.is_binary).to be false;

        c = Character.new "0b0010011k";
        expect(c.is_binary).to be false;
    end

    it "finds a valid hexadecimal" do
        c = Character.new "0x0";
        expect(c.is_hexadecimal).to be true;

        c = Character.new "0x00";
        expect(c.is_hexadecimal).to be true;

        c = Character.new "0X00";
        expect(c.is_hexadecimal).to be true;

        c = Character.new "0xfeed01";
        expect(c.is_hexadecimal).to be true;

        c = Character.new "0x125251";
        expect(c.is_hexadecimal).to be true;

        c = Character.new "0X124141d02842150fbcad";
        expect(c.is_hexadecimal).to be true;

        c = Character.new "0xaababac";
        expect(c.is_hexadecimal).to be true;
    end

    it "finds an invalid hexadecimal" do
        c = Character.new "0x";
        expect(c.is_hexadecimal).to be false;

        c = Character.new "0X";
        expect(c.is_hexadecimal).to be false;

        c = Character.new "qwfoiwbgqwo";
        expect(c.is_hexadecimal).to be false;

        c = Character.new "12412512";
        expect(c.is_hexadecimal).to be false;

        c = Character.new "0xwqirowhtrqwo";
        expect(c.is_hexadecimal).to be false;

        c = Character.new "0x12215215197acdfs";
        expect(c.is_hexadecimal).to be false;
    end

    it "finds a valid octal" do
        c = Character.new "0o125";
        expect(c.is_octal).to be true;

        c = Character.new "0o777";
        expect(c.is_octal).to be true;

        c = Character.new "0O777";
        expect(c.is_octal).to be true;

        c = Character.new "0o000";
        expect(c.is_octal).to be true;

        c = Character.new "0o0";
        expect(c.is_octal).to be true;
    end

    it "finds an invalid octal" do
        c = Character.new "0o";
        expect(c.is_octal).to be false;

        c = Character.new "0O";
        expect(c.is_octal).to be false;

        c = Character.new "asfgqwfg";
        expect(c.is_octal).to be false;

        c = Character.new "0o12512fwqsga";
        expect(c.is_octal).to be false;

        c = Character.new "0o99885";
        expect(c.is_octal).to be false;

        c = Character.new "0o121528";
        expect(c.is_octal).to be false;
    end

    it "find a valid string" do
        c = Character.new "\"agoiqwegqewlshgq\"";
        expect(c.is_string).to be true;

        c = Character.new "\"129g8ho2ficqw79uhi~!@#$%^&/;][.\""
        expect(c.is_string).to be true;

        c = Character.new "'129g8ho2ficqw79uhi~!@#$%^&/;][.'"
        expect(c.is_string).to be true;

        c = Character.new "\"\\nandstuff\\n   \""
        expect(c.is_string).to be true;

        c = Character.new "\"  \"";
        expect(c.is_string).to be true;

        c = Character.new "\"\"";
        expect(c.is_string).to be true;

        c = Character.new "''";
        expect(c.is_string).to be true;
    end

    it "finds an invalid string" do
        c = Character.new "\"";
        expect(c.is_string).to be false;

        c = Character.new "'";
        expect(c.is_string).to be false;

        c = Character.new "\"asfgqwgf";
        expect(c.is_string).to be false;

        c = Character.new "asfgqwgf\"";
        expect(c.is_string).to be false;

        c = Character.new "36973697";
        expect(c.is_string).to be false;

        c = Character.new "asgagkabsg";
        expect(c.is_string).to be false;

        c = Character.new "125125twjfkasn";
        expect(c.is_string).to be false;
    end

    # it "finds a valid symbol" do
    #     c = Character.new ":sym";
    #     expect(c.is_symbol).to be true;

    #     c = Character.new ":asgsagqsg";
    #     expect(c.is_symbol).to be true;
    # end

    # it "finds an invalid symbol" do
    #     c = Character.new ":"
    #     expect(c.is_symbol).to be false;

    #     c = Character.new "afsfas:";
    #     expect(c.is_symbol).to be false;

    #     c = Character.new "sagqw123653561";
    #     expect(c.is_symbol).to be false;

    #     c = Character.new "125125";
    #     expect(c.is_symbol).to be false;

    #     c = Character.new "::";
    #     expect(c.is_symbol).to be false;

    #     c = Character.new "test";
    #     expect(c.is_symbol).to be false;

    #     c = Character.new ":\"\"";
    #     expect(c.is_symbol).to be false;
    # end
end