//
//  AllImage&VideoViewController.swift
//  BioTecknoAssigment
//
//  Created by macbook on 10/24/1398 AP.
//  Copyright © 1398 Yahya. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class AllImage_VideoViewController: UIViewController {
    @IBOutlet weak var tableMedia: UITableView!
    
    //var images :[UIImage?] = []
//    var videosUrl = [""]
//    var imageUrl = [MediaViewModel]()
//    var mediaViewModel = MediaViewModel()
    var media = [MediaModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableMedia.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaTableViewCell")
        
        let media = MediaViewModel()
        self.media = media.media
           
        // Do any additional setup after loading the view.
    }
    func generateThumbnail(path: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: path, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }

}

extension AllImage_VideoViewController:UITableViewDelegate,UITableViewDataSource {
 

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.media.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell") as! MediaTableViewCell
        
        let segment = media[indexPath.row]
        
        if  let image = segment.imageUrl {
            cell.fill(image)
            return cell
        }else if let video = segment.videoUrl,let videoUrl = URL(string: video){
            cell.fillVideoType(image: self.generateThumbnail(path: videoUrl))
            return cell
        }
        
        

        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                self.performSegue(withIdentifier: "imageShow", sender: indexPath.row)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageShow"{
            if let destination = segue.destination as? ImageSliderViewController , let sender = sender as? Int{
                destination.selectIndex = sender
                destination.media = media
            }
            
        }
    }
}
