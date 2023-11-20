//
//  CircleActionView.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import UIKit

enum CircleActionViewEnum {
    case textOnly
    case imageOnly
    case textAndImage
}

class CircleActionView: UIControl {
    
    var type: CircleActionViewEnum = .textAndImage {
        didSet {
            self.stackView.removeAllArrangedSubviews()
            switch type {
            case .imageOnly:
                stackView.addArrangedSubview(imageView)
                break
            case .textOnly:
                stackView.addArrangedSubview(label)
                break
            case .textAndImage:
                stackView.addArrangedSubview(imageView)
                stackView.addArrangedSubview(label)
                break
            }
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            self.imageView.tintColor = self.tintColor
        }
    }
    
    private lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.distribution = .fillEqually
        v.alignment = .center
        v.axis = .vertical
        v.spacing = 0
        v.addArrangedSubview(imageView)
        v.addArrangedSubview(label)
        return v
    }()
    
    private(set) lazy var imageView: ImageView = {
        let v = ImageView()
        v.image = UIImage(named: "ic-snapmatch")
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    private(set) lazy var label: UILabel = {
        let v = UILabel()
        v.font = UIFont.boldSystemFont(ofSize: 17)
        v.textAlignment = .center
        v.text = "Demo"
        v.textColor = .white
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = .black.withAlphaComponent(0.6)
        self.clipsToBounds = true
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.size.height / 2
    }
}
