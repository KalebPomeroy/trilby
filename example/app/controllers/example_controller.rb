
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
        next_url = sinatra.url_for ExampleTwoController, :example_two
        "It came from " + controller_specific_logic + 
            "<br /><a href='#{next_url}'>#{next_url}</a>" 
    end
end

class ExampleTwoController < BaseController

    def example_two
        next_url = sinatra.url_for ExampleTwoController, :example_three, :id=>3

        "This is example two" +
            "<br /><a href='#{next_url}'>#{next_url}</a>" 
    end

    def example_three
        next_url = {
            :json => sinatra.url_for(ExampleTwoController, :example_four, :format=>:json),
            :html =>sinatra.url_for(ExampleTwoController, :example_four, :format=>:html),
            :default =>sinatra.url_for(ExampleTwoController, :example_four)
        }

        sinatra.params[:id] + " is the ID" +
            "<br /><a href='#{next_url[:json]}'>#{next_url[:json]}</a>" +
            "<br /><a href='#{next_url[:html]}'>#{next_url[:html]}</a>" +
            "<br /><a href='#{next_url[:default]}'>#{next_url[:default]}</a>" 

    end

    def example_four

        data = {'data'=>'this is your datas'}
        return data.to_json if sinatra.format=="json"
        
        "HTML says hi"
        
    end

end