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

@end
