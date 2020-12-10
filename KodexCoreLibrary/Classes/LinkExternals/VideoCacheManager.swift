//
//  VideoCacheManager.swift
//  Duet
//
//  Created by Jassie on 8/2/19.
//  Copyright © 2019 CodingPixel. All rights reserved.
//

import UIKit

public enum ResultVideo<T> {
    case success(T)
    case failure(NSError)
}

public enum MultipleResultVideos<T> {
    case success([T])
    case failure(Error)
}

protocol CacheManagerDelegate {
    func FileCacheSuccessfully(url : String)
}

class CacheManager {
    static let shared = CacheManager()
    var delegate : CacheManagerDelegate? = nil
    private let fileManager = FileManager.default
    
    private lazy var mainDirectoryUrl: URL = {
        
        let documentsUrl = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return documentsUrl
    }()
    
    func isFileExist(stringUrl: String) -> Bool {
        if !stringUrl.isEmpty {
             let file = directoryFor(stringUrl: stringUrl)
            if !fileManager.fileExists(atPath: file.path){
                return false
            }else{
                return true
            }
        }
        return false
    }
    
    func getFileWith(stringUrl: String, completionHandler: @escaping (ResultVideo<URL>) -> Void ) {
        print("File Path \(stringUrl)")
        if !stringUrl.isEmpty {
            let file = directoryFor(stringUrl: stringUrl)
            
            //return file path if already exists in cache directory
            if !fileManager.fileExists(atPath: file.path){
                completionHandler(ResultVideo.failure(NSError.init()))
            }  else {
                completionHandler(ResultVideo.success(file))
                return
            }
            DispatchQueue.global(qos: .background).async {
                if let videoData = NSData(contentsOf: URL(string: stringUrl)!) {
                    videoData.write(to: file, atomically: true)
                }
            }
        }
    }
    
    func getMultipleFilesWith(stringUrls: [String], localURLs: [URL] = [],completionHandler: @escaping (MultipleResultVideos<URL>) -> Void ) {
        
        if localURLs.count == stringUrls.count {
            completionHandler(MultipleResultVideos.success(localURLs))
        } else {
            var cacheUrls = localURLs
            cacheFile(from: stringUrls[localURLs.count], completionHandler: { result in
                switch result {
                    case .success(let url):
                        print("-------------------")
                        print("success")
                        print(stringUrls[localURLs.count])
                        if let url = URL.init(string: stringUrls[localURLs.count]){
                            self.delegate?.FileCacheSuccessfully(url: url.lastPathComponent)
                        }
                        print("-------------------")
                        cacheUrls.append(url)
                        self.getMultipleFilesWith(stringUrls: stringUrls,localURLs: cacheUrls, completionHandler: { result in
                            switch result {
                            case .success(let urls):
                                print("success multiple")
                                if let url = URL.init(string: stringUrls[localURLs.count]){
                                    self.delegate?.FileCacheSuccessfully(url: url.lastPathComponent)
                                }
                                completionHandler(MultipleResultVideos.success(urls))
                            case .failure(_):
                                print("failure multiple")
                                completionHandler(MultipleResultVideos.failure(NSError.init()))
                            }
                       })
                    case .failure(_):
                        print("failure")
                        completionHandler(MultipleResultVideos.failure(NSError.init()))
                }
            })
        }
    }
    
    func cacheFile(from stringUrl: String, completionHandler: @escaping (ResultVideo<URL>) -> Void) {
        let file = directoryFor(stringUrl: stringUrl)
        //return file path if already exists in cache directory
        if fileManager.fileExists(atPath: file.path){
            completionHandler(ResultVideo.success(file))
            return
        }  else {
            DispatchQueue.global(qos: .background).async {
                if let videoData = NSData(contentsOf: URL(string: stringUrl)!) {
                    if videoData.write(to: file, atomically: true) {
                        completionHandler(ResultVideo.success(file))
                    } else {
                        completionHandler(ResultVideo.failure(NSError.init()))
                    }
                }
            }
        }
    }
    
    private func directoryFor(stringUrl: String) -> URL {
        
        let fileURL = URL(string: stringUrl)!.lastPathComponent
        
        let file = self.mainDirectoryUrl.appendingPathComponent(fileURL)
        
        return file
    }
}
