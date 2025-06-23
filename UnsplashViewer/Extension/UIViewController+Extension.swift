//
//  Extension+UIColor.swift
//  UnsplashViewer
//
//  Created by Даниил Павленко on 22.06.2025.
//

import UIKit

//MARK: - UIViewController
extension UIViewController {
    func presentRetryAlert(
        title: String = "Ошибка",
        message: String = "Что-то пошло не так. Попробуйте позже.",
        retryActionTitle: String = "Повторить",
        cancelActionTitle: String = "Отмена",
        onRetry: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: retryActionTitle, style: .default) { _ in
            onRetry()
        })
        
        alert.addAction(UIAlertAction(title: cancelActionTitle, style: .cancel))
        
        present(alert, animated: true)
    }
}
