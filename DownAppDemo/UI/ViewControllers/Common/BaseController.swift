//
//  BaseController.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import UIKit

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }
    
    func configureNavigationBar() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.black
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
            ]

            self.navigationController?.navigationBar.standardAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        } else {
            // Fallback on earlier versions
        }
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.rightBarButtonItems = self.rightBarButtons()
        self.navigationItem.leftItemsSupplementBackButton = true
        if #available(iOS 13.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.shadowColor = .clear
            navigationBarAppearance.backgroundColor = .black
            self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        } else {
            // Fallback on earlier versions
        }
        
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 4.0

        let titleImageView = self.navigationTitleView()
        stackView.addArrangedSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        
        navigationItem.titleView = stackView

        self.navigationItem.leftBarButtonItems = self.leftBarButtonItems()
    }
    
    
    func navigationTitleView() -> UIView {
        let titleImageView = UIImageView(image: UIImage(named: "Logo"))
        titleImageView.contentMode = .scaleAspectFit
        return titleImageView
    }
    
    func rightBarButtons() -> [UIBarButtonItem] {
        var result: [UIBarButtonItem] = []
        result.append(UIBarButtonItem(image: UIImage(named: "ic-location"),
                                      landscapeImagePhone: nil,
                                      style: .plain,
                                      target: self,
                                      action: nil))
        return result
    }
    
    func leftBarButtonItems() -> [UIBarButtonItem] {
        
        let circleView = CircleView()
        circleView.layer.borderColor = UIColor.white.cgColor
        circleView.layer.borderWidth = 1.5
        circleView.clipsToBounds = true
        let imageView = UIImageView(image: #imageLiteral(resourceName: "profile"))
        imageView.contentMode = .scaleAspectFill
        
        circleView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let appIcon = UIBarButtonItem(customView: circleView)
        appIcon.imageInsets = UIEdgeInsets(top: 8, left: -20, bottom: 0, right: 0)
        appIcon.customView?.translatesAutoresizingMaskIntoConstraints = false
        appIcon.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        appIcon.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true

        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -24;

        return [appIcon]
    }
}
