define [
  'backbone_marionette'
], (Marionette) ->

  class AppController extends Marionette.Controller

    root: ->
      console.log '[navigate] root'
      $('.container').html app.templates.home()

    missing: ->
      console.log '[navigate] missing'
