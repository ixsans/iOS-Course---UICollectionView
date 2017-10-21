//
//  PhotoCollectionViewController.swift
//  PhotoCollections
//
//  Created by Ikhsan on 21/10/17.
//  Copyright © 2017 Ikhsan. All rights reserved.
//

import UIKit

class PhotoCellViewController : UICollectionViewController
{
    
    var photos: [PhotoCategory] = PhotoLibrary.fetchPhotos()
    
    struct Storyboard {
        static let photoCell = "PhotoCell"
        static let leftAndRightPaddings: CGFloat = 2.0
        static let numberOfItemPerRows: CGFloat = 3.0
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = (collectionViewWidth! - Storyboard.leftAndRightPaddings) / Storyboard.numberOfItemPerRows
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos[section].imageNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.photoCell, for: indexPath) as! PhotoCell
        let imageNames = photos[indexPath.section].imageNames
        let imageName = imageNames[indexPath.row]
        cell.imageName = imageName

        return cell
    }
    
    
    sectionon
    
    
}
