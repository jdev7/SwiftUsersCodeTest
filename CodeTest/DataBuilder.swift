//
//  DataBuilderProtocol.swift
//  TestCode
//
//  Created by Juan Navas Martin on 20/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol DataBuilder {
    static func buildWithJSONObject(jsonObject: JSON) -> Any?
}
