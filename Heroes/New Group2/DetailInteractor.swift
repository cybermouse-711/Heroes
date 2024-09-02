//
//  DetailInteractor.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 02.09.24.
//

import Foundation

protocol DetailInteractorInputProtocol {
    var isFavorite: Bool { get }
    init(presenter: DetailInteractorOutputProtocol, superhero: Superhero)
    func provideDetail()
    func toggleFavoriteStatus()
}

protocol DetailInteractorOutputProtocol: AnyObject {
    func receiveDetail(with dataStore: DetailDataStore)
    func receiveFavoriteStatus(with status: Bool)
}

class DetailInteractor: DetailInteractorInputProtocol {
    var isFavorite: Bool {
        get {
            DataManager.shared.getFavoriteStatus(for: superhero.id)
        } set {
            DataManager.shared.setFavoriteStatus(for: superhero.id, with: newValue)
        }
    }

    private unowned let presenter: DetailInteractorOutputProtocol
    private let superhero: Superhero
    
    required init(presenter: DetailInteractorOutputProtocol, superhero: Superhero) {
        self.presenter = presenter
        self.superhero = superhero
    }
    
    func provideDetail() {
        let imageData = NetworkManager.shared.fetchImageData(from: URL(string: superhero.images.lg))
        let dataStore = DetailDataStore(
            title: superhero.name,
            firstText: superhero.biography.fullName,
            secondText: superhero.appearance.race ?? "not race",
            imageData: imageData,
            isFavorite: isFavorite
        )
        presenter.receiveDetail(with: dataStore)
    }
    
    func toggleFavoriteStatus() {
        isFavorite.toggle()
        presenter.receiveFavoriteStatus(with: isFavorite)
    }
}
