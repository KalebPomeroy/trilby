class Trilby < Sinatra::Base
    
    class << self
        alias :super_get :get
        alias :super_put :put
        alias :super_post :post
        alias :super_delete :delete
    end

    @@routes = {}

    #
    # Given a controller and methods (and optionally arguments) this generates
    # a the route to get there. If there are named params, its tries to fill them
    # in with the args passed. Failing that, it uses params already in the URL (so
    # that on if the current request is /posts/:post_id (/posts/32), and you call 
    # url_for on a routes that is /posts/:post_id/comments, params[:post_id] is 
    # automagically filled in with 32. If you want to link to a different posts 
    # comment, simply pass :post_id in the args parameter. 
    #
    def url_for controller, method_name, args={}  
        path = @@routes["#{controller}.#{method_name}"]
        
        puts path
        puts "#{controller}.#{method_name}"
        if args[:format]
            puts args[:format]
            path += ".#{args[:format]}"
        end

        raise "Could not find route for #{controller}.#{method_name}" unless path
        path.gsub!(/:([a-z_])*/) { |p| args[p[1..-1].to_sym] || p }
        path.gsub!(/:([a-z_])*/) { |p| params[p[1..-1]] || p}
        path
    end

    def format
        # TODO: Make this not lame
        (params[:captures]) ? params[:captures][0] : nil
    end


    def self.modify_path http_method, path, controller, method_name, args
        

        # Add the pretty route to the @@routes hash
        if path.is_a? String
            @@routes["#{controller}.#{method_name}"] = path
            path += "/?"
        end

        if args[:formats]
            args[:formats].each do |format| 
                self.send(http_method, %r{#{path}.(#{format})}, controller, method_name, {})
            end
        end

        path
    end


    def self.get path, controller, method_name, args={}
        puts "Adding #{path} to #{controller}.#{method_name}"
        path = Trilby.modify_path :get, path, controller, method_name, args
        instance_eval("super_get(path) { controller.new(self).#{method_name} }")
    end
    def self.put path, controller, method_name, args={}
        path = modify_path :put, path, controller, method_name, args
        instance_eval("super_put(path) { controller.new(self).#{method_name} }")
    end
    def self.post path, controller, method_name, args={}
        path = modify_path :post, path, controller, method_name, args
        instance_eval("super_post(path) { controller.new(self).#{method_name} }")
    end
    def self.delete path, controller, method_name, args={}
        path = modify_path :delete, path, controller, method_name, args
        instance_eval("super_delete(path) { controller.new(self).#{method_name} }")
    end
end 