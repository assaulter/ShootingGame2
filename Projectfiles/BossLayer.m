//
//  BossLayer.m
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/05.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "BossLayer.h"

/// Boss専用レイヤー(おそらくplayerと同列のため)
@implementation BossLayer

-(id)init {
    if (self = [super init]) {
        self.bullets = [NSMutableArray new];
        _isActive = NO;
    }
    return self;
}

/// pointにボスを登場させる
-(void)addBossWithPoint:(CGPoint)point {
    if (!_isActive) {
        self.boss = [Boss new];
        self.boss.position = point;
        [self addChild:self.boss];
        
        _isActive = YES;
    }
}

@end
