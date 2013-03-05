
class BaseController
    def initialize(sinatra)
        @sinatra = sinatra
    end

    def sinatra
        return @sinatra
    end
end
