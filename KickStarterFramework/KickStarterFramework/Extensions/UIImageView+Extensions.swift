//
//  UIImageView+Extensions.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/10/06.
//

import Foundation
import UIKit

@objc extension UIImageView {
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        self.image = UIImage(named: "logo")
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
