// open a single window
var window = Ti.UI.createWindow({
	backgroundColor:'white'
});


// Get a reference to the module
var qrEncoder = require('com.acktie.mobile.ios.qr.encoder');
Ti.API.info("module is => " + qrEncoder);

// Init QR Encoder (Optional see docs for defaults)
qrEncoder.init({size: 1000, margin: 1, correction:'Q'});

// Get PNG Blob representing QR Code
var qrImage = qrEncoder.stringToQR({text: 'Acktie\'s Awesome QR Encoder'});


// Once you have the blob you can display it, write it to disk, sent it to a server, etc.
var image = Ti.UI.createImageView({
	width: 300,
	height: 300,
	image:qrImage,
});

window.add(image);
window.open();

