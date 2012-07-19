/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComAcktieMobileIosQrEncoderModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "qrencode.h"

@implementation ComAcktieMobileIosQrEncoderModule
@synthesize margin;
@synthesize size;
@synthesize correction;

- (void)drawQRCode:(QRcode *)qrCode context:(CGContextRef)ctx
{
	unsigned char *data = qrCode->data;
	int width = qrCode->width;
    
	float zoom = (double)size / (qrCode->width + 1.0 * margin);
	CGRect rect = CGRectMake(0, 0, zoom, zoom);
	
	// Draw Image
	CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
	for(int i = 0; i < width; ++i) 
    {
		for(int j = 0; j < width; ++j) 
        {
            // Draw if only only exist
			if(*data & 1) {
				rect.origin = CGPointMake((j + margin) * zoom,(i + margin) * zoom);
				CGContextAddRect(ctx, rect);
			}
			++data;
		}
	}
    
	CGContextFillPath(ctx);
}

- (UIImage *)stringToQrImage:(NSString *)text {
	if ([text length] == 0) {
        NSLog([NSString stringWithFormat:@"String is empty!"]);
		return nil;
	}
	
    // encode String to QR
	QRcode *qrCode = QRcode_encodeString([text UTF8String], 0, correction, QR_MODE_8, YES);
    
	if (!qrCode) {
        NSLog([NSString stringWithFormat:@"QRcode is nil!"]);
		return nil;
	}
	
	// context
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, kCGImageAlphaPremultipliedLast);
	
	CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
	CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
	CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
	
	// draw QR on this context	
	[self drawQRCode:qrCode context:ctx];
	
	// get image
	CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
	UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
	
	// some releases
	CGContextRelease(ctx);
	CGImageRelease(qrCGImage);
	CGColorSpaceRelease(colorSpace);
	QRcode_free(qrCode);
	
	return qrImage;
}

- (void) initArgValues: (id)args
{
    NSLog(@"initArgValues");
    ENSURE_SINGLE_ARG_OR_NIL(args, NSDictionary);
    
    if ([args objectForKey:@"size"] != nil) 
    {
        [self setSize:[TiUtils floatValue:[args objectForKey:@"size"]]];
    }
    NSLog([NSString stringWithFormat:@"size: %f", size]);
    
    if ([args objectForKey:@"margin"] != nil) 
    {
        [self setMargin:[TiUtils intValue:[args objectForKey:@"margin"]]];
    }
    NSLog([NSString stringWithFormat:@"margin: %d", margin]);
    
    if ([args objectForKey:@"correction"] != nil) 
    {
        NSString* correctionString = [TiUtils stringValue:[args objectForKey:@"correction"]];
        
        if ([correctionString caseInsensitiveCompare:@"L"] == NSOrderedSame) {
            [self setCorrection: QR_ECLEVEL_L];
        }
        else if ([correctionString caseInsensitiveCompare:@"M"] == NSOrderedSame) {
            [self setCorrection: QR_ECLEVEL_M];
        }
        else if ([correctionString caseInsensitiveCompare:@"Q"] == NSOrderedSame) {
            [self setCorrection: QR_ECLEVEL_Q];
        }
        else if ([correctionString caseInsensitiveCompare:@"H"] == NSOrderedSame) {
            [self setCorrection: QR_ECLEVEL_H];
        }
        
    }
    NSLog([NSString stringWithFormat:@"correction: %d", correction]);
}

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"3db2cca5-6db0-4fe2-8d22-f154e3d563ca";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.acktie.mobile.ios.qr.encoder";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
    [self setSize:300.0f];
    [self setMargin:1];
    [self setCorrection: QR_ECLEVEL_L];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma Public APIs

- (void)init: (id)args
{
    NSLog(@"init: args");
    ENSURE_SINGLE_ARG_OR_NIL(args, NSDictionary);
    
    [self initArgValues:args];
}

-(id)stringToQR:(id)args
{
    NSLog(@"stringToQR");
    ENSURE_SINGLE_ARG_OR_NIL(args, NSDictionary);
    
    TiBlob *imageBlob = nil;
    NSString *text = nil;
    
    
    if ([args objectForKey:@"text"] != nil) 
    {
        text = [TiUtils stringValue:[args objectForKey:@"text"]];
        NSLog([NSString stringWithFormat:@"text: %@", text]);
    }
    
    [self initArgValues:args];
    
    if(text != nil)
    {
        UIImage *qrCodeImage = [self stringToQrImage:text];
        imageBlob = [[[TiBlob alloc] initWithImage:qrCodeImage] autorelease];
    }
    else
    {
        NSLog([NSString stringWithFormat:@"[stringToQR]: Text is not set!"]);
    }
    
    return imageBlob;
}


@end
