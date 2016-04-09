_     = require 'lodash'
{Module} = require 'coffeescript-module'
Canvas = require './renderer/canvas.coffee'

#blender = require 'renderer/blender.coffee'
#canvas = require 'renderer/canvas.coffee'
#canvasManagement = require 'renderer/canvas_management.coffee' 
# clippingMask = require 'renderer/clipping_mask.coffee' 
# compose = require 'renderer/compose.coffee'
# mask = require 'renderer/mask.coffee'
# mask_canvas = require 'renderer/mask_canvas.coffee'

module.exports = class Renderer extends Module
	constructor: (@node,@_opts) ->
		@root_node = @node
		@opts = @_opts
		# render_hidden
		
		#@width = @root_node.width
		#@height = @root_node.height
		
		# 暂时不知道有什么用
		@canvas_stack = []
		@node_stack = [@root_node]
		
		#解析像素
		@pixel = [];
		
		@rendered = false
		
	width: ->
		@root_node.width
		
	height:->
		@root_node.height
		
	render:(output) ->
		console.log("Beginning render process");
		
		#引用canvasManagement module 创建一个canvas 组
		# activeNode = @active_node()
		# canvasManagement.create_group_canvas(activeNode,activeNode.width,activeNode.height,{base:true})
		
		# @execute_pipeline();
		
		
		# 测试裁剪算法
		#console.log(@root_node.layer.image.pixelData);
		# console.log("clipped: " + @root_node.layer.clipped);
		# if @root_node.layer.clipped
		# 	mask_node = @root_node.clippingMask();
		# 	@mask_pixelData = mask_node.layer.image.pixelData;
		# 	@pixelData = @root_node.layer.image.pixelData;
			
		# 	#console.log(@root_node.layer);
		# 	console.log("array: " + @pixel_array(@pixelData,@width(),@height()));
		# 	console.log(@pixelData.length);
		
		canvas = new Canvas(@root_node,null,null,null);
		canvas.paint_to();
		canvas.CanvasToPng(output)
		#@pixelData = @root_node.layer.image.pixelData;
		#@pixelData = canvas.pixelData;
		
		@rendered = true;
		
	execute_pipeline: ->
		console.log("Executing pipeline on" + @active_node().name)
		#获取所有的子节点 倒置 
		# many thing to do
		
	to_png: ->
		#检查这个节点是否渲染过，先渲染，保证canvas有内容，然后export这个canvas
		if !rendered
			@render()
			@active_canvas.canvas
		
	
	children: ->
		if @active_node().layer?
			[@active_node()]
		else
			@active_node().children
			
	push_node: (@node) ->
		@node_stack.push @node
		
	pop_node: ->
		@node_stack.pop()
		
	active_node: ->
		_.last(@node_stack)
		
		
		
	