//
//  ViewController.swift
//  ItemRX_2
//
//  Created by Khachatur Hakobyan on 2/27/20.
//  Copyright © 2020 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var array = [1, 2, 3]
    var currentIndex = 0
    
    

    @IBAction func printNext(_ sender: Any) {
      print(array[currentIndex])
      
      if currentIndex != array.count-1 {
        currentIndex += 1
      }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

