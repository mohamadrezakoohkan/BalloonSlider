//
//  BalloonThumbView.swift
//  BalloonSlider
//
//  Created by Mohammad reza Koohkan on 8/15/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import UIKit.UIView

class BalloonThumbView: UIView {
    
    private let borderMinWidth: CGFloat = 1
    private let borderMaxWidth: CGFloat = 5
    private let scaleFactor: CGFloat = 2.5
    private var originSize: CGSize = .zero


    var isBig: Bool = false
    var centerPoint: CGPoint = .zero

    private var radius: CGFloat {
        self.frame.size.height/2
    }
    
    init(size: CGSize,frame: CGRect) {
        super.init(frame: frame)
        self.originSize = size
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height/2
    }
    
    func setupView() {
        self.frame.size = self.originSize
        self.backgroundColor = .white
        self.isUserInteractionEnabled = false
        self.layer.borderWidth = self.borderMaxWidth
        self.layer.borderColor = #colorLiteral(red: 0.3346309662, green: 0.1460499763, blue: 0.9099250436, alpha: 1).cgColor
        self.layer.masksToBounds = true
    }

    
    func big() {
        guard !isBig else { return }
        self.isBig.toggle()
        self.moveWithSlider()
        self.scaleTransform(scale: self.scaleFactor)
        self.animateBorderWidth(toValue: self.borderMinWidth)
        self.layoutIfNeeded()
    }
    
    func changing() {
        self.moveWithSlider()
        self.scaleTransform(scale: self.scaleFactor - 0.5)
        self.animateBorderWidth(toValue: self.borderMinWidth)
        self.layoutIfNeeded()
    }
    
    func small() {
        guard isBig else { return }
        self.isBig.toggle()
        self.moveWithSlider()
        self.scaleTransform()
        self.animateBorderWidth(toValue: self.borderMaxWidth)
        self.layoutIfNeeded()
    }
    
    func moveWithSlider() {
        self.center.x = self.centerPoint.x - 5
    }
    
    func scaleTransform(scale: CGFloat = 1) {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    func animateBorderWidth(toValue: CGFloat, duration: Double = 0.3) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        animation.fromValue = layer.borderWidth
        animation.toValue = toValue
        animation.duration = duration
        self.layer.add(animation, forKey: "border.width")
        self.layer.borderWidth = toValue
      }
}
