//
//  Meal.swift
//  FoodTracker
//
//  Created by Capt. Ihsan on 1/16/17.
//  Copyright © 2017 Erlangga. All rights reserved.
//

import UIKit
class Meal:NSObject{
    
 
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
    

    
}