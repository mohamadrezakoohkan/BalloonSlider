//
//  ViewController.swift
//  BalloonSlider
//
//  Created by Mohammad reza Koohkan on 8/15/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var valueChange = #selector(self.sliderValueChanged(_:))
    lazy var editingEnd = #selector(self.sliderEndEditing(_:))
    lazy var editingBegin = #selector(self.sliderBeginEditing(_:))

    lazy var balloonSlider: BalloonSliderView = {
        BalloonSliderView(frame: BalloonSliderView.commonFrame(xPadding: 40, on: self.view))
    }()

    let archFont = UIFont(name: "Arch-Bold", size: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViews()
        self.setupActions()
        self.balloonSlider.balloonView.percentageLabel.font = self.archFont
    }
    
    
    func addViews() {
        self.view.addSubview(self.balloonSlider)
    }

    func setupActions() {
        self.balloonSlider.slider.addTarget(self, action: self.valueChange, for: .valueChanged)
        self.balloonSlider.slider.addTarget(self, action: editingBegin, for: .touchDown)
        self.balloonSlider.slider.addTarget(self, action: self.editingEnd, for: [.touchUpInside,.touchUpOutside])
    }

    @objc func sliderValueChanged(_ sender: BalloonSliderView) {
        print("change")
    }
    
    @objc func sliderEndEditing(_ sender: BalloonSliderView) {
        print("end")
    }
    
    @objc func sliderBeginEditing(_ sender: BalloonSliderView) {
        print("begin")
    }
}

