//
//  BalloonSliderView.swift
//  BalloonSliderView
//
//  Created by Mohammad reza Koohkan on 8/15/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import UIKit.UIView

class BalloonSliderView: UIView {
    
    lazy var slider: BalloonSlider = {
        BalloonSlider()
    }()
    
    lazy var balloonView: BalloonView = {
        BalloonView(frame: BalloonView.commonFrame() )
    }()

    lazy var thumbView: BalloonThumbView = {
        let size = CGSize(width: 15, height: 15)
        let yPos = (self.frame.height/2) - (size.height/2)
        let frame = CGRect(x: 0, y: yPos, width: size.width, height: size.height)
        return BalloonThumbView(size: size,frame: frame)
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layoutSliderView()
        self.layoutBalloonView()
        self.layoutThumbView()
        self.addTargets()
    }
    
    func addTargets() {
        self.slider.addTarget(self, action: #selector(self.changed), for: .valueChanged)
        self.slider.addTarget(self, action: #selector(self.dragged), for: .touchDown)
        self.slider.addTarget(self, action: #selector(self.released), for: [.touchUpInside,.touchUpOutside])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.valueChange()
    }
    
    @objc private func changed() {
        self.valueChange()
        self.thumbView.changing()
    }
    
    @objc private func dragged() {
        self.thumbView.big()
        self.balloonView.show()
    }
    
    @objc private func released() {
        self.thumbView.small()
        self.balloonView.hide()
    }
    
    
    func valueChange() {
        let changedPoint = self.slider.point(for: self.thumbView)
        self.thumbChange(changedPoint)
        self.balloonChange(changedPoint)
    }
    
    func thumbChange(_ point: CGPoint) {
        let changedPoint = CGPoint(x: point.x - 5, y: point.y)
        self.thumbView.centerPoint = changedPoint
    }
    
    func balloonChange(_ point: CGPoint) {
        self.balloonView.seek(using: self,point: point)
        self.balloonView.percentage = Int(self.slider.value * 100)
    }
    
    func layoutSliderView() {
        self.addSubview(self.slider)
        self.slider.frame = self.bounds
    }
    
    func layoutBalloonView() {
        self.addSubview(self.balloonView)
    }
    
    func layoutThumbView() {
        self.addSubview(self.thumbView)
        self.valueChange()
    }
    
    static func commonFrame(xPadding: CGFloat,on view: UIView) -> CGRect {
        let frame = view.frame
        let width = frame.width - (xPadding * 2)
        let height: CGFloat = 40
        let yPadding = (frame.height/2) - (height * 2)
        return CGRect(x: xPadding, y: yPadding, width: width, height: height)
    }
}
