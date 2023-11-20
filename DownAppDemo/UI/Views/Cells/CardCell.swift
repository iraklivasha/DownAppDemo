//
//  CardCell.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 17.11.23.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    private(set) lazy var cardView: CardView = {
        let view = CardView()
        view.addTarget(self, action: #selector(cardMoved(sender:)), for: .valueChanged)
        return view
    }()
    
    private lazy var labelDownDate: DownOrDateView = {
        let l = DownOrDateView()
        l.alpha = 0
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(cardView)
        
        self.layer.masksToBounds = false
        
        cardView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        self.addSubview(labelDownDate)
        labelDownDate.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(64)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func execOnCellForRow(cardItem: CardItem) {
        self.cardView.cardItem = cardItem
    }
    
    func execOnWillDisplay() {
        self.cardView.willDisplay()
    }
    
    func execOnEndDisplay() {
        self.cardView.willEndDisplay()
    }
    
    @objc private func cardMoved(sender: CardView) {
        self.labelDownDate.labelDownDate.textColor = sender.action.color
        self.labelDownDate.alpha = sender.moveAlphaPoint
        self.labelDownDate.imageView.image = sender.action.icon
        self.labelDownDate.imageView.tintColor = sender.action.color
        self.labelDownDate.labelDownDate.text = sender.action.title
    }
}
