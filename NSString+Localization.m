
#import "NSString+Localization.h"

@implementation NSString (Localization)



-(NSString*)localizedString{
    
    NSString *localizationCode = [NSString currentLocalizationCode];
    NSString *path= [[NSBundle mainBundle] pathForResource:localizationCode ofType:@"lproj"];
    //Quick fix if app could not find the localization file it uses en by default
    if(path == nil)
        path= [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    NSBundle* languageBundle = [NSBundle bundleWithPath:path];
    NSString* str=[languageBundle localizedStringForKey:self value:@"" table:nil];
    return str;
}

+(NSString*)currentLocalizationCode{
    
    NSString *preferredLanguage=@"en";

    preferredLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    NSArray *listItems = [preferredLanguage componentsSeparatedByString:@"-"];
    
    preferredLanguage = [listItems objectAtIndex:0];
    
    NSString *path= [[NSBundle mainBundle] pathForResource:preferredLanguage ofType:@"lproj"];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (fileExists) {
        return preferredLanguage;
    }
    else {
        return [NSString findPreferredLanguageCode];
    }
    
    return preferredLanguage;
}

+(NSString*)findPreferredLanguageCode{
    
    NSString *preferredLanguage=@"en";
    
    //get preferred languages in userdefaults
    NSArray *arr=[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    
    for (NSString *lang in arr) {
        NSString *path= [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];  
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
        if (fileExists) {
            preferredLanguage=lang;
            break;
        }
    }
    return preferredLanguage;
}

@end
