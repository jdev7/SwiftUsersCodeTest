//
//  RESTClientImplementation.swift
//  SwiftUsersCodeTest
//
//  Created by Juan Navas Martin on 20/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit
import Alamofire

class RESTClientImplementation: RESTClient {

    func getUrl(urlString: String, parameters: [String : AnyObject]?, success: RESTClientSuccessBlock, fail: RESTClientFailBlock) {
        Alamofire.request(.GET, urlString, parameters: parameters, encoding: .URL)
        .validate()
        .responseJSON { (response) in
            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(response.result.error)")
                fail(error: response.result.error!)
                return
            }
            
            guard let responseObject = response.result.value as? [String: AnyObject] else {
                let errorDescription = "Malformed data received from \(urlString) service"
                print(errorDescription)
                let error = NSError(code: -90000, description: errorDescription)
                fail(error: error)
                return
            }
            success(responseObject: responseObject)
        }
        
    }
}
