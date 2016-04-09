/// <reference path="../../typings/node/node.d.ts"/>
/**
 * Created with JetBrains WebStorm.
 * User: xyz
 * Date: 15/7/15
 * Time: 14:14
 * To change this template use File | Settings | File Templates.
 */
var PSD = require('../../');
var file = process.argv[2] || '/Users/z/Desktop/test.psd';

var psd = PSD.fromFile(file);
psd.parse();

//var node = psd.tree().childrenAtPath('layer1')[0];

var treenode = psd.tree();
//console.log(treenode.export());
var node = treenode.descendants()[0];
//console.log(node.export());
//console.log(node.layer.infoKeys);
//console.log(node.layer.adjustments['metadata'].parse());
console.log(node.layer.adjustments['objectEffects'].export());
//console.log(treenode.descendants());

