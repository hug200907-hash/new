
#import "SaveSetting.h"

@interface SaveSetting ()
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSMutableDictionary *settings;
@end

@implementation SaveSetting

+ (instancetype)shared {
    static SaveSetting *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SaveSetting alloc] init];
        [instance loadSettings];
    });
    return instance;
}

- (NSString *)filePath {
    if (!_filePath) {
        NSString *docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _filePath = [docsDir stringByAppendingPathComponent:@"Settingss.plist"];
    }
    return _filePath;
}

- (void)loadSettings {
    self.settings = [NSMutableDictionary dictionaryWithContentsOfFile:self.filePath];
    if (!self.settings) {
        self.settings = [NSMutableDictionary dictionary];
    }
}

- (void)saveToDisk {
    [self.settings writeToFile:self.filePath atomically:YES];
}

- (void)saveBool:(BOOL)value forKey:(NSString *)key {
    self.settings[key] = @(value);
    [self saveToDisk];
}

- (BOOL)loadBoolForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    if (self.settings[key]) {
        return [self.settings[key] boolValue];
    }
    return defaultValue;
}

- (void)saveInt:(NSInteger)value forKey:(NSString *)key {
    self.settings[key] = @(value);
    [self saveToDisk];
}

- (NSInteger)loadIntForKey:(NSString *)key defaultValue:(NSInteger)defaultValue {
    if (self.settings[key]) {
        return [self.settings[key] integerValue];
    }
    return defaultValue;
}

- (void)saveFloat:(float)value forKey:(NSString *)key {
    self.settings[key] = @(value);
    [self saveToDisk];
}

- (float)loadFloatForKey:(NSString *)key defaultValue:(float)defaultValue {
    if (self.settings[key]) {
        return [self.settings[key] floatValue];
    }
    return defaultValue;
}

@end
