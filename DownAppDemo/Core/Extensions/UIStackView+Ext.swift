//
//  UIStackView+Ext.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        self.arrangedSubviews.forEach { v in
            self.removeArrangedSubview(v)
            v.removeFromSuperview()
        }
    }
}
