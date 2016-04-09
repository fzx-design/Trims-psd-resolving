#LayerStyle = require './layer_style.coffee'
ClippingMask = require './clipping_mask.coffee'
{Module} = require 'coffeescript-module'
Export   = require '../image_export.coffee'
LayerStyle = require './layer_style.coffee'

module.exports = class Canvas extends Module
	@includes Export.PNG
	
	constructor: (@_node,@_width,@_height,@_opts)->
		#保存node节点中的基本参数
		@node = @_node
		@opts = @_opts
		if @node.isGroup()
			@pixelData = []
		else
			@pixelData = @node.layer.image.pixelData
		
		@width = @_width || @node.width
		@height = @_height || @node.height
		
		@opacity = @node.layer.opacity
		@fill_opacity = @node.layer.fill_opacity
		
		#添加left top 属性，用来确认位置
		@left = @node.left
		@top = @node.top
		
		#添加blendmode 到 node 节点 方便获取
		@node.blending_mode = @node.layer.blendMode.mode
		
		#初始化canvas ，需要用 node-canvas来实现
		#@initialize_canvas()
	
	#该函数没有用，因为没有使用外部的canvas来实现，所以也就没有@canvas属性
	initialize_canvas: ->
		console.log("Initializing canvas for" + @node.name);
		if !@node.group 
			@canvas = new Canvas(@width,@height)
	
	# 在renderer中传入node新建一个canvas，调用该方法，处理图像效果	
	# base 在ruby中貌似是this的用法，所以nodejs方法不传参
	paint_to: ->
		console.log("Painting " + @node.name);
		#@apply_masks()
		@apply_clipping_mask()
		@apply_layer_styles()
		@apply_layer_opacity()
        
	#apply_masks: ->
		
	apply_clipping_mask: ->
		console.log("clipped:" + @node.layer.clipped)
		return unless @node.layer.clipped
		i = new ClippingMask(@)
		i.apply()
		
	
	apply_layer_styles:->
		console.log("Applying layer styles to " + @node.name);
		i = new LayerStyle(@)
		i.apply()
		
	
	apply_layer_opacity:->
		console.log "Applying layer opacity to #{@node.name}"
		@opacity = @node.layer.opacity
		for parent in @node.ancestors()
			break unless parent.passthruBlending()
			@opacity = (@opacity * parseFloat(parent.opacity))/255.0

		@opacity = parseInt(@opacity)

		for y in [0...@.height]
			for x in [0...@.width]
				pixel = @.getPixel(x,y);
				pixel[3] = @opacity
				@.setPixel(x,y, pixel);


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
		if alpha?
			#console.log(parseInt(rgba[3]*alpha/255));
			@pixelData[index+3] = parseInt(rgba[3]*alpha/255)
		else
			#console.log("no arg Alpha");
			@pixelData[index+3] = rgba[3]
		
		
		
	
	
		
		
	
		
		
		
	
		  
	