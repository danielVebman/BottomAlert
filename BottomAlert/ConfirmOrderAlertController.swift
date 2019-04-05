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
    enum OrderType {
        case delivery, pickup
    }
    
    private(set) var type: OrderType
    
    var detailLabel: UILabel!
    var totalPriceLabel: UILabel!
    var paymentMethodLabel: UILabel!
    
    var confirmButton = UIButton(type: .roundedRect)
    var cancelButton = UIButton(type: .system)
    
    var orderDestination: String?
    var orderTime: String?
    var orderPrice: String
    var creditDigits: String
    
    override var contentHeight: CGFloat {
        if type == .delivery {
            return titleInset + 10
                + orderDestination!.height(withConstrainedWidth: view.frame.width - 40, font: UIFont.systemFont(ofSize: 15)) + 10
                + orderPrice.height(withConstrainedWidth: view.frame.width - 40, font: UIFont.boldSystemFont(ofSize: 18)) + 5
                + 110 + 10 + 30
        } else {
            return titleInset + 10
                + orderTime!.height(withConstrainedWidth: view.frame.width - 40, font: UIFont.systemFont(ofSize: 15)) + 10
                + orderPrice.height(withConstrainedWidth: view.frame.width - 40, font: UIFont.boldSystemFont(ofSize: 18)) + 5
                + 110 + 10 + 30
        }
    }
    
    // This has to be restructured to not be idiotic.
    init(type: OrderType, orderTime: String?, orderDestination: String?, orderPrice: String, creditDigits: String) {
        self.type = type
        self.orderTime = orderTime
        self.orderDestination = orderDestination
        self.orderPrice = orderPrice
        self.creditDigits = creditDigits
        super.init(title: "Order for " + (type == .delivery ? "delivery" : "pickup"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if type == .delivery {
            detailLabel = UILabel(frame: CGRect(x: 20, y: titleInset + 20, width: contentView.frame.width - 40, height: orderDestination!.height(withConstrainedWidth: view.frame.width, font: UIFont.systemFont(ofSize: 17))))
            detailLabel.text = "Deliver to " + orderDestination!
        } else {
            detailLabel = UILabel(frame: CGRect(x: 20, y: titleInset + 20, width: contentView.frame.width - 40, height: orderTime!.height(withConstrainedWidth: view.frame.width, font: UIFont.systemFont(ofSize: 17))))
            detailLabel.text = "Pickup at " + orderTime!
        }
        detailLabel.textColor = .gray
        detailLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(detailLabel)
        
        totalPriceLabel = UILabel(frame: CGRect(x: 20, y: detailLabel.frame.maxY + 5, width: 0, height: 0))
        totalPriceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        totalPriceLabel.text = orderPrice
        totalPriceLabel.sizeToFit()
        contentView.addSubview(totalPriceLabel)
        
        paymentMethodLabel = UILabel()
        paymentMethodLabel.text = "prepaid with •••• •••• •••• \(creditDigits)"
        paymentMethodLabel.font = UIFont.systemFont(ofSize: 15)
        paymentMethodLabel.textColor = .gray
        paymentMethodLabel.sizeToFit()
        paymentMethodLabel.frame.origin = CGPoint(x: totalPriceLabel.frame.maxX + 5, y: totalPriceLabel.frame.origin.y + totalPriceLabel.frame.height - paymentMethodLabel.frame.height)
        contentView.addSubview(paymentMethodLabel)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.gray, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        cancelButton.sizeToFit()
        cancelButton.center = CGPoint(x: contentView.frame.midX, y: contentView.frame.height - cancelButton.frame.height / 2 - 10)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        contentView.addSubview(cancelButton)
        
        confirmButton.setTitle("Place Order", for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        confirmButton.frame = CGRect(x: 20, y: cancelButton.frame.origin.y - 10 - 50, width: contentView.frame.width - 40, height: 50)
        confirmButton.layer.cornerRadius = 0.5 * confirmButton.frame.height
        confirmButton.backgroundColor = UIColor(rgb: 0x4286f4)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.addDropShadow(color: confirmButton.backgroundColor!, shadowRadius: 10, shadowOpacity: 0.8)
        contentView.addSubview(confirmButton)
    }
    
    @objc func cancel() {
        dismiss()
    }
}
