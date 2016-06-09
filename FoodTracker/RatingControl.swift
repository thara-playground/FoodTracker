//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Tomochika Hara on 2016/06/06.
//  Copyright © 2016年 Tomochika Hara. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    
    var rating = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    
    let spacing = 5
    let starCount = 5
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        for _ in 0..<self.starCount {
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: #selector(ratingButtonTapped(_:)), forControlEvents: .TouchDown)
            
            self.ratingButtons += [button]
            self.addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + self.spacing))
            button.frame = buttonFrame
        }
        self.updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * self.starCount) + (self.spacing * (self.starCount - 1))
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    
    func ratingButtonTapped(button: UIButton) {
        self.rating = self.ratingButtons.indexOf(button)! + 1
        self.updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in self.ratingButtons.enumerate() {
            // If the index of a button is less than the rating, that button should be selected.
            button.selected = index < self.rating
        }
    }
}
