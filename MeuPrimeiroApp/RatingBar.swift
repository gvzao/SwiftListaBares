//
//  RatingBar.swift
//  MeuPrimeiroApp
//
//  Created by Jonathan on 31/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit

@IBDesignable class RatingBar: UIStackView {
    //MARK: Initialization
    //MARK: Private Methods
    //MARK: Button Action
    //MARK: Properties
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
            
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    

    
    private func setupButtons() {
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "star1", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"star2", in: bundle, compatibleWith: self.traitCollection)
        
        
        for _ in 0..<5 {
            
        let button = UIButton()
        // Add constraints
       
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
    
            
        // Setup the button action
        button.addTarget(self, action: #selector(RatingBar.ratingButtonTapped(button:)), for: .touchUpInside)
        
        addArrangedSubview(button)
            
        // Add the new button to the rating button array
        ratingButtons.append(button)
    
    }
    updateButtonSelectionStates()
  }
    
}
