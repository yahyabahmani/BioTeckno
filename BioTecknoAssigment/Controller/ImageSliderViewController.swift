//
//  ImageSliderViewController.swift
//  BioTecknoAssigment
//
//  Created by macbook on 10/24/1398 AP.
//  Copyright © 1398 Yahya. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ImageSliderViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    var selectImageIndex = IndexPath()
    var selectIndex = 0
    var media = [MediaModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sliderCollectionView.register(UINib(nibName: "ImgeSliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImgeSliderCollectionViewCell")
        self.indicator.isHidden = true
        
        // Do any additional setup after loading the view.
    }

    @IBAction func closeButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          DispatchQueue.main.async {
            self.sliderCollectionView.scrollToItem(at:IndexPath(row: self.selectIndex, section: 0), at: .centeredHorizontally, animated: false)
          }
        

    }


}
extension ImageSliderViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return media.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgeSliderCollectionViewCell", for: indexPath) as! ImgeSliderCollectionViewCell
        
        let segment = self.media[indexPath.row]
        cell.fill(media: segment)

        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let segment = self.media[indexPath.row]
        guard let video  =  segment.videoUrl, let videoUrl = URL(string: video) else{return}

        
        indicator.isHidden = false
        indicator.startAnimating()
        self.view.isUserInteractionEnabled = false

        MediaViewModel.getMedia(videoUrl: videoUrl) { (done) in
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            self.view.isUserInteractionEnabled = true

            if done{
                let baseUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                
                let assetUrl = baseUrl.appendingPathComponent(videoUrl.lastPathComponent)
                
                let url = assetUrl
                print(url)
                let avAssest = AVAsset(url: url)
                let playerItem = AVPlayerItem(asset: avAssest)
                
                
                let player = AVPlayer(playerItem: playerItem)
                
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                
                self.present(playerViewController, animated: true, completion: {
                    player.play()
                })
                
                
                
            }else{
            }
        }

        
    }
}
