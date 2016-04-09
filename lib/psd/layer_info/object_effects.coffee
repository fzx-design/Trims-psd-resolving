LayerInfo = require '../layer_info.coffee'
Descriptor = require '../descriptor.coffee'

module.exports = class ObjectEffects extends LayerInfo
  constructor: (layer, length) ->
    super(layer,length)
    @dropshadow = {}
    @innershadow = {}
    @outerglow = {}
    @innerglow = {}
    @bevel = {}
    @stroke = {}
    @satin = {}
    @colorOverlay = {}
    @gradientOverlay = {}
    @patternOverlay = {}

  @shouldParse: (key) -> key is 'lfx2'

  parse: ->
    @file.seek 8, true
    @data = new Descriptor(@file).parse()
    @getDropShadow()
    @getInnerShadow()
    @getOuterGlow()
    @getInnerGlow()
    @getBevel()
    @getStroke()
    @getSatin()
    @getColorOverlay()
    @getGradientOverlay()
    @getPatternOverlay()
    
  getColor: (color) ->
    hash = {}
    hash['type'] = color['class']['id']
    hash['r'] = Math.round color['Rd  ']
    hash['g'] = Math.round color['Grn ']
    hash['b'] = Math.round color['Bl  ']
    return hash

  getGradientColor: (colorArray) ->
    list = []
    for color in colorArray
      hash = {}
      hash['color'] = @getColor(color['Clr '])
      hash['location'] = Math.round color['Lctn']/4096*100
      list.push hash
    return list

  getGradientOpacity: (opacityArray) ->
    list = []
    for opacity in opacityArray
      hash = {}
      hash['opacity'] = opacity['Opct']['value']
      hash['location'] = Math.round opacity['Lctn']/4096*100
      list.push hash
    return list
   
  getGradient: (gradient)->
    hash = {}
    hash['angle'] = gradient['Angl']['value']
    hash['style'] = gradient['Type']['value']
    hash['reverse'] = gradient['Rvrs']
    hash['Dither'] = gradient['Dthr']
    hash['AlignWithLayer'] = gradient['Algn']
    hash['scale'] = gradient['Scl ']['value']
    hash['gradientName'] = gradient['Grad']['Nm  ']
    hash['gradientType'] = gradient['Grad']['GrdF']['value']
    hash['gradientColor'] = @getGradientColor(gradient['Grad']['Clrs'])
    hash['gradientOpacity'] = @getGradientOpacity(gradient['Grad']['Trns'])
    return hash
     
 
  getDropShadow: ->
    DrSh = @data['DrSh']
    if DrSh?
      @dropshadow['enbled'] = DrSh['enab']
      @dropshadow['blendmode'] = DrSh['Md  ']['value']
      @dropshadow['color'] = @getColor(DrSh['Clr '])
      @dropshadow['opacity'] = DrSh['Opct']['value']
      @dropshadow['useGlobalLight'] = DrSh['uglg']
      @dropshadow['angle'] = DrSh['lagl']['value']
      @dropshadow['distance'] = DrSh['Dstn']['value']
      @dropshadow['Spread'] = DrSh['Ckmt']['value']
      @dropshadow['size'] = DrSh['blur']['value']
      @dropshadow['noise'] = DrSh['Nose']['value']
      @dropshadow['anti-aliasing'] = DrSh['AntA']
    
  getInnerShadow: ->
    IrSh = @data['IrSh']
    if IrSh?
      @innershadow['enbled'] = IrSh['enab']
      @innershadow['blendmode'] = IrSh['Md  ']['value']
      @innershadow['color'] = @getColor(IrSh['Clr '])
      @innershadow['opacity'] = IrSh['Opct']['value']
      @innershadow['useGlobalLight'] = IrSh['uglg']
      @innershadow['angle'] = IrSh['lagl']['value']
      @innershadow['distance'] = IrSh['Dstn']['value']
      @innershadow['Spread'] = IrSh['Ckmt']['value']
      @innershadow['size'] = IrSh['blur']['value']
      @innershadow['noise'] = IrSh['Nose']['value']
      @innershadow['anti-aliasing'] = IrSh['AntA']
      
  getOuterGlow: ->
    OrGl = @data['OrGl']
    if OrGl?
      @outerglow['enbled'] = OrGl['enab']
      @outerglow['blendmode'] = OrGl['Md  ']['value']
      @outerglow['color'] = @getColor(OrGl['Clr '])
      @outerglow['opacity'] = OrGl['Opct']['value']
      @outerglow['Technique'] = OrGl['GlwT']['value']
      @outerglow['useGlobalLight'] = OrGl['uglg']
      @outerglow['Spread'] = OrGl['Ckmt']['value']
      @outerglow['size'] = OrGl['blur']['value']
      @outerglow['noise'] = OrGl['Nose']['value']
      @outerglow['anti-aliasing'] = OrGl['AntA']
      @outerglow['range'] = OrGl['Inpr']['value']
 
  getInnerGlow: ->
    IrGl = @data['IrGl']
    if IrGl?
      @innerglow['enbled'] = IrGl['enab']
      @innerglow['blendmode'] = IrGl['Md  ']['value']
      @innerglow['color'] = @getColor(IrGl['Clr '])
      @innerglow['opacity'] = IrGl['Opct']['value']
      @innerglow['technique'] = IrGl['GlwT']['value']
      @innerglow['useGlobalLight'] = IrGl['uglg']
      @innerglow['Spread'] = IrGl['Ckmt']['value']
      @innerglow['size'] = IrGl['blur']['value']
      @innerglow['noise'] = IrGl['Nose']['value']
      @innerglow['anti-aliasing'] = IrGl['AntA']
      @innerglow['range'] = IrGl['Inpr']['value']  
      
  getBevel: ->
    ebbl = @data['ebbl']
    if ebbl?
      @bevel['enbled'] = ebbl['enab']
      @bevel['hightLightMode'] = ebbl['hglM']['value']
      @bevel['hightLightColor'] = @getColor(ebbl['hglC'])
      @bevel['hightLightOpacity'] = ebbl['hglO']['value']
      @bevel['shadowMode'] = ebbl['sdwM']['value']
      @bevel['shadowColor'] = @getColor(ebbl['sdwC'])
      @bevel['shadowOpacity'] = ebbl['sdwO']['value']
      @bevel['technique'] = ebbl['bvlT']['value']
      @bevel['style'] = ebbl['bvlS']['value']
      @bevel['useGlobalLight'] = ebbl['uglg']
      @bevel['angle'] = ebbl['lagl']['value']
      @bevel['altitude'] = ebbl['Lald']['value']
      @bevel['depth'] = ebbl['srgR']['value']
      @bevel['size'] = ebbl['blur']['value']
      @bevel['direction'] = ebbl['bvlD']['value']
      @bevel['antialiasGloss'] = ebbl['antialiasGloss']
      @bevel['soften'] = ebbl['Sftn']['value']
      @bevel['useShape'] = ebbl['useShape']
      if @bevel['useShape'] is true
        @bevel['anti-aliasing'] = ebbl['AntA']
        @bevel['range'] = ebbl['Inpr']['value']
      @bevel['useTexture'] = ebbl['useTexture']
      if @bevel['useTexture'] is true
        @bevel['invert'] = ebbl['InvT']
        @bevel['linkWithLayer'] = ebbl['Algn']
        @bevel['scale'] = ebbl['Scl ']['value']
        @bevel['textureDepth'] = ebbl['textureDepth']['value']
        
  getStroke: ->
    FrFX = @data['FrFX']
    if FrFX?
      @stroke['enbled'] = FrFX['enab']
      @stroke['blendmode'] = FrFX['Md  ']['value']
      @stroke['position'] = FrFX['Styl']['value']
      @stroke['size'] = FrFX['Sz  ']['value']
      @stroke['opacity'] = FrFX['Opct']['value']
      
      @stroke['fillType'] = FrFX['PntT']['value']
      switch @stroke['fillType']
        when 'SClr' 
          @stroke['fillType'] = 'soildColor'
          @stroke['solidColor'] = {}
          @stroke['solidColor']['color'] = @getColor(FrFX['Clr '])
        when 'GrFl'
          @stroke['fillType'] = 'gradient'
          @stroke['gradient'] = @getGradient(FrFX)
          @stroke['gradient']['color'] = @getColor(FrFX['Clr '])
  
  getSatin: ->
    ChFX = @data['ChFX']
    if ChFX?
      @satin['enbled'] = ChFX['enab']
      @satin['blendmode'] = ChFX['Md  ']['value']
      @satin['color'] = @getColor(ChFX['Clr '])
      @satin['anti-aliased'] = ChFX['AntA']
      @satin['invert'] = ChFX['Invr']
      @satin['opacity'] = ChFX['Opct']['value']
      @satin['angle'] = ChFX['lagl']['value']
      @satin['distance'] = ChFX['Dstn']['value']
      @satin['size'] = ChFX['blur']['value']

  getColorOverlay: ->
    SoFi = @data['SoFi']
    if SoFi?
      @colorOverlay['enbled'] = SoFi['enab']
      @colorOverlay['blendmode'] = SoFi['Md  ']['value']
      @colorOverlay['opacity'] = SoFi['Opct']['value']
      @colorOverlay['color'] = @getColor(SoFi['Clr '])
   
  getGradientOverlay: ->
    GrFl = @data['GrFl']
    if GrFl?
      @gradientOverlay = {}
      @gradientOverlay['gradient'] = @getGradient(GrFl)
      @gradientOverlay['enbled'] = GrFl['enab']
      @gradientOverlay['blendmode'] = GrFl['Md  ']['value']
      @gradientOverlay['opacity'] = GrFl['Opct']['value']

  getPatternOverlay: ->
    patternFill = @data['patternFill']
    if patternFill?
      @patternOverlay = {}
      @patternOverlay['enbled'] = patternFill['enab']
      @patternOverlay['blendmode'] = patternFill['Md  ']['value']
      @patternOverlay['opacity'] = patternFill['Opct']['value']
      @patternOverlay['scale']= patternFill['Scl ']['value']
      
    
  export: ->
    dropShaow: @dropshadow
    InnerShadow: @innershadow
    OuterGlow: @outerglow
    InnerGlow: @innerglow
    Bevel: @bevel
    Stroke: @stroke
    Satin: @satin
    ColorOverlay: @colorOverlay
    GradientOverlay: @gradientOverlay
    PatternOverlay: @patternOverlay