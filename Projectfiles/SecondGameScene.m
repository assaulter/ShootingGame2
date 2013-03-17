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
        _bullets = [NSMutableArray new];
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
    // playerと壁との当たり判定を行う
}

@end
