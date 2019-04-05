//
//  TwoButtonAlertController.swift
//  BottomAlert
//
//  Created by Daniel Vebman on 4/4/19.
//  Copyright © 2019 Daniel Vebman. All rights reserved.
//

import Foundation
import UIKit

class TwoButtonAlertController: BottomAlertController {
    var button1 = ImageSubtitleButton()
    var button2 = ImageSubtitleButton()
    var cancelButton = UIButton(type: .system)
    
    var dismissCompletionBlock: ((Int) -> ())?
    
    override var contentHeight: CGFloat {
        return 200
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.gray, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        cancelButton.sizeToFit()
        cancelButton.center = CGPoint(x: contentView.frame.midX, y: contentView.frame.height - cancelButton.frame.height / 2 - 10)
        cancelButton.tag = 0
        cancelButton.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
        contentView.addSubview(cancelButton)
        
        button1.frame = CGRect(x: 20, y: 20, width: contentView.frame.width / 2 - 30, height: cancelButton.frame.minY - 30)
        button1.tag = 1
        button1.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
        contentView.addSubview(button1)
        
        button2.frame = CGRect(x: contentView.frame.width / 2 + 10, y: 20, width: contentView.frame.width / 2 - 30, height: cancelButton.frame.minY - 30)
        button2.tag = 2
        button2.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
        contentView.addSubview(button2)
    }
    
    @objc func tappedButton(_ button: UIButton) {
        dismiss {
            self.dismissCompletionBlock?(button.tag)
        }
    }
}

class ImageSubtitleButton: UIButton {
    var bigImageView = UIImageView()
    var subtitleLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        bigImageView.contentMode = .scaleAspectFit
        bigImageView.tintColor = .white
        addSubview(bigImageView)
        
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.systemFont(ofSize: 15)
        subtitleLabel.textColor = .white
        addSubview(subtitleLabel)
        
        backgroundColor = UIColor(rgb: 0x4286f4)
        layer.cornerRadius = 10
        addDropShadow(color: .red, shadowRadius: 10, shadowOpacity: 0.8)
        
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchReenter), for: .touchDragEnter)
        addTarget(self, action: #selector(tapOut), for: .touchDragExit)
        addTarget(self, action: #selector(tapOut), for: .touchUpInside)
        addTarget(self, action: #selector(tapOut), for: .touchUpOutside)
        addTarget(self, action: #selector(tapOut), for: .touchCancel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func touchDown() {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 0.8
        }
    }
    
    @objc func touchReenter() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.8
        }
    }
    
    @objc func tapOut() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        bigImageView.image = image
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        subtitleLabel.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bigImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 30).insetBy(dx: 30, dy: 30)
        subtitleLabel.frame = CGRect(x: 0, y: frame.height - 40, width: frame.width, height: 30)
        addDropShadow(color: backgroundColor!, shadowRadius: 10, shadowOpacity: 0.5)
    }
}
