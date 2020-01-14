//
//  ImageSliderViewController.swift
//  BioTecknoAssigment
//
//  Created by macbook on 10/24/1398 AP.
//  Copyright © 1398 Yahya. All rights reserved.
//

import UIKit

class ImageSliderViewController: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    var allImage  =  [UIImage?]()
    var selectImageIndex = IndexPath()
    var selectIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sliderCollectionView.register(UINib(nibName: "ImgeSliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImgeSliderCollectionViewCell")
        
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
        return allImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgeSliderCollectionViewCell", for: indexPath) as! ImgeSliderCollectionViewCell
        let image = self.allImage[indexPath.row]
       cell.sliderImageView.image =  image
        
        return cell
    }

}
