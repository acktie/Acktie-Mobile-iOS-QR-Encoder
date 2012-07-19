/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"
#import "qrencode.h"

@interface ComAcktieMobileIosQrEncoderModule : TiModule {}

- (UIImage *)stringToQrImage:(NSString *)string;
@property(nonatomic,readwrite,assign) int   margin;
@property(nonatomic,readwrite,assign) float size;
@property(nonatomic,readwrite,assign) QRecLevel correction;

@end
