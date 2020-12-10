//
//  ImageRound.swift
//  HelpMe
//
//  Created by J Aiden on 16/10/2018.
//  Copyright © 2018 
//

import UIKit
import Kingfisher

class KingFisherImage {
    static let shared = KingFisherImage()
    let modifier = AnyModifier { request in
        var r = request
        //        r.setValue("Bearer \(DataManager.sharedInstance.getPermanentlySavedUser()?.token ?? "")", forHTTPHeaderField: "Authorization")
        return r
    }
    var downloader:ImageDownloader {
        get{
            let downl = KingfisherManager.shared.downloader
            downl.trustedHosts = Set(["sruser.fnnsolutions.com","s3.us-east-2.amazonaws.com"])
            return downl
        }
    }
}


enum PlaceHolder:String{
    
    case ImageDefault = "icPlaceholderDefault"
    case UserDefault = "icPlaceholderUser"
    var image:UIImage? {
        UIImage.init(named: self.rawValue)
    }
}

extension UIImageView {
    func loadGif(url:URL?,placeholder:PlaceHolder,mode:ContentMode = .scaleAspectFill){
        print("Link : \(url?.absoluteString ?? "")")
        self.kf.indicatorType = .activity
        self.contentMode = mode
        //        self.isSkeletonable = true
        let processor = DownsamplingImageProcessor(size: self.frame.size)
            |> RoundCornerImageProcessor(cornerRadius: 0)
        if let link = url {
            let cacheResult = ImageCache.default.imageCachedType(forKey: link.absoluteString)//isImageCachedForKey(link.absoluteString)
            switch cacheResult.cached {
            case true:
                ImageCache.default.retrieveImage(forKey: link.absoluteString) { (result) in
                    switch result {
                    case .success(_):
//                        self.image = value.image
                        self.kf.setImage(
                            with: link,
                            placeholder: placeholder.image,
                            options: [
                                .downloader(KingFisherImage.shared.downloader),
                                .requestModifier(KingFisherImage.shared.modifier),
                                .alsoPrefetchToMemory,
                                .processor(processor),
                                .scaleFactor(UIScreen.main.scale),
                                .transition(.none),
                                .cacheOriginalImage
                            ])
                    case .failure(_):
                        let resource = ImageResource(downloadURL: link, cacheKey: link.absoluteString)
                        self.kf.setImage(with: resource,placeholder: placeholder.image,
                                         options: [
                                            .downloader(KingFisherImage.shared.downloader),
                                            .requestModifier(KingFisherImage.shared.modifier),
                                            .alsoPrefetchToMemory,
                                            .processor(processor),
                                            .scaleFactor(UIScreen.main.scale),
                                            .transition(.none),
                                            .cacheOriginalImage
                                         ])
                    }
                }
            case false:
                self.kf.setImage(
                    with: link,
                    placeholder: placeholder.image,
                    options: [
                        .downloader(KingFisherImage.shared.downloader),
                        .requestModifier(KingFisherImage.shared.modifier),
                        .alsoPrefetchToMemory,
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.none),
                        .cacheOriginalImage
                    ])
            }
            //            , completionHandler: { result in
            //               switch result {
            //               case .success(let data):
            //                   self.image = data.image
            //               case .failure(let error):
            //                   print("KingF Error: \(error as Any)")
            //                   print("KingF Error: \(error.localizedDescription)")
            //
            //               }
            //
            //            }
        }else{
            self.image = placeholder.image
        }
    }
    
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }
    
    @objc
    private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
    
    func setRounded() {
        
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: self.image!.size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(CGRect(x: -origin.x, y: -origin.y,
                        width: self.image!.size.width, height: self.image!.size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self.image!
        }
        return self.image!
    }
    
    
}



extension UIImage {
    func addFilter(filter : String) -> UIImage {
        let filter = CIFilter(name: filter)
        
        // convert UIImage to CIImage and set as input
        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput, forKey: "inputImage")
        // get output CIImage, render as CGImage first to retain proper UIImage scale
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        //Return the image
        return UIImage(cgImage: cgImage!, scale: self.scale, orientation: self.imageOrientation)
    }
    
    func crop(to rect: CGRect) -> UIImage? {
        // Modify the rect based on the scale of the image
        var rect = rect
        rect.size.width = rect.size.width * self.scale
        rect.size.height = rect.size.height * self.scale
        
        // Crop the image
        guard let imageRef = self.cgImage?.cropping(to: rect) else {
            return nil
        }
        
        return UIImage(cgImage: imageRef)
    }
    
    public func compressed(quality: CGFloat = 0.1) -> UIImage? {
        guard let data = compressedData(quality: quality) else { return nil }
        return UIImage(data: data)
    }
    public func compressedData(quality: CGFloat = 0.6) -> Data? {
        return self.jpegData(compressionQuality: quality)
    }
    
    func imageResize (sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    
    func writeImageToTemporaryDirectory(resourceName: String, fileExtension: String) -> URL?
    {
        // Get the file path in the bundle
        let tempDirectoryURL = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
        // Create a destination URL.
        let targetURL = tempDirectoryURL.appendingPathComponent("\(resourceName).\(fileExtension)")
        // Copy the file.
        do {
            try self.compressedData()?.write(to: targetURL)
            return targetURL
        } catch let error {
            NSLog("Unable to copy file: \(error)")
        }
        
        return nil
    }
    
    func fixedOrientation() -> UIImage? {
        guard imageOrientation != UIImage.Orientation.up else {
            // This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }
        
        guard let cgImage = self.cgImage else {
            // CGImage is not available
            return nil
        }
        
        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil // Not able to create CGContext
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
        case .up, .upMirrored:
            break
        @unknown default:
            break
        }
        
        // Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            break
        }
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
    
}


