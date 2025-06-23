//
//  UnsplashApiService.swift
//  UnsplashViewer
//
//  Created by Даниил Павленко on 22.06.2025.
//

import Foundation
import Alamofire

class UnsplashAPIService {
    
    //MARK: - Properties
    private let baseURL = "https://api.unsplash.com/photos/"
    private let accessKey = "fv0XZYf-ObHZemdEPo9GzjuJZ-foGFlrE0K7JvnLr5g"
    
    //MARK: - Methods
    func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        let url = "\(baseURL)?client_id=\(accessKey)"

        AF.request(url).responseDecodable(of: [Photo].self) { response in
            switch response.result {
            case .success(let photos):
                completion(.success(photos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
