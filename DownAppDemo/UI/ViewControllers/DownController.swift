//
//  ViewController.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 17.11.23.
//

import UIKit
import SnapKit

class DownController: BaseController {

    let presenter = CardsPresenter()
    
    let cellHeight = (2.5 / 4) * UIScreen.main.bounds.height
    private var isScrolling = false
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.layer.masksToBounds = false
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        return collectionView
    }()

    private lazy var topPicksView: UIView = {
        let v = TopPicksView()
        return v
    }()

    private lazy var buttonTryAgain: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitle("Try again", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.attach(this: self)
        
        self.view.backgroundColor = .black
        self.view.addSubview(topPicksView)
        self.view.addSubview(buttonTryAgain)
        self.view.addSubview(collectionView)
        
        topPicksView.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.left.equalToSuperview()
            make.height.equalTo(80)
        }
        
        buttonTryAgain.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topPicksView.snp.bottom)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    @objc private func tryAgain() {
        self.presenter.fetch()
    }
}

extension DownController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        cell.cardView.delegate = self
        if let item = self.presenter.item(at: indexPath) {
            cell.execOnCellForRow(cardItem: item)
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.numberOfItems
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? CardCell)?.execOnWillDisplay()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? CardCell)?.execOnEndDisplay()
    }
}

// ScrollView
extension DownController {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrolling = true
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { scrollViewDidEndScrolling(scrollView) }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrolling(scrollView)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndScrolling(scrollView)
    }

    func scrollViewDidEndScrolling(_ scrollView: UIScrollView) {
        isScrolling = false
    }
}

extension DownController: CardViewDelegate {
    func cardViewContainerIsScrolling() -> Bool {
        return self.isScrolling
    }
    
    func cardView(willDismissWith action: MatchType, at indexPath: IndexPath) {
        self.presenter.remove(at: indexPath)
    }
}

extension DownController: CardsPresenterView {
    func notifyError(message: String, okAction: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let alert = UIAlertController(title: "Error",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    func reloadView() {
        self.collectionView.isHidden = self.presenter.numberOfItems == 0
        self.buttonTryAgain.isHidden = self.presenter.numberOfItems > 0
        self.collectionView.reloadData()
    }
    
    func remove(at indexPath: IndexPath) {
        self.collectionView.deleteItems(at: [indexPath])
        self.reloadView()
    }
    
    func beginLoading() {
        
    }
    
    func endLoading() {
        
    }
}
