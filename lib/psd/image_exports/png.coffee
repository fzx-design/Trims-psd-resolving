fs = require 'fs'
{PNG} = require 'pngjs'
RSVP = require 'rsvp'

# width: @width(), height: @height() 调用函数，容易导致错误
module.exports =
  toPng: ->
    png = new PNG(filterType: 4, width: @width(), height: @height())
    png.data = @pixelData
    png
    
  toPngForCanvas:->
    png = new PNG(filterType: 4, width: @width, height: @height)
    #console.log(@pixelData)
    png.data = @pixelData
    png

  saveAsPng: (output) ->
    new RSVP.Promise (resolve, reject) =>
      @toPng()
        .pack()
        .pipe(fs.createWriteStream(output))
        .on 'finish', resolve
        
  CanvasToPng: (output) ->
    new RSVP.Promise (resolve, reject) =>
      @toPngForCanvas()
        .pack()
        .pipe(fs.createWriteStream(output))
        .on 'finish', resolve
