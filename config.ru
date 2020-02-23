require './config/environment'



use Rack::MethodOverride

use UsersController
use RoulettesController
run ApplicationController