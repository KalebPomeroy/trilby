class Trilby < Sinatra::Base
    
    class << self
        alias :super_get :get
        alias :super_put :put
        alias :super_post :post
        alias :super_delete :delete
    end

    def self.get path, controller, method_name
        instance_eval("super_get(path) { controller.new(self).#{method_name} }")
    end
    def self.put path, controller, method_name
        instance_eval("super_put(path) { controller.new(self).#{method_name} }")
    end
    def self.post path, controller, method_name
        instance_eval("super_post(path) { controller.new(self).#{method_name} }")
    end
    def self.delete path, controller, method_name
        instance_eval("super_delete(path) { controller.new(self).#{method_name} }")
    end
end 