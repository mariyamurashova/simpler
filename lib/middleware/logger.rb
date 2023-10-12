require 'logger'

class AppLogger
  
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STROUT)
    @app = app
  end

  def call(env)
   @logger.info(generate_log(env))
   @app.call(env)
  end

  def generate_log(env)
    "Request: #{env["REQUEST_METHOD"]} #{env["REQUEST_PATH"]} #{env["QUERY_STRING"]}
     Handler: #{@app.router.route_for(env).controller}##{@app.router.route_for(env).action} 
     Parameters:"
  end

end
