
@import Foundation;

static inline NSString* tempDirectory() {
    return NSTemporaryDirectory();
}

static inline NSString *cachesDirectory(){
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

static inline NSString *documentDirectory(){
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject];
}


static inline NSString  *currnetDate(){
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    dateFormatter.locale  = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}


static inline  BOOL isBlankString(NSString *string)
{
    if (string == nil || string == NULL || [string isKindOfClass:[NSNull class]]|| [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return YES;
    }
    return NO;
}