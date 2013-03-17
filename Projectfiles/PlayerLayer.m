//
//  PlayerLayer.m
//  ShootingGame
//
//  Created by KazukiKubo on 2013/02/20.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PlayerLayer.h"
// TODO: 次は弾のインタフェースを作ろう
#import "BulletNormal.h"
#import "NormalPattern.h" // デフォルトの発射パターン
#import "SimpleAudioEngine.h"

@implementation PlayerLayer

-(id)init {
    if (self = [super init]) {
        self.bullets = [NSMutableArray new];

        // bulletPatternを生成
        _bulletPattern = [NormalPattern new];
        _bulletPattern.delegate = self;
        // 死亡時のアニメーションをセットアップ
        _dieAnimation = [self setUpAnimation];
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"nc30644.wav"];
        
        [self schedule:@selector(addBullet:) interval:1.0f];
        [self schedule:@selector(movePlayer:)];
    }
    return self;
}

-(CCAnimation*)setUpAnimation {
    // 死んだ時用画像を準備
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"explosion_default.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"explosion_default.png"];
    [self addChild:spriteSheet];
    // TODO:たしかccArrayとかを使ったほうが早いはず
    NSMutableArray *frames = [NSMutableArray new];
    for (int i = 1; i <= 10; i++) {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"explosion%d.png", i]]];
    }

    return [CCAnimation animationWithSpriteFrames:frames delay:0.1f];
}

-(void)execDieAnimation {
    CCSprite *explosion = [CCSprite spriteWithSpriteFrameName:@"explosion1.png"];
    explosion.position = self.player.position;
    CCAction* dieAciton = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:_dieAnimation] times:1];
    [[SimpleAudioEngine sharedEngine] playEffect:@"nc30644.wav"];
    [explosion runAction:dieAciton];
    [self addChild:explosion];
}

// プレイヤーをtouchした位置に移動させる(runActionを使わないバージョン)
-(void)movePlayer:(ccTime)dt {
    if (_isTouches) {
        // 長さ1に正規化されたベクトル
        CGPoint v = ccpNormalize(ccpSub(_touchLocation, self.player.position));
        self.player.position = ccpAdd(v, self.player.position);
        NSLog(@"player position x %f y %f", self.player.position.x, self.player.position.y);
    }
}

-(void)addPlayerWithPoint:(CGPoint)point {
    self.player = [Player new];
    self.player.position = point;
    _touchLocation = point;
    
    [self addChild:self.player];
}

// 実際に弾を撃ってるところ
-(void)addBullet:(ccTime)dt {
    NSArray *createdBullets = [_bulletPattern createBullet:self.player.position];
    for (BulletNormal *bullet in createdBullets) {
        [self.bullets addObject:bullet];
    }
}

// アニメーションが終了した時の処理 = 画面から消えたとき(bulletPatternから呼ばれる)
-(void)spriteMoveFinished:(id)sender {
    CCSprite *sprite = (CCSprite *)sender;
    if (sprite.tag == SpriteTagsBullet) {
        [self.bullets removeObject:sprite];
    }
    [self removeChild:sprite cleanup:YES];
}

// 状態を設定してもらう。
-(void)setBulletPattern:(NSObject<BulletPattern>*)bulletPattern {
    _bulletPattern = bulletPattern;
    _bulletPattern.delegate = self;
}

#pragma mark - bulletPatternDelegate
-(void)addBulletToLayer:(BulletNormal*)bullet {
    [self addChild:bullet];
}

#pragma mark - observer protocol
-(void)update:(CGPoint)point isTouches:(BOOL)isTouches {
    _touchLocation = point;
    _isTouches = isTouches;
}

@end
