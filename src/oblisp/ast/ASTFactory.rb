module Abstract
    def abstract_methods(*args)
        args.each do |name|
            class_eval(<<-END, __FILE__, __LINE__)
                def #{name}(*args)
                    raise NotImplementedError.new("Unimplemented #{name}(#{args}).");
                end
            END
        end
    end

    def error(message)
        raise StandardError.new message;
    end
end

class ASTInterface; extend Abstract;
    abstract_methods :quoted_list,
                     :list,
                     :base_ten_literal,
                     :tuple_literal,
                     :hash_literal,
                     :association,
                     :json_association,
                     :symbol_literal,
                     :terminal_SELF,
                     :terminal_SUPER,
                     :terminal_POSITIVE_BASE_TEN_NUMBER,
                     :terminal_ALTERNATE_BASE_NUMBER,
                     :terminal_STRING,
                     :terminal_IDENTIFIER,
                     :terminal_MESSAGE_SYMBOL,
                     :terminal_IDENTIFIER_SYMBOL,
                     :terminal_SIGN;
end

class Default < ASTInterface
    # def program(body)
    #     {
    #         type: "Program",
    #         body: body
    #     };
    # end

    def quoted_list(unit_list)
    end

    def list(unit_list)
    end

    def base_ten_literal(sign, number)
    end

    def tuple_literal(item_list)
    end

    def hash_literal(association_list)
    end

    def association(key, value)
    end

    def json_association(key, value)
    end

    def symbol_literal(id)
    end

    def terminal_SELF(keyword)
    end

    def terminal_SUPER(keyword)
    end

    def terminal_POSITIVE_BASE_TEN_NUMBER(number)
    end

    def terminal_ALTERNATE_BASE_NUMBER(number)
    end

    def terminal_STRING(value)
    end

    def terminal_IDENTIFIER(id)
    end

    def terminal_MESSAGE_SYMBOL(symb)
    end

    def terminal_IDENTIFIER_SYMBOL(symb)
    end

    def terminal_SIGN(symb)
    end
end

class SExpression < ASTInterface
    def quoted_list(unit_list)
        res = "(__quoted__ (";
        (0...unit_list.size-1).each do |i|
            res << unit_list[i] << " ";
        end
        res << unit_list[unit_list.size-1] << "))";
        res;
        # unit_list.each do |unit|
        #     res << unit;
        # end
        # res << "))";
        # res;
    end

    def list(unit_list)
        res = "(";
        (0...unit_list.size-1).each do |i|
            res << unit_list[i] << " ";
        end
        res << unit_list[unit_list.size-1] << ")";
        res;
        # res = "(";
        # unit_list.each do |unit|
        #     res << unit;
        # end
        # res << ")";
        # res;
    end

    def base_ten_literal(sign, number)
        if sign == "-"
            "(negated #{number})";
        else
            number;
        end
    end

    def tuple_literal(item_list)
        res = "(new Tuple (";

        if item_list.size > 0
            (0...item_list.size-1).each do |i|
                res << item_list[i] << " ";
            end
            res << item_list[item_list.size-1];
        end

        res << "))";
        res;
    end

    def hash_literal(association_list)
        res = "(new Hash (";
        (0...association.size-1).each do |i|
            res << association_list[i];
        end
        res << association_list[association_list.size-1] << "))";
        res;
        # res = "(new Hash (";
        # association_list.each do |assoc|
        #     res << assoc;
        # end
        # res << "))";
        # res;
    end

    def association(key, value)
        "(new Association #{key} #{value})";
    end

    def json_association(key, value)
        association ":#{key}", value;
    end

    def symbol_literal(id)
        %Q{(new Symbol "#{id}")};
    end
    
    def terminal_SELF(keyword)
        keyword.value;
    end

    def terminal_SUPER(keyword)
        keyword.value;
    end

    def terminal_POSITIVE_BASE_TEN_NUMBER(number)
        number.value;
    end

    def terminal_ALTERNATE_BASE_NUMBER(number)
        number.value;
    end

    def terminal_STRING(value)
        value.value;
    end

    def terminal_IDENTIFIER(id)
        id.value;
    end

    def terminal_MESSAGE_SYMBOL(symb)
        symb.value;
    end

    def terminal_IDENTIFIER_SYMBOL(symb)
        symb.value;
    end

    def terminal_SIGN(symb)
        symb.value;
    end
end

class ASTFactory
    def generate(ast_type)
        case ast_type
        when "s-expressions"
            SExpression.new;
        else
            Default.new;
        end
    end
end