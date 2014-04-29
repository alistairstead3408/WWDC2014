//
//  Grid.h
//  AlistairStead
//
//  Created by Alistair Stead on 12/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"


@interface Grid : NSObject

typedef enum {
    NONE, LEFT, RIGHT, UP, DOWN
} MovementDirection ;

@property (nonatomic) CGPoint gridOrigin;
@property (nonatomic) int gridRows;
@property (nonatomic) int gridCols;
@property (nonatomic) int tileWidth;

@property (nonatomic) NSMutableArray *actualGrid;
@property (nonatomic, assign, getter=isWorking) BOOL hasShuffled;

- (id) initWithOrigin: (CGPoint) origin andTileWidth:(int) tileWidth andTiles: (NSMutableArray *) tiles;
- (CGPoint) getScreenPositionForRow:(int) row andCol: (int) col;
- (void) shuffleGrid;
- (Tile *) getTileAtPosition: (CGPoint) pos;
- (Tile *) getEmptyTile;

- (void) swapTile: tileBeingDragged forTile: emptyTile;

-(MovementDirection) getAvailableDirectionForTile: (Tile *) tileToFind;

@end
