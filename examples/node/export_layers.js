var PSD = require('../../');

var file = process.argv[2] || '/Users/z/Desktop/test.psd';
var start = new Date();

PSD.open(file).then(function (psd) {
  console.log("image: " + psd.tree().descendants()[0].layer.name);
  psd.tree().descendants()[0].saveAsPng("../output/test.png");
  // psd.tree().descendants().forEach(function (node) {
  //   if (node.isGroup()) return true;
  //   node.saveAsPng("../output/" + node.name + ".png").catch(function (err) {
  //     console.log(err.stack);
  //   });
  //   //console.log(node.layer.image);
  //   //console.log(Object.getOwnPropertyNames(node.layer.channels));
  // });
}).then(function () {
  console.log("Finished in " + ((new Date()) - start) + "ms");
}).catch(function (err) {
  console.log(err.stack);
});
