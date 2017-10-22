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
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var photos: [PhotoCategory] = PhotoLibrary.fetchPhotos()
    
    struct Storyboard {
        static let photoCell = "PhotoCell"
        static let sectionHeaderView = "SectionHeaderView"
        static let showDetailVC = "ShowImageDetail"
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
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: - Action
    
    
    @IBAction func addPhoto(_ sender: Any) {
        // 1 - get a random image
        let firstCategoryImageNames = photos[0].imageNames
        let randomIndex = Int(arc4random()) % firstCategoryImageNames.count
        let randomImage = photos[0].imageNames[randomIndex]
        
        // 2 - add image to data model
        photos[0].imageNames.append(randomImage)
        
        // 3 - update collectionview
        let insertedIndexPath = IndexPath(item: firstCategoryImageNames.count, section: 0)
        collectionView?.insertItems(at: [insertedIndexPath])
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
        cell.delegate = self
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Storyboard.sectionHeaderView, for: indexPath) as! SectionHeaderView
        
        let photoCategory = photos[indexPath.section]
        sectionHeaderView.photoCategory = photoCategory
        
        return sectionHeaderView
    }
    
    // MARK - Editing mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        addButton.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? PhotoCell {
                    cell.isEditing = editing
                }
            }
        }
    }
    
    var selectedImage: String!
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        selectedImage = photos[indexPath.section].imageNames[indexPath.row]
        performSegue(withIdentifier: Storyboard.showDetailVC, sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showDetailVC {
            let destinationVC = segue.destination as! PhotoDetailViewController
            destinationVC.image = selectedImage
        }
    }
    
}

extension PhotoCellViewController : PhotoCellDelegate
{
    func delete(cell: PhotoCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            // 1. Delete photo from data source
            photos[indexPath.section].imageNames.remove(at: indexPath.item)
            
            // 2. Delete the photo cell at that index path from collection view
            collectionView?.deleteItems(at: [indexPath])
        }
    }
}
