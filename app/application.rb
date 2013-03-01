require "rubygems"
require "sinatra/base"
require "json"
require "trilby"

Dir.glob('app/controllers/*.rb').each { |file| load file }

class Trilby < Sinatra::Base

    get "/example/one", ExampleController, :example_one
    get "/example/two", ExampleTwoController, :example_two
    get "/example/three/:id", ExampleTwoController, :example_three
    get "/example/four", ExampleTwoController, :example_four, :formats=>[:json, :html]

    #
    # context "/accounts/:account_id" do 
    #   before_filter AccountController, :account_details
    # 
    #   get "", :show, :format => [:json, :xml, :html]
    #   post "", :update, :skip_filter => [:account_details]
    #   get "/servers", ServersController, :list
    #   get "/servers/:server_id", ServersController, :show
    #
    #   context "/servers/:server_id" do 
    #       before_filter ServersController, :server_details
    #       get "/images", ImagesController, :list
        # end
    #    
    # end

end 