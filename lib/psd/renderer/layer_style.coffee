LazyExecute = require '../lazy_execute.coffee'
Util = require '../util.coffee'
{Module} = require 'coffeescript-module'

SUPPORTED_STYLES = {
	ColorOverlay : require('./layer_styles/color_overlay.coffee') 
}

module.exports = class LayerStyles extends Module
	constructor:(canvas)->
		@canvas = canvas;
		@node = @canvas.node;
		
		# @node.layer.adjustments['objectEffects']
		@data = @node.layer.adjustments.objectEffects;
		#console.log(@data);
		
		if !@data
			@applied = true;
		else 
			@data = @data.data;
			@applied = false;
		
	apply: ->
		return if @applied
		#unless @styles_enabled()
		
		for own name,klass of SUPPORTED_STYLES
			#console.log(own);
			console.log(name);
			console.log(klass);
			if klass.should_apply(@canvas,@data)
				i = new klass(@)
				i.apply();
			
			 
		
	 styles_enabled : ->
	 	data['masterFXSwitch'];
		#data.enabled