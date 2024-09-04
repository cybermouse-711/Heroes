//
//  DetailPresenter.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 03.09.24.
//

import Foundation

protocol DetailPresentionLogic {
    func presentDetail(response: Detail.ShowDetail.Response)
    func presentFavoriteStatus(response: Detail.SetFavoriteStatus.Response)
}

class DetailPresenter: DetailPresentionLogic {
    //Свойство через которые переходят данные во вью
    weak var viewController: DetailDisplayLogic?
    //Метод для передачи данных во вью через создание вьюмодели и передачи данных через ее инициализацию и свойство вью
    func presentDetail(response: Detail.ShowDetail.Response) {
        let fullname = "FullName: \(response.firstText ?? "No data")"
        let race = "Race: \(response.secondText ?? "No data")"
        
        let viewModel = Detail.ShowDetail.ViewModel(
            title: response.title ?? "No data",
            firstText: fullname,
            secondText: race,
            imageData: response.imageData ?? Data(),
            isFavorite: response.isFavorite
        )
        viewController?.displayDetail(viewModel: viewModel)
    }
    
    func presentFavoriteStatus(response: Detail.SetFavoriteStatus.Response) {
        let viewModel = Detail.SetFavoriteStatus.ViewModel(isFavorite: response.isFavorite)
        viewController?.displayFavoriteButtonStatus(viewModel: viewModel)
    }
}
