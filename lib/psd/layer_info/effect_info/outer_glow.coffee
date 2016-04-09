

module.exports = class OuterGlow
  @shouldParse: (key) -> key is 'oglw'

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

  constructor: (file, size) ->
    @file = file

    @version = null #4
    @blur = null #4
    @intensity = null #4
    @color = null #10
    @blendmode = null #4+4
    @embled = null #1
    @opacity = null #1

    @invert = null #1
    @native_color = null #10

    @end = @file.tell() + size

  parse: ->
    @version = @file.readInt()
    @blur = @file.readInt()/65536
    @intensity = @file.readInt()/65536
    @color = @file.readSpaceColor()

    @file.seek 4, true
    @blendmode = @file.readString(4)
    @enbled = @file.readBoolean()
    @opacity = Math.round(@file.readByte()/2.55)

    @invert = @file.readByte()
    @nativeColor = @file.readSpaceColor()

    @file.seek @end

  export: ->
    version: @version
    blur: @blur
    intensity: @intensity
    color: @color
    blendmode: @blendmode
    enbled: @enbled
    opacity: @opacity
    invert: @invert
    nativeColor: @nativeColor






