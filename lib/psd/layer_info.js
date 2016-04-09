// Generated by CoffeeScript 1.9.3
(function() {
  var LayerInfo;

  module.exports = LayerInfo = (function() {
    function LayerInfo(layer, length) {
      this.layer = layer;
      this.length = length;
      this.file = this.layer.file;
      this.section_end = this.file.tell() + this.length;
      this.data = {};
    }

    LayerInfo.prototype.skip = function() {
      return this.file.seek(this.section_end);
    };

    LayerInfo.prototype.parse = function() {
      return this.skip();
    };

    return LayerInfo;

  })();

}).call(this);