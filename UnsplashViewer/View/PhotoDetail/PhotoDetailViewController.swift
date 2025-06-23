//
//  PhotoDetailViewController.swift
//  UnsplashViewer
//
//  Created by Даниил Павленко on 22.06.2025.
//

import UIKit
import Kingfisher

class PhotoDetailViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    //MARK: - Properties
    var photo: Photo?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupPhoto()
    }
    
    //MARK: - Private methods
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        title = photo?.user.username
        navigationController?.navigationBar.tintColor = .label
    }
    
    private func setupPhoto() {
        guard let urlStr = photo?.urls.regular, let url = URL(string: urlStr) else { return }
        
        loadingIndicatorView.startAnimating()
        
        imageView.kf.setImage(with: url, options: nil, progressBlock: nil) { [weak self] result in
            DispatchQueue.main.async {
                self?.loadingIndicatorView.stopAnimating()
                
                switch result {
                case .success:
                    break
                case .failure:
                    self?.presentRetryAlert {
                        self?.setupPhoto()
                    }
                }
            }
        }
    }
}
