#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>



@class FaceLandmark;
@class FaceTracker;

@protocol FaceTrackerDelegate <NSObject>
- (void)faceTracker: (FaceTracker*)faceTracker didOutputLandmarks: (NSArray<FaceLandmark *> *)landmarks;
- (void)faceTracker: (FaceTracker*)faceTracker didOutputPixelBuffer: (CVPixelBufferRef)pixelBuffer;
@end

@interface FaceTracker : NSObject
- (instancetype)init;
- (void)startGraph;
- (void)processVideoFrame:(CVPixelBufferRef)imageBuffer;
@property (weak, nonatomic) id <FaceTrackerDelegate> delegate;
@end

@interface FaceLandmark: NSObject
@property(nonatomic, readonly) float x;
@property(nonatomic, readonly) float y;
@property(nonatomic, readonly) float z;
@end
