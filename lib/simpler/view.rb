require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      ERB.new(get_template_or_text_plain).result(binding)
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def template_path
      path = template || [controller.name, action].join('/')
      if path.class ==Hash
        return path 
      else 
        Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
      end
    end

    def get_template_or_text_plain
      text = template_path
      return text[:plain]  if text.class==Hash
      text = File.read(text)
    end
  end

end
