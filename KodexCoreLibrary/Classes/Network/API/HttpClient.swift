//
//  APIContants.swift
//  BandPass
//
//  Created by Jassie on 12/01/16.
//  Copyright © 2016 eeGames. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import MobileCoreServices

typealias HttpClientSuccess = (AnyObject?,_ header: Any) -> ()
typealias HttpClientFailure = (NSError,_ header: Any) -> ()


class AlamoFireCall {
    static let shared = AlamoFireCall()
    let manager:ServerTrustManager!
    let session:Session!
    init() {
        manager = ServerTrustManager(evaluators: ["sruser.fnnsolutions.com": DisabledTrustEvaluator(),"app.fakejson.com": DisabledTrustEvaluator(),"www.compass242.com":DisabledTrustEvaluator()])
        session = Session(serverTrustManager: manager)
    }
}



public class HTTPClient {
    func removeCall(){
        AlamoFireCall.shared.session.cancelAllRequests()
    }
    
    func postRequest(withApi api : Router  , success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure )  {
        let params = api.parameters
        let method = api.method
        let headers = api.headers
        if(method == .get || method == .delete){
            AlamoFireCall.shared.session.request(api.url!, method: method, encoding: URLEncoding.queryString,headers: headers).responseString { (response:DataResponse<String,AFError>) in
                switch(response.result) {
                case .success(let value):
                    success(value.parseJSONString as AnyObject?,headers as Any)
                    print("----------------✅✅✅  API Start  ✅✅✅---------------------"  )
                    print("URL : \(String(describing: api.url!))")
                    print("Params : \(String(describing: params ?? [:]))")
                    print("Headers : \(String(describing: headers ?? [:]))")
                    print("result : \(value)")
                    print("----------------✅✅✅  API End  ✅✅✅---------------------"  )
                case .failure(let error):
                    failure(error as NSError,headers as Any)
                    print("---------------- API Start ---------------------"  )
                    print("URL : \(String(describing: api.url!))")
                    print("Params : \(String(describing: params  ?? [:]))")
                    print("Headers : \(String(describing: headers ?? [:]))")
                    print("result : \(error)")
                    print("----------------❌❌❌  API End  ❌❌❌---------------------"  )
                    
                }
            }
        }else{
            AlamoFireCall.shared.session.request(api.url!
                , method: method, parameters: params,encoding:JSONEncoding.default,headers:headers).responseString { response in
                switch response.result {
                case .success(let resultString):
                    success(resultString.parseJSONString as AnyObject?,headers as Any)
                    print("----------------✅✅✅  API Start  ✅✅✅---------------------"  )
                    print("URL : \(String(describing: api.url!))")
                    print("Params : \(String(describing: params ?? [:]))")
                    print("Headers : \(String(describing: headers ?? [:]))")
                    print("result : \(resultString)")
                    print("----------------✅✅✅  API End  ✅✅✅---------------------"  )
                    break
                case .failure(let error):
                    failure(error as NSError,headers as Any)
                    print("---------------- API Start ---------------------"  )
                    print("URL : \(String(describing: api.url!))")
                    print("Params : \(String(describing: params ?? [:]))")
                    print("Headers : \(String(describing: headers ?? [:]))")
                    print("result : \(error)")
                    print("----------------❌❌❌  API End  ❌❌❌---------------------"  )
                }
            }
        }
    }
    
    
    func withFile(withApi api:Router,fileUrl:[URL?]?,paramName:[String],progressCompletation : @escaping (Double?) -> (),success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure ){
            let params = api.parameters ?? [String:Any]()
            let method = api.method
            let headers = api.headers
            AlamoFireCall.shared.session.upload(
                multipartFormData: { multiPart in
                    for (key, value) in params {
                        if let value = value as? String{
                            multiPart.append(value.data(using: .utf8)!, withName: key)
                        }else if let value = value as? Int{
                            let intValie = try! JSONEncoder().encode(value)
                            multiPart.append(intValie, withName: key)
                        }else if let value = value as? Bool{
                            let boolData = try! JSONEncoder().encode(value)
                            multiPart.append(boolData, withName: key)
                        }
                    }
                    if let linkFiles = fileUrl {
                        for (index,item) in linkFiles.enumerated() {
                            if let linkFile = item {
                                multiPart.append(linkFile, withName: paramName[index] , fileName: linkFile.lastPathComponent, mimeType: linkFile.mimeType())
                            }
                        }
                    }
                    
            },
                to: api.url!, method: method , headers: headers)
                .uploadProgress(queue: .main, closure: { progress in
                    print("Upload Progress: \(progress.fractionCompleted)")
                    progressCompletation(progress.fractionCompleted)
                })
                .responseString { (response:DataResponse<String,AFError>) in
                    switch(response.result) {
                    case .success(let value):
                        success(value.parseJSONString as AnyObject?,headers as Any)
                        print("----------------✅✅✅  API Start  ✅✅✅---------------------"  )
                        print("URL : \(String(describing: api.url!))")
                        print("Params : \(String(describing: params ))")
                        print("Headers : \(String(describing: headers ?? [:]))")
                        print("result : \(value)")
                        print("----------------✅✅✅  API End  ✅✅✅---------------------"  )
                    case .failure(let error):
                        failure(error as NSError,headers as Any)
                        print("---------------- API Start ---------------------"  )
                        print("URL : \(String(describing: api.url!))")
                        print("Params : \(String(describing: params))")
                        print("Headers : \(String(describing: headers ?? [:]))")
                        print("result : \(error)")
                        print("----------------❌❌❌  API End  ❌❌❌---------------------"  )
                    }
                }

        }
}





extension URL {
    func mimeType() -> String {
        let pathExtension = self.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
}
