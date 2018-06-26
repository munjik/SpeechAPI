//
//  CircleButton.swift
//  Scribe
//
//  Created by Munji on 6/23/18.
//  Copyright © 2018 Munji. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        // need didset for the inspectable var
        didSet {
            setUpView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    func setUpView() {
        layer.cornerRadius = cornerRadius

    }

}
