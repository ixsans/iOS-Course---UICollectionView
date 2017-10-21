//
//  Photo.swift
//  PhotoCollections
//
//  Created by Ikhsan on 15/10/17.
//  Copyright © 2017 Ikhsan. All rights reserved.
//

import Foundation

struct PhotoCategory
{
    var categoryImageName: String
    var title: String
    var imageNames: [String]
}


class PhotoLibrary
{
    class func fetchPhotos() -> [PhotoCategory]
    {
        var categories = [PhotoCategory]()
        
        let photoData = downloadPhotosData()
        for(categoryTitle, dict) in photoData {
            if let data = dict as? [String : Any] {
                let categoryImageName = data["categoryImageName"] as! String
                let imageNames = data["imageNames"] as! [String]
                let photoCategory = PhotoCategory(categoryImageName: categoryImageName, title: categoryTitle, imageNames: imageNames)
                categories.append(photoCategory)
            }
        }
        
        return categories
    }
    
    class func downloadPhotosData() -> [String : Any]
    {
        return [
            "Nature" : [
                "categoryImageName" : "nature",
                "imageNames" : PhotoLibrary.generateImage(categoryPrefix: "n", numberOfImages: 6)
            ],
            "Foods" : [
                "categoryImageName" : "foods",
                "imageNames" : PhotoLibrary.generateImage(categoryPrefix: "f", numberOfImages: 6)
            ],
            "Cars" : [
                "categoryImageName" : "cars",
                "imageNames" : PhotoLibrary.generateImage(categoryPrefix: "c", numberOfImages: 6)
            ],
            "Travels" : [
                "categoryImageName" : "travels",
                "imageNames" : PhotoLibrary.generateImage(categoryPrefix: "t", numberOfImages: 6)
            ],
        
        ]
    }
    
    private class func generateImage(categoryPrefix: String, numberOfImages: Int) -> [String]
    {
        var imageNames = [String]()
        
        for i in 1...numberOfImages {
            imageNames.append("\(categoryPrefix)\(i)")
        }
        return imageNames
    }
    
}
