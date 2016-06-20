//
//  UserBuilder.swift
//  TestCode
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserBuilder: DataBuilder  {
    static func buildWithJSONObject(jsonObject: JSON) -> Any? {
        if let gender = jsonObject["gender"].string,
            let email = jsonObject["email"].string,
            let phone = jsonObject["phone"].string,
            let registeredInSeconds = jsonObject["registered"].double,
            let firstName = jsonObject["name"]["first"].string,
            let lastName = jsonObject["name"]["last"].string,
            let locationStreet = jsonObject["location"]["street"].string,
            let locationCity = jsonObject["location"]["street"].string,
            let locationState = jsonObject["location"]["street"].string,
            let picLarge = jsonObject["picture"]["large"].string,
            let picThumbnail = jsonObject["picture"]["thumbnail"].string
        {
            let registered = NSDate(timeIntervalSince1970: registeredInSeconds)
            let userName = UserName(first: firstName, last: lastName)
            let userLocation = Location(street: locationStreet, city: locationCity, state: locationState)
            let userPicture = Picture(large: picLarge, thumbnail: picThumbnail)
            
            return User(gender: gender, email: email, phone: phone, registered: registered, name: userName, location: userLocation, picture: userPicture)
        }
        return nil
    }
}
