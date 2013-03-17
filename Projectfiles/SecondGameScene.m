//
//  SecondGameScene.m
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "SecondGameScene.h"
#import "GamePadLayer.h"
#import "MainScene.h"
#import "GameOverScene.h"
#import "SimpleAudioEngine.h"

@implementation SecondGameScene

-(id)init {
    if (self = [super init]) {
        // 各レイヤーを初期化
        [self setUpLayers];
        [self setUpMusic];
        [self setUpPlayerPosition];
        
        [self schedule:@selector(update:)];
    }
    return self;
}

-(void)setUpMusic {
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"pickup.caf"];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"TileMap.caf"];
}

-(void)setUpLayers {
    _backGroundLayer = [SecondBackGroundLayer new];
    _backGroundLayer.delegate = self;
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
            [[SimpleAudioEngine sharedEngine] playEffect:@"hit.caf"];
            [spritesToDelete addObject:bullet];
        }
    }
    [self deleteSprites:spritesToDelete];
    
    // playerとの当たり判定を行う
    CGPoint point = _playerLayer.player.position;
    if ([self isCollisioningWithCGPoint:point]) {
        [self goToGameOverScene];
    }
}

// 削除用バッファからtagごとに削除を行う。
-(void)deleteSprites:(NSMutableArray*)sprites {
    for (CCSprite *sprite in sprites) {
        [_playerLayer.bullets removeObject:sprite];
        [_playerLayer removeChild:sprite cleanup:YES];
    }
}

// 壁との当たり判定
-(BOOL)collisiondetectWithCGpoint:(CGPoint)point {
    // isCollided : なんらかの壁に当たっているかどうか
    BOOL isCollided = NO;
    CGPoint tileCoord = [_backGroundLayer tileCoordForPosition:point];
    int tileGid = [_backGroundLayer getEventTileIDWithTileCoord:tileCoord];
    if (tileGid) {
        [_backGroundLayer removeTileWithTileCoord:tileCoord tileGid:tileGid];
        isCollided = YES;
    }
    return isCollided;
}

// 当たっているかどうかだけを返す
-(BOOL)isCollisioningWithCGPoint:(CGPoint)point {
    CGPoint tileCood = [_backGroundLayer tileCoordForPosition:point];
    int tileGid = [_backGroundLayer getEventTileIDWithTileCoord:tileCood];
    return tileGid > 0;
}

-(void)goToGameOverScene {
    [_playerLayer execDieAnimation];
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [self unschedule:@selector(update:)];
    
    CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1.0 scene:[GameOverScene nodeWithScene] withColor:ccc3(255, 255, 255)];
    [[CCDirector sharedDirector]replaceScene:tran];
}

#pragma mark - SecondBackgroundLayerDelegate
-(void)goToNextStage {
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [self unschedule:@selector(update:)];
    
    CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1.0 scene:[MainScene nodeWithScene] withColor:ccc3(255, 255, 255)];
    [[CCDirector sharedDirector]replaceScene:tran];
}

@end
