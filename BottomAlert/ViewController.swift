//
//  ViewController.swift
//  BottomAlert
//
//  Created by Daniel Vebman on 3/30/19.
//  Copyright © 2019 Daniel Vebman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAlert)))
    }
    
    @objc func showAlert() {
        let alert = ConfirmOrderAlertController(orderDestination: "6923 SE 35th St.", orderPrice: "$22.13", creditDigits: "1928")
        present(alert, animated: false, completion: nil)
    }
}

