// Generated by CoffeeScript 1.10.0
var Convolution, Module;

Module = require('coffeescript-module').Module;

Convolution = require('./Convolution.coffee');

module.exports = function(pixels) {
  var divider, opeartor;
  divider = 9;
  opeartor = [1 / divider, 1 / divider, 1 / divider, 1 / divider, 1 / divider, 1 / divider, 1 / divider, 1 / divider, 1 / divider];
  return Convolution(pixels, opeartor);
};