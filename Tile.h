//
//  Tile.h
//  AlistairStead
//
//  Created by Alistair Stead on 08/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Grid;

@interface Tile : NSObject


@property CGPoint tilePosition;
@property CGPoint tileDraggedPosition;

@property BOOL isBeingDragged;

@property int tileWidth;

@property UIImage *tileImage;

@property int tileID;

@property NSMutableArray *gridReference;

- (id) initWithImage:(UIImage*)croppedImage atPosition:(CGPoint) position withWidth:(int) width withIndex:(int) tileIndex withParentGrid: (Grid *) parentGrid;

- (id) initEmptyTile: (CGPoint) position withWidth: (int) width withIndex:(int) tileIndex withParentGrid: (Grid *) parentGrid;

- (BOOL) containsPoint:(CGPoint) point;

- (BOOL) isEmptyTile;

- (void) moveToGridCol:(int) x andRow:(int) y;


@end
