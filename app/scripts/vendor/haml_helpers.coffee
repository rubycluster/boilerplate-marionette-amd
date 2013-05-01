# source: https://gist.github.com/marioizquierdo/2dfb0f4afcdbc549e10b
#
# HTML Tag class
#
# Programmatically generate HTML so you aren't scotch-taping strings together all the time.
# Usage: targetString = Tag.make(tagName, attributeHash, text)
# The text is NOT escaped by default. Use the special attribute 'escapeText': true to escape the inner text.

define [], () ->

  class Tag
    constructor: (@tagName, @attributes = {}, @text = "") ->
      if @attributes['escapeText']
        delete @attributes['escapeText']
        @text = HAML.escape(@text)

    # Create a tag as string
    @make: (tagName, attributes, text) ->
      t = new Tag(tagName, attributes, text)
      t.toString()

    openTag: ->
      close = if @text then '>' else ' />'
      attributeStrings = []
      attributeStrings.push("#{key}=\"#{attribute}\"") for key, attribute of @attributes
      attributeString = if attributeStrings.length > 0 then ' ' + attributeStrings.join(' ') else ''

      "<#{@tagName}#{attributeString}#{close}"

    closeTag: (tagName) ->
      "</#{@tagName}>"

    toString: ->
      s = ''
      s += @openTag()
      s += @text
      s += @closeTag() if @text
      s


  HAMLHtmlHelpers =

    Tag: Tag

    linkTo: (name, href, attrs = {}) ->
      attrs['href'] ||= href
      Tag.make 'a', attrs, name

    textField: (name, value = "", attrs = {}) ->
      attrs['type']  = 'text'
      attrs['name']  = name
      attrs['value'] = value
      Tag.make 'input', attrs

    passwordField: (name, value = "", attrs = {}) ->
      attrs['type']  = 'password'
      attrs['name']  = name
      attrs['value'] = value
      Tag.make 'input', attrs

    fileField: (name, attrs = {}) ->
      attrs['name'] = name
      attrs['type'] = 'file'
      Tag.make 'input', attrs

    textarea: (name, value = "", attrs = {}) ->
      attrs['name'] = name
      Tag.make 'textarea', attrs, value

    # Create a select tag with options
    # @param collection is used to create the options. Can be an Array of Strings (used as text and value), or Array of [text, value]
    # @params attrs can include the options:
    #   * selected: value of the option that should be selected
    #   * caption: Text to use as first option (blank with blank value)
    #   * any other option will be used as HTML attribute in the select tag
    # Examples:
    #   select('country', ['US', 'ES', 'GB', 'SE'], {id: 'country-selector', selected: 'ES'})
    #   select('language', [['English', 'en'], ['Spanish', 'es']], {caption: 'Select Language'})
    select: (name, collection = [], attrs = {}) ->
      attrs['name'] = name
      selectBody = []
      selectBody.push Tag.make('option', {value: ''}, attrs['caption']) if attrs['caption']
      for opt in collection
        if opt instanceof Array
          body = opt[0]
          value = opt[1]
        else
          body  = opt
          value = opt
        selectOptions = {}
        selectOptions['value'] = value
        selectOptions['selected'] = 'selected' if attrs['selected'] && attrs['selected'].toString() == value.toString()
        selectOptions['escapeText'] = true
        selectBody.push Tag.make('option', selectOptions, body)

      delete attrs['selected']
      delete attrs['caption']
      Tag.make 'select', attrs, selectBody.join('')

    checkBox: (name, value = 1, checked = false, attrs = {}) ->
      attrs['type']   = 'checkbox'
      attrs['name']   = name
      attrs['id']     ||= name
      attrs['value']  = value
      if checked
        attrs['checked'] = 'checked'
      Tag.make 'input', attrs, null

    label: (name, content = "", attrs = {}) ->
      attrs['for'] = name
      Tag.make 'label', attrs, content

    submit: (value = "", attrs = {}) ->
      attrs['type']   = 'submit'
      attrs['value']  = value
      Tag.make 'input', attrs

  HAMLHtmlHelpers

