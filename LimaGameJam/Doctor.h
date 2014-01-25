#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "NewtonConstants.h"

typedef NS_ENUM(NSInteger, NewtonSphereEffect) {
    NewtonSphereEffectLight
};

@interface Doctor : CCNode {
    
}

@property (nonatomic, strong) CCSprite *sphere;
@property (nonatomic, assign) CGPoint lightPos;
@property (nonatomic, assign) NewtonSphereEffect effect;

+ (instancetype)doctorWithLetter:(NSString *)letter;
- (instancetype)initWithLetter:(NSString *)letter;

@end
