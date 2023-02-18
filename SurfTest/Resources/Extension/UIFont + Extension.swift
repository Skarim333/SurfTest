//
//  UIFont + Extension.swift
//  SurfTest
//
//  Created by Карим Садыков on 13.02.2023.
//

import UIKit

extension UIFont {
    static func sfProDisplayBold(size: CGFloat) -> UIFont {
        UIFont(name: "SFProDisplay-Bold", size: size) ?? UIFont.systemFont(ofSize: 24)
    }

    static func sfProDisplayMedium(size: CGFloat) -> UIFont {
        UIFont(name: "SFProDisplay-Medium", size: size) ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func sfProDisplayRegular(size: CGFloat) -> UIFont {
        UIFont(name: "SFProDisplay-Regular", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
}
