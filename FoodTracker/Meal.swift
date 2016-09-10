//
//  Meal.swift
//  FoodTracker
//
//  Created by Julia Castro on 9/7/16.
//  Copyright © 2016 Julia Castro. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths 
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    //MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    init?(name: String, photo: UIImage?, rating: Int){ //an initializer with ? is a failable initializer, which means that it's possible for the initializer to return nil after initialization 
        
        //initalize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        //initalization should fail if there is no name or if the rating is negative 
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    //NSCoding
    func encodeWithCoder(aCoder: NSCoder) { // prepares the class' information to be archived
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(rating, forKey: PropertyKey.ratingKey)
    }
    
    //initializer to decode the encoded data 
    //required keyword means the initializer must be implemented on every subclass of the class that defines this initializer 
    //convenience means convenience initializer: secondary, supporting initializers that need to call one of their class's designtated initializers
    required convenience init? (coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        //because photo is an optional property of Meal , use conditional cast
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        let rating = aDecoder.decodeObjectForKey(PropertyKey.ratingKey) as! Int
        
        //must call designated initalizer
        self.init(name: name, photo: photo, rating: rating)
    }
}
