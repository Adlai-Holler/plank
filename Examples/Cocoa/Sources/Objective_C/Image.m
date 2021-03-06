//
//  Image.m
//  Autogenerated by plank
//
//  DO NOT EDIT - EDITS WILL BE OVERWRITTEN
//  @generated
//

#import "Image.h"

struct ImageDirtyProperties {
    unsigned int ImageDirtyPropertyHeight:1;
    unsigned int ImageDirtyPropertyUrl:1;
    unsigned int ImageDirtyPropertyWidth:1;
};

@interface Image ()
@property (nonatomic, assign, readwrite) struct ImageDirtyProperties imageDirtyProperties;
@end

@interface ImageBuilder ()
@property (nonatomic, assign, readwrite) struct ImageDirtyProperties imageDirtyProperties;
@end

@implementation Image
+ (NSString *)className
{
    return @"Image";
}
+ (NSString *)polymorphicTypeIdentifier
{
    return @"image";
}
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithModelDictionary:dictionary];
}
- (instancetype)init
{
    return [self initWithModelDictionary:@{}];
}
- (instancetype)initWithModelDictionary:(NS_VALID_UNTIL_END_OF_SCOPE NSDictionary *)modelDictionary
{
    NSParameterAssert(modelDictionary);
    if (!modelDictionary) {
        return self;
    }
    if (!(self = [super init])) {
        return self;
    }
        {
            __unsafe_unretained id value = modelDictionary[@"height"]; // Collection will retain.
            if (value != nil) {
                if (value != (id)kCFNull) {
                    self->_height = [value integerValue];
                }
                self->_imageDirtyProperties.ImageDirtyPropertyHeight = 1;
            }
        }
        {
            __unsafe_unretained id value = modelDictionary[@"url"]; // Collection will retain.
            if (value != nil) {
                if (value != (id)kCFNull) {
                    self->_url = [NSURL URLWithString:value];
                }
                self->_imageDirtyProperties.ImageDirtyPropertyUrl = 1;
            }
        }
        {
            __unsafe_unretained id value = modelDictionary[@"width"]; // Collection will retain.
            if (value != nil) {
                if (value != (id)kCFNull) {
                    self->_width = [value integerValue];
                }
                self->_imageDirtyProperties.ImageDirtyPropertyWidth = 1;
            }
        }
    if ([self class] == [Image class]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPlankDidInitializeNotification object:self userInfo:@{ kPlankInitTypeKey : @(PlankModelInitTypeDefault) }];
    }
    return self;
}
- (instancetype)initWithBuilder:(ImageBuilder *)builder
{
    NSParameterAssert(builder);
    return [self initWithBuilder:builder initType:PlankModelInitTypeDefault];
}
- (instancetype)initWithBuilder:(ImageBuilder *)builder initType:(PlankModelInitType)initType
{
    NSParameterAssert(builder);
    if (!(self = [super init])) {
        return self;
    }
    _height = builder.height;
    _url = builder.url;
    _width = builder.width;
    _imageDirtyProperties = builder.imageDirtyProperties;
    if ([self class] == [Image class]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPlankDidInitializeNotification object:self userInfo:@{ kPlankInitTypeKey : @(initType) }];
    }
    return self;
}
- (NSString *)debugDescription
{
    NSArray<NSString *> *parentDebugDescription = [[super debugDescription] componentsSeparatedByString:@"\n"];
    NSMutableArray *descriptionFields = [NSMutableArray arrayWithCapacity:3];
    [descriptionFields addObject:parentDebugDescription];
    struct ImageDirtyProperties props = _imageDirtyProperties;
    if (props.ImageDirtyPropertyHeight) {
        [descriptionFields addObject:[@"_height = " stringByAppendingFormat:@"%@", @(_height)]];
    }
    if (props.ImageDirtyPropertyUrl) {
        [descriptionFields addObject:[@"_url = " stringByAppendingFormat:@"%@", _url]];
    }
    if (props.ImageDirtyPropertyWidth) {
        [descriptionFields addObject:[@"_width = " stringByAppendingFormat:@"%@", @(_width)]];
    }
    return [NSString stringWithFormat:@"Image = {\n%@\n}", debugDescriptionForFields(descriptionFields)];
}
- (instancetype)copyWithBlock:(PLANK_NOESCAPE void (^)(ImageBuilder *builder))block
{
    NSParameterAssert(block);
    ImageBuilder *builder = [[ImageBuilder alloc] initWithModel:self];
    block(builder);
    return [builder build];
}
- (BOOL)isEqual:(id)anObject
{
    if (self == anObject) {
        return YES;
    }
    if ([anObject isKindOfClass:[Image class]] == NO) {
        return NO;
    }
    return [self isEqualToImage:anObject];
}
- (BOOL)isEqualToImage:(Image *)anObject
{
    return (
        (anObject != nil) &&
        (_width == anObject.width) &&
        (_height == anObject.height) &&
        (_url == anObject.url || [_url isEqual:anObject.url])
    );
}
- (NSUInteger)hash
{
    NSUInteger subhashes[] = {
        17,
        (NSUInteger)_height,
        [_url hash],
        (NSUInteger)_width
    };
    return PINIntegerArrayHash(subhashes, sizeof(subhashes) / sizeof(subhashes[0]));
}
- (instancetype)mergeWithModel:(Image *)modelObject
{
    return [self mergeWithModel:modelObject initType:PlankModelInitTypeFromMerge];
}
- (instancetype)mergeWithModel:(Image *)modelObject initType:(PlankModelInitType)initType
{
    NSParameterAssert(modelObject);
    ImageBuilder *builder = [[ImageBuilder alloc] initWithModel:self];
    [builder mergeWithModel:modelObject];
    return [[Image alloc] initWithBuilder:builder initType:initType];
}
#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
#pragma mark - NSSecureCoding
+ (BOOL)supportsSecureCoding
{
    return YES;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (!(self = [super init])) {
        return self;
    }
    _height = [aDecoder decodeIntegerForKey:@"height"];
    _url = [aDecoder decodeObjectOfClass:[NSURL class] forKey:@"url"];
    _width = [aDecoder decodeIntegerForKey:@"width"];
    _imageDirtyProperties.ImageDirtyPropertyHeight = [aDecoder decodeIntForKey:@"height_dirty_property"] & 0x1;
    _imageDirtyProperties.ImageDirtyPropertyUrl = [aDecoder decodeIntForKey:@"url_dirty_property"] & 0x1;
    _imageDirtyProperties.ImageDirtyPropertyWidth = [aDecoder decodeIntForKey:@"width_dirty_property"] & 0x1;
    if ([self class] == [Image class]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPlankDidInitializeNotification object:self userInfo:@{ kPlankInitTypeKey : @(PlankModelInitTypeDefault) }];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.height forKey:@"height"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeInteger:self.width forKey:@"width"];
    [aCoder encodeInt:_imageDirtyProperties.ImageDirtyPropertyHeight forKey:@"height_dirty_property"];
    [aCoder encodeInt:_imageDirtyProperties.ImageDirtyPropertyUrl forKey:@"url_dirty_property"];
    [aCoder encodeInt:_imageDirtyProperties.ImageDirtyPropertyWidth forKey:@"width_dirty_property"];
}
@end

@implementation ImageBuilder
- (instancetype)initWithModel:(Image *)modelObject
{
    NSParameterAssert(modelObject);
    if (!(self = [super init])) {
        return self;
    }
    struct ImageDirtyProperties imageDirtyProperties = modelObject.imageDirtyProperties;
    if (imageDirtyProperties.ImageDirtyPropertyHeight) {
        _height = modelObject.height;
    }
    if (imageDirtyProperties.ImageDirtyPropertyUrl) {
        _url = modelObject.url;
    }
    if (imageDirtyProperties.ImageDirtyPropertyWidth) {
        _width = modelObject.width;
    }
    _imageDirtyProperties = imageDirtyProperties;
    return self;
}
- (Image *)build
{
    return [[Image alloc] initWithBuilder:self];
}
- (void)mergeWithModel:(Image *)modelObject
{
    NSParameterAssert(modelObject);
    ImageBuilder *builder = self;
    if (modelObject.imageDirtyProperties.ImageDirtyPropertyHeight) {
        builder.height = modelObject.height;
    }
    if (modelObject.imageDirtyProperties.ImageDirtyPropertyUrl) {
        builder.url = modelObject.url;
    }
    if (modelObject.imageDirtyProperties.ImageDirtyPropertyWidth) {
        builder.width = modelObject.width;
    }
}
- (void)setHeight:(NSInteger)height
{
    _height = height;
    _imageDirtyProperties.ImageDirtyPropertyHeight = 1;
}
- (void)setUrl:(NSURL *)url
{
    _url = [url copy];
    _imageDirtyProperties.ImageDirtyPropertyUrl = 1;
}
- (void)setWidth:(NSInteger)width
{
    _width = width;
    _imageDirtyProperties.ImageDirtyPropertyWidth = 1;
}
@end
