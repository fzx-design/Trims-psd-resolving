// Generated by CoffeeScript 1.9.3
(function() {
  var Descriptor, LayerInfo, ObjectEffects,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  LayerInfo = require('../layer_info.coffee');

  Descriptor = require('../descriptor.coffee');

  module.exports = ObjectEffects = (function(superClass) {
    extend(ObjectEffects, superClass);

    function ObjectEffects(layer, length) {
      ObjectEffects.__super__.constructor.call(this, layer, length);
      this.dropshadow = {};
      this.innershadow = {};
      this.outerglow = {};
      this.innerglow = {};
      this.bevel = {};
      this.stroke = {};
      this.satin = {};
      this.colorOverlay = {};
      this.gradientOverlay = {};
      this.patternOverlay = {};
    }

    ObjectEffects.shouldParse = function(key) {
      return key === 'lfx2';
    };

    ObjectEffects.prototype.parse = function() {
      this.file.seek(8, true);
      this.data = new Descriptor(this.file).parse();
      this.getDropShadow();
      this.getInnerShadow();
      this.getOuterGlow();
      this.getInnerGlow();
      this.getBevel();
      this.getStroke();
      this.getSatin();
      this.getColorOverlay();
      this.getGradientOverlay();
      return this.getPatternOverlay();
    };

    ObjectEffects.prototype.getColor = function(color) {
      var hash;
      hash = {};
      hash['type'] = color['class']['id'];
      hash['r'] = Math.round(color['Rd  ']);
      hash['g'] = Math.round(color['Grn ']);
      hash['b'] = Math.round(color['Bl  ']);
      return hash;
    };

    ObjectEffects.prototype.getGradientColor = function(colorArray) {
      var color, hash, i, len, list;
      list = [];
      for (i = 0, len = colorArray.length; i < len; i++) {
        color = colorArray[i];
        hash = {};
        hash['color'] = this.getColor(color['Clr ']);
        hash['location'] = Math.round(color['Lctn'] / 4096 * 100);
        list.push(hash);
      }
      return list;
    };

    ObjectEffects.prototype.getGradientOpacity = function(opacityArray) {
      var hash, i, len, list, opacity;
      list = [];
      for (i = 0, len = opacityArray.length; i < len; i++) {
        opacity = opacityArray[i];
        hash = {};
        hash['opacity'] = opacity['Opct']['value'];
        hash['location'] = Math.round(opacity['Lctn'] / 4096 * 100);
        list.push(hash);
      }
      return list;
    };

    ObjectEffects.prototype.getGradient = function(gradient) {
      var hash;
      hash = {};
      hash['angle'] = gradient['Angl']['value'];
      hash['style'] = gradient['Type']['value'];
      hash['reverse'] = gradient['Rvrs'];
      hash['Dither'] = gradient['Dthr'];
      hash['AlignWithLayer'] = gradient['Algn'];
      hash['scale'] = gradient['Scl ']['value'];
      hash['gradientName'] = gradient['Grad']['Nm  '];
      hash['gradientType'] = gradient['Grad']['GrdF']['value'];
      hash['gradientColor'] = this.getGradientColor(gradient['Grad']['Clrs']);
      hash['gradientOpacity'] = this.getGradientOpacity(gradient['Grad']['Trns']);
      return hash;
    };

    ObjectEffects.prototype.getDropShadow = function() {
      var DrSh;
      DrSh = this.data['DrSh'];
      if (DrSh != null) {
        this.dropshadow['enbled'] = DrSh['enab'];
        this.dropshadow['blendmode'] = DrSh['Md  ']['value'];
        this.dropshadow['color'] = this.getColor(DrSh['Clr ']);
        this.dropshadow['opacity'] = DrSh['Opct']['value'];
        this.dropshadow['useGlobalLight'] = DrSh['uglg'];
        this.dropshadow['angle'] = DrSh['lagl']['value'];
        this.dropshadow['distance'] = DrSh['Dstn']['value'];
        this.dropshadow['Spread'] = DrSh['Ckmt']['value'];
        this.dropshadow['size'] = DrSh['blur']['value'];
        this.dropshadow['noise'] = DrSh['Nose']['value'];
        return this.dropshadow['anti-aliasing'] = DrSh['AntA'];
      }
    };

    ObjectEffects.prototype.getInnerShadow = function() {
      var IrSh;
      IrSh = this.data['IrSh'];
      if (IrSh != null) {
        this.innershadow['enbled'] = IrSh['enab'];
        this.innershadow['blendmode'] = IrSh['Md  ']['value'];
        this.innershadow['color'] = this.getColor(IrSh['Clr ']);
        this.innershadow['opacity'] = IrSh['Opct']['value'];
        this.innershadow['useGlobalLight'] = IrSh['uglg'];
        this.innershadow['angle'] = IrSh['lagl']['value'];
        this.innershadow['distance'] = IrSh['Dstn']['value'];
        this.innershadow['Spread'] = IrSh['Ckmt']['value'];
        this.innershadow['size'] = IrSh['blur']['value'];
        this.innershadow['noise'] = IrSh['Nose']['value'];
        return this.innershadow['anti-aliasing'] = IrSh['AntA'];
      }
    };

    ObjectEffects.prototype.getOuterGlow = function() {
      var OrGl;
      OrGl = this.data['OrGl'];
      if (OrGl != null) {
        this.outerglow['enbled'] = OrGl['enab'];
        this.outerglow['blendmode'] = OrGl['Md  ']['value'];
        this.outerglow['color'] = this.getColor(OrGl['Clr ']);
        this.outerglow['opacity'] = OrGl['Opct']['value'];
        this.outerglow['Technique'] = OrGl['GlwT']['value'];
        this.outerglow['useGlobalLight'] = OrGl['uglg'];
        this.outerglow['Spread'] = OrGl['Ckmt']['value'];
        this.outerglow['size'] = OrGl['blur']['value'];
        this.outerglow['noise'] = OrGl['Nose']['value'];
        this.outerglow['anti-aliasing'] = OrGl['AntA'];
        return this.outerglow['range'] = OrGl['Inpr']['value'];
      }
    };

    ObjectEffects.prototype.getInnerGlow = function() {
      var IrGl;
      IrGl = this.data['IrGl'];
      if (IrGl != null) {
        this.innerglow['enbled'] = IrGl['enab'];
        this.innerglow['blendmode'] = IrGl['Md  ']['value'];
        this.innerglow['color'] = this.getColor(IrGl['Clr ']);
        this.innerglow['opacity'] = IrGl['Opct']['value'];
        this.innerglow['technique'] = IrGl['GlwT']['value'];
        this.innerglow['useGlobalLight'] = IrGl['uglg'];
        this.innerglow['Spread'] = IrGl['Ckmt']['value'];
        this.innerglow['size'] = IrGl['blur']['value'];
        this.innerglow['noise'] = IrGl['Nose']['value'];
        this.innerglow['anti-aliasing'] = IrGl['AntA'];
        return this.innerglow['range'] = IrGl['Inpr']['value'];
      }
    };

    ObjectEffects.prototype.getBevel = function() {
      var ebbl;
      ebbl = this.data['ebbl'];
      if (ebbl != null) {
        this.bevel['enbled'] = ebbl['enab'];
        this.bevel['hightLightMode'] = ebbl['hglM']['value'];
        this.bevel['hightLightColor'] = this.getColor(ebbl['hglC']);
        this.bevel['hightLightOpacity'] = ebbl['hglO']['value'];
        this.bevel['shadowMode'] = ebbl['sdwM']['value'];
        this.bevel['shadowColor'] = this.getColor(ebbl['sdwC']);
        this.bevel['shadowOpacity'] = ebbl['sdwO']['value'];
        this.bevel['technique'] = ebbl['bvlT']['value'];
        this.bevel['style'] = ebbl['bvlS']['value'];
        this.bevel['useGlobalLight'] = ebbl['uglg'];
        this.bevel['angle'] = ebbl['lagl']['value'];
        this.bevel['altitude'] = ebbl['Lald']['value'];
        this.bevel['depth'] = ebbl['srgR']['value'];
        this.bevel['size'] = ebbl['blur']['value'];
        this.bevel['direction'] = ebbl['bvlD']['value'];
        this.bevel['antialiasGloss'] = ebbl['antialiasGloss'];
        this.bevel['soften'] = ebbl['Sftn']['value'];
        this.bevel['useShape'] = ebbl['useShape'];
        if (this.bevel['useShape'] === true) {
          this.bevel['anti-aliasing'] = ebbl['AntA'];
          this.bevel['range'] = ebbl['Inpr']['value'];
        }
        this.bevel['useTexture'] = ebbl['useTexture'];
        if (this.bevel['useTexture'] === true) {
          this.bevel['invert'] = ebbl['InvT'];
          this.bevel['linkWithLayer'] = ebbl['Algn'];
          this.bevel['scale'] = ebbl['Scl ']['value'];
          return this.bevel['textureDepth'] = ebbl['textureDepth']['value'];
        }
      }
    };

    ObjectEffects.prototype.getStroke = function() {
      var FrFX;
      FrFX = this.data['FrFX'];
      if (FrFX != null) {
        this.stroke['enbled'] = FrFX['enab'];
        this.stroke['blendmode'] = FrFX['Md  ']['value'];
        this.stroke['position'] = FrFX['Styl']['value'];
        this.stroke['size'] = FrFX['Sz  ']['value'];
        this.stroke['opacity'] = FrFX['Opct']['value'];
        this.stroke['fillType'] = FrFX['PntT']['value'];
        switch (this.stroke['fillType']) {
          case 'SClr':
            this.stroke['fillType'] = 'soildColor';
            this.stroke['solidColor'] = {};
            return this.stroke['solidColor']['color'] = this.getColor(FrFX['Clr ']);
          case 'GrFl':
            this.stroke['fillType'] = 'gradient';
            this.stroke['gradient'] = this.getGradient(FrFX);
            return this.stroke['gradient']['color'] = this.getColor(FrFX['Clr ']);
        }
      }
    };

    ObjectEffects.prototype.getSatin = function() {
      var ChFX;
      ChFX = this.data['ChFX'];
      if (ChFX != null) {
        this.satin['enbled'] = ChFX['enab'];
        this.satin['blendmode'] = ChFX['Md  ']['value'];
        this.satin['color'] = this.getColor(ChFX['Clr ']);
        this.satin['anti-aliased'] = ChFX['AntA'];
        this.satin['invert'] = ChFX['Invr'];
        this.satin['opacity'] = ChFX['Opct']['value'];
        this.satin['angle'] = ChFX['lagl']['value'];
        this.satin['distance'] = ChFX['Dstn']['value'];
        return this.satin['size'] = ChFX['blur']['value'];
      }
    };

    ObjectEffects.prototype.getColorOverlay = function() {
      var SoFi;
      SoFi = this.data['SoFi'];
      if (SoFi != null) {
        this.colorOverlay['enbled'] = SoFi['enab'];
        this.colorOverlay['blendmode'] = SoFi['Md  ']['value'];
        this.colorOverlay['opacity'] = SoFi['Opct']['value'];
        return this.colorOverlay['color'] = this.getColor(SoFi['Clr ']);
      }
    };

    ObjectEffects.prototype.getGradientOverlay = function() {
      var GrFl;
      GrFl = this.data['GrFl'];
      if (GrFl != null) {
        this.gradientOverlay = {};
        this.gradientOverlay['gradient'] = this.getGradient(GrFl);
        this.gradientOverlay['enbled'] = GrFl['enab'];
        this.gradientOverlay['blendmode'] = GrFl['Md  ']['value'];
        return this.gradientOverlay['opacity'] = GrFl['Opct']['value'];
      }
    };

    ObjectEffects.prototype.getPatternOverlay = function() {
      var patternFill;
      patternFill = this.data['patternFill'];
      if (patternFill != null) {
        this.patternOverlay = {};
        this.patternOverlay['enbled'] = patternFill['enab'];
        this.patternOverlay['blendmode'] = patternFill['Md  ']['value'];
        this.patternOverlay['opacity'] = patternFill['Opct']['value'];
        return this.patternOverlay['scale'] = patternFill['Scl ']['value'];
      }
    };

    ObjectEffects.prototype["export"] = function() {
      return {
        dropShaow: this.dropshadow,
        InnerShadow: this.innershadow,
        OuterGlow: this.outerglow,
        InnerGlow: this.innerglow,
        Bevel: this.bevel,
        Stroke: this.stroke,
        Satin: this.satin,
        ColorOverlay: this.colorOverlay,
        GradientOverlay: this.gradientOverlay,
        PatternOverlay: this.patternOverlay
      };
    };

    return ObjectEffects;

  })(LayerInfo);

}).call(this);
