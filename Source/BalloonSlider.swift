//
//  BalloonSlider.swift
//  BalloonSlider
//
//  Created by Mohammad reza Koohkan on 8/15/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import UIKit.UISlider

class BalloonSlider: UISlider {
    

    var rectTrack: CGRect {
        self.trackRect(forBounds: self.bounds)
    }

    var rectThumb: CGRect {
        self.thumbRect(forBounds: self.bounds, trackRect: self.rectTrack, value: self.value)
    }
    
    private var touchSize = CGSize(width: 60, height: 60)

    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let increasedBounds = bounds.insetBy(dx: -touchSize.width, dy: -touchSize.height)
          let containsPoint = increasedBounds.contains(point)
          return containsPoint
    }
    
    func point(for thumb: BalloonThumbView) -> CGPoint {
        let origin = self.bounds.origin
        let thumbSize = thumb.frame.size
        var thumbHeight = thumbSize.height
        let thumbWidth = thumbSize.width
        let xPosition = self.rectThumb.origin.x + origin.x + thumbWidth/2.1
        if thumb.isBig { thumbHeight -= 8 }
        let yPosition = origin.y + thumbHeight
        return CGPoint(x: xPosition, y: yPosition)
    }
    
    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.tintColor = #colorLiteral(red: 0.3346309662, green: 0.1460499763, blue: 0.9099250436, alpha: 1)
        self.setThumbImage(UIImage(), for: [.highlighted,.normal])
    }
    
}
