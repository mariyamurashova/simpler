require_relative 'router/route'

module Simpler
  class Router

    attr_reader :routes

    def initialize
      @routes = []
    end 

    def get(path, route_point)
      add_route(:get, path, route_point)
    end

    def post(path, route_point)
      add_route(:post, path, route_point)
    end

    def route_for(env)
      method = env['REQUEST_METHOD'].downcase.to_sym
      path = env['PATH_INFO']
      if path_include_id?(path)
        find_route_for_action_show(method,path)
      else
        @routes.find { |route| route.match?(method, path) }
      end  
    end

    private

    def add_route(method, path, route_point)
      route_point = route_point.split('#')
      controller = controller_from_string(route_point[0])
      action = route_point[1]
      route = Route.new(method, path, controller, action)

      @routes.push(route)
    end

    def controller_from_string(controller_name)
      Object.const_get("#{controller_name.capitalize}Controller")
    end

    def path_include_id?(path)
      !(path.split('/'))[2].nil?
    end

    def get_path_for_action_show(path)
      path.split('/').delete_at(1)
    end

    def find_route_for_action_show(method, path)
      
      @routes.find { |route| route.match?(method, "/#{get_path_for_action_show(path)}/:id") }
    end

  end
end
