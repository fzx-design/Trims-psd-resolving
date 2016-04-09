{Module} = require 'coffeescript-module'
Convolution = require './Convolution.coffee'

module.exports = (pixels)->
	divider = 9
	opeartor = [1/divider, 1/divider, 1/divider,
				1/divider, 1/divider, 1/divider,
				1/divider, 1/divider, 1/divider]

	return Convolution(pixels, opeartor)
