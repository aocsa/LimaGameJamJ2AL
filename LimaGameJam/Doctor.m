#import "Doctor.h"

@implementation Doctor {
    CCSprite *_highlight;
    CCSprite *_shadow;
    
    BOOL _grabbed;
    NSTimeInterval _previousTime;
    CGPoint _previousVelocity;
    CGPoint _previousPos;
}


+ (instancetype)doctorWithLetter:(NSString *)letter; {
    return([[Doctor alloc] initWithLetter:letter]);
}

- (instancetype)initWithLetter:(NSString *)letter {
    self = [super init];
    if (!self) return(nil);
     
    // fist create a sphere with a letter
    self.sphere = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"letter.%@.png", letter]];
    [self addChild:self.sphere];
    
    // Give the sprite a physics body.
    // Use the content size from the sphere, and subtract NewtonSphereMargin (a constant), as the image we are using, has a transparent edge
    CCPhysicsBody *body = [CCPhysicsBody bodyWithCircleOfRadius:(self.sphere.contentSize.width - NewtonSphereMargin) * 0.5 andCenter:CGPointZero];
    
    self.physicsBody = body;
    
    body.friction = 0.5;
    body.elasticity = 1.0;
    
    // Assign the collision category
    // As you can assign several categories, this becomes an extremely flexible and clever way of filtering collisions.
    body.collisionCategories = @[NewtonSphereCollisionSphere];
    
    // Spheres should collide with both other spheres, and the outline
    body.collisionMask = @[NewtonSphereCollisionSphere, NewtonSphereCollisionOutline];
    
    // Create the shadow
    _shadow = [CCSprite spriteWithImageNamed:@"letter.shadow.png"];
    [self addChild:_shadow];
    
    // Create the highlight
    _highlight = [CCSprite spriteWithImageNamed:@"letter.highlight.png"];
    [self addChild:_highlight];
    
    // enable touch for the sphere
    self.userInteractionEnabled = YES;
    
    // set effect mode and control data
    _lightPos = CGPointZero;
    self.effect = NewtonSphereEffectLight;
    
    return(self);
}

- (void)dealloc {
    CCLOG(@"A Newton Sphere was deallocated");
}

#pragma mark - Hit test override

- (BOOL)hitTestWithWorldPos:(CGPoint)pos {
    // The Newton Sphere is a compound physics object, and thus based on a CCNode.
    // Because of that, the object has no content size, and default touch registration will not work
    // Giving the node a content size, will ruin the compound placement.
    
    // To fix this, the hit test function is overridden.
    // As this is a simple sphere, the hit test will return YES, if the touch distance to sphere, is less than radius
    
    // calculate distance from touch to node position
    float distance = ccpDistance(pos, self.position);
    return(distance < self.sphere.contentSize.width * 0.5);
}

#pragma mark - Touch implementation

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    self.physicsBody.mass = NewtonSphereMovingMass;
    
    // 2) Save state data, like time and position, so that a velocity can be calculated when moving the sphere.
    // Velocity must be set on forced movement, otherwise the collisions will feel "mushy"
    _grabbed = YES;
    _previousVelocity = CGPointZero;
    _previousTime = event.timestamp;
    _previousPos = touch.locationInWorld;
    CCLOG(@"A Newton Sphere was touched");
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    // on each move, calculate a velocity used in update, and save new state data
    _previousVelocity = ccpMult( ccpSub(touch.locationInWorld, _previousPos), 1 / (event.timestamp - _previousTime));
    _previousTime = event.timestamp;
    _previousPos = touch.locationInWorld;
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    // if not grabbed anymore, return mass to normal
    _grabbed = NO;
    self.physicsBody.mass = NewtonSphereNormalMass;
}

- (void)touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    [self touchEnded:touch withEvent:event];
}

#pragma mark - Scheduled update

- (void)update:(CCTime)delta
{
    // update needs not to be scheduled anymore. Just overriding update:, will automatically cause it to be called
    
    // if the sphere is grabbed, force it into position, and update its velocity.
    if (_grabbed) {
        self.position = _previousPos;
        self.physicsBody.velocity = _previousVelocity;
    }
    
    // check which effect is currently active
    switch (_effect) {
        case NewtonSphereEffectLight: {
            // if light is active, calculate the light vector (not normalized)
            CGPoint lightVector = ccpSub(_lightPos, self.position);
            
            // calculate angle and distance to light source
            float angle = ccpToAngle(lightVector);
            float distance = ccpLength(lightVector);
            
            // set highlight and shadow rotation, based on angle
            // Note.
            // Highlight and shadow are children of the physics node, and will as such, rotate with it
            // As highlight and shadow should only rotate with light position, self.rotation is subtracted
            _highlight.rotation = 90 - (angle * 180 / M_PI) - self.rotation;
            _shadow.rotation = 90 - (angle * 180 / M_PI) - self.rotation;
            
            // calculate highlight and shadow intensity, based on distance
            // normalize distance, based on screen width
            distance /= [CCDirector sharedDirector].viewSize.width;
            
            // calculate opacity for highlight and shadow, to make the lighting look believeable
            // I know ... this is kind of hardcoded ... Sorry ...
            _highlight.opacity = clampf(1 - (2 * distance),0,1);
            _shadow.opacity = clampf(3 * distance,0,1);
            
            break;
        }
    }
}

#pragma mark - Property implementation

- (void)setEffect:(NewtonSphereEffect)effect {
    _effect = effect;
    
    switch (effect) {
        case NewtonSphereEffectLight: {
            _highlight.visible = YES;
            break;
        }
    }
}


@end
