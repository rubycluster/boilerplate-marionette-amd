'use strict'

define [
  'backbone'
  'backbone_marionette'
  'templates'
  'vent'
  'app_controller'
  'app_router'
  'app_deps'
], (Backbone, Marionette, Templates, vent, AppController, AppRouter) ->

  Marionette.Renderer.render = (template, data) ->
    if typeof template is 'string' and typeof Templates[template] is 'function'
      Templates[template](data)
    else if typeof template is 'function'
      template(data)
    else
      console.log '[marionette] template is not found:', template

  app = new Marionette.Application()

  app.vent = vent

  app.templates = Templates

  app.on "initialize:before", (options) =>

  app.on "initialize:after", (options) =>
    Backbone.history.start
      pushState: false
      root: '/'

  app.addInitializer ->
    app.appController = new AppController()
    app.appRouter = new AppRouter
      controller: app.appController

  app
