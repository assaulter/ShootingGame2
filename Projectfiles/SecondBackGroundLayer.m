//
//  SecondBackGroundLayer.m
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "SecondBackGroundLayer.h"


@implementation SecondBackGroundLayer

-(id)init {
    if (self = [super init]) {
        _tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"secondStage.tmx"];
        _background = [_tileMap layerNamed:@"background"];
        _event = [_tileMap layerNamed:@"event"];
        _event.visible = NO;
        
        [self addChild:_tileMap];
    }
    return self;
}

-(CGPoint)getPlayerSpawnPoint {
    return [self getCGPointFromObjectLayerName:@"position" objectName:@"PlayerSpawnPoint"];
}

-(CGPoint)getCGPointFromObjectLayerName:(NSString*)objectLayerName objectName:(NSString*)objectName {
    CCTMXObjectGroup *objects = [_tileMap objectGroupNamed:objectLayerName];
    NSMutableDictionary *point = [objects objectNamed:objectName];
    int x = [[point valueForKey:@"x"] intValue];
    int y = [[point valueForKey:@"y"] intValue];
    /// CC_CONTENT_SCALE_FACTOR return 2.0 at retina display
    return ccp(x/CC_CONTENT_SCALE_FACTOR(), y/CC_CONTENT_SCALE_FACTOR());
}

- (CGPoint)tileCoordForPosition:(CGPoint)position {
    int x = position.x / _tileMap.tileSize.width;
    int y = ((_tileMap.mapSize.height * _tileMap.tileSize.height) + (position.y * CC_CONTENT_SCALE_FACTOR())) / _tileMap.tileSize.height;
    // make sure coordinates are within bounds
	x = fminf(fmaxf(x, 0), _tileMap.mapSize.width - 1);
	y = fminf(fmaxf(y, 0), _tileMap.mapSize.height - 1);
    
    return ccp(x, y);
}

@end