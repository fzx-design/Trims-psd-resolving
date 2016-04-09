_ = require 'lodash'
parseEngineData = require 'parse-engine-data'
LayerInfo = require '../layer_info.coffee'
Descriptor = require '../descriptor.coffee'
LazyExecute = require '../lazy_execute.coffee'

EFFECT_TYPE = {
commonState:  require('../layer_info/effect_info/common_state.coffee')
dropShadow:   require('../layer_info/effect_info/drop_shadow.coffee')
innerShadow:  require('../layer_info/effect_info/inner_shadow.coffee')
outerGlow:    require('../layer_info/effect_info/outer_glow.coffee')
innerGlow:    require('../layer_info/effect_info/inner_glow.coffee')
#bevel:        require('../layer_info/layer_name_source.coffee')
#sofi:         require('../layer_info/legacy_typetool.coffee')
}

module.exports = class EffectLayerInfo extends LayerInfo
  @shouldParse: (key) -> key is 'lrFX'

  constructor: (layer, length) ->
    super(layer, length)

    @version = null      #2
    @effectCount = null  #2

    #@signature
    @type_key = null
    @block_size = null

    #effect_layer_info_detail
    @Detail = []

  parse: ->
    @version = @file.readShort()
    @effectCount = @file.readShort()

    for i in [0...@effectCount]
      @file.seek 4, true # sig
      @type_key = @file.readString(4)
      @block_size = @file.readInt()
      console.log("key: " + @type_key + " size: " + @block_size + "pos: " + @file.tell())
      keyParseable = false
      for own name, klass of EFFECT_TYPE
        continue unless klass.shouldParse(@type_key)
        i = new klass(@file,@block_size)
        @Detail[name] = i.parse()
        console.log(i.export())
        keyParseable = true
        break;

      # if not parse
      @file.seek @block_size, true if not keyParseable

  # to do add export function
  export: ->
    key : @type_key




