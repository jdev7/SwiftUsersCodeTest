//
//  RESTClient.swift
//  SwiftUsersCodeTest
//
//  Created by Juan Navas Martin on 20/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import Foundation

typealias RESTClientSuccessBlock = (responseObject: AnyObject) -> Void
typealias RESTClientFailBlock = (error: NSError) -> Void

protocol RESTClient {    
    func getUrl(urlString: String, parameters: [String: AnyObject]?, success: RESTClientSuccessBlock, fail: RESTClientFailBlock)
}
