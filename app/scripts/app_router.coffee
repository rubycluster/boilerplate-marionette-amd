define [
  'backbone_marionette'
], (Marionette) ->

  class AppRouter extends Marionette.AppRouter

    appRoutes:
      '': 'root'
      # '*defaults': 'missing'
