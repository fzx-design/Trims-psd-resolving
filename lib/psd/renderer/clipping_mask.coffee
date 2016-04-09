MaskCanvas = require './mask_canvas.coffee'
{Module} = require 'coffeescript-module'

module.exports = class Clippingmask extends Module
	constructor: (canvas) ->
		@canvas = canvas;
		@node = @canvas.node;
		
		mask_node = @node.clippingMask();
		
		#ruby 库调用了mask_canvas
		@mask = new MaskCanvas(mask_node);
		
	apply:->
		return unless @node.layer.clipped
		
		console.log("Applying clipping mask "+ @mask.node.name + " to" + @node.name );
		
		console.log(@mask.left);
		
		# to do clipping mode 
		# 目前还有未明bug 不能裁剪 mask.left为负值的情况
		for y in [0...@canvas.height]
			for x in [0...@canvas.width]
				doc_x = @canvas.left + x;
				doc_y = @canvas.top + y;
				
				mask_x = doc_x - @mask.left;
				mask_y = doc_y - @mask.top;
				
				if mask_x < 0 || mask_x > @mask.width || mask_y < 0 || mask_y > @mask.height
					alpha = 0;
				else
					pixel = @mask.getPixel(mask_x,mask_y)
					if pixel
						alpha = pixel[3];
						#console.log("alpha: " +alpha);
					else
						alpha = 0;
				
				color = @canvas.getPixel(x,y);
				@canvas.setPixel(x,y,color,alpha);
		
		console.log(@canvas.pixelData.length);