//
//  DownOrDateView.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import UIKit

class DownOrDateView: CircleView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var containerView: UIView = {
        let l = UIView()
        
        l.addSubview(imageView)
        l.addSubview(labelDownDate)
        
        imageView.snp.makeConstraints { make in
            make.left.top.equalTo(16)
            make.bottom.equalTo(-16)
            make.width.equalTo(imageView.snp.height)
        }
        
        labelDownDate.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(6)
            make.centerY.equalToSuperview()
            make.right.equalTo(-6)
        }
        
        return l
    }()
    
    private(set) lazy var labelDownDate: UILabel = {
        let l = UILabel()
        l.text = "DOWN"
        l.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()
 
    private func layout() {
        self.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}
