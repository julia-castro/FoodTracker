//
//  Meal.swift
//  FoodTracker
//
//  Created by Julia Castro on 9/7/16.
//  Copyright © 2016 Julia Castro. All rights reserved.
//

import UIKit

class Meal {
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    init?(name: String, photo: UIImage?, rating: Int){ //an initializer with ? is a failable initializer, which means that it's possible for the initializer to return nil after initialization 
        
        //initalize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
        
        //initalization should fail if there is no name or if the rating is negative 
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
}
