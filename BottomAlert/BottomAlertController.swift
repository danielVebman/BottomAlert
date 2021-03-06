//
//  BottomAlertController.swift
//  BottomAlert
//
//  Created by Daniel Vebman on 3/30/19.
//  Copyright © 2019 Daniel Vebman. All rights reserved.
//

import Foundation
import UIKit

/// Subclass `BottomAlertController` and override `setup(contentView:)` and `contentHeight`
class BottomAlertController: UIViewController {
    private var backgroundView: UIView!
    private var containerView: UIView!
    
    var contentView: UIView!
    
    var contentHeight: CGFloat {
        return 300
    }
    
    var canTapBackgroundToDismiss = true
    var canSwipeToDismiss = true
    
    private var bottomInset: CGFloat {
        return max(UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0, 10)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overCurrentContext
        modalPresentationCapturesStatusBarAppearance = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Be sure to call super.viewDidLoad() before trying to access `contentView`.
    open override func viewDidLoad() {
        view.backgroundColor = .clear
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swipe(_:))))
        
        backgroundView = UIView(frame: view.frame)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        backgroundView.alpha = 0
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        view.addSubview(backgroundView)
        
        containerView = UIView(frame: CGRect(x: 10, y: view.frame.height, width: view.frame.width - 20, height: contentHeight))
        containerView.layer.cornerRadius = 30
        containerView.addDropShadow()
        view.addSubview(containerView)
        
        contentView = UIView(frame: containerView.bounds)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 30
        containerView.addSubview(contentView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.containerView.frame.origin.y = self.view.frame.height - self.contentHeight - self.bottomInset
        })
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 1
        })
    }
    
    @objc private func tap() {
        guard canTapBackgroundToDismiss else { return }
        
        dismiss()
    }
    
    @objc private func swipe(_ gesture: UIPanGestureRecognizer) {
        guard canSwipeToDismiss else { return }
        
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: gesture.view).y
            backgroundView.alpha = translation > 0 ? 1 - translation / contentHeight : 1
            containerView.frame.origin.y = view.frame.height - contentHeight - bottomInset + translation / (translation > 0 ? 1 : 4)
        case .ended:
            let velocity = gesture.velocity(in: gesture.view).y
            if velocity > 1500 {
                let distanceToMove = view.frame.height - containerView.frame.origin.y - bottomInset
                let duration = Double(distanceToMove / velocity)
                dismiss(duration: duration)
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
                    self.containerView.frame.origin.y = self.view.frame.height - self.contentHeight - self.bottomInset
                })
                
                UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
                    self.backgroundView.alpha = 1
                })
            }
        default:
            return
        }
    }
    
    @objc public func dismiss(duration: Double = 0.3, completion: (() -> ())? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.backgroundView.alpha = 0
            self.containerView.frame.origin.y = self.view.frame.height
        }) { (_) in
            self.dismiss(animated: true, completion: {
                completion?()
            })
        }
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIView {
    func round(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath
        layer.mask = maskLayer
    }
    
    func addDropShadow(color: UIColor = .black, shadowRadius: CGFloat = 5, shadowOpacity: Float = 0.2) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: layer.cornerRadius, height: layer.cornerRadius)).cgPath
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
