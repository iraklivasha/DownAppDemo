//
//  TopPicksView.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 20.11.23.
//

import UIKit

class TopPickItem: UIView {
    
    private(set) lazy var imageView: CircleImageView = {
        let v = CircleImageView()
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.borderWidth = 1
        v.contentMode = .scaleAspectFill
        return v
    }()
    
    private(set) lazy var label: UILabel = {
        let v = UILabel()
        v.font = UIFont.boldSystemFont(ofSize: 17)
        v.textAlignment = .center
        v.text = ""
        v.textColor = .white
        v.font = UIFont.boldSystemFont(ofSize: 12)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        self.addSubview(imageView)
        label.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(18)
        }
        
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(label.snp.top).offset(-6)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(imageView.snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// This should be collection view - Right now it's stack view just for demo purposes

class TopPicksView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.distribution = .fill
        self.spacing = 8
        
        addGeneratedSubview(for: "Nearby",
                            imageURL: "https://www.sftravel.com/sites/default/files/styles/hero/public/2022-10/cable-cars-downtown-san-francisco.jpg.webp?itok=8jadbiE5")
        
        addGeneratedSubview(for: "Los Angeles",
                            imageURL: "https://a.cdn-hotels.com/gdcs/production67/d1465/e9ab508c-3660-491b-ae2f-582e3c1b0ec5.jpg?impolicy=fcrop&w=800&h=533&q=medium")
        
        addGeneratedSubview(for: "San Francisco",
                            imageURL: "https://cdn.britannica.com/13/77413-050-95217C0B/Golden-Gate-Bridge-San-Francisco.jpg")
    
    }
    
    private func addGeneratedSubview(for title: String, imageURL: String) {
        let x1 = TopPickItem()
        x1.imageView.setImageFromUrl(imageURL)
        x1.label.text = title
        
        self.addArrangedSubview(x1)
        x1.snp.makeConstraints { make in
            make.width.equalTo(self.snp.height)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


