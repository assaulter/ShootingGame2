//
//  NextStage.m
//  ShootingGame
//
//  Created by KazukiKubo on 2013/02/28.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "NextStage.h"
#import "MainScene.h"

@implementation NextStage

-(id)init {
    if (self = [super init]) {
        [CCMenuItemFont setFontSize:20];
		[CCMenuItemFont setFontName:@"Helvetica"];
		CCMenuItem *start = [CCMenuItemFont itemWithString:@"Next Stage"
                                                    target:self selector:@selector(backToTitle:)];
        CCMenu *menu = [CCMenu menuWithItems:start, nil];
		[menu alignItemsVertically];
		[self addChild:menu];
    }
    return self;
}

- (void)backToTitle:(id)sender {
    CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1.0 scene:[MainScene nodeWithScene] withColor:ccc3(255, 255, 255)];
    [[CCDirector sharedDirector] replaceScene:tran];
}

@end
