{Module} = require 'coffeescript-module'
Compose = require './compose.coffee'

module.exports = class Blender extends Module
	constructor: (fg,bg) ->
		#fg and bg is Canvas instance
		@fg = fg
		@bg = bg
		
		@opacity = @fg.opacity
		@fill_opacity = @fg.fill_opacity
		PSD.logger.debug "Blender: name = #{fg.node.name}, opacity = #{@opacity}, fill opacity = #{@fill_opacity}"
		
	compose: ->
		console.log(fg.node.name + " -> " + bg.node.name + " " + fg.node.blending_mode +  "blending")
		console.log("fg: (" + fg.left + " " +  fg.top + ")(" +  fg.width + "x" + fg.height + ") bg: (" +  bg.left + "," + bg.top + ")(" +  bg.width + "x" + bg.height + ")")
		offset_x = fg.left - bg.left
		offset_y = fg.top - bg.top
		
		for y in [0...fg.height]
			for x in [0...fg.width]
				base_x = x + offset_x
				base_y = y + offset_y
				
				unless base_x < 0 || base_y < 0 || base_x >= bg.width || base_y >= bg.height
					# 以上是 ruby 的 send 方法 
					# color = Compose.send(
					# 	fg.node.blending_mode,
					# 	fg.getPixel(x,y),
					# 	bg.getPixel(base_x,base_y),
					# 	@calculated_opacity()
					# )
					
					#js 使用另外的方式来实现
					color = Compose[fg.node.blending_mode](
						fg.getPixel(x,y),
					 	bg.getPixel(base_x,base_y),
					 	@calculated_opacity()
					);
					
					# setPixel 没有aphla 参数，注意处理
					bg.setPixel(base_x,base_y,color)
		
		
	calculated_opacity :->
		@calculated_opacity = parseInt(@opacity * @fill_opacity /255)
	