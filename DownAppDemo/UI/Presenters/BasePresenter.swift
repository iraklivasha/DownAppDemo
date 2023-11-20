//
//  BasePresenter.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import Foundation

@objc protocol BasePresenterView: AnyObject {
    func notifyError(message: String, okAction: (() -> Void)?)
    func reloadView()
}

protocol Presenter: AnyObject {
    func attach(this view: BasePresenterView)
    func detach()
}

class BasePresenter<View> : NSObject, Presenter {
    
    private var firstLaunch = true
    weak var baseView: BasePresenterView?
    
    var view : View? {
        return self.baseView as? View
    }
    
    func attach(this view: BasePresenterView) {
        self.baseView = view
        
        if firstLaunch {
            firstLaunch = false
            onFirstViewAttach()
        }
    }
    
    func detach() {
        self.baseView = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    func onFirstViewAttach() { }
}
