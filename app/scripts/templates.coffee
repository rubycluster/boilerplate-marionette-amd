# List all templates here and access them via requirejs by Templates hash

keys = [
  'home'
]

pathRoot = 'templates'

pathsMap = _(keys).reduce (memo, key) ->
  memo[key] = [pathRoot, key].join '/'
  memo
, {}

define _(pathsMap).values(), () ->
  _(arguments).reduce (memo, fn, index) ->
    key = keys[index]
    memo[key] = fn
    memo
  , {}
