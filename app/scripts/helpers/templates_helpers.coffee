define [
  'vendor/haml_helpers'
], (HAMLHtmlHelpers) ->

  TemplatesHelpers = {}

  _.extend TemplatesHelpers, HAMLHtmlHelpers

  # Add HAML helpers here available from templates
  _.extend TemplatesHelpers,

    # someHelper: ->
    #   'someValue'

  TemplatesHelpers
