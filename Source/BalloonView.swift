//
//  Balloon.swift
//  BalloonSlider
//
//  Created by Mohammad reza Koohkan on 8/15/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import UIKit.UIView

final class BalloonView: UIView {
    
    var percentage: Int = 0 {
        didSet {
            self.percentageLabel.text = String(self.percentage)
        }
    }
    
    private var movePoint: CGPoint = .zero
    private var flowDirection: UISwipeGestureRecognizer.Direction = .left
    private var delay: Double = 0
    private let animationDuration: Double = 0.5
    private var imageName: String { "Balloon" }
    private var motion: CGFloat = 10
    private var rotationDegree: Double = 10
    private var scaleMultiplier: CGFloat = 6
    private var angle: CGFloat {
        CGFloat(self.rotationDegree * (Double.pi/180))
    }
    
    lazy var balloonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: self.imageName)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutBalloonImageView()
        self.layoutPercentageLabel()
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.alpha = 0
        self.hide()
    }
    
    func layoutBalloonImageView() {
        self.addSubview(self.balloonImageView)
        self.balloonImageView.translatesAutoresizingMaskIntoConstraints = false
        [self.balloonImageView.topAnchor.constraint(equalTo: self.topAnchor),
         self.balloonImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         self.balloonImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         self.balloonImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)]
            .forEach { $0.isActive = true }
    }
    
    func layoutPercentageLabel() {
        self.addSubview(self.percentageLabel)
        self.percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        [self.percentageLabel.topAnchor.constraint(equalTo: self.topAnchor),
         self.percentageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
         self.percentageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         self.percentageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)]
            .forEach { $0.isActive = true }
    }
    
    func hide() {
        UIView.animate(withDuration: self.animationDuration - 0.2, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            let scale = CGAffineTransform(scaleX: 0.7, y: 0.7)
            let translation = CGAffineTransform(translationX: 0,y: self.frame.height/1.5)
            self.transform = scale.concatenating(translation)
            self.alpha = 0
        }, completion: nil)
    }
    
    func show() {
        UIView.animate(withDuration: self.animationDuration, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: .curveEaseOut, animations: {
            self.transform = .identity
            self.alpha = 1
        }, completion: nil)
    }
    
    
    func seek(using sliderView: BalloonSliderView, point: CGPoint) {
        self.movePoint = point
        let slideValue = sliderView.slider.value
        let previousValue = self.percentage
        let currentValue = Int(slideValue * 100)
        let isStopped = currentValue - previousValue == 0
        guard !isStopped else { return }
        (currentValue < previousValue) ? self.seekBackward() : self.seekForward()
        self.seekTransition(slideValue)
    }
    
    
    func seekForward() {
        self.motion = -10
        self.rotationDegree = 350
        self.flowChanges(direction: .right)
    }
    
    func seekBackward() {
        self.motion = 10
        self.rotationDegree = 10
        self.flowChanges(direction: .left)
    }
    
    func flowChanges(direction: UISwipeGestureRecognizer.Direction) {
        guard direction != self.flowDirection else { return }
        self.delay = 0
        self.flowDirection = direction
    }
    
    func seekTransition(_ slideValue: Float) {
        let newPoint = CGPoint(x: self.movePoint.x - 10, y:  -(self.movePoint.y * 1.5))
        let scaleFactor = (CGFloat(slideValue)/self.scaleMultiplier) + 1
        let scale = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        self.delay += 0.003

        UIView.animate(withDuration: 0.3, delay: self.delay, options: .curveEaseInOut, animations: {
            self.center = newPoint
            self.transform = scale.rotated(by: self.angle)
        }, completion:nil)
    }
    
    
    
    static func commonFrame() -> CGRect {
        let scale: CGFloat = 2
        let width: CGFloat = 90/scale
        let height: CGFloat = 120/scale
        return CGRect(x: -width/4, y: -height, width: width, height: height)
    }
    
}
