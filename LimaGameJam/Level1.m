#import "Level1.h"
#import "Doctor.h"
#import "LightBulb.h"



@implementation Level1{
    CCPhysicsNode *_physics;
    LightBulb *_light;

}

+ (Level1 *)scene {
    return [[self alloc] init];
}


- (id)init{
    self = [super init];
    if (!self) return(nil);
    self.levelNumber = 1;
    self.worldRect = CGRectMake(0, 85, [CCDirector sharedDirector].viewSize.width, [CCDirector sharedDirector].viewSize.height-85);
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    [self setSceneTitle];
    [self setBackground];
    [self createBody];
	return self;
}

- (void) setSceneTitle {
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Level %i",self.levelNumber] fontName:@"Chalkduster" fontSize:60.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor whiteColor];
    label.position = ccp(0.5f, 0.80f);
    [self addChild:label];
}

- (void) setBackground {
    CCSprite *backgroundSprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"backgroundLevel%i.jpg",self.levelNumber]];
    backgroundSprite.positionType = CCPositionTypeNormalized;
    backgroundSprite.position = ccp(0.5f, 0.5f);
    [self addChild:backgroundSprite];
}

- (void) createDoctor {
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"DoctorCoordinates.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"DoctorTexture.png"];
    [self addChild:spriteSheet];
    NSMutableArray *doctorWalkImageArray = [NSMutableArray array];
    for (int i=1; i<=8; i++) {
        NSLog(@"recorre");
        [doctorWalkImageArray addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                     [NSString stringWithFormat:@"%i.png",i]]];
    }
    
}

- (void) createBody {
    // llamar al spriteSheet
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"newton.plist"];
    
    // crear y dibujar la luz
    _light = [LightBulb spriteWithImageNamed:@"light.png"];
    _light.position = ccp([CCDirector sharedDirector].viewSize.width * NewtonLightPosition.x, [CCDirector sharedDirector].viewSize.height * NewtonLightPosition.y);
    _light.userInteractionEnabled = YES;
    [self addChild:_light z:1];
    
    // EL DOCTOR
    
    // Create a physics node, to hold all the spheres
    // This node is a physics node, so that you can add physics to the spheres
    _physics = [CCPhysicsNode node];
    _physics.gravity = CGPointMake(0,-980.665);
    [self addChild:_physics];
    
    // Propiedades fisicas del grupo de _physics
    CCNode *outline = [CCNode node];
    outline.physicsBody = [CCPhysicsBody bodyWithPolylineFromRect:self.worldRect cornerRadius:0];
    outline.physicsBody.friction = 1.0f;
    outline.physicsBody.elasticity = 0.5;
    [_physics addChild:outline];
    
    // Propiedades del objeto doctor (ball)
    Doctor *sphere = [Doctor doctorWithLetter:@"c"];
    sphere.positionType = CCPositionTypePoints;
    sphere.position = ccp(100,200);
    sphere.lightPos = _light.position;
    [_physics addChild:sphere];
    self.userInteractionEnabled = YES;
}

#pragma mark - Enter and Exit

- (void)onEnter {
    [super onEnter];
}

- (void)onExit {
    [super onExit];
}

- (void)onEnterTransitionDidFinish {
    [super onEnterTransitionDidFinish];
}

- (void)onExitTransitionDidStart {
    [super onExitTransitionDidStart];
}

- (void)update:(CCTime)delta {
    for (CCNode *node in _physics.children) {
        // update light on all nodes which are of type NewtonSphere
        // Includes some "old scholl" casting.
        // Be careful with casting, unless you are 100% certain about what you do. Can create some nasty bugs
        if ([node isKindOfClass:[Doctor class]]) {
            Doctor *sphere = (Doctor *)node;
            sphere.lightPos = _light.position;
        }
    }
}

@end
