local server = require("orange.api.server")
-- global context
local srv = server:new(context.config, context.store)
return srv:get_app()
