#! /usr/bin/env bash

if which yasm > /dev/null ; then
  echo 'yasm found'
else
  echo 'yasm not found. see https://github.com/Bilibili/ijkplayer#before-build'
  exit 1
fi

echo 'Preparing IOS'

cd config
rm module.sh
ln -s module-lite-hevc.sh module.sh
source module.sh

# need for clean before init-ios.sh
cd ../ios
./compile-openssl.sh clean
./compile-ffmpeg.sh clean

cd ../
./init-ios.sh
./init-ios-openssl.sh

cd ios
./compile-openssl.sh clean
./compile-ffmpeg.sh clean
./compile-openssl.sh all
./compile-ffmpeg.sh all

# Demo
#     open ios/IJKMediaDemo/IJKMediaDemo.xcodeproj with Xcode
#
# Import into Your own Application
#     Select your project in Xcode.
#     File -> Add Files to ... -> Select ios/IJKMediaPlayer/IJKMediaPlayer.xcodeproj
#     Select your Application's target.
#     Build Phases -> Target Dependencies -> Select IJKMediaFramework
#     Build Phases -> Link Binary with Libraries -> Add:
#         IJKMediaFramework.framework
#
#         AudioToolbox.framework
#         AVFoundation.framework
#         CoreGraphics.framework
#         CoreMedia.framework
#         CoreVideo.framework
#         libbz2.tbd
#         libz.tbd
#         MediaPlayer.framework
#         MobileCoreServices.framework
#         OpenGLES.framework
#         QuartzCore.framework
#         UIKit.framework
#         VideoToolbox.framework
#
#         ... (Maybe something else, if you get any link error)
#
