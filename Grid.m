//
//  Grid.m
//  AlistairStead
//
//  Created by Alistair Stead on 12/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import "Grid.h"

@implementation Grid



- (id) initWithOrigin: (CGPoint) origin andTileWidth:(int) tileWidth andTiles: (NSMutableArray *) tiles
{
    self.actualGrid = [NSMutableArray array];
    self.tileWidth = tileWidth;
    self.gridRows = (int)[[tiles objectAtIndex:0] count];
    self.gridCols = (int)[tiles count];
    self.gridOrigin = origin;
    
    //Initialise the actual grid
    for(int i = 0; i < self.gridCols; i++){
        NSMutableArray * row = [tiles objectAtIndex:i];
        for(int j = 0; j < self.gridRows; j++){
            Tile *t = [row objectAtIndex:j];
            CGPoint pos = CGPointMake(origin.x + (i * tileWidth), origin.y + (j * tileWidth));
            [t setTilePosition:pos];
        }
    }
    
    self.actualGrid = tiles;
    
    
    
    return self;
}

- (CGPoint) getScreenPositionForRow:(int) row andCol: (int) col
{
    return CGPointMake(col * self.tileWidth, row * self.tileWidth);
}

- (void) setTile: (Tile *) t atGridRow: (int) row andCol: (int) col
{
    [[self.actualGrid objectAtIndex:row] replaceObjectAtIndex:col withObject:t];
    [t setTilePosition:CGPointMake(col * self.tileWidth, row * self.tileWidth)];
     
}

- (void) shuffleGrid
{
    self.hasShuffled = true;
    //Takes a uniform grid and randomly allocates each square
    NSMutableArray *newGrid = [NSMutableArray array];
    int arrayLength = (int) [self.actualGrid count];
    
    //Populate new array as needed
    for(int i = 0; i < arrayLength; i++){
        NSMutableArray *row = [NSMutableArray array];
        for(int j = 0; j < arrayLength; j++){
            Tile *t = [[self.actualGrid objectAtIndex:i] objectAtIndex:j];
            [row addObject:t];
        }
        [newGrid addObject:row];
    }
    
    
    for(int i = 0; i < arrayLength; i++){
        for(int j = 0; j < arrayLength; j++){
            //Assume there's something there
            int randX = (arc4random() % [self.actualGrid count]);
            int randY = (arc4random() % [[self.actualGrid objectAtIndex:randX] count]);
            
            //Add to newGrid
            Tile *tOld = [[self.actualGrid objectAtIndex:randX] objectAtIndex:randY];
            
            [[newGrid objectAtIndex:i] setObject:tOld atIndex:j];
            
            
            //Remove from tmpGrid
            [[self.actualGrid objectAtIndex:randX] removeObjectAtIndex:randY];
            if([[self.actualGrid objectAtIndex:randX] count] == 0)
                [self.actualGrid removeObjectAtIndex:randX];
            
        }
    }
    
    //Go through newGrid and re-assign positions
    for(int i = 0; i < [newGrid count]; i++){
        int xPos = self.gridOrigin.x + (i * self.tileWidth);
        for(int j = 0; j < [[newGrid objectAtIndex:i] count]; j++){
            int yPos = self.gridOrigin.y  + (j * self.tileWidth);
            CGPoint point = CGPointMake(xPos,yPos);
            Tile *t = [[newGrid objectAtIndex:i] objectAtIndex:j];
            [t setTilePosition:point];
        }
    }
    
    
    
    self.actualGrid = newGrid;
}



-(Tile *) getTileAtPosition: (CGPoint) pos
{
    for(int i = 0; i <  [self.actualGrid count]; i++){
        for(int j = 0; j < [[self.actualGrid objectAtIndex:i] count]; j++){
            Tile *t = [[self.actualGrid objectAtIndex:i] objectAtIndex:j];
            if([t containsPoint:pos]){
                return t;
            }
        }
    }
    return nil;
}

-(MovementDirection) getAvailableDirectionForTile: (Tile *) tileToFind
{
    for(int i = 0; i < self.gridRows; i++){
        NSMutableArray *row = [self.actualGrid objectAtIndex:i];
        for(int j = 0; j < self.gridCols; j++){
            if([row objectAtIndex:j]  == tileToFind){
                
                //Up
                if(j > 0 && [[row objectAtIndex:j-1] isEmptyTile]){
                    NSLog(@"Empty Up");
                    return UP;
                }
                
                //Down
                if(j < [row count] - 1 && [[row objectAtIndex:j+1] isEmptyTile]){
                    NSLog(@"Empty Down");
                    return DOWN;
                }
                
                //Left
                if(i > 0 && [[[self.actualGrid objectAtIndex:i-1] objectAtIndex:j] isEmptyTile]){
                    NSLog(@"Empty Left");
                    return LEFT;
                }
                
                //Right
                if(i < [self.actualGrid count] - 1 && [[[self.actualGrid objectAtIndex:i+1] objectAtIndex:j]  isEmptyTile]){
                    NSLog(@"Empty Right");
                    return RIGHT;
                }
            }
        }
    }
    return NONE;
}

- (Tile *) getEmptyTile
{
    for(NSMutableArray *row in self.actualGrid){
        for(Tile *t in row){
            if([t isEmptyTile])
                return t;
        }
    }
    return nil;
}


- (void) swapTile: t1 forTile: t2
{
    //First swap their positions
    CGPoint t1Pos = [t1 tilePosition];
    [t1 setTilePosition:[t2 tilePosition]];
    [t2 setTilePosition:t1Pos];
    
    
    
    //Then swap them in the actual grid
    for(int i = 0; i < [self.actualGrid count]; i++){
        NSMutableArray *row = [self.actualGrid objectAtIndex:i];
        for(int j = 0; j < [row count]; j++){
            if([row objectAtIndex:j] == t1){
                [row replaceObjectAtIndex:j withObject:t2];
            }
            else if([row objectAtIndex:j] == t2){
                [row replaceObjectAtIndex:j withObject:t1];
            }
        }
    }
}


@end
