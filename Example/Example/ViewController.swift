//
//  ViewController.swift
//  Example
//
//  Created by Tomoya Hirano on 2020/04/02.
//  Copyright © 2020 Tomoya Hirano. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate ,FaceTrackerDelegate{

    

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toggleView: UISwitch!
    var previewLayer: AVCaptureVideoPreviewLayer!
    @IBOutlet weak var xyLabel:UILabel!
    @IBOutlet weak var featurePoint: UIView!
    let camera = Camera()
    let tracker: FaceTracker = FaceTracker()!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        camera.setSampleBufferDelegate(self)
        camera.start()
        tracker.startGraph()
        tracker.delegate = self

    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        print(pixelBuffer?.pixelFormatName())
        tracker.processVideoFrame(pixelBuffer)

        DispatchQueue.main.async {
            if !self.toggleView.isOn {
                self.imageView.image = UIImage(ciImage: CIImage(cvPixelBuffer: pixelBuffer!))
            }
        }
    }
    
    func faceTracker(_ faceTracker: FaceTracker!, didOutputPixelBuffer pixelBuffer: CVPixelBuffer!) {
        print(pixelBuffer.pixelFormatName())
        DispatchQueue.main.async {
            if self.toggleView.isOn {
                self.imageView.image = UIImage(ciImage: CIImage(cvPixelBuffer: pixelBuffer))
            }
        }
    }
    
    func faceTracker(_ faceTracker: FaceTracker!, didOutputLandmarks landmarks: [FaceLandmark]!) {
//        if let landmark = landmarks[safe : 8] {
//            DispatchQueue.main.async {
//                let width = self.view.frame.size.width
//                let height = self.view.frame.size.height
//                let x = CGFloat(landmark.x) * width
//                let y = CGFloat(landmark.y) * height
//                self.featurePoint.frame = CGRect(x: CGFloat(landmark.x) * width, y: CGFloat(landmark.y) * height, width: 5, height: 5)
//                self.xyLabel.text = "\(landmark.x) , \(landmark.y)"
//            }
//        }
    }
    
//    func handTracker(_ handTracker: HandTracker!, didOutputLandmarks landmarks: [Landmark]!, andHand handSize: CGSize) {
//
//        var thumbUp = false
//        var firstUp = false
//        var secondUp = false
//        var thirdUp = false
//        var fourUp = false
//
//        var pseudoFixKeyPoint = landmarks[2].x
//        if (landmarks[3].x < pseudoFixKeyPoint && landmarks[4].x < pseudoFixKeyPoint)
//        {
//            thumbUp = true;
//        }
//        thumbUp = true;
//
//        pseudoFixKeyPoint = landmarks[6].y;
//        if (landmarks[7].y < pseudoFixKeyPoint && landmarks[8].y < pseudoFixKeyPoint)
//        {
//            firstUp = true;
//        }
//
//        pseudoFixKeyPoint = landmarks[10].y;
//        if (landmarks[11].y < pseudoFixKeyPoint && landmarks[12].y < pseudoFixKeyPoint)
//        {
//            secondUp = true;
//        }
//
//        pseudoFixKeyPoint = landmarks[14].y;
//        if (landmarks[15].y < pseudoFixKeyPoint && landmarks[16].y < pseudoFixKeyPoint)
//        {
//            thirdUp = true;
//        }
//
//        pseudoFixKeyPoint = landmarks[18].y;
//        if (landmarks[19].y < pseudoFixKeyPoint && landmarks[20].y < pseudoFixKeyPoint)
//        {
//            fourUp = true;
//        }
//
//        if thumbUp && firstUp && secondUp && thirdUp && fourUp {
//            DispatchQueue.main.async {
//                self.xyLabel.text = "FIVE"
//            }
//            return
//        }
//
//        if let first = landmarks[safe:8], let second = landmarks[safe:12], let thr = landmarks[safe:16], let four = landmarks[safe:20], let thumb = landmarks[safe:4], let thumb2 = landmarks[safe:2] {
//
//            if thumb.y < first.y && thumb.y < second.y && thumb.y < thr.y && thumb.y < four.y && thumb2.y > four.y {
//                DispatchQueue.main.async {
//                    if thumb.x < first.x {
//                        self.xyLabel.text = "left"
//                    } else {
//                        self.xyLabel.text = "right"
//                    }
//                }
////                print("left")
//            } else {
//                DispatchQueue.main.async {
//                    self.xyLabel.text = ""
//                }
//            }
//        }
//
////        if let landmark = landmarks[safe : 8] {
////            DispatchQueue.main.async {
////                let width = self.view.frame.size.width
////                let height = self.view.frame.size.height
////                let x = CGFloat(landmark.x) * width
////                let y = CGFloat(landmark.y) * height
////                self.featurePoint.frame = CGRect(x: CGFloat(landmark.x) * width, y: CGFloat(landmark.y) * height, width: 5, height: 5)
////                self.xyLabel.text = "\(landmark.x) , \(landmark.y)"
////            }
////        }
////        print(landmarks!)
//    }
    


}
//
//extension Collection {
//    /// Returns the element at the specified index if it is within bounds, otherwise nil.
//    subscript (safe index: Index) -> Element? {
//        return indices.contains(index) ? self[index] : nil
//    }
//}
//
//extension CGFloat {
//    func ceiling(toDecimal decimal: Int) -> CGFloat {
//        let numberOfDigits = CGFloat(abs(pow(10.0, Double(decimal))))
//        if self.sign == .minus {
//            return CGFloat(Int(self * numberOfDigits)) / numberOfDigits
//        } else {
//            return CGFloat(ceil(self * numberOfDigits)) / numberOfDigits
//        }
//    }
//}
//
//extension Double {
//    func ceiling(toDecimal decimal: Int) -> Double {
//        let numberOfDigits = abs(pow(10.0, Double(decimal)))
//        if self.sign == .minus {
//            return Double(Int(self * numberOfDigits)) / numberOfDigits
//        } else {
//            return Double(ceil(self * numberOfDigits)) / numberOfDigits
//        }
//    }
//}
extension CVPixelBuffer {
    
    func pixelFormatName() -> String {
        let p = CVPixelBufferGetPixelFormatType(self)
        switch p {
        case kCVPixelFormatType_1Monochrome:                   return "kCVPixelFormatType_1Monochrome"
        case kCVPixelFormatType_2Indexed:                      return "kCVPixelFormatType_2Indexed"
        case kCVPixelFormatType_4Indexed:                      return "kCVPixelFormatType_4Indexed"
        case kCVPixelFormatType_8Indexed:                      return "kCVPixelFormatType_8Indexed"
        case kCVPixelFormatType_1IndexedGray_WhiteIsZero:      return "kCVPixelFormatType_1IndexedGray_WhiteIsZero"
        case kCVPixelFormatType_2IndexedGray_WhiteIsZero:      return "kCVPixelFormatType_2IndexedGray_WhiteIsZero"
        case kCVPixelFormatType_4IndexedGray_WhiteIsZero:      return "kCVPixelFormatType_4IndexedGray_WhiteIsZero"
        case kCVPixelFormatType_8IndexedGray_WhiteIsZero:      return "kCVPixelFormatType_8IndexedGray_WhiteIsZero"
        case kCVPixelFormatType_16BE555:                       return "kCVPixelFormatType_16BE555"
        case kCVPixelFormatType_16LE555:                       return "kCVPixelFormatType_16LE555"
        case kCVPixelFormatType_16LE5551:                      return "kCVPixelFormatType_16LE5551"
        case kCVPixelFormatType_16BE565:                       return "kCVPixelFormatType_16BE565"
        case kCVPixelFormatType_16LE565:                       return "kCVPixelFormatType_16LE565"
        case kCVPixelFormatType_24RGB:                         return "kCVPixelFormatType_24RGB"
        case kCVPixelFormatType_24BGR:                         return "kCVPixelFormatType_24BGR"
        case kCVPixelFormatType_32ARGB:                        return "kCVPixelFormatType_32ARGB"
        case kCVPixelFormatType_32BGRA:                        return "kCVPixelFormatType_32BGRA"
        case kCVPixelFormatType_32ABGR:                        return "kCVPixelFormatType_32ABGR"
        case kCVPixelFormatType_32RGBA:                        return "kCVPixelFormatType_32RGBA"
        case kCVPixelFormatType_64ARGB:                        return "kCVPixelFormatType_64ARGB"
        case kCVPixelFormatType_48RGB:                         return "kCVPixelFormatType_48RGB"
        case kCVPixelFormatType_32AlphaGray:                   return "kCVPixelFormatType_32AlphaGray"
        case kCVPixelFormatType_16Gray:                        return "kCVPixelFormatType_16Gray"
        case kCVPixelFormatType_30RGB:                         return "kCVPixelFormatType_30RGB"
        case kCVPixelFormatType_422YpCbCr8:                    return "kCVPixelFormatType_422YpCbCr8"
        case kCVPixelFormatType_4444YpCbCrA8:                  return "kCVPixelFormatType_4444YpCbCrA8"
        case kCVPixelFormatType_4444YpCbCrA8R:                 return "kCVPixelFormatType_4444YpCbCrA8R"
        case kCVPixelFormatType_4444AYpCbCr8:                  return "kCVPixelFormatType_4444AYpCbCr8"
        case kCVPixelFormatType_4444AYpCbCr16:                 return "kCVPixelFormatType_4444AYpCbCr16"
        case kCVPixelFormatType_444YpCbCr8:                    return "kCVPixelFormatType_444YpCbCr8"
        case kCVPixelFormatType_422YpCbCr16:                   return "kCVPixelFormatType_422YpCbCr16"
        case kCVPixelFormatType_422YpCbCr10:                   return "kCVPixelFormatType_422YpCbCr10"
        case kCVPixelFormatType_444YpCbCr10:                   return "kCVPixelFormatType_444YpCbCr10"
        case kCVPixelFormatType_420YpCbCr8Planar:              return "kCVPixelFormatType_420YpCbCr8Planar"
        case kCVPixelFormatType_420YpCbCr8PlanarFullRange:     return "kCVPixelFormatType_420YpCbCr8PlanarFullRange"
        case kCVPixelFormatType_422YpCbCr_4A_8BiPlanar:        return "kCVPixelFormatType_422YpCbCr_4A_8BiPlanar"
        case kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange:  return "kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange"
        case kCVPixelFormatType_420YpCbCr8BiPlanarFullRange:   return "kCVPixelFormatType_420YpCbCr8BiPlanarFullRange"
        case kCVPixelFormatType_422YpCbCr8_yuvs:               return "kCVPixelFormatType_422YpCbCr8_yuvs"
        case kCVPixelFormatType_422YpCbCr8FullRange:           return "kCVPixelFormatType_422YpCbCr8FullRange"
        case kCVPixelFormatType_OneComponent8:                 return "kCVPixelFormatType_OneComponent8"
        case kCVPixelFormatType_TwoComponent8:                 return "kCVPixelFormatType_TwoComponent8"
        case kCVPixelFormatType_30RGBLEPackedWideGamut:        return "kCVPixelFormatType_30RGBLEPackedWideGamut"
        case kCVPixelFormatType_OneComponent16Half:            return "kCVPixelFormatType_OneComponent16Half"
        case kCVPixelFormatType_OneComponent32Float:           return "kCVPixelFormatType_OneComponent32Float"
        case kCVPixelFormatType_TwoComponent16Half:            return "kCVPixelFormatType_TwoComponent16Half"
        case kCVPixelFormatType_TwoComponent32Float:           return "kCVPixelFormatType_TwoComponent32Float"
        case kCVPixelFormatType_64RGBAHalf:                    return "kCVPixelFormatType_64RGBAHalf"
        case kCVPixelFormatType_128RGBAFloat:                  return "kCVPixelFormatType_128RGBAFloat"
        case kCVPixelFormatType_14Bayer_GRBG:                  return "kCVPixelFormatType_14Bayer_GRBG"
        case kCVPixelFormatType_14Bayer_RGGB:                  return "kCVPixelFormatType_14Bayer_RGGB"
        case kCVPixelFormatType_14Bayer_BGGR:                  return "kCVPixelFormatType_14Bayer_BGGR"
        case kCVPixelFormatType_14Bayer_GBRG:                  return "kCVPixelFormatType_14Bayer_GBRG"
        default: return "UNKNOWN"
        }
    }
}
