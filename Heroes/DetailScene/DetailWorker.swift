//
//  DetailWorker.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 03.09.24.
//

import Foundation

class DetailWorker {
    //Провайдер для передачи методов по работе с сервисным слоем в интерактор
    func getImage(from imageURL: URL?) -> Data? {
        NetworkManager.shared.fetchImageData(from: imageURL)
    }
    
    //Провайдер для запроса состояния кнопки из БД
    func getFavoriteStatus(for superheroId: Int) -> Bool {
        DataManager.shared.getFavoriteStatus(for: superheroId)
    }
    
    //Провайдер для обновления состояния кнопки из БД
    func setFavoriteStatus(for superheroId: Int, and status: Bool) {
        DataManager.shared.setFavoriteStatus(for: superheroId, with: status)
    }
}
