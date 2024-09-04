//
//  DetailViewController.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 25.08.24.
//

import UIKit

protocol DetailDisplayLogic: AnyObject {
    func displayDetail(viewModel: Detail.ShowDetail.ViewModel)
    func displayFavoriteButtonStatus(viewModel: Detail.SetFavoriteStatus.ViewModel)
}

class DetailViewController: UIViewController {

    @IBOutlet var detailImage: UIImageView! {
        didSet {
            detailImage.layer.cornerRadius = 30
        }
    }
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    var interactor: DetailBusinessLogic?
    var router: (NSObjectProtocol & DetailRouterLogic & DetailDataPassing)?
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        DetailConfigurator.shared.configure(with: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        DetailConfigurator.shared.configure(with: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toggleFavorite() {
        interactor?.setFavoriteStatus()
    }
    
    private func passRequest() {
        interactor?.provideDetail()
    }
}

// MARK: - DetailDisplayLogic
extension DetailViewController: DetailDisplayLogic {
    //Метод по обработке данных от презентера и передачи в UI
    func displayDetail(viewModel: Detail.ShowDetail.ViewModel) {
        titleLabel.text = viewModel.title
        firstLabel.text = viewModel.firstText
        secondLabel.text = viewModel.secondText
        detailImage.image = UIImage(data: viewModel.imageData)
        favoriteButton.tintColor = viewModel.isFavorite ? .red : .gray
    }
    
    func displayFavoriteButtonStatus(viewModel: Detail.SetFavoriteStatus.ViewModel) {
        favoriteButton.tintColor = viewModel.isFavorite ? .red : .gray
    }
}
