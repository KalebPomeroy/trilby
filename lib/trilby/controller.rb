
class TrilbyController
    def initialize(sinatra)
        @sinatra = sinatra
    end

    def before
        # Empty passthru
    end

    def before_filter
        if self.respond_to? :get_parent_controller
            Kernel.const_get(get_parent_controller).new(@sinatra).before_filter
        end
        before
    end

    def self.parent_controller controller
        define_method(:get_parent_controller) do |method|
            return controller
        end
    end

    def method_missing(meth, *args, &block)
        if @sinatra.respond_to? meth
          @sinatra.send(meth, *args, &block)
        else
          super
        end
    end

    #
    # This magic sauce is what makes trilby work with views.
    #
    def put_on_a_hat

        # set all instance variables we have in the sinatra request object
        self.instance_variables.each { |v|  @sinatra.instance_variable_set(v, self.instance_variable_get(v)) }

    end
        
    #
    # If a template dir is specified, use that (or don't use one if 
    # nil is specified). Otherwise, if the controller has a default 
    # view directory, use that.
    #
    def render template, options={}
        put_on_a_hat

        if options.has_key? :dir
            template = :"#{options[:dir]}/#{template}" if options[:dir]

        elsif view_dir
            template = :"#{view_dir}/#{template}"
        end

        return erubis template, options
    end
end
