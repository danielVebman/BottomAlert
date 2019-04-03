//
//  LeftTitledAlertController.swift
//  BottomAlert
//
//  Created by Daniel Vebman on 3/31/19.
//  Copyright © 2019 Daniel Vebman. All rights reserved.
//

import Foundation
import UIKit

class LeftTitledAlertController: BottomAlertController {
    var titleLabel: UILabel!
    
    private(set) var titleText: String
    
    var titleInset: CGFloat {
        return 20 + titleText.height(withConstrainedWidth: CGFloat.greatestFiniteMagnitude, font: UIFont.boldSystemFont(ofSize: 25))
    }
    
    init(title: String) {
        titleText = title
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 0, height: 0))
        titleLabel.text = titleText
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.sizeToFit()
        contentView.addSubview(titleLabel)
    }
}
