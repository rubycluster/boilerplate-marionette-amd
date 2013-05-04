define [
  'backbone_marionette'
  'views/home_page'
], (Marionette, HomePageView) ->

  class AppController extends Marionette.Controller

    root: ->
      console.log '[navigate] root'
      new HomePageView()

    missing: ->
      console.log '[navigate] missing'
