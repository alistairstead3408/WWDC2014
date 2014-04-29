//
//  QuartzView.h
//  AlistairStead
//
//  Created by Alistair Stead on 08/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"
#import "Grid.h"

@interface QuartzView : UIView




@property (nonatomic, retain) UIImage *fullImage;
@property (nonatomic, retain) Grid *grid;
@property (nonatomic) CGPoint dragOffset;
@property (nonatomic) BOOL isDraggable;
@property (nonatomic) CGRect draggableBounds;
@property (nonatomic) MovementDirection tileDirection;



- (CGSize) getMaximumSizeforBounds:(CGRect) bounds;
- (void) splitImageIntoTiles:(UIImage*)inputImage inBounds:(CGRect) bounds;
- (void) drawGrid;


@property (nonatomic, retain) IBOutlet UILabel *label;

@end
