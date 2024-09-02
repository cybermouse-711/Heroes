//
//  DetailViewController.swift
//  Heroes
//
//  Created by Elizaveta Medvedeva on 25.08.24.
//

import UIKit

protocol DetailViewControllerInputProtocol: AnyObject {
    func displayTitle(with title: String)
    func displayFirstText(with title: String)
    func displaySecondText(with title: String)
    func displayImageData(with data: Data)
    func displayImageForFavoriteStatus(with status: Bool)
}

protocol DetailViewControllerOutputProtocol {
    init(view: DetailViewControllerInputProtocol)
    func showDetail()
    func favoriteButtonPressed()
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
    
    var presenter: DetailViewControllerOutputProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showDetail()
    }
    
    @IBAction func toggleFavorite() {
        presenter.favoriteButtonPressed()
    }
}

//MARK: - DetailViewControllerInputProtocol
extension DetailViewController: DetailViewControllerInputProtocol {
    func displayTitle(with title: String) {
        titleLabel.text = title
    }
    
    func displayFirstText(with title: String) {
        firstLabel.text = title
    }
    
    func displaySecondText(with title: String) {
        secondLabel.text = title
    }
    
    func displayImageData(with data: Data) {
        detailImage.image = UIImage(data: data)
    }
    
    func displayImageForFavoriteStatus(with status: Bool) {
        favoriteButton.tintColor = status ? .red : .gray
    }
}
