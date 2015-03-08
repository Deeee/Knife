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
    int handHitCategory;
    int knifeHitCategory;
    SKShapeNode *point;
    BOOL isTouched;
    CGPoint location;
}
@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
//    self.physicsWorld.gravity = CGVectorMake( 0.0, -5.0 );
    /* Setup your scene here */
    self.physicsWorld.gravity = CGVectorMake( 0.0, 0 );
    handHitCategory = 1;
    knifeHitCategory = 2;
    isTouched = NO;
    self.physicsWorld.contactDelegate = self;

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
    _knife.position = CGPointMake(self.frame.size.width / 4 + 400, self.frame.size.height / 200 + 700);
//    _knife.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_knife.size.height/2];
    _knife.physicsBody = [SKPhysicsBody bodyWithTexture:_knife.texture size:_knife.size];
    _knife.physicsBody.dynamic = NO;
    _knife.physicsBody.allowsRotation = NO;
    
    _knife.physicsBody.categoryBitMask = knifeHitCategory;
    _knife.physicsBody.contactTestBitMask = handHitCategory;
    _knife.physicsBody.collisionBitMask = handHitCategory;
    
    
    _hand = [SKSpriteNode spriteNodeWithTexture:handTexture];
    [_hand setScale:0.7];
    _hand.position = CGPointMake(self.frame.size.width / 4 + 280 , self.frame.size.height / 200 + 210);
    _hand.physicsBody = [SKPhysicsBody bodyWithTexture:_hand.texture size:_hand.size];
    
    _hand.physicsBody.categoryBitMask = handHitCategory;
    _hand.physicsBody.contactTestBitMask = knifeHitCategory;
    _hand.physicsBody.collisionBitMask = knifeHitCategory;
    
//    _skyColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
//    [self setBackgroundColor:_skyColor];
    
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
    
//    SKNode* dummy = [SKNode node];
//    dummy.position = CGPointMake(0, groundTexture.size.height);
//    dummy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, groundTexture.size.height * 2)];
//    dummy.physicsBody.dynamic = NO;
    
    [self addChild:_hand];
    [self addChild:_knife];
    //    [self addChild:dummy];
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
        self.physicsWorld.contactDelegate = self;
    }
    return self;
}

-(void)rotatingHand {
    SKAction *rotatM2L = [SKAction rotateToAngle:0.56 duration:SKActionTimingEaseIn];
    SKAction *rotatL2R = [SKAction rotateToAngle:-0.72 duration:SKActionTimingEaseIn];
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
    location = [[touches anyObject] locationInNode:self];
    CGPoint originLoc = _knife.position;
    location.x = originLoc.x - 20;
    location.y = originLoc.y - 20;
    SKAction *move = [SKAction moveTo:location duration:0.1f];
    SKAction *moveback = [SKAction moveTo:originLoc duration:0.1f];
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

//-(Boolean)hitFingers {
//    location.x
//}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    int firstBody, secondBody;
    point = [SKShapeNode shapeNodeWithCircleOfRadius:10];
    [point setName:@"point"];
    [point setFillColor:[UIColor redColor]];
    [point setPosition:contact.contactPoint];
    [self addChild:point];

    firstBody = contact.bodyA.categoryBitMask;
    secondBody = contact.bodyB.categoryBitMask;
    
    if (isTouched == YES) {
        if((((firstBody & handHitCategory) != 0) &&((secondBody & knifeHitCategory) != 0)) || (((firstBody & knifeHitCategory) != 0) && ((secondBody & handHitCategory) != 0)))
        {
            NSLog(@"balloon hit the spikes");

            //setup your methods and other things here
        }
    }
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

