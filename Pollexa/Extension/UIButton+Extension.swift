//
//  UIButton+Extension.swift
//  Pollexa
//
//  Created by Umut Yüksel on 12.06.2024.
//

import Foundation
import UIKit

extension UIButton {
    
    func makeCircular() {
        self.clipsToBounds = true
        self.layer.cornerRadius = min(self.frame.size.width, self.frame.size.height) / 2.0
    }
}


