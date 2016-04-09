{Module} = require 'coffeescript-module' 

module.exports = class Compose extends Module

	calculate_alphas :(fg, bg, opacity) ->
      src_alpha = fg[3] * opacity >> 8
      dst_alpha = bg[3]

      mix_alpha = (src_alpha << 8) / (src_alpha + ((256 - src_alpha) * dst_alpha >> 8))
      dst_alpha = dst_alpha + ((256 - dst_alpha) * src_alpha >> 8)

      return [mix_alpha,dst_alpha]

  apply_opacity : (color, opacity) ->
      (color & 0xffffff00) | ((color & 0x000000ff) * opacity / 255)

  blend_channel : (bg, fg, alpha) ->
      ((bg << 8) + (fg - bg) * alpha) >> 8

  blend_alpha : (bg, fg) ->
      bg + ((255 - bg) * fg >> 8)
	
	
	#目前只实现normal  #fg bg 这里代表的是pixel数组 长度为4
	normal : (fg,bg,opacity) ->
    if bg[3] == 0
      return apply_opacity(fg, opacity)
    if fg[3] == 0 
      return bg 

    [mix_alpha, dst_alpha] = @calculate_alphas(fg, bg, opacity)
    
    new_r = @blend_channel(bg[0], fg[0], mix_alpha)
    new_g = @blend_channel(bg[1], fg[1], mix_alpha)
    new_b = @blend_channel(bg[2], fg[2], mix_alpha)
    
    #console.log(new_r + " " + new_g + " " + new_b + " " + dst_alpha);

    return [new_r, new_g, new_b, dst_alpha]
        
        
  #todo 其他