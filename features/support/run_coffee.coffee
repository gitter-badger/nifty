coffee = require 'coffee-script'


runCoffee = (expression, runContext = {}) ->
  args = Object.keys runContext
  values = args.map (arg) -> runContext[arg]
  javascript = "return #{coffee.compile expression, bare: yes}"
  Function(args..., javascript) values...


module.exports = runCoffee
