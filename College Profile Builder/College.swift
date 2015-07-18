//
//  College.swift
//  College Profile Builder
//
//  Created by Jack Cable on 7/6/15.
//  Copyright © 2015 Jack Cable. All rights reserved.
//

import UIKit

class College: NSObject {
    
    var name = ""
    var location = ""
    var enrollment = 0
    var website = ""
    var image = UIImage(named: "default")
    
    convenience init(name: String, location: String, enrollment: Int, website: String, image: UIImage) {
        self.init()
        self.name = name
        self.location = location
        self.enrollment = enrollment
        self.website = website
        self.image = image
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }

}
