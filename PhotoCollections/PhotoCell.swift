//
//  PhotoCell.swift
//  PhotoCollections
//
//  Created by Ikhsan on 21/10/17.
//  Copyright © 2017 Ikhsan. All rights reserved.
//

import UIKit

class PhotoCell : UICollectionViewCell
{
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var imageName: String! {
        didSet{
            photoImageView.image = UIImage(named: imageName)
        }
    }
}
