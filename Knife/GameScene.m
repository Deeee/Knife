//
//  GameScene.m
//  Knife
//
//  Created by Liu Di on 3/6/15.
//  Copyright (c) 2015 Liu Di. All rights reserved.
//

#import "GameScene.h"

@interface GameScene () {
    SKSpriteNode* _hand;
}
@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKTexture* handTexture = [SKTexture textureWithImageNamed:@"hand.jpg"];
    handTexture.filteringMode = SKTextureFilteringNearest;
    
    _hand = [SKSpriteNode spriteNodeWithTexture:handTexture];
    [_hand setScale:1.0];
    _hand.position = CGPointMake(self.frame.size.width / 4 + 200, CGRectGetMidY(self.frame));
    
    
    [self addChild:_hand];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        SKTexture* handTexture = [SKTexture textureWithImageNamed:@"hand.jpg"];
        handTexture.filteringMode = SKTextureFilteringNearest;
        
        _hand = [SKSpriteNode spriteNodeWithTexture:handTexture];
        [_hand setScale:2.0];
        _hand.position = CGPointMake(self.frame.size.width / 4, CGRectGetMidY(self.frame));
        
        [self addChild:_hand];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
