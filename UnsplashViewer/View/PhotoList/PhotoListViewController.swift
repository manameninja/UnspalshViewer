//
//  PhotoListViewController.swift
//  UnsplashViewer
//
//  Created by Даниил Павленко on 22.06.2025.
//

import UIKit

class PhotoListViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    //MARK: - Properties
    let viewModel = PhotoListViewModel()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
        bindViewModel()
        viewModel.fetchPhotos()
    }
    
    //MARK: - Private methods
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = "Список фото"
    }
    
    private func bindViewModel() {
        viewModel.isLoading = { [weak self] loading in
            DispatchQueue.main.async {
                loading ? self?.loadingIndicatorView.startAnimating() : self?.loadingIndicatorView.stopAnimating()
                self?.collectionView.isHidden = loading
            }
        }
        
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                print("Запрос закончился ошибкой: \(errorMessage)")
                self?.presentRetryAlert {
                    self?.viewModel.fetchPhotos()
                }
            }
        }
        
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            UINib(nibName: "PhotoCell", bundle: nil),
            forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension PhotoListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = viewModel.photos[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: photo)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 16
        let sectionInset: CGFloat = 16
        let itemsPerRow: CGFloat = 2
        
        let totalSpacing = (itemsPerRow - 1) * spacing + sectionInset * 2
        let width = (collectionView.bounds.width - totalSpacing) / itemsPerRow
        
        return CGSize(width: width, height: width + 80)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "Список фото"
        navigationItem.backBarButtonItem = backItem
        
        let photo = viewModel.photos[indexPath.item]
        let detailVC = PhotoDetailViewController(nibName: "PhotoDetailViewController", bundle: nil)
        detailVC.photo = photo
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: { _ in
            self.collectionView.reloadData()
        })
    }
}
