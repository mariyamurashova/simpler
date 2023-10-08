class TestsController < Simpler::Controller

  def index
  render plain: "text plain"
   status 400
   headers['Content-Type'] = 'text/'
  end

  def create

  end

  def show
   @test = Test.find(params)
  end

end
