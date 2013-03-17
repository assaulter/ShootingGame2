//
//  SecondGameScene.m
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "SecondGameScene.h"
#import "GamePadLayer.h"


@implementation SecondGameScene

-(id)init {
    if (self = [super init]) {
        // 各レイヤーを初期化
        [self setUpLayers];
        [self setUpPlayerPosition];
        
        [self schedule:@selector(update:)];
    }
    return self;
}

-(void)setUpLayers {
    _backGroundLayer = [SecondBackGroundLayer new];
    [self addChild:_backGroundLayer z:-1];
    
    _playerLayer = [PlayerLayer new];
    [self addChild:_playerLayer z:0];
    
    GamePadLayer *gamePadLayer = [GamePadLayer new];
    [gamePadLayer addObserver:_playerLayer];
    [self addChild:gamePadLayer z:1];
}

-(void)setUpPlayerPosition {
    [_playerLayer addPlayerWithPoint:[_backGroundLayer getPlayerSpawnPoint]];
}

-(void)update:(ccTime)delta {
    NSMutableArray *spritesToDelete = [NSMutableArray new];
    // bulletとの当たり判定を行う
    for (CCSprite* bullet in _playerLayer.bullets) {
        if ([self collisiondetectWithCGpoint:bullet.position]) {
            [spritesToDelete addObject:bullet];
        }
    }
    [self deleteSprites:spritesToDelete];
}

// 削除用バッファからtagごとに削除を行う。
-(void)deleteSprites:(NSMutableArray*)sprites {
    for (CCSprite *sprite in sprites) {
        switch (sprite.tag) {
            case SpriteTagsBullet:
                [_playerLayer.bullets removeObject:sprite];
                [_playerLayer removeChild:sprite cleanup:YES];
                break;
            default:
                break;
        }
    }
}

// 壁との当たり判定
-(BOOL)collisiondetectWithCGpoint:(CGPoint)point {
    BOOL isCollided = NO;
    CGPoint tileCoord = [_backGroundLayer tileCoordForPosition:point];
    int tileGid = [_backGroundLayer getEventTileIDWithTileCoord:tileCoord];
    if (tileGid) {
        [_backGroundLayer removeTileWithTileCoord:tileCoord tileGid:tileGid];
        isCollided = YES;
    }
    return isCollided;
}

@end
