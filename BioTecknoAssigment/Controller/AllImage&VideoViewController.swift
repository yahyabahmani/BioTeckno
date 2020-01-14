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
    
    var images :[UIImage?] = []
    var videos = [""]
   // var allImage:[ImageModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableMedia.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaTableViewCell")
        let imageViewModel =  ImageViewModel()
        self.images = imageViewModel.imageView
        print("adadadadad ")
        let videoViewModel = VideoViewModel()
        self.videos = videoViewModel.pathVideo
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ? "Image":"Video"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.images.count: self.videos.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell") as! MediaTableViewCell
        if indexPath.section == 0 {
                   
            if let section = self.images[indexPath.row] {
            
            cell.fill(section)
            }
            
            return cell
        }else{
            
            guard let path = Bundle.main.path(forResource: self.videos[indexPath.row], ofType:"mp4") else {
                    debugPrint("video.m4v not found")
                    return UITableViewCell()
                }
            
            if let image =   self.generateThumbnail(path:  URL(fileURLWithPath: path)) {
            cell.fill(image)
            }
            
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            self.performSegue(withIdentifier: "imageShow", sender: indexPath.row)
            
            
        }else{
            guard let path = Bundle.main.path(forResource: self.videos[indexPath.row], ofType:".mp4") else {
                      debugPrint("video.m4v not found")
                      return
                  }
                  let player = AVPlayer(url: URL(fileURLWithPath: path))
                  let playerController = AVPlayerViewController()
                  playerController.player = player
                  present(playerController, animated: true) {
                      player.play()
                  }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageShow"{
            if let destination = segue.destination as? ImageSliderViewController , let sender = sender as? Int{
                destination.selectIndex = sender
                destination.allImage = self.images
            }
            
        }
    }
}
