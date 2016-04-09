var PSD = require('../../');

PSD.open('../images/example.psd').then(function (psd) {
  console.log(psd.resources.resource('layerComps').export());
});