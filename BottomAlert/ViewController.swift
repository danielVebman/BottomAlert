//
//  ViewController.swift
//  BottomAlert
//
//  Created by Daniel Vebman on 3/30/19.
//  Copyright © 2019 Daniel Vebman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let alert = ConfirmOrderAlertController(orderDestination: "6923 SE 35th St.", orderPrice: 22.13)
        present(alert, animated: false, completion: nil)
        
        print(UIScreen.main.scale)
    }
}

