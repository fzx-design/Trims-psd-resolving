{Module} = require 'coffeescript-module'
Compose = require '../compose.coffee'
LayerStyles = require '../layer_style.coffee'
BlendMode = require '../../blend_mode.coffee'

module.exports = class ColorOverlay extends Module
	constructor:(style)->
		@canvas = style.canvas
		@node = style.node
		@data = style.data
	
	# 全局函数加个 @ 
	@should_apply: (canvas,data)->
		data['SoFi'] && data['SoFi']['enab'] 
		#&& canvas.node.header.rgb

	can_apply: (canvas,data) ->
		
		
	for_canvas: (canvas)->
		
	
	apply: ->
		console.log("Layer style: layer =" + @node.name + " type = color overlay, blend mode = " + @blending_mode())
		#console.log(@data)
		overlay = @data['SoFi'];
		color = overlay['Clr '];
		r = Math.round color['Rd  '];
		g = Math.round color['Grn '];
		b = Math.round color['Bl  '];
		a = Math.ceil overlay['Opct']['value'] * 2.55;
		
		compose = new Compose()
		for y in [0...@canvas.height]
			for x in [0...@canvas.width]
				pixel = @canvas.getPixel(x,y);
				alpha = pixel[3];	
				unless alpha == 0
					new_pixel = compose[@blending_mode()]([r,g,b,a],pixel,a);
					#console.log(new_pixel);
					@canvas.setPixel(x,y,new_pixel);
	
	overlay_color : ->
        [@r(),@g(),@b(),@a]	
		
	overlay_data: ->
		@data['SoFi']
		
	color_data: ->
		@overlay_data()['Clr ']
		
	r:->
		@color_data()['Rd  '].round
	
	g:->
		@color_data()['Grn '].round
		
	b:->
		 @color_data()['Bl  '].round
	
	a:->
		(@overlay_data()['Opct']['value'] * 2.55).ceil
	
	blending_mode: ->
		#console.log(BlendMode::BLEND_TRANSLATION);
		#console.log(LayerStyles:BLEND_TRANSLATION[@overlay_data()['Md  ']['value']]);
		BlendMode::BLEND_MODES[BlendMode::BLEND_TRANSLATION[@overlay_data()['Md  ']['value']]]