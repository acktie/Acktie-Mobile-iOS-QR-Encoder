# Acktie Mobile QR Encoder Module (iOS)

## Example

A working example of how to use this module can be found on Github at
[https://github.com/acktie/Acktie-Mobile-QR-Encoder-Example](https://github.com/acktie/Acktie-Mobile-QR-Encoder-Example).

## Description

This module allows for quick generation of QR Codes on your mobile device.

## Accessing the Acktie Mobile QR Encoder Module

To get started, review the [module install instructions](http://docs.appcelerator.com/titanium/2.0/#!/guide/Using_Titanium_Modules) on the Appcelerator
website. To access this module from JavaScript, you would do the following:

    
    var qrEncoder = require('com.acktie.mobile.ios.qr.encoder'); 

The qrEncoder variable is a reference to the module object.

## Reference

The following are the Javascript functions you can call with the module.

### init

This options initializes the QR Encoder. In this option you can set the size,
margin, and correction level (see below for detail).

#### Properties

The following are the valid properties that can be passed into the print
function.

#### size (optional)

This property is used set the size of the returned QR Encoded PNG blob. The
size is a single value with matching height and width. For example, if 100 is
entered. The QR Encoded PNG will be of size 100 height and 100 width. However,
you can use an imageview to display it however you want. size: 100 The default
is 300 x 300. _Note_: If you intent to use the module to display QR's that
will be read by other mobile devices it is recommended that you create a QR
bigger then you need and just scale it down in the image view. This will give
you a clear QR Code.

#### margin (optional)

The margin is a border around the QR code. You can size the margin to your
needs or even remove it by passing in 0. Example: margin: 3 The default is 1

#### correction (optional)

This property will set the correction level of the QR Code rendered. The
higher correction level the more dense the QR code is however it allow for
redundent data so part of the QR code may be missing or damaged and it will
still be readable.

  * Level L (Low) 7% of codewords can be restored.
  * Level M (Medium) 15% of codewords can be restored.
  * Level Q (Quartile) 25% of codewords can be restored.
  * Level H (High) 30% of codewords can be restored.
For more information see
(Wikipedia)[http://en.wikipedia.org/wiki/QR_code#Error_correction] Example:
correction: 'M' Valid input is L, M, Q or H The default is 'L',

#### useJISEncoding (optional):

This option is used to encode the QR code result with the Shift JIS encoding.
This is necessary when encoding Kanji Characters and UTF-8 is not sufficient.
By default the QR encoder will use UTF-8. For most circumstances UTF-8 will
work fine. Example: useJISEncoding: true, By default this value is false.

### stringToQR

This function is used to generate the QR Code and return it as a PNG blob. The
only option for this function is text.

#### text (required)

Use this property to pass in the text that will be converted to a QR Code. The
limit is 7000 characters.

## Known issues

None

## Change Log

  * 1.0 Initial Release
  * 1.1 Added UTF-8 Byte order mark (used for more accurate decodeing) and useJISEndoding option.

## Author

Tony Nuzzi @ Acktie 
Twitter: @Acktie 
Email: support@acktie.com

Code licensed under Apache License v2.0, documentation under CC BY 3.0.

Libaries Used:

qrencode: Copyright (C) 2006-2012 Kentaro Fukuchi
libpng version 1.5.11 : Copyright (c) 1998-2012 Glenn Randers-Pehrson
  * (Version 0.96 Copyright (c) 1996, 1997 Andreas Dilger)
  * (Version 0.88 Copyright (c) 1995, 1996 Guy Eric Schalnat, Group 42, Inc.)

Attribution is welcome but not required.