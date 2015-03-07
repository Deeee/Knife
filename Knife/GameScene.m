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
    SKSpriteNode* _knife;
    SKColor* _skyColor;
}
@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKTexture* handTexture = [SKTexture textureWithImageNamed:@"hand.jpg"];
    handTexture.filteringMode = SKTextureFilteringNearest;
    
    SKTexture* knifeTexture = [SKTexture textureWithImageNamed:@"knife.png"];
    _knife = [SKSpriteNode spriteNodeWithTexture:knifeTexture];
    [_knife setScale:0.5];
    _knife.position = CGPointMake(self.frame.size.width / 4 + 400, CGRectGetMidY(self.frame));
    _knife.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_knife.size];
    
    _hand = [SKSpriteNode spriteNodeWithTexture:handTexture];
    [_hand setScale:1.0];
    _hand.position = CGPointMake(self.frame.size.width / 4 + 200, CGRectGetMidY(self.frame));
    _skyColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
    [self setBackgroundColor:_skyColor];
    
    [self addChild:_hand];
    [self addChild:_knife];
    }

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        SKTexture* handTexture = [SKTexture textureWithImageNamed:@"hand.jpg"];
        handTexture.filteringMode = SKTextureFilteringNearest;
        
        _hand = [SKSpriteNode spriteNodeWithTexture:handTexture];
        [_hand setScale:2.0];
        _hand.position = CGPointMake(self.frame.size.width / 4, CGRectGetMidY(self.frame));
        _skyColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
        [self setBackgroundColor:_skyColor];
        [self addChild:_hand];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    [_knife.physicsBody applyImpulse:CGVectorMake(0, 8)];
    

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
