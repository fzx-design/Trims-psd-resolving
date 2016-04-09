#Canvas  = require './canvas.coffee'
{Module} = require 'coffeescript-module'

module.exports = class MaskCanvas extends Module
	constructor:(@_node,@_width,@_height,@_opts) ->
		@node = @_node
		@opts = @_opts
		if @node.isGroup()
			@pixelData = []
		else
			@pixelData = @node.layer.image.pixelData
		
		@width = @_width || @node.width
		@height = @_height || @node.height
		
		@opacity = @node.opacity
		@fill_opacity = @node.fill_opacity
		
		#添加left top 属性，用来确认位置
		@left = @node.left
		@top = @node.top
		
		
	getPixel: (x,y) ->
		index = (y*@node.width + x)*4;
		[@pixelData[index],@pixelData[index+1],@pixelData[index+2],@pixelData[index+3]]
	
	
	# 一维数组转像素格式 （width height 顺序反了，需要转秩）	
	pixel_array : (@pixelData,width,height)->
		for i in [0...height]
			@pixel[i] = [];
			
		for p,i in @pixelData by 4
			y = parseInt(i/width/4);
			@pixel[y].push [@pixelData[i],@pixelData[i+1],@pixelData[i+2],@pixelData[i+3]]
	
	setPixel : (x, y, rgba,alpha)->
		index = (y*@node.width + x)*4;
		@pixelData[index] = rgba[0];
		@pixelData[index+1] = rgba[1];
		@pixelData[index+2] = rgba[2];
		
		#如果alpha 没有传参 默认设为1
		alpha = 1 unless alpha
		
		@pixelData[index+3] = parseInt(rgba[3]*alpha/255)
	