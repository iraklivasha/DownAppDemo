//
//  CardActionsView.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import UIKit

class CardActionsView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.distribution = .fillEqually
        self.spacing = 12
        self.axis = .horizontal
        self.layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewWithContainer(v: UIView, multiplier: CGFloat = 1.0) -> UIView {
        let view = UIView()
        view.addSubview(v)
        v.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(multiplier)
            make.width.equalTo(v.snp.height)
        }
        return view
    }
    
    private func layout() {
        let action1 = CircleActionView()
        action1.tintColor = .systemGreen
        action1.label.text = "Date"
        action1.imageView.image = MatchType.date.icon
        
        self.addArrangedSubview(viewWithContainer(v: action1))
        
        let action2 = CircleActionView()
        action2.type = .imageOnly
        action2.tintColor = .white
        action2.imageView.image = TabType.chats.icon
        
        self.addArrangedSubview(viewWithContainer(v: action2, multiplier: 0.6))
        
        let action3 = CircleActionView()
        action3.tintColor = .systemRed
        action3.label.text = "Down"
        action3.imageView.image = MatchType.down.icon
        
        self.addArrangedSubview(viewWithContainer(v: action3))
    }
}
