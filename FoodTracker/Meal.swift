//
//  Meal.swift
//  FoodTracker
//
//  Created by Capt. Ihsan on 1/16/17.
//  Copyright © 2017 Erlangga. All rights reserved.
//

import UIKit
class Meal:NSObject,NSCoding{
    
    required convenience init?(coder aDecoder:NSCoder) {
        guard let name = aDecoder.decodeObjectForKey(PropertyKey.name) as? String else{
            print("Unable to decode the name for a Meal object")
            return nil
        }
        
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.rating)
        
        // harus intialisasi setelah decode
        self.init(name:name, photo:photo, rating:rating)
    }
    
    struct PropertyKey {
        static let name="name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    // MARK: Properties
    var name:String
    var photo: UIImage?
    var rating:Int
    
    init?(name:String, photo:UIImage?, rating:Int){
        guard !name.isEmpty else {
            return nil
        }
        
        guard rating>=0 && rating <= 5 else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.name)
        aCoder.encodeInt(Int32(rating), forKey: PropertyKey.rating)
        aCoder.encodeObject(photo, forKey: PropertyKey.photo)
    }
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meal", isDirectory: true)
}