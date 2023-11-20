//
//  CircleView.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import UIKit

class CircleView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.size.height / 2
    }
}
