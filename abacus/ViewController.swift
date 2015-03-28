//
//  ViewController.swift
//  abacus
//
//  Created by marcio vinicius dos santos on 28/03/15.
//  Copyright (c) 2015 marcio vinicius dos santos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var one: NumberView!
  @IBOutlet weak var two: NumberView!
  @IBOutlet weak var three: NumberView!
  @IBOutlet weak var four: NumberView!
  @IBOutlet weak var five: NumberView!
  @IBOutlet weak var six: NumberView!
  @IBOutlet weak var seven: NumberView!
  @IBOutlet weak var eight: NumberView!
  @IBOutlet weak var nine: NumberView!
  @IBOutlet weak var ten: NumberView!
  
  
  @IBOutlet weak var zeroSpace: NSLayoutConstraint!
  @IBOutlet weak var oneSpace: NSLayoutConstraint!
  @IBOutlet weak var twoSpace: NSLayoutConstraint!
  @IBOutlet weak var threeSpace: NSLayoutConstraint!
  @IBOutlet weak var fourSpace: NSLayoutConstraint!
  @IBOutlet weak var fiveSpace: NSLayoutConstraint!
  @IBOutlet weak var sixSpace: NSLayoutConstraint!
  @IBOutlet weak var sevenSpace: NSLayoutConstraint!
  @IBOutlet weak var eightSpace: NSLayoutConstraint!
  @IBOutlet weak var nineSpace: NSLayoutConstraint!
  
  var spaces: [NSLayoutConstraint] = []
  var currentNumber = 0
  
  @IBAction func viewTapped(sender: UITapGestureRecognizer) {
    setCurrentNumber(++currentNumber%10)

  }
  
  func setCurrentNumber(value: Int){
    
    for index in 1...10 {
      if index <= value {
        showNumber(index)
      } else {
        hideNumber(index)
      }
    }
    
    currentNumber = value

    UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: nil, animations: {
      self.view.layoutSubviews()
      }, completion: nil)
  }
  
  func showNumber(value: Int){
    if spaces[value-1].constant >= self.view.bounds.width {
      spaces[value-1].constant = spaces[value-1].constant - self.view.bounds.width
    }
  }
  
  func hideNumber(value: Int){
    if value > 9 {
      return
    }
    if spaces[value-1].constant <= self.view.bounds.width {
      spaces[value-1].constant = spaces[value-1].constant + self.view.bounds.width
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    spaces = [zeroSpace, oneSpace,twoSpace,threeSpace,fourSpace,fiveSpace,sixSpace,sevenSpace,eightSpace,nineSpace]

    setCurrentNumber(1)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

