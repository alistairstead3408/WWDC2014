//
//  QuartzView.m
//  AlistairStead
//
//  Created by Alistair Stead on 08/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import "QuartzView.h"
#import "Tile.h"
#import "Grid.h"

@implementation QuartzView

const int idealTileSize = 30;
const int yMargin = 10;
const int xMargin = 10;
int tileWidth;
CGRect imageRect;



Tile * tileBeingDragged;


-(id) init
{
    self = [super init];
    [self setOpaque:YES];
    [self setBackgroundColor:[UIColor whiteColor]];
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    
    self = [super init];
    [self setOpaque:YES];
    [self setBackgroundColor:[UIColor whiteColor]];
    return self;
}

// Initialisation Method
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.layer.zPosition = 1;
        self.fullImage = [UIImage imageNamed:@"alistair2"];
        NSLog(@"Image loaded!");
        [self setOpaque:YES];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


//Main Drawing Method
- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
    
    if(!self.grid){
        NSLog(@"Ourbounds: Width is: %f height is: %f", rect.size.width, rect.size.height);
        rect = CGRectMake(xMargin, yMargin, rect.size.width - (xMargin * 2), rect.size.height - (yMargin * 2));
        CGSize maxImageBounds = [self getMaximumSizeforBounds:rect];
        NSLog(@"Ourbounds: Width is: %f height is: %f", rect.size.width, rect.size.height);
        
        int xPos = ((rect.size.width + (2 * xMargin)) - maxImageBounds.width) / 2;
        int yPos = ((rect.size.height + (2 * yMargin)) - maxImageBounds.height) / 2;
        NSLog(@"xPos:%d yPos:%d, ourBounds Width:%f %f", xPos, yPos, rect.size.width, maxImageBounds.width);
        imageRect = CGRectMake(xPos, yPos, maxImageBounds.width, maxImageBounds.height);
        
        [self splitImageIntoTiles:self.fullImage inBounds:imageRect];
    
//        [self shuffleGrid];
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, self.bounds);
    
    //Draw image for testing purposes
    [self drawGrid];
    CGContextSaveGState(context);
    
}



- (void) splitImageIntoTiles:(UIImage*)inputImage inBounds:(CGRect) bounds
{
    NSLog(@"We're given bounds: %f %f %f %f", bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    double ratio = bounds.size.width / bounds.size.height;
    int lengthLongest = 4;
    
    int xTiles, yTiles;
    if(ratio < 1){
        NSLog(@"Height is bigger than width");
        xTiles = lengthLongest;
        yTiles = lengthLongest / ratio;
        tileWidth = bounds.size.width / lengthLongest;
    }
    else{
        NSLog(@"Width is bigger than height");
        tileWidth = bounds.size.height / lengthLongest;
        yTiles = lengthLongest;
        xTiles = bounds.size.width / tileWidth;
    }
    
    int newWidth = (xTiles * tileWidth);
    int newHeight = (yTiles * tileWidth);
    
    int newX = bounds.origin.x + ((bounds.size.width - newWidth) / 2);
    int newY = bounds.origin.y + ((bounds.size.height - newHeight) / 2);
    
    
    //Try to resize core image
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointMake(0, 0);
    thumbnailRect.size.width  = newWidth;
    thumbnailRect.size.height = newHeight;
    
    [inputImage drawInRect:thumbnailRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    inputImage = newImage;
    
    //Resize image to appropriate size
    imageRect = CGRectMake(newX, newY, newWidth, newHeight);
    int tileIndex = 0;
    
    
    
    NSMutableArray *cols = [NSMutableArray array];
    
    for(int i = 0; i < xTiles; i++){
        NSMutableArray *rows = [NSMutableArray array];
        int xPos = imageRect.origin.x + (i * tileWidth);
        for(int j = 0; j < yTiles; j++){
            int yPos = imageRect.origin.y  + (j * tileWidth);
            CGRect rectInImage = CGRectMake((i * tileWidth), (j * tileWidth), tileWidth-2, tileWidth-2);
            CGPoint pointOnScreen = CGPointMake(xPos, yPos);
            
            
            CGImageRef sourceImageRef = [inputImage CGImage];
            CGImageRef croppedImageRef = CGImageCreateWithImageInRect(sourceImageRef, rectInImage);
            
            UIImage *newImage = [UIImage imageWithCGImage:croppedImageRef scale:1.0 orientation:inputImage.imageOrientation];
            tileIndex++;
            Tile *t;
            if(i == xTiles - 1 && j == yTiles - 1){
                t = [[Tile alloc] initEmptyTile:pointOnScreen withWidth:tileWidth withIndex:tileIndex withParentGrid:self.grid];
            }
            else{
                t = [[Tile alloc] initWithImage:newImage atPosition:pointOnScreen withWidth:tileWidth withIndex:tileIndex withParentGrid:self.grid];
            }
            [rows addObject:t];
        }
        [cols addObject:rows];
    }
    
    self.grid = [[Grid alloc] initWithOrigin:imageRect.origin andTileWidth:tileWidth andTiles:cols];
    
}





- (CGSize) getMaximumSizeforBounds:(CGRect) bounds
{
    CGSize imageSize = self.fullImage.size;
    
    NSLog(@"Image w:%f h:%f", self.fullImage.size.width, self.fullImage.size.height);
    NSLog(@"Bounds w:%f h:%f", bounds.size.width, bounds.size.height);
    double imageRatio = imageSize.width / imageSize.height;
    
    double boundsRatio = bounds.size.width / bounds.size.height;
    
    if(imageRatio > boundsRatio){
        NSLog(@"ImageRatio is bigger: %f vs. %f", imageRatio, boundsRatio);
        //Width is going to be the stopping point
        return CGSizeMake(bounds.size.width,   bounds.size.width / imageRatio);
    }
    else{
        NSLog(@"BoundsRatio is bigger: %f vs. %f", imageRatio, boundsRatio);
        //height is going to be the stopping point
        return CGSizeMake(bounds.size.height, bounds.size.height * imageRatio);
    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"We have had %lu touch: ", (unsigned long)touches.count);
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    
    tileBeingDragged = [self.grid getTileAtPosition:location];
    [tileBeingDragged setIsBeingDragged:true];
    
    if(![tileBeingDragged isEmptyTile]){
        NSLog(@"Found tile at position %f %f", tileBeingDragged.tilePosition.x, tileBeingDragged.tilePosition.y);
        
        //Determine whether it can move or not
        
        self.tileDirection = [self.grid getAvailableDirectionForTile: tileBeingDragged];
        
        if(self.tileDirection == UP){
           self.draggableBounds = CGRectMake(tileBeingDragged.tilePosition.x, tileBeingDragged.tilePosition.y - tileBeingDragged.tileWidth, 0, tileBeingDragged.tileWidth);
        }
        else if(self.tileDirection == DOWN){
            self.draggableBounds = CGRectMake(tileBeingDragged.tilePosition.x, tileBeingDragged.tilePosition.y, 0, tileBeingDragged.tileWidth);
        }
        else if(self.tileDirection == LEFT){
            self.draggableBounds = CGRectMake(tileBeingDragged.tilePosition.x - tileBeingDragged.tileWidth, tileBeingDragged.tilePosition.y, tileBeingDragged.tileWidth, 0);
        }
        else if(self.tileDirection == RIGHT){
            self.draggableBounds = CGRectMake(tileBeingDragged.tilePosition.x, tileBeingDragged.tilePosition.y, tileBeingDragged.tileWidth, 0);
        }
   
        if(self.tileDirection != NONE){
            [self setDragOffset:CGPointMake( tileBeingDragged.tilePosition.x - location.x, tileBeingDragged.tilePosition.y - location.y)];
            [self setIsDraggable:true];
//            tileForDragging = CGPointMake(i, j);
//            [t setTilePressedPosition:t.tilePosition];
        }
        
    }
    else if([tileBeingDragged isEmptyTile] && [tileBeingDragged containsPoint:location]){
        NSLog(@"Empty Tile!!!!!");
        [self setIsDraggable:false];
    }

    
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    if(self.isDraggable){
        NSLog(@"Dragging");
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:touch.view];
        

        int x = location.x + self.dragOffset.x;
        int y = location.y + self.dragOffset.y;
        
        x = MAX(x, self.draggableBounds.origin.x);
        x = MIN(x, self.draggableBounds.origin.x + self.draggableBounds.size.width);
        
        y = MAX(y, self.draggableBounds.origin.y);
        y = MIN(y, self.draggableBounds.origin.y + self.draggableBounds.size.height);
        
        [tileBeingDragged setTileDraggedPosition:CGPointMake(x, y)];
        
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Drop in nearest location and do the swap of empty tile and dropped tile.
    
    [tileBeingDragged setIsBeingDragged:false];
    
    if(self.isDraggable){
        [self setIsDraggable:false];
        
        if(self.tileDirection == LEFT){
        
            if(tileBeingDragged.tileDraggedPosition.x < (self.draggableBounds.origin.x + (self.draggableBounds.size.width / 2))){
                //Swap
                Tile *emptyTile = [self.grid getEmptyTile];
                [self.grid swapTile: tileBeingDragged forTile: emptyTile];

            }
        }
        else if(self.tileDirection == RIGHT){
            if(tileBeingDragged.tileDraggedPosition.x > (self.draggableBounds.origin.x + (self.draggableBounds.size.width / 2))){
                //Swap
                Tile *emptyTile = [self.grid getEmptyTile];
                [self.grid swapTile: tileBeingDragged forTile: emptyTile];
                
            }
        }
        else if(self.tileDirection == UP){
            
            if(tileBeingDragged.tileDraggedPosition.y < (self.draggableBounds.origin.y + (self.draggableBounds.size.height / 2))){
                //Swap
                Tile *emptyTile = [self.grid getEmptyTile];
                [self.grid swapTile: tileBeingDragged forTile: emptyTile];
                
            }
        }
        else if(self.tileDirection == DOWN){
            if(tileBeingDragged.tileDraggedPosition.y > (self.draggableBounds.origin.y + (self.draggableBounds.size.height / 2))){
                //Swap
                Tile *emptyTile = [self.grid getEmptyTile];
                [self.grid swapTile: tileBeingDragged forTile: emptyTile];
                
            }
        }
    
    }
    
    [self setNeedsDisplay];
    
}



- (void) drawGrid
{
    for(NSMutableArray *row in self.grid.actualGrid){
        for(Tile *t in row){
            if (t != (id)[NSNull null]){
                if([t tileImage]){
                    if(t.isBeingDragged){
                        [[t tileImage] drawAtPoint:t.tileDraggedPosition];
                    }
                    else{
                        [[t tileImage] drawAtPoint:t.tilePosition];
                    }
                }
            }
        }
    }

}





@end
