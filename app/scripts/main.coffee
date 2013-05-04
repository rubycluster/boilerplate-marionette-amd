#global require

"use strict"

require.config

  paths:
    app: "app"
    app_deps: "config/app_deps"
    jquery: "../components/jquery/jquery"
    backbone: "../components/backbone/backbone"
    underscore: "../components/underscore/underscore"
    bootstrap: "vendor/bootstrap"
    backbone_marionette: "../components/backbone.marionette/lib/backbone.marionette"

  shim:

    jquery:
      exports: '$'

    underscore:
      exports: "_"

    backbone:
      exports: "Backbone"
      deps: [
        "underscore"
        "jquery"
      ]

    backbone_marionette:
      exports: "Backbone.Marionette"
      deps: ["backbone"]

    bootstrap:
      exports: "jquery"
      deps: ["jquery"]

    app:
      deps: [ 'app_deps' ]

require ["app", "jquery", "app_deps"], (app, $) ->
  $ ->
    window.app = app
    app.start()
