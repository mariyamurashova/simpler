require_relative 'config/environment'
require_relative 'lib/middleware/logger'

use AppLogger, logdev: File.expand_path('lib/log/app.log', __dir__)
run Simpler.application
