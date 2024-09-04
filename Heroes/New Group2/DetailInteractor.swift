//
//  DetailInteractor.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 03.09.24.
//

import Foundation

protocol DetailBusinessLogic {
    func setFavoriteStatus()
    func provideDetail()
}

//Протокол при помощи которого интерактор собирает данные и передает в презентер и который отвечает за состояние сцены
protocol DetailDataStore {
    var superhero: Superhero? { get set }
    var isFavorite: Bool { get set }
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore {
    var superhero: Superhero?
    var presenter: DetailPresentionLogic?
    var worker: DetailWorker?
    var isFavorite: Bool = false
    
    func provideDetail() {
        //Инициализация провайдера и работа с сервисным слоем
        worker = DetailWorker()
        isFavorite = worker?.getFavoriteStatus(for: superhero?.id ?? 0) ?? false
        let imageData = worker?.getImage(from: URL(string: superhero?.images.lg ?? ""))
        
        //Передача данных в презентер через создание ответа и его передачи в метод презентера
        let response = Detail.ShowDetail.Response(
            title: superhero?.name,
            firstText: superhero?.biography.fullName,
            secondText: superhero?.appearance.race,
            imageData: imageData,
            isFavorite: isFavorite
        )
        presenter?.presentDetail(response: response)
    }
    
    func setFavoriteStatus() {
        isFavorite.toggle()
        worker?.setFavoriteStatus(for: superhero?.id ?? 0, and: isFavorite)
        
        let response = Detail.SetFavoriteStatus.Response(isFavorite: isFavorite)
        presenter?.presentFavoriteStatus(response: response)
    }
}
