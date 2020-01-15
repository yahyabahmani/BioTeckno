//
//  ImgeSliderCollectionViewCell.swift
//  BioTecknoAssigment
//
//  Created by macbook on 10/24/1398 AP.
//  Copyright © 1398 Yahya. All rights reserved.
//

import UIKit
import AVKit
import Kingfisher
class ImgeSliderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var playImageView: UIImageView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var sliderImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func fill(media:MediaModel) {
        if let name = media.imageUrl {
            let url = URL(string: name)
                  sliderImageView.kf.setImage(with: url)

            self.playImageView.isHidden = true
            
        }else if let video = media.videoUrl, let videoUrl = URL(string: video) {
                    
            self.sliderImageView.image = self.generateThumbnail(path: videoUrl)
            
            self.playImageView.isHidden = false
        }
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
