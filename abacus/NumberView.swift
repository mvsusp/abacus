//
//  NumberView.swift
//  abacus
//
//  Created by marcio vinicius dos santos on 28/03/15.
//  Copyright (c) 2015 marcio vinicius dos santos. All rights reserved.
//

import UIKit

@IBDesignable
class NumberView: UIView {

  @IBInspectable var borderColor: UIColor = UIColor.blackColor() {
    didSet {
      layer.borderColor = borderColor.CGColor
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 1.0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var cornerRadius: CGFloat = 3.0 {
    didSet {
      layer.cornerRadius = cornerRadius
    }
  }
  
}
