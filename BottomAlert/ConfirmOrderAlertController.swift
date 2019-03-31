//
//  ConfirmOrderAlertController.swift
//  BottomAlert
//
//  Created by Daniel Vebman on 3/31/19.
//  Copyright © 2019 Daniel Vebman. All rights reserved.
//

import Foundation
import UIKit

class ConfirmOrderAlertController: LeftTitledAlertController {
    var destinationLabel: UILabel!
    var totalPriceLabel: UILabel!
    var paymentMethodLabel: UILabel!
    
    var confirmButton = UIButton(type: .roundedRect)
    var cancelButton = UIButton(type: .system)
    
    var orderDestination: String
    var orderPrice: String
    
    override var contentHeight: CGFloat {
        return titleInset + 10
            + orderDestination.height(withConstrainedWidth: view.frame.width - 40, font: UIFont.systemFont(ofSize: 17)) + 10
            + orderPrice.height(withConstrainedWidth: view.frame.width - 40, font: UIFont.boldSystemFont(ofSize: 20)) + 10
            + 116 + 10 + 30
    }
    
    init(orderDestination: String, orderPrice: Double) {
        self.orderDestination = orderDestination
        self.orderPrice = "$\(orderPrice)"
        super.init(title: "Order for delivery")
    }
    
    override func setup(contentView: UIView) {
        super.setup(contentView: contentView)
        
        destinationLabel = UILabel(frame: CGRect(x: 20, y: titleInset + 20, width: contentView.frame.width - 40, height: orderDestination.height(withConstrainedWidth: view.frame.width, font: UIFont.systemFont(ofSize: 17))))
        destinationLabel.text = "Deliver to " + orderDestination
        destinationLabel.textColor = .gray
        destinationLabel.font = UIFont.systemFont(ofSize: 17)
        contentView.addSubview(destinationLabel)
        
        totalPriceLabel = UILabel(frame: CGRect(x: 20, y: destinationLabel.frame.maxY + 10, width: 0, height: 0))
        totalPriceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        totalPriceLabel.text = orderPrice
        totalPriceLabel.sizeToFit()
        contentView.addSubview(totalPriceLabel)
        
        paymentMethodLabel = UILabel()
        paymentMethodLabel.text = "prepaid with •••• •••• •••• 1928."
        paymentMethodLabel.font = UIFont.systemFont(ofSize: 17)
        paymentMethodLabel.textColor = .gray
        paymentMethodLabel.sizeToFit()
        paymentMethodLabel.frame.origin = CGPoint(x: totalPriceLabel.frame.maxX + 5, y: totalPriceLabel.frame.origin.y + totalPriceLabel.frame.height - paymentMethodLabel.frame.height)
        contentView.addSubview(paymentMethodLabel)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.gray, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancelButton.sizeToFit()
        cancelButton.center = CGPoint(x: contentView.frame.midX, y: contentView.frame.height - cancelButton.frame.height / 2 - 10)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        contentView.addSubview(cancelButton)
        
        confirmButton.setTitle("Place Order", for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        confirmButton.frame = CGRect(x: 20, y: cancelButton.frame.origin.y - 10 - 60, width: contentView.frame.width - 40, height: 60)
        confirmButton.layer.cornerRadius = 0.5 * confirmButton.frame.height
        confirmButton.backgroundColor = UIColor(rgb: 0x4286f4)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.addDropShadow(color: confirmButton.backgroundColor!, shadowRadius: 10, shadowOpacity: 0.8)
        contentView.addSubview(confirmButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cancel() {
        dismiss()
    }
}
