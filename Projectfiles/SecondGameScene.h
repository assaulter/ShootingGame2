//
//  SecondGameScene.h
//  ShootingGame
//
//  破壊不可能な壁と、破壊可能な壁をマップ定義ファイルから取得して設定。
//  壁に当たるとプレイヤーは死ぬ。
//  あとはアニメーション位。
//
//  Created by KazukiKubo on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayerLayer.h"
#import "SecondBackGroundLayer.h"

@interface SecondGameScene : CCLayer<SecondBackGroundLayerDelegate> {
    PlayerLayer* _playerLayer;
    SecondBackGroundLayer* _backGroundLayer;
    CGPoint _touchLocation;
}

@end
