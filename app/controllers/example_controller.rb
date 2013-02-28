
class ExampleController < BaseController

    # We can define methods that have access to the sinatra application
    # but are not known to every class that has access to sinatra. Additionally,
    # This in no way conflicts with the other methods named the same (which is
    # a particular problem with shoving things in sinatra helpers)
    def controller_specific_logic()
        if sinatra.request.referer =~ /black lagoon/
            return "the black lagoon"
        else
            return "a mysterious place..."
        end

    end

    def example_one
        "It came from " + controller_specific_logic
    end
end

class ExampleTwoController < BaseController
    def controller_specific_logic()
        puts sinatra.request # prove I can access sinatra request object
        return "Return stuff specific to example two"
    end

    def example_two
        controller_specific_logic
    end

end