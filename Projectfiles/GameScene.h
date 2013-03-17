//
//  GameScene.h
//  ShootingGame
//
//  Created by KazukiKubo on 2013/02/19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayerLayer.h"
#import "ItemLayer.h"
#import "GamePadLayer.h"
#import "EnemyLayer.h"
#import "BossLayer.h"
#import "BackGroundLayer.h"

@interface GameScene : CCLayer<BackGroundLayerDelegate, BossLayerDelegate> {
    PlayerLayer *_playerLayer;
    ItemLayer *_itemLayer;
    EnemyLayer *_enemyLayer;
    BossLayer *_bossLayer;
    BackGroundLayer *_backGround;
    NSMutableArray *_items;
    NSMutableArray *_bullets;
    CGPoint _touchLocation;
}

@end
