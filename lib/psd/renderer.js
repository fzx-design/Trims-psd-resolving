// Generated by CoffeeScript 1.10.0
var Canvas, Module, Renderer, _,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

_ = require('lodash');

Module = require('coffeescript-module').Module;

Canvas = require('./renderer/canvas.coffee');

module.exports = Renderer = (function(superClass) {
  extend(Renderer, superClass);

  function Renderer(node, _opts) {
    this.node = node;
    this._opts = _opts;
    this.root_node = this.node;
    this.opts = this._opts;
    this.canvas_stack = [];
    this.node_stack = [this.root_node];
    this.pixel = [];
    this.rendered = false;
  }

  Renderer.prototype.width = function() {
    return this.root_node.width;
  };

  Renderer.prototype.height = function() {
    return this.root_node.height;
  };

  Renderer.prototype.render = function(output) {
    var canvas;
    console.log("Beginning render process");
    canvas = new Canvas(this.root_node, null, null, null);
    canvas.paint_to();
    canvas.CanvasToPng(output);
    return this.rendered = true;
  };

  Renderer.prototype.execute_pipeline = function() {
    return console.log("Executing pipeline on" + this.active_node().name);
  };

  Renderer.prototype.to_png = function() {
    if (!rendered) {
      this.render();
      return this.active_canvas.canvas;
    }
  };

  Renderer.prototype.children = function() {
    if (this.active_node().layer != null) {
      return [this.active_node()];
    } else {
      return this.active_node().children;
    }
  };

  Renderer.prototype.push_node = function(node) {
    this.node = node;
    return this.node_stack.push(this.node);
  };

  Renderer.prototype.pop_node = function() {
    return this.node_stack.pop();
  };

  Renderer.prototype.active_node = function() {
    return _.last(this.node_stack);
  };

  return Renderer;

})(Module);