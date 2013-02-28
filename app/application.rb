require "rubygems"
require "sinatra/base"
require "json"
require "trilby"

Dir.glob('app/controllers/*.rb').each { |file| load file }

class Trilby < Sinatra::Base

    get "/example/one", ExampleController, :example_one
    get "/example/two", ExampleTwoController, :example_two

end 