Renderer = require '../renderer.coffee'


module.exports =
  #这个地方之后要改调 render module
  # toPng: -> @layer.image.toPng()
  # saveAsPng: (output) -> @layer.image.saveAsPng(output)
  
  toPng: ->
    @layer.image.toPng()
    
  saveAsPng: (output) ->
    renderer = new Renderer(@,{})
    renderer.render(output)
    #renderer.saveAsPng(output)
    #@layer.image.saveAsPng(output)