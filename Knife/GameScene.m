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
    CGPoint originLoc;
    int handHitCategory;
    int knifeHitCategory;
    SKShapeNode *point;
    CGPoint loc;
    BOOL isTouched;
}
@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
//    self.physicsWorld.gravity = CGVectorMake( 0.0, -5.0 );
    /* Setup your scene here */
    SKTexture* handTexture = [SKTexture textureWithImageNamed:@"final_hand.png"];
    handTexture.filteringMode = SKTextureFilteringNearest;
    SKTexture* groundTexture = [SKTexture textureWithImageNamed:@"final_background.png"];
    groundTexture.filteringMode = SKTextureFilteringNearest;

//    SKAction* moveGroundSprite = [SKAction moveByX:-groundTexture.size.width*2 y:0 duration:0.02 * groundTexture.size.width*2];
//    SKAction* resetGroundSprite = [SKAction moveByX:groundTexture.size.width*2 y:0 duration:0];
//    SKAction* moveGroundSpritesForever = [SKAction repeatActionForever:[SKAction sequence:@[moveGroundSprite, resetGroundSprite]]];
    
    SKTexture* knifeTexture = [SKTexture textureWithImageNamed:@"knife2.png"];
    _knife = [SKSpriteNode spriteNodeWithTexture:knifeTexture];
    [_knife setScale:0.23];
    _knife.position = CGPointMake(self.frame.size.width / 4 + 400, self.frame.size.height / 200 + 730);
//    _knife.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_knife.size.height/2];
//    _knife.physicsBody.dynamic = YES;
//    _knife.physicsBody.allowsRotation = NO;
    
    
    _hand = [SKSpriteNode spriteNodeWithTexture:handTexture];
    [_hand setScale:0.7];
    _hand.position = CGPointMake(self.frame.size.width / 3.29 + 200, self.frame.size.height / 200 + 250);
    
    SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithTexture:groundTexture];
    [sprite setScale:0.45];
    sprite.position = CGPointMake(self.frame.size.width / 3.29 + 200, CGRectGetMidY(self.view.frame) + 100);
    
    [self addChild:sprite];
    
//    _skyColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
//    [self setBackgroundColor:_skyColor];
    
//    for( int i = 0; i < 2 + self.frame.size.width / ( groundTexture.size.width * 2 ); ++i ) {
//        SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithTexture:groundTexture];
//        [sprite setScale:0.5];
//        sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2);
//        [sprite runAction:moveGroundSpritesForever];
//
//        [self addChild:sprite];
//    }
    
    SKNode* dummy = [SKNode node];
    dummy.position = CGPointMake(0, groundTexture.size.height);
    dummy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, groundTexture.size.height * 2)];
    dummy.physicsBody.dynamic = NO;
    [self addChild:_hand];
    [self addChild:_knife];
    [self addChild:dummy];
    [self rotatingHand];
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

-(void)rotatingHand {
    SKAction *rotatM2L = [SKAction rotateToAngle:0.58 duration:SKActionTimingEaseIn];
    SKAction *rotatL2R = [SKAction rotateToAngle:-0.66 duration:SKActionTimingEaseIn];
    SKAction *rotatR2M = [SKAction rotateToAngle:0.0 duration:SKActionTimingEaseIn];
    
    SKAction *rotateSeq = [SKAction sequence:@[rotatM2L, rotatL2R, rotatR2M]];
    rotateSeq.timingMode = SKActionTimingEaseIn;
    
    [_hand runAction:[SKAction repeatActionForever:rotateSeq] withKey:@"rotatingHand"];

    
    return;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setUserInteractionEnabled: NO];
    [point removeFromParent];
    /* Called when a touch begins */
    CGPoint location = [[touches anyObject] locationInNode:self];
    location.x = location.x + _knife.size.width/2;
    location.y = location.y - _knife.size.height/2;
    SKAction *move = [SKAction moveTo:loc duration:0.2f];
    SKAction *moveback = [SKAction moveTo:originLoc duration:0.2f];
    SKAction *action = [SKAction sequence:@[move, moveback]];
    
    [_knife runAction:action completion:^(void){
       // [self runAction:moveback];
        //[self setUserInteractionEnabled:NO];
        //if(CGPointEqualToPoint(_knife.position, originLoc))
        //{
            [self setUserInteractionEnabled:YES];
        //}
    }];;
    isTouched = YES;
   // [_knife runAction:moveback];

//    _knife.position = originLoc;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    isTouched = NO;
}
-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    point = [SKShapeNode shapeNodeWithCircleOfRadius:10];
    [point setName:@"point"];
    [point setFillColor:[UIColor redColor]];
    [point setPosition:contact.contactPoint];
    [self addChild:point];
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    
    if(isTouched == YES && firstBody.categoryBitMask == knifeHitCategory && secondBody.categoryBitMask == handHitCategory)
    {
        
        NSLog(@"balloon hit the spikes");
        //setup your methods and other things here
        
    }
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

