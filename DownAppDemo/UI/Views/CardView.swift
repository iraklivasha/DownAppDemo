//
//  CardView.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 17.11.23.
//

import UIKit

protocol CardViewDelegate: AnyObject {
    func cardViewContainerIsScrolling() -> Bool
    func cardView(willDismissWith action: MatchType, at indexPath: IndexPath)
}

class CardView: UIControl {
    
    // Props
    weak var delegate: CardViewDelegate?
    private var initialPoint: CGPoint = CGPoint.zero
    private var isDragging = false
    private(set) var moveAlphaPoint = 0.0
    private(set) var action: MatchType = .date
    
    var cardItem: CardItem? {
        didSet {
            self.reload()
        }
    }
    
    // UI Props
    private(set) lazy var imageView: ImageView = {
        let v = ImageView()
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        return v
    }()
    
    private(set) lazy var labelName: UILabel = {
        let v = UILabel()
        v.font = UIFont.boldSystemFont(ofSize: 28)
        v.text = ""
        v.textColor = .white
        v.layer.shadowOffset = CGSize(width: -1.5, height: 0)
        v.layer.shadowRadius = 3
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.5
        return v
    }()
    
    private lazy var gesture: UIPanGestureRecognizer = {
        let sw = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        sw.delegate = self
        return sw
    }()
    
    private lazy var actionsContainer: CardActionsView = {
        return CardActionsView()
    }()
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        self.layer.borderWidth = 0.5
        self.addSubview(imageView)
        self.imageView.snp.makeConstraints { make in make.edges.equalToSuperview() }
        
        self.addSubview(actionsContainer)
        actionsContainer.snp.makeConstraints { make in
            make.bottom.right.equalTo(-16)
            make.left.equalTo(8)
            make.height.equalTo(100)
        }
        
        self.addSubview(labelName)
        labelName.snp.makeConstraints { make in
            make.bottom.equalTo(actionsContainer.snp.top).offset(-16)
            make.left.equalTo(12)
            make.right.equalTo(-8)
            make.height.equalTo(30)
        }
        
        self.addGestureRecognizer(gesture)
    }
    
    private func reload() {
        guard let cardItem = cardItem else {
            return
        }
        
        self.labelName.text = "\(cardItem.profile.name) • \(cardItem.profile.age)"
        self.imageView.setImageFromUrl(cardItem.profile.profilePicUrl)
    }
    
    func willDisplay() {}
    func willEndDisplay() {
        self.imageView.cancelLoad()
    }
    
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            self.isDragging = true
            self.initialPoint = self.center
            onStateChanged(sender: sender)
            break
        case .changed:
            onStateChanged(sender: sender)
            break
        case .ended:
            onStateEnded()
            break
        default:
            break
        }
    }
    
    private func onStateChanged(sender: UIPanGestureRecognizer) {
        
        guard let superview = self.superview, 
                let view = sender.view else {
            return
        }
        
        if let delegate = delegate {
            if delegate.cardViewContainerIsScrolling() {
                return
            }
        }
        
        let translation = sender.translation(in: superview)
        
        let newPos = CGPoint(x: view.center.x + translation.x,
                             y: view.center.y + translation.y)
        self.animateLabel(newPosY: newPos.y)
        
/* Enable this code if we need to give the card vertical boundaries
        if abs(newPos.y - self.initialPoint.y) >= (self.bounds.size.height / 2 - 40) {
            return
        }
*/
        self.center.y = newPos.y
        sender.setTranslation(.zero, in: self)
    }
    
    private func animateLabel(newPosY: CGFloat) {
        if newPosY > initialPoint.y {
            self.action = .down
        } else {
            self.action = .date
        }
        
        self.moveAlphaPoint = ((abs(newPosY - initialPoint.y) / initialPoint.y)) * 1.4
        self.sendActions(for: .valueChanged)
    }
    
    private func onStateEnded() {
        
        guard let superview = self.superview else {
            return
        }
        
        if abs(center.y - self.initialPoint.y) >= (self.bounds.size.height / 2 - 40) {
            
            guard let item = self.cardItem else {
                return
            }
            self.delegate?.cardView(willDismissWith: self.action, at: item.indexPath)
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            let timingFunction = CAMediaTimingFunction.init(controlPoints: 0.25, 0.85, 0.55, 1)
            CATransaction.begin()
            CATransaction.setAnimationTimingFunction(timingFunction)
            self.center.y = superview.center.y
            self.moveAlphaPoint = 0
            self.sendActions(for: .valueChanged)
            CATransaction.commit()
        }, completion: {(_) in
        })
        
        isDragging = false
    }
    
}

extension CardView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return !isDragging
    }
}
