// Generated by CoffeeScript 1.9.3
(function() {
  var Layer, Module,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  Module = require('coffeescript-module').Module;

  module.exports = Layer = (function(superClass) {
    extend(Layer, superClass);

    Layer.includes(require('./layer/position_channels.coffee'));

    Layer.includes(require('./layer/blend_modes.coffee'));

    Layer.includes(require('./layer/mask.coffee'));

    Layer.includes(require('./layer/blending_ranges.coffee'));

    Layer.includes(require('./layer/name.coffee'));

    Layer.includes(require('./layer/info.coffee'));

    Layer.includes(require('./layer/helpers.coffee'));

    Layer.includes(require('./layer/channel_image.coffee'));

    function Layer(file, header) {
      this.file = file;
      this.header = header;
      this.mask = {};
      this.blendingRanges = {};
      this.adjustments = {};
      this.channelsInfo = [];
      this.blendMode = {};
      this.groupLayer = null;
      this.infoKeys = [];
      Object.defineProperty(this, 'name', {
        get: function() {
          if (this.adjustments['name'] != null) {
            return this.adjustments['name'].data;
          } else {
            return this.legacyName;
          }
        }
      });
    }

    Layer.prototype.parse = function() {
      var extraLen;
      this.parsePositionAndChannels();
      this.parseBlendModes();
      extraLen = this.file.readInt();
      this.layerEnd = this.file.tell() + extraLen;
      this.parseMaskData();
      this.parseBlendingRanges();
      this.parseLegacyLayerName();
      this.parseLayerInfo();
      console.log("layerEnd: " + this.layerEnd);
      this.file.seek(this.layerEnd);
      return this;
    };

    Layer.prototype.exports = function() {
      return {
        name: this.name,
        top: this.top,
        right: this.right,
        bottom: this.bottom,
        left: this.left,
        width: this.width,
        height: this.height,
        opacity: this.opacity,
        visible: this.visible,
        clipped: this.clipped,
        mask: this.mask["export"]()
      };
    };

    return Layer;

  })(Module);

}).call(this);
