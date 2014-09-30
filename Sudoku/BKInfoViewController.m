//
//  BKInfoViewController.m
//  Sudoku
//
//  Created by Hayden Blauzvern on 9/28/14.
//  Copyright (c) 2014 BlauzvernKutsko. All rights reserved.
//

#import "BKInfoViewController.h"
#import "BKInfoView.h"

@interface BKInfoViewController () {
    BKInfoView* _infoView;
}

@end

@implementation BKInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // set background to custom image (Function call from Stackoverflow)
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self
                                                                resizeImage:[UIImage imageNamed:@"white spot blue.jpg"]
                                                                newSize:self.view.frame.size]];
    // Set up frame dimensions
    CGRect frame = self.view.frame;
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.1;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    // Create info panel
    _infoView = [[BKInfoView alloc] initWithFrame:gridFrame];
    
    [self.view addSubview:_infoView];
}


// From Stackoverflow
- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    CGContextDrawImage(context, newRect, imageRef);
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}


// Actions to do before view loads
- (void)viewWillAppear:(BOOL)animated
{
    // Create the navigation bar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // Makes the navbar clear so background is displayed
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
