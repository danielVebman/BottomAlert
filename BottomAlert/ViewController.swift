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
        let alert = TwoButtonAlertController()
        alert.button1.setImage(#imageLiteral(resourceName: "person"), for: .normal)
        alert.button1.setTitle("Pickup", for: .normal)
        alert.button2.setImage(#imageLiteral(resourceName: "bike"), for: .normal)
        alert.button2.setTitle("Delivery", for: .normal)
        alert.dismissCompletionBlock = { button in
            if button == 1 {
                let alert2 = ConfirmOrderAlertController(type: .pickup, orderTime: "2:00pm", orderDestination: nil, orderPrice: "$22.13", creditDigits: "1928")
                self.present(alert2, animated: false, completion: nil)
            } else if button == 2 {
                let alert2 = ConfirmOrderAlertController(type: .delivery, orderTime: nil, orderDestination: "6923 SE 35th St.", orderPrice: "$22.13", creditDigits: "1928")
                self.present(alert2, animated: false, completion: nil)
            }
        }
        present(alert, animated: false, completion: nil)
    }
}

