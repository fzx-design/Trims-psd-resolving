Descriptor = require '../../descriptor.coffee'
EffectLayer = require '../effect_layer_info.coffee'

module.exports = class CommonState
  @shouldParse: (key) -> key is 'cmnS'

  constructor: (file,size) ->
    #super(size)
    @file = file

    @version = null #4
    @visible = null #1

  parse: ->
    @version = @file.readInt()
    @visible = @file.readByte()
    # 2 byte unuse
    @file.seek 2 ,true

  export: ->
    version: @version
    visible: @visible
