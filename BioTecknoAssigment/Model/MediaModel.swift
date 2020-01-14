//
//  MediaModel.swift
//  BioTecknoAssigment
//
//  Created by macbook on 10/24/1398 AP.
//  Copyright © 1398 Yahya. All rights reserved.
//

import Foundation
import UIKit
class ImageModel {

    var image:  [UIImage?]
    
    init(image:[UIImage?]) {
        
        self.image = image
    }
    
}
class VideoModel {

    var path = [""]
    
    init(path:[String]) {
        self.path = path
    }
}
