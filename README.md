# PublicMethod
#### 获取Assets.xcassets中的 `LaunchImage`图片
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    // 竖屏
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
    CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
    if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
    {
    launchImageName = dict[@"UILaunchImageName"];
    }
    }
    return launchImageName;
    }

#### 获取Assets.xcassets中的 `AppIcon`
    + (UIImage *)getAppIcon {

    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage *image = [UIImage imageNamed:icon];
    return image;
    }

#### 判断是否是 iPhoneX
    + (BOOL)xys_isIPhoneX {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) {
    // 模拟器下采用屏幕的高度来判断
    return [UIScreen mainScreen].bounds.size.height == 812;
    }
    BOOL isIPhoneX = [platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"];
    return isIPhoneX;
    }

#### 汉字转拼音
    + (NSString *) chineseCharactersToPinyin:(NSString *)sourceString {
    NSMutableString *mutableString = [NSMutableString stringWithString:sourceString];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return mutableString;
    }

#### 获取视频第一帧图片
    + (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {

    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;

    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 6)actualTime:NULL error:&thumbnailImageGenerationError];

    if(!thumbnailImageRef)
    NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);

    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;

    return thumbnailImage;
    }

#### 金额格式化
    + (NSString *)stringTwoDecimalPlaces:(NSString *)numString positivePrefix:(NSString *)positivePrefix {

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    NSNumber *number = [formatter numberFromString:numString];

    //整数每三位逗号分开
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    //小数点后保留两位
    formatter.maximumFractionDigits = 2;
    formatter.minimumFractionDigits = 2;
    //数字前加￥
    formatter.positivePrefix = positivePrefix;

    NSString *string = [formatter stringFromNumber:number];

    return string;
    }

