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
class MediaViewModel{
    private var mediaModel = [MediaModel]()
    init() {
//        let path = ["https://www.radiantmediaplayer.com/media/bbb-360p.mp4","https://www.hdwplayer.com/videos/300.mp4"]
//        let images = ["https://static2.farakav.com/files/pictures/01449771.jpg","https://static2.farakav.com/files/pictures/01469620.jpg","https://static2.farakav.com/files/pictures/01469617.jpg","https://static2.farakav.com/files/pictures/01469616.jpg"]
        
        
        self.mediaModel.append(MediaModel(videoUrl: nil, imageUrl: "https://static2.farakav.com/files/pictures/01449771.jpg"))
        
                self.mediaModel.append(MediaModel(videoUrl: nil, imageUrl: "https://static2.farakav.com/files/pictures/01469620.jpg"))
                self.mediaModel.append(MediaModel(videoUrl: nil, imageUrl: "https://static2.farakav.com/files/pictures/01469617.jpg"))
                self.mediaModel.append(MediaModel(videoUrl: nil, imageUrl: "https://static2.farakav.com/files/pictures/01469616.jpg"))
        
                self.mediaModel.append(MediaModel(videoUrl: "https://www.hdwplayer.com/videos/300.mp4", imageUrl:nil ))
                self.mediaModel.append(MediaModel(videoUrl: "https://www.radiantmediaplayer.com/media/bbb-360p.mp4", imageUrl: nil))
        
        
        
    }
//    var videoUrl :[String]{
//        return mediaModel.videoUrl
//    }
//    var imgUrl:[String]{
//        return mediaModel.imageUrl
//    }
    var media :[MediaModel]{
        return self.mediaModel
    }
    
   class func getMedia (videoUrl:URL,callback:@escaping (Bool)->Void) {

                let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = docsUrl.appendingPathComponent(videoUrl.lastPathComponent)
            if(FileManager().fileExists(atPath: destinationUrl.path)){
                    print("\n\nfile already exists\n\n")
                    callback(true)
                }
                else{
                    //DispatchQueue.global(qos: .background).async {
                        var request = URLRequest(url: videoUrl)
                        request.httpMethod = "GET"
                let urlconfig = URLSessionConfiguration.ephemeral
                 urlconfig.timeoutIntervalForRequest = 30
                 urlconfig.timeoutIntervalForResource = 30
                 let session = URLSession(configuration: urlconfig)
                        _ = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if(error != nil){
                print("\n\nsome error occured\n\n")
                callback(false)

                return
            }
            if let response = response as? HTTPURLResponse{
                if response.statusCode == 200{
                    DispatchQueue.main.async {
                        if let data = data{
                            if (try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)) != nil{
                                callback(true)

                                print("\n\nurl data written\n\n")
                            }
                            else{
                                callback(false)

                                print("\n\nerror again\n\n")
                            }
                        }//end if let data
                    }//end dispatch main
                }//end if let response.status
            }
        }).resume()
                    //}//end dispatch global
                }//end outer else
        
    }
    
}
