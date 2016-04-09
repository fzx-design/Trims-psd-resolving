var Canvas = require('../../node_modules/canvas');
var Image = Canvas.Image;
var PixelArray = Canvas.PixelArray;
var Image = Canvas.Image;
var fs = require('fs');
var PSD = require('../../');

var file = process.argv[2] || '../images/layer_clip.psd';
var start = new Date();

fs.readFile(__dirname + '/test.png', function(err, squid){
    console.log(squid);
    // var img = new Image();
    // img.src = squid;
    // var canvas = new Canvas(850,850);
    // var ctx = canvas.getContext('2d');
    // ctx.drawImage(img,0,0,850,850);
    
    // console.log(canvas.toBuffer());
});


PSD.open(file).then(function (psd) {
  var pixelData = psd.tree().descendants()[0].layer.image.pixelData;
  console.log("--------------------");
  //console.log(psd.tree().descendants()[0].toPng().pack());
  
  var node = psd.tree().descendants()[0].layer.image;
  var pos = node.startPos;
  var file = node.file.data;
  //file.seek(pos);
  console.log(node.startPos);
  console.log(node.endPos);
  console.log(node.length);
  
  
  var buf = new Buffer(node.length);
  console.log(buf);
  buf.copy(file,0,node.startPos,node.endPos,function(err){
    console.log(err);
  });
  
  var img = new Image();
  img.src = buf;
  var canvas = new Canvas(850,850);
  var ctx = canvas.getContext('2d');
  ctx.drawImage(img,0,0,850,850);
  
  console.log(canvas.toBuffer());
  
  //var p = new PixelArray(pixelData);
  //console.log(p);
}).then(function () {
  console.log("Finished in " + ((new Date()) - start) + "ms");
});;



  
