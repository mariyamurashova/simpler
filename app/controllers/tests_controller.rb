class TestsController < Simpler::Controller

  def index
   render plain: "Plain text response"
   status 400
   headers['Content-Type'] = 'text/'
  end

  def create

  end

end
