YYWebImage
==============
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/ibireme/YYWebImage/master/LICENSE)&nbsp;
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/YYWebImage.svg?style=flat)](http://cocoapods.org/?q= YYWebImage)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/YYWebImage.svg?style=flat)](http://cocoapods.org/?q= YYWebImage)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%206%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Build Status](https://travis-ci.org/ibireme/YYWebImage.svg?branch=master)](https://travis-ci.org/ibireme/YYWebImage)

![ProgressiveBlur~](https://raw.github.com/ibireme/YYWebImage/master/Demo/Demo.gif
)

YYWebImage is an asynchronous image loading framework (a component of [YYKit](https://github.com/ibireme/YYKit)).

It was created as an improved replacement for SDWebImage, PINRemoteImage and FLAnimatedImage.

It use [YYCache](https://github.com/ibireme/YYCache) to support memory and disk cache, and [YYImage](https://github.com/ibireme/YYImage) to support WebP/APNG/GIF image decode.<br/>
See these project for more information.


Features
==============
- Asynchronous image load from remote or local URL.
- Animated WebP, APNG, GIF support (dynamic buffer, lower memory usage).
- Baseline/progressive/interlaced image decode support.
- Image loading category for UIImageView, UIButton, MKAnnotationView and CALayer.
- Image effect: blur, round corner, resize, color tint, crop, rotate and more.
- High performance memory and disk image cache.
- High performance image loader to avoid main thread blocked.
- Fully documented.

Usage
==============

###Load image from URL

	// load from remote url
	imageView.yy_imageURL = [NSURL URLWithString:@"http://github.com/logo.png"];
	
	// load from local url
	imageView.yy_imageURL = [NSURL fileURLWithPath:@"/tmp/logo.png"];
	

###Load animated image
	
	// just replace `UIImageView` with `YYAnimatedImageView`
	UIImageView *imageView = [YYAnimatedImageView new];
	imageView.yy_imageURL = [NSURL URLWithString:@"http://github.com/ani.webp"];


###Load image progressively
	
	// progressive
	[imageView yy_setImageWithURL:url options:YYWebImageOptionProgressive];
	
	// progressive with blur and fade animation (see the demo at the top of this page)
	[imageView yy_setImageWithURL:url options:YYWebImageOptionProgressiveBlur ｜ YYWebImageOptionSetImageWithFadeAnimation];


###Load and process image
	
	// 1. download image from remote
	// 2. get download progress
	// 3. resize image and add round corner
	// 4. set image with a fade animation
	
	[imageView yy_setImageWithURL:url
        placeholder:nil
        options:YYWebImageOptionSetImageWithFadeAnimation
        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            progress = (float)receivedSize / expectedSize;
        }
        transform:^UIImage *(UIImage *image, NSURL *url) {
            image = [image yy_imageByResizeToSize:CGSizeMake(100, 100) contentMode:UIViewContentModeCenter];
            return [image yy_imageByRoundCornerRadius:10];
        }
        completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
            if (from == YYWebImageFromDiskCache) {
                NSLog(@"load from disk cache");
            }
        }];
        
###Image Cache
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    
    // get cache capacity
    cache.memoryCache.totalCost;
    cache.memoryCache.totalCount;
    cache.diskCache.totalCost;
    cache.diskCache.totalCount;
    
    // clear cache
    [cache.memoryCache removeAllObjects];
    [cache.diskCache removeAllObjects];
    
    // clear disk cache with progress
    [cache.diskCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
        // progress
    } endBlock:^(BOOL error) {
        // end
    }];
	
Installation
==============

### CocoaPods

1. Update cocoapods to the latest version.
2. Add `pod 'YYWebImage'` to your Podfile.
3. Run `pod install` or `pod update`.
4. Import \<YYWebImage/YYWebImage.h\>.
5. Notice: it doesn't include WebP subspec by default, if you want to support WebP format, you may add `pod 'YYImage/WebP'` to your Podfile. You may call `YYImageWebPAvailable()` to check whether the WebP subspec is installed correctly.

### Carthage

1. Add `github "ibireme/YYWebImage"` to your Cartfile.
2. Run `carthage update --platform ios` and add the framework to your project.
3. Import \<YYWebImage/YYWebImage.h\>.
4. Notice: carthage framework doesn't include webp component, if you want to support WebP format, use CocoaPods or install manually. You may call `YYImageWebPAvailable()` to check whether the WebP library is installed correctly.

### Manually

1. Download all the files in the YYWebImage subdirectory.
2. Add the source files to your Xcode project.
3. Link with required frameworks:
	* UIKit
	* CoreFoundation
	* QuartzCore
	* AssetsLibrary
	* ImageIO
	* Accelerate
	* MobileCoreServices
	* sqlite3
	* libz
4. Import `YYWebImage.h`.
5. Notice: if you want to support WebP format, you may add `Vendor/WebP.framework`(static library) to your Xcode project.


Documentation
==============
Full API documentation is available on [CocoaDocs](http://cocoadocs.org/docsets/YYWebImage/).<br/>
You can also install documentation locally using [appledoc](https://github.com/tomaz/appledoc).


Requirements
==============
This library requires `iOS 6.0+` and `Xcode 7.0+`.


License
==============
YYWebImage is provided under the MIT license. See LICENSE file for details.


<br/><br/>
---
中文介绍
==============
![ProgressiveBlur~](https://raw.github.com/ibireme/YYWebImage/master/Demo/Demo.gif
)

YYWebImage 是一个异步图片加载框架 ([YYKit](https://github.com/ibireme/YYKit) 组件之一).

其设计目的是试图替代 SDWebImage、PINRemoteImage、FLAnimatedImage 等开源框架，它支持这些开源框架的大部分功能，同时增加了大量新特性、并且有不小的性能提升。

它底层用 [YYCache](https://github.com/ibireme/YYCache) 实现了内存和磁盘缓存, 用 [YYImage](https://github.com/ibireme/YYImage) 实现了 WebP/APNG/GIF 动图的解码和播放。<br/>
你可以查看这些项目以获得更多信息。


特性
==============
- 异步的图片加载，支持 HTTP 和本地文件。
- 支持 GIF、APNG、WebP 动画（动态缓存，低内存占用）。
- 支持逐行扫描、隔行扫描、渐进式图像加载。
- UIImageView、UIButton、MKAnnotationView、CALayer 的 Category 方法支持。
- 常见图片处理：模糊、圆角、大小调整、裁切、旋转、色调等。
- 高性能的内存和磁盘缓存。
- 高性能的图片设置方式，以避免主线程阻塞。
- 每个类和方法都有完善的文档注释。

用法
==============

###从 URL 加载图片

	// 加载网络图片
	imageView.yy_imageURL = [NSURL URLWithString:@"http://github.com/logo.png"];
	
	// 加载本地图片
	imageView.yy_imageURL = [NSURL fileURLWithPath:@"/tmp/logo.png"];
	

###加载动图
	
	// 只需要把 `UIImageView` 替换为 `YYAnimatedImageView` 即可。
	UIImageView *imageView = [YYAnimatedImageView new];
	imageView.yy_imageURL = [NSURL URLWithString:@"http://github.com/ani.webp"];


###渐进式图片加载
	
	// 渐进式：边下载边显示
	[imageView yy_setImageWithURL:url options:YYWebImageOptionProgressive];
	
	// 渐进式加载，增加模糊效果和渐变动画 （见本页最上方的GIF演示）
	[imageView yy_setImageWithURL:url options:YYWebImageOptionProgressiveBlur ｜ YYWebImageOptionSetImageWithFadeAnimation];


###加载、处理图片
	
	// 1. 下载图片
	// 2. 获得图片下载进度
	// 3. 调整图片大小、加圆角
	// 4. 显示图片时增加一个淡入动画，以获得更好的用户体验
	
	[imageView yy_setImageWithURL:url
        placeholder:nil
        options:YYWebImageOptionSetImageWithFadeAnimation
        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            progress = (float)receivedSize / expectedSize;
        }
        transform:^UIImage *(UIImage *image, NSURL *url) {
            image = [image yy_imageByResizeToSize:CGSizeMake(100, 100) contentMode:UIViewContentModeCenter];
            return [image yy_imageByRoundCornerRadius:10];
        }
        completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
            if (from == YYWebImageFromDiskCache) {
                NSLog(@"load from disk cache");
            }
        }];


###图片缓存
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    
    // 获取缓存大小
    cache.memoryCache.totalCost;
    cache.memoryCache.totalCount;
    cache.diskCache.totalCost;
    cache.diskCache.totalCount;
    
    // 清空缓存
    [cache.memoryCache removeAllObjects];
    [cache.diskCache removeAllObjects];
    
    // 清空磁盘缓存，带进度回调
    [cache.diskCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
        // progress
    } endBlock:^(BOOL error) {
        // end
    }];
	
安装
==============

### CocoaPods

1. 将 cocoapods 更新至最新版本.
2. 在 Podfile 中添加 `pod 'YYWebImage'`。
3. 执行 `pod install` 或 `pod update`。
4. 导入 \<YYWebImage/YYWebImage.h\>。
5. 注意：pod 配置并没有包含 WebP 组件, 如果你需要支持 WebP，可以在 Podfile 中添加 `pod 'YYImage/WebP'`。你可以调用 `YYImageWebPAvailable()` 来检查一下 WebP 组件是否被正确安装。

### Carthage

1. 在 Cartfile 中添加 `github "ibireme/YYWebImage"`。
2. 执行 `carthage update --platform ios` 并将生成的 framework 添加到你的工程。
3. 导入 \<YYWebImage/YYWebImage.h\>。
4. 注意: carthage framework 并没有包含 webp 组件。如果你需要支持 WebP，可以用 CocoaPods 安装，或者手动安装。

### 手动安装

1. 下载 YYWebImage 文件夹内的所有内容。
2. 将 YYWebImage 内的源文件添加(拖放)到你的工程。
3. 链接以下 frameworks:
	* UIKit
	* CoreFoundation
	* QuartzCore
	* AssetsLibrary
	* ImageIO
	* Accelerate
	* MobileCoreServices
	* sqlite3
	* libz
4. 导入 `YYWebImage.h`。
5. 注意：如果你需要支持 WebP，可以将 `Vendor/WebP.framework`(静态库) 加入你的工程。你可以调用 `YYImageWebPAvailable()` 来检查一下 WebP 组件是否被正确安装。


文档
==============
你可以在 [CocoaDocs](http://cocoadocs.org/docsets/YYWebImage/) 查看在线 API 文档，也可以用 [appledoc](https://github.com/tomaz/appledoc) 本地生成文档。


系统要求
==============
该项目最低支持 `iOS 6.0` 和 `Xcode 7.0`。


许可证
==============
YYWebImage 使用 MIT 许可证，详情见 LICENSE 文件。

相关链接
==============
[移动端图片格式调研](http://blog.ibireme.com/2015/11/02/mobile_image_benchmark/)<br/>

[iOS 处理图片的一些小 Tip](http://blog.ibireme.com/2015/11/02/ios_image_tips/)

