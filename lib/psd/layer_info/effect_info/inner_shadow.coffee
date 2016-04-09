Descriptor = require '../../descriptor.coffee'
EffectLayer = require '../effect_layer_info.coffee'

module.exports = class InnerShadow
  @shouldParse: (key) -> key is 'isdw'

  BLEND_MODES = {
  norm: 'normal',
  dark: 'darken',
  lite: 'lighten',
  hue:  'hue',
  sat:  'saturation',
  colr: 'color',
  lum:  'luminosity',
  mul:  'multiply',
  scrn: 'screen',
  diss: 'dissolve',
  over: 'overlay',
  hLit: 'hard_light',
  sLit: 'soft_light',
  diff: 'difference',
  smud: 'exclusion',
  div:  'color_dodge',
  idiv: 'color_burn',
  lbrn: 'linear_burn',
  lddg: 'linear_dodge',
  vLit: 'vivid_light',
  lLit: 'linear_light',
  pLit: 'pin_light',
  hMix: 'hard_mix',
  pass: 'passthru',
  dkCl: 'darker_color',
  lgCl: 'lighter_color',
  fsub: 'subtract',
  fdiv: 'divide'
  }

  constructor: (file,size) ->
    #super(size)
    @file = file

    @version = null #4
    @blur = null #4
    @intensity = null #4
    @angle = null  #4
    @distance = null #4
    @color = null # 2 + 4*2
    @blendmode = null # 4 sig 4 key
    @enbled = null #1
    @angleInAll = null #1
    @opacity = null #1
    @nativeColor = null #2 + 4*2

    @end = @file.tell() + size


  parse: ->
    @version = @file.readInt()
    @blur = @file.readInt()/65536
    @intensity = @file.readInt()/65536
    @angle = @file.readInt()/65536
    @distance = @file.readInt()/65536
    @color = @file.readSpaceColor()

    @file.seek 4, true
    @blendmode = BLEND_MODES[@file.readString(4).trim()]

    @enbled = @file.readBoolean()
    @angleInAll = @file.readByte()
    @opacity = Math.round(@file.readByte()/2.55)
    @nativeColor = @file.readSpaceColor()

    @file.seek @end

  export: ->
    version: @version
    blur: @blur
    intensity: @intensity
    angle: @angle
    distance: @distance
    color: @color
    blendmode: @blendmode
    enbled: @enbled
    angleInAll: @angleInAll
    opacity: @opacity
    nativeColor: @nativeColor
