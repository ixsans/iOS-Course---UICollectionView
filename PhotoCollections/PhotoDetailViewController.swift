//
//  PhotoDetailViewController.swift
//  PhotoCollections
//
//  Created by Ikhsan on 22/10/17.
//  Copyright © 2017 Ikhsan. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: image)
        navigationItem.title = "Photo"
    }


}
