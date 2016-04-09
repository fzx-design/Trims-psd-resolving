{Module} = require 'coffeescript-module'


module.exports = class Opacity extends Module
	constructor:(style)->
		@canvas = style.canvas
		@node = style.node
		@data = style.data
