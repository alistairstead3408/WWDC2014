//
//  Tile.m
//  AlistairStead
//
//  Created by Alistair Stead on 08/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import "Tile.h"
#import "Grid.h"

@implementation Tile

- (id) initWithImage:(UIImage*)croppedImage atPosition:(CGPoint) position withWidth: (int) width withIndex:(int)tileIndex  withParentGrid: (NSMutableArray* ) parentGrid
{
    self = [super init];
    if(self)
    {
        self.tileWidth = width;
        self.tileImage = croppedImage;
        self.tilePosition = position;
        self.tileID = tileIndex;
        self.gridReference = parentGrid;
    }
    return self;
}

- (id) initEmptyTile: (CGPoint) position withWidth: (int) width withIndex:(int) tileIndex  withParentGrid: (NSMutableArray* ) parentGrid
{
    self = [super init];
    if(self)
    {
        self.tileWidth = width;
        self.tileImage = nil;
        self.tilePosition = position;
        self.tileID = tileIndex;
        self.gridReference = parentGrid;
    }
    return self;
}

- (BOOL) containsPoint:(CGPoint) point
{
    return CGRectContainsPoint(CGRectMake(self.tilePosition.x, self.tilePosition.y, self.tileWidth, self.tileWidth),point);
}

- (void) moveToGridCol:(int) x andRow:(int) y
{
    
}

- (BOOL) isEmptyTile
{
    if(!self.tileImage)
        return true;
    return false;
}


@end
