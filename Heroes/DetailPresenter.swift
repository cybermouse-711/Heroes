//
//  DetailPresenter.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 02.09.24.
//

import Foundation

struct DetailDataStore {
    let title: String
    let firstText: String
    let secondText: String
    let imageData: Data?
    let isFavorite: Bool
}

class DetailPresenter: DetailViewControllerOutputProtocol {
    var interactor: DetailInteractorInputProtocol!
    private unowned let view: DetailViewControllerInputProtocol
    
    required init(view: DetailViewControllerInputProtocol) {
        self.view = view
    }
    
    func showDetail() {
        interactor.provideDetail()
    }
    
    func favoriteButtonPressed() {
        interactor.toggleFavoriteStatus()
    }
}

//MARK: - DetailInteractorOutputProtocol
extension DetailPresenter: DetailInteractorOutputProtocol {
    func receiveDetail(with dataStore: DetailDataStore) {
        let firstText = "FullName: \(dataStore.firstText)"
        let secondText = "Race: \(dataStore.secondText)"
        
        view.displayTitle(with: dataStore.title)
        view.displayFirstText(with: firstText)
        view.displaySecondText(with: secondText)
        view.displayImageForFavoriteStatus(with: dataStore.isFavorite)
        
        guard let imageData = dataStore.imageData else { return }
        view.displayImageData(with: imageData)
    }
    
    func receiveFavoriteStatus(with status: Bool) {
        view.displayImageForFavoriteStatus(with: status)
    }
}
