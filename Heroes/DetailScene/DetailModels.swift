//
//  DetailModels.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 03.09.24.
//

import Foundation

enum Detail {
    //MARK: Use case 
    //(отвечает за отображение всей модели)
    enum ShowDetail {
        //Передача запроса от вью интерактору
        struct Request {}
        
        //Передача ответа от интерактора презентору
        struct Response {
            let title: String?
            let firstText: String?
            let secondText: String?
            let imageData: Data?
            let isFavorite: Bool
        }
        
        //Передача данных от презентора вью
        struct ViewModel {
            let title: String
            let firstText: String
            let secondText: String
            let imageData: Data
            let isFavorite: Bool
        }
    }
    
    //MARK: Use case (отвечает за отображение кнопки)
    enum SetFavoriteStatus {
        //Передача ответа от интерактора презентору
        struct Response {
            let isFavorite: Bool
        }
        
        //Передача данных от презентора вью
        struct ViewModel {
            let isFavorite: Bool
        }
    }
}
