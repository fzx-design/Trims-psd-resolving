{Module} = require 'coffeescript-module'
Convolution = require './convolution.coffee'

module.exports =  (pixels)->
	divider = 16
	operator = [1/divider, 2/divider, 1/divider,
				2/divider, 4/divider, 2/divider, 
				1/divider, 2/divider, 1/divider]
	return Convolution(pixels, operator)



