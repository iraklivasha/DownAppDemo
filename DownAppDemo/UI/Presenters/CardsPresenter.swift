//
//  CardsPresenter.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import Foundation
import Combine
import SDWebImage

protocol CardsPresenterView: BasePresenterView {
    func beginLoading()
    func endLoading()
    func remove(at indexPath: IndexPath)
}

// For advanced possible manipulation
class CardItem {
    
    private(set) var profile: Profile
    fileprivate(set) var indexPath: IndexPath
    
    init(profile: Profile, indexPath: IndexPath) {
        self.profile = profile
        self.indexPath = indexPath
    }
}

class CardsPresenter: BasePresenter<CardsPresenterView> {
    
    private(set) var items: [CardItem] = []
    
    private let api: ProfilesAPIProtocol
    private var subscription: AnyCancellable?
    
    init(api: ProfilesAPIProtocol = ProfilesAPI()) {
        self.api = api
    }

    override func onFirstViewAttach() {
        super.onFirstViewAttach()
        self.fetch()
    }
    
    func fetch() {
        self.view?.beginLoading()
        subscription = self.api.fetch()
        .task
        .sink(receiveCompletion: { completion in
            
            self.view?.endLoading()
            
            switch completion {
            case .finished:
                debugPrint("Profiles fetched")
                break
            case .failure(let e):
                debugPrint("Error: \(e)")
                self.view?.notifyError(message: "Error: \(e)", okAction: nil)
                break
            }
            
        }, receiveValue: { [weak self] result in
            
            self?.items = result.enumerated().map { (index, element) in
                return CardItem(profile: element, indexPath: IndexPath(row: index, section: 0))
            }

            self?.view?.reloadView()
        })
    }
    
    var numberOfItems: Int {
        return self.items.count
    }
    
    func item(at indexPath: IndexPath) -> CardItem? {
        guard indexPath.row < numberOfItems else {
            return nil
        }
        
        self.prefetchPhotos(for: indexPath)
        return items[indexPath.row]
    }
    
    private func prefetchPhotos(for indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            var idx = indexPath.row
            var count = 0
            let prefetchTotal = 5
            var urls: [URL] = []
            while idx < numberOfItems && count < prefetchTotal {
                let it = items[idx]
                if let url = URL(string: it.profile.profilePicUrl) {
                    urls.append(url)
                }
                idx += 1
                count += 1
            }
            
            SDWebImagePrefetcher.shared.prefetchURLs(urls)
        }
    }
    
    func remove(at indexPath: IndexPath) {
        guard indexPath.row < self.numberOfItems else {
            return
        }
        
        self.items.remove(at: indexPath.row)
        self.items.enumerated().forEach { index, item in
            item.indexPath = IndexPath(row: index, section: 0)
        }
        self.view?.remove(at: indexPath)
    }
}
