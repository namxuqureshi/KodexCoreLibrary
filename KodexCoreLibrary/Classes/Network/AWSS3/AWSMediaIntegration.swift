//
//  AWAMediaIntegration.swift
//  The Craft
//
//  Created by Jaisee on 4/22/19.
//  Copyright © 2019 
//
import Foundation
import UIKit
import AWSS3 //1

typealias progressBlock = (_ progress: Double) -> Void //2
typealias completionBlock = (_ response: Any?, _ error: Error?) -> Void //3

class AWSMediaIntegration: NSObject {
    static var shared  = AWSMediaIntegration()
    static var  s3Url = AWSS3.default().configuration.endpoint.url
    
    func uploadData(name : String , extn : String , fileUrl : URL ,completion: ((_ status : Bool ,  _ path:  URL?,_ error:Error?) -> Void)? = nil, progress: ((Double, AWSS3TransferUtilityUploadExpression) -> Void)? = nil){
        let fileName = "public/\(name).\(extn)"
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.setValue("public-read", forRequestHeader: "x-amz-acl")
        expression.progressBlock = {(task, awsProgress) in
            guard let uploadProgress = progress else { return }
            DispatchQueue.main.async {
                uploadProgress(awsProgress.fractionCompleted,expression)
            }
        }
        var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
        completionHandler = { (task, error) -> Void in
            DispatchQueue.main.async(execute: {
                if error == nil {
                    let url = AWSS3.default().configuration.endpoint.url
                    let publicURL = url?.appendingPathComponent(kBucketName).appendingPathComponent(fileName)
                    let urlLink = AWSMediaIntegration.s3Url?.appendingPathComponent(fileName).absoluteString
                    print("Uploaded to:\(String(describing: publicURL)) , \(urlLink ?? "")")
                    if let completionBlock = completion {
                        completionBlock(true,publicURL,nil)
                    }
                } else {
                    if let completionBlock = completion {
                        completionBlock(false, nil,error)
                    }
                }
            })
        }
        // Start uploading using AWSS3TransferUtility
        let awsTransferUtility = AWSS3TransferUtility.default()
        let config = awsTransferUtility.configuration
        config.addUserAgentProductToken("ColeaqeuToken")
        
        awsTransferUtility.uploadFile(fileUrl, bucket: kBucketName, key: fileName, contentType: fileUrl.mimeType(), expression: expression, completionHandler: completionHandler).continueWith { (task) -> Any? in
            if let error = task.error {
                print("error is: \(error.localizedDescription)")
            }
            if let _ = task.result {
                // your uploadTask
            }
            return nil
        }
//        let bucketName = kBucketName
//        let key = "\(name).\(extn)"
//        let mngr = AWSS3TransferManagerUploadRequest.init()!//()!
//        mngr.bucket = bucketName
//        mngr.key = "public/\(key)"
//        mngr.body = fileUrl
//        mngr.acl = .publicReadWrite
//        let transferMngr  = AWSS3TransferManager.default()
//        transferMngr.upload(mngr).continueWith(executor: AWSExecutor.mainThread()) { (task) -> Any? in
//            if let err = task.error {
//                print(err)
//                completion(false , "")
//            }else if task.result != nil{
//                print(task.result?.absoluteURL as Any)
//                print("Uploaded \(key)")
//                let url = AWSMediaIntegration.s3Url?.appendingPathComponent(bucketName).appendingPathComponent(mngr.key!).absoluteString
//                completion(true , url!)
//            }else{
//                completion(false , "")
//            }
//            return nil
//        }
//        mngr.uploadProgress = {(bytesSent, totalBytesSent, totalBytesExpectedToSend) in
//            DispatchQueue.main.async(execute: {
//                progress?(Double(Double(totalBytesSent)/Double(totalBytesExpectedToSend)), mngr)
//            })
//        }
//
        
    }
    
    //MARK: For Message Cells
    func uploadDataMessage(name : String , extn : String , fileUrl : URL ,cellMsgId:String,completion: @escaping (_ status : Bool ,_ cellMsgId:String,  _ path:  String) -> Void, progress: ((Double, String,AWSS3TransferUtilityUploadExpression) -> Void)? = nil){
//        let bucketName = kBucketName
//        let key = "\(name).\(extn)"
//        let mngr = AWSS3TransferManagerUploadRequest()
//        mngr?.bucket = bucketName
//        mngr?.key = "public/\(key)"
//        mngr?.body = fileUrl
//        mngr?.acl = .publicReadWrite
//        let transferMngr  = AWSS3TransferManager.default()
//        transferMngr.upload(mngr!).continueWith(executor: AWSExecutor.mainThread()) { (task) -> Any? in
//            if let err = task.error {
//                print(err)
//                completion(false ,cellMsgId, "")
//            }else if task.result != nil{
//                print(task.result?.absoluteURL as Any)
//                print("Uploaded \(key)")
//                let url = AWSMediaIntegration.s3Url?.appendingPathComponent(bucketName).appendingPathComponent(mngr!.key!).absoluteString
//                completion(true,cellMsgId , url!)
//            }else{
//                completion(false,cellMsgId , "")
//            }
//            return nil
//        }
//        mngr?.uploadProgress = {(bytesSent, totalBytesSent, totalBytesExpectedToSend) in
//            DispatchQueue.main.async(execute: {
//                progress?(Double(Double(totalBytesSent)/Double(totalBytesExpectedToSend)),cellMsgId, mngr!)
//            })
//        }
        
        let fileName = "public/\(name).\(extn)"
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.setValue("public-read", forRequestHeader: "x-amz-acl")
        expression.progressBlock = {(task, awsProgress) in
            guard let uploadProgress = progress else { return }
            DispatchQueue.main.async {
                uploadProgress(awsProgress.fractionCompleted,cellMsgId, expression)
            }
        }
        var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
        completionHandler = { (task, error) -> Void in
            DispatchQueue.main.async(execute: {
                if error == nil {
                    let url = AWSS3.default().configuration.endpoint.url
                    let publicURL = url?.appendingPathComponent(kBucketName).appendingPathComponent(fileName)
                    let urlLink = AWSMediaIntegration.s3Url?.appendingPathComponent(fileName).absoluteString
                    print("Uploaded to:\(String(describing: publicURL)) , \(urlLink ?? "")")
                    completion(true,cellMsgId , publicURL?.absoluteString ?? urlLink ?? "")
//                    if let completionBlock = completion {
//                        completionBlock(true,publicURL,nil)
//                    }
                } else {
                    completion(false ,cellMsgId, "")
                }
            })
        }
        // Start uploading using AWSS3TransferUtility
        let awsTransferUtility = AWSS3TransferUtility.default()
        let config = awsTransferUtility.configuration
        config.addUserAgentProductToken("ColeaqeuToken")
        
        awsTransferUtility.uploadFile(fileUrl, bucket: kBucketName, key: fileName, contentType: fileUrl.mimeType(), expression: expression, completionHandler: completionHandler).continueWith { (task) -> Any? in
            if let error = task.error {
                print("error is: \(error.localizedDescription)")
            }
            if let _ = task.result {
                // your uploadTask
            }
            return nil
        }
        
    }
    
    func uploadMutipleResource(name : [String] , extn : [String] , fileUrl : [URL], pathsCon: [String],cellMsgId:String,completion: @escaping (_ status : Bool,_ cellMsgId:String ,  _ paths:  [String]) -> Void, progress: ((Double,String, AWSS3TransferUtilityUploadExpression) -> Void)? = nil){
        var paths = pathsCon
        if name.count == 0{
            completion(true,cellMsgId, paths)
        }else{
            AWSMediaIntegration.shared.uploadDataMessage(name: name.first!, extn: extn.first!, fileUrl: fileUrl.first!,cellMsgId: cellMsgId, completion: { (val,cellMsgId, path) in
                if val{
                    paths.append(path)
                    let newName = Array(name.dropFirst())
                    let newExtn = Array(extn.dropFirst())
                    let newFileUrl = Array(fileUrl.dropFirst())
                    AWSMediaIntegration.shared.uploadMutipleResource(name: newName, extn: newExtn, fileUrl: newFileUrl,pathsCon: paths ,cellMsgId: cellMsgId,completion: { (success,cellMsgId, result) in
                        if success{
                            completion(true,cellMsgId, result)
                            
                        }else{
                            completion(false,cellMsgId, [""])
                        }
                    },progress: {(val,cellMsgId, task) in
                        print(val)
                        progress?(val,cellMsgId, task)
                    })
                }
            }, progress: {(val,cellMsgId,task) in
                print(val)
                progress?(val,cellMsgId, task)
            })
        }
    }
    
    func deleteFile(name:String){
//        let bucketName = kBucketName
//        let key = name
//        let s3 = AWSS3.default()
//        let deleteObjectRequest = AWSS3DeleteObjectRequest()
//        deleteObjectRequest?.bucket = bucketName
//        deleteObjectRequest?.key = "public/\(key)"
//        s3.deleteObject(deleteObjectRequest!).continueWith { (task:AWSTask) -> AnyObject? in
//            if let error = task.error {
//                print("Error occurred: \(error)")
//                return nil
//            }
//            print("Deleted successfully.")
//            return nil
//        }
        let s3 = AWSS3.default()
        guard let deleteObjectRequest = AWSS3DeleteObjectRequest() else {
            return
        }
        deleteObjectRequest.bucket = kBucketName//"yourBucketName"
        deleteObjectRequest.key = "public/\(name)"//"yourFileName"
        s3.deleteObject(deleteObjectRequest).continueWith { (task:AWSTask) -> AnyObject? in
            
            if let error = task.error {
                print("Error occurred: \(error)")
                return nil
            }
            print("Deleted successfully.")
            return nil
            
        }
    }
    
}

extension URL {
    func getFileCompleteName() -> String {
        return self.lastPathComponent
    }
    func getFileName() -> String {
        return String(self.lastPathComponent.split(separator: ".").first!)
    }
    
    func getFileExtension() -> String {
        return String(self.lastPathComponent.split(separator: ".").last!)
    }
}




//
//class AWSS3Manager {
//
//    static let shared = AWSS3Manager() // 4
//    private init () { }
//    let bucketName = kBucketName//"***** your bucket name *****" //5
//
//    // Upload image using UIImage object
//    func uploadImage(image: UIImage, progress: progressBlock?, completion: completionBlock?) {
//
//        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
//            let error = NSError(domain:"", code:402, userInfo:[NSLocalizedDescriptionKey: "invalid image"])
//            completion?(nil, error)
//            return
//        }
//
//        let tmpPath = NSTemporaryDirectory() as String
//        let fileName: String = ProcessInfo.processInfo.globallyUniqueString + (".jpeg")
//        let filePath = tmpPath + "/" + fileName
//        let fileUrl = URL(fileURLWithPath: filePath)
//
//        do {
//            try imageData.write(to: fileUrl)
//            self.uploadfile(fileUrl: fileUrl, fileName: fileName, contenType: "image", progress: progress, completion: completion)
//        } catch {
//            let error = NSError(domain:"", code:402, userInfo:[NSLocalizedDescriptionKey: "invalid image"])
//            completion?(nil, error)
//        }
//    }
//
//    // Upload video from local path url
//    func uploadVideo(videoUrl: URL, progress: progressBlock?, completion: completionBlock?) {
//        let fileName = self.getUniqueFileName(fileUrl: videoUrl)
//        self.uploadfile(fileUrl: videoUrl, fileName: fileName, contenType: "video", progress: progress, completion: completion)
//    }
//
//    // Upload auido from local path url
//    func uploadAudio(audioUrl: URL, progress: progressBlock?, completion: completionBlock?) {
//        let fileName = self.getUniqueFileName(fileUrl: audioUrl)
//        self.uploadfile(fileUrl: audioUrl, fileName: fileName, contenType: "audio", progress: progress, completion: completion)
//    }
//
//    // Upload files like Text, Zip, etc from local path url
//    func uploadOtherFile(fileUrl: URL, conentType: String, progress: progressBlock?, completion: completionBlock?) {
//        let fileName = self.getUniqueFileName(fileUrl: fileUrl)
//        self.uploadfile(fileUrl: fileUrl, fileName: fileName, contenType: conentType, progress: progress, completion: completion)
//    }
//
//    // Get unique file name
//    func getUniqueFileName(fileUrl: URL) -> String {
//        let strExt: String = "." + (URL(fileURLWithPath: fileUrl.absoluteString).pathExtension)
//        return (ProcessInfo.processInfo.globallyUniqueString + (strExt))
//    }
//
//    //MARK:- AWS file upload
//    // fileUrl :  file local path url
//    // fileName : name of file, like "myimage.jpeg" "video.mov"
//    // contenType: file MIME type
//    // progress: file upload progress, value from 0 to 1, 1 for 100% complete
//    // completion: completion block when uplaoding is finish, you will get S3 url of upload file here
//    func uploadfile(fileUrl: URL, fileName: String, contenType: String, progress: progressBlock?, completion: completionBlock?) {
//        // Upload progress block
//        let expression = AWSS3TransferUtilityUploadExpression()
//        expression.progressBlock = {(task, awsProgress) in
//            guard let uploadProgress = progress else { return }
//            DispatchQueue.main.async {
//                uploadProgress(awsProgress.fractionCompleted)
//            }
//        }
//        // Completion block
//        var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
//        completionHandler = { (task, error) -> Void in
//            DispatchQueue.main.async(execute: {
//                if error == nil {
//                    let url = AWSS3.default().configuration.endpoint.url
//                    let publicURL = url?.appendingPathComponent(self.bucketName).appendingPathComponent(fileName)
//                    print("Uploaded to:\(String(describing: publicURL))")
//                    if let completionBlock = completion {
//                        completionBlock(publicURL?.absoluteString, nil)
//                    }
//                } else {
//                    if let completionBlock = completion {
//                        completionBlock(nil, error)
//                    }
//                }
//            })
//        }
//        // Start uploading using AWSS3TransferUtility
//        let awsTransferUtility = AWSS3TransferUtility.default()
//        awsTransferUtility.uploadFile(fileUrl, bucket: bucketName, key: fileName, contentType: contenType, expression: expression, completionHandler: completionHandler).continueWith { (task) -> Any? in
//            if let error = task.error {
//                print("error is: \(error.localizedDescription)")
//            }
//            if let _ = task.result {
//                // your uploadTask
//            }
//            return nil
//        }
//    }
//}
//
