//
//  ScavengerHuntItem.swift
//  Scavenger Hunt
//
//  Created by Surabhi Subramanya on 11/14/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import Foundation
//for image, include UIKit
import UIKit

//Add protocol name after NSObject - conform to protocol - to auto complete stuff for NSCoding support
class ScavengerHuntItem: NSObject, NSCoding {
    
    //let is used for a constant value
    let name: String
    var photo: UIImage?
    var isCompleted: Bool {
        get {
            return photo != nil
        }
    }
    
    let nameKey = "name"
    let photoKey = "photo"
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: nameKey)
        if let thePhoto = photo {
            aCoder.encodeObject(thePhoto, forKey: photoKey)
        }
    }

required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObjectForKey(nameKey) as! String
    photo = aDecoder.decodeObjectForKey(photoKey) as? UIImage
}

//like a constructor to set value of variable
init(name: String) {
    self.name = name
}
}
