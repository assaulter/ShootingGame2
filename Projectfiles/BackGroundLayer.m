//
//  BackGround.m
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "BackGroundLayer.h"

static float const SCROLL_Y = 1.0f;

@implementation BackGroundLayer

-(id)init {
    if (self = [super init]) {
        _tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"scrollSample.tmx"];
        _map =  [_tileMap layerNamed:@"map"];
        _event = [_tileMap layerNamed:@"event"];
        _event.visible = NO;
        
        _isMovable = YES;
        
        [self addChild:_tileMap];
        _current = ccp(0.0f, 0.0f);
        [self schedule:@selector(update:)];
    }
    return self;
}

-(CGPoint)getPlayerSpawnPoint {
    return [self getCGPointFromObjectLayerName:@"position" objectName:@"SpawnPoint"];
}

-(CGPoint)getCGPointFromObjectLayerName:(NSString*)objectLayerName objectName:(NSString*)objectName {
    CCTMXObjectGroup *objects = [_tileMap objectGroupNamed:objectLayerName];
    NSMutableDictionary *point = [objects objectNamed:objectName];
    int x = [[point valueForKey:@"x"] intValue];
    int y = [[point valueForKey:@"y"] intValue];
    /// CC_CONTENT_SCALE_FACTOR return 2.0 at retina display
    return ccp(x/CC_CONTENT_SCALE_FACTOR(), y/CC_CONTENT_SCALE_FACTOR());
}

-(void)update:(ccTime)delta {
//    CCMoveTo* moveTo = [CCMoveTo actionWithDuration:delta position:_current];
//    CCEaseIn* ease = [CCEaseIn actionWithAction:moveTo rate:0.0f];
//    [self runAction:ease];
    if (_isMovable) {
        [self moveBackGround:delta];
    }
    
    //　ここで、マップの特定の位置に到達したかどうかを検知する？
    int tileGid = [_event tileGIDAt:[self tileCoordForPosition:_current]];
    if (tileGid) {
        [self.delegate addBossWithPoint:
         [self convertToBasicLayerPoint:
          [self getCGPointFromObjectLayerName:@"position" objectName:@"BossSpawnPoint"]]];
        _isMovable = NO;
    }
}

-(void)moveBackGround:(ccTime)delta {
    _current = ccp(_current.x, _current.y - SCROLL_Y);
    _map.position = _current;
}

// 背景レイヤーと他のレイヤーとの間で差があるので、変換する
-(CGPoint)convertToBasicLayerPoint:(CGPoint)point {
    return ccpAdd(point, _current);
}

- (CGPoint)tileCoordForPosition:(CGPoint)position {
    int x = position.x / _tileMap.tileSize.width;
    int y = ((_tileMap.mapSize.height * _tileMap.tileSize.height) + (position.y * CC_CONTENT_SCALE_FACTOR())) / _tileMap.tileSize.height;
    // make sure coordinates are within bounds
	x = fminf(fmaxf(x, 0), _tileMap.mapSize.width - 1);
	y = fminf(fmaxf(y, 0), _tileMap.mapSize.height - 1);

    return ccp(x, y);
}

-(CGPoint) tilePosFromLocation:(CGPoint)location {
	// Tilemap position must be added as an offset, in case the tilemap position is not at 0,0 due to scrolling
	CGPoint pos = ccpSub(location, _tileMap.position);
	
	// scaling tileSize to Retina display size if necessary
	float scaledWidth = _tileMap.tileSize.width / CC_CONTENT_SCALE_FACTOR();
	float scaledHeight = _tileMap.tileSize.height / CC_CONTENT_SCALE_FACTOR();
	// Cast to int makes sure that result is in whole numbers, tile coordinates will be used as array indices
	pos.x = (int)(pos.x / scaledWidth);
	pos.y = (int)((_tileMap.mapSize.height * _tileMap.tileSize.height - pos.y) / scaledHeight);
	
	CCLOG(@"touch at (%.0f, %.0f) is at tileCoord (%i, %i)", location.x, location.y, (int)pos.x, (int)pos.y);
	
	// make sure coordinates are within bounds
	pos.x = fminf(fmaxf(pos.x, 0), _tileMap.mapSize.width - 1);
	pos.y = fminf(fmaxf(pos.y, 0), _tileMap.mapSize.height - 1);
	
	return pos;
}

@end
