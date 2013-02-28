[Trilby](http://en.wikipedia.org/wiki/Trilby) , because is sits on top of Sinatra.

This allows a user to write sinatra routes with a smart DSL like so
```
    # get route, class, method_name
    get "/example/one", ExampleController, :example_one
```

It also allows a controller to have access to methods that the rest of the application does not. Typically
with Sinatra, if you need to call a method, you have to add it to the helper class, which become dirty very quickly. 

```
    def controller_specific_logic()
        if sinatra.request.referer =~ /black.lagoon/
            return "the black lagoon"
        else
            return "a mysterious place..."
        end

    end

    def example_one
        "It came from " + controller_specific_logic
    end
```