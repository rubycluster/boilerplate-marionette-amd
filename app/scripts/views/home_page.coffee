define [
  'backbone_marionette'
  'templates/home'
], (Marionette, template) ->

  class HomePageView extends Marionette.ItemView

    template: template

    el: '.container'

    initialize: ->
      @render()
      @
