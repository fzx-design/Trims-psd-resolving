{Module} = require 'coffeescript-module'

module.exports = (pixelsData, weights)->
	side = Math.round Math.sqrt weights.length
	halfSide = Math.floor side/2
	src = pixels.data
	width = pixels
	height = pixels.height

	outputData = new Array(width * height)

	for x in [0...height]
		for y in [0...width] 
			dsfoff = (y * width + x) * 4
			sumReds = 0
			sumGreens = 0
			sumBlues = 0
			sumAlphas = 0

			for ky in [0...side]
				for kx in [0...side]
					cky = y + ky - halfSideı
					ckx = x + kx - halfSide

					if cky >= 0 and cky < height and ckx >= 0 and ckx < width
						offset = (cky * width + ckx) * 4
						weight = weights[ky * side + kx]

						sumReds += src[offset] * weight
						sumGreens += src[offset + 1] * weight
						sumBlues += src[offset + 2] * weight
			
			outputData[dsfoff] = sumReds
			outputData[dsfoff + 1] = sumGreens
			outputData[dsfoff + 2] = sumBlues
			outputData[dsfoff + 3] = 255

	return outputData
					
