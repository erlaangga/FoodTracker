//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Capt. Ihsan on 1/16/17.
//  Copyright © 2017 Erlangga. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    var rattingButtons = [UIButton]()
    var rating = 0{
        didSet{
            updateButtonSelectionStates()
        }
    }

    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0)
        {
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount:Int = 5{
        didSet{
            setupButtons()
        }
    }
    
    override init(frame: CGRect) {
     super.init(frame: frame)
        setupButtons()
    }
 
    required init?(coder:NSCoder){
        super.init(coder:coder)
        setupButtons()
    }

    private func setupButtons(){
        
        for button in rattingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        rattingButtons.removeAll()
        
        let bundle = NSBundle(forClass: self.classForCoder)
        let filledStar = UIImage(named: "filledStar", inBundle: bundle, compatibleWithTraitCollection: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", inBundle: bundle, compatibleWithTraitCollection: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", inBundle: bundle, compatibleWithTraitCollection: self.traitCollection)
        
        for index in 0..<starCount{
            let button = UIButton()
//            button.backgroundColor = UIColor.redColor()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraintEqualToConstant(starSize.height).active = true
            button.widthAnchor.constraintEqualToConstant(starSize.width).active = true
            
            button.setImage(emptyStar, forState: .Normal)
            button.setImage(highlightedStar, forState: .Highlighted)
            button.setImage(highlightedStar, forState: [.Highlighted, .Selected])
            button.setImage(filledStar, forState: .Selected)
            
            button.accessibilityLabel = "set \(index+1) star rating"
            
            button.addTarget(self, action: #selector(ratingButtonTapped(_:)), forControlEvents: .TouchUpInside)
            
            addArrangedSubview(button)
            rattingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    func ratingButtonTapped(button: UIButton) {
        print("Button pressed 👍")
        
        guard let index = rattingButtons.indexOf(button) else {
            fatalError("The button, \(button), is not in ratingButtons array")
        }
        
        let selectedRating = index + 1
        
        if selectedRating == rating{
            rating = 0
        }else{
            rating = selectedRating
        }
        
        
    }
    
    func updateButtonSelectionStates(){
        for (index,button) in rattingButtons.enumerate(){
            button.selected = index < rating
            
            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
}
