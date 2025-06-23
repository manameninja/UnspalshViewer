//
//  PhotoListViewModel.swift
//  UnsplashViewer
//
//  Created by Даниил Павленко on 22.06.2025.
//

class PhotoListViewModel {
    
    //MARK: - Properties
    private let apiService = UnsplashAPIService()
    var photos: [Photo] = []
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    var isLoading: ((Bool) -> Void)?
    
    //MARK: - Methods
    func fetchPhotos() {
        isLoading?(true)
        
        apiService.fetchPhotos { [weak self] result in
            switch result {
            case .success(let photos):
                self?.isLoading?(false)
                self?.photos = photos
                self?.onUpdate?()
            case .failure(let error):
                self?.isLoading?(false)
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
