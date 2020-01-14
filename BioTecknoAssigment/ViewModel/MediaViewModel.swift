//
//  MediaViewModel.swift
//  BioTecknoAssigment
//
//  Created by macbook on 10/24/1398 AP.
//  Copyright © 1398 Yahya. All rights reserved.
//

import Foundation
import UIKit
class ImageViewModel {
    private var singleImage :ImageModel
    
    init() {
        let images = [UIImage(named: "photo1.jpg"),UIImage(named: "photo2.jpg"),UIImage(named: "photo3.jpg"),UIImage(named: "photo4.jpg")]
        
        self.singleImage = ImageModel(image: images)
        
    }
    var imageView:[UIImage?]{
        return singleImage.image
    }
}
class VideoViewModel {
    private var videoModel :VideoModel
    
    init() {
        
        let videos = ["ezgif.com","ezgi2"]

        self.videoModel = VideoModel(path: videos)
    }
    
    var pathVideo :[String]{
        return videoModel.path
    }
}
