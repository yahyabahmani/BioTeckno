//
//  MediaTableViewCell.swift
//  BioTecknoAssigment
//
//  Created by macbook on 10/24/1398 AP.
//  Copyright © 1398 Yahya. All rights reserved.
//

import UIKit
import Kingfisher
class MediaTableViewCell: UITableViewCell {
    @IBOutlet weak var previewImageView: UIImageView!

    @IBOutlet weak var playIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    func fill(_ name:String) {
        let url = URL(string: name)
        previewImageView.kf.setImage(with: url)
        self.playIcon.isHidden = true

    }
    func fillVideoType(image:UIImage?) {
        self.previewImageView.image = image
        self.playIcon.isHidden = false
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
