//
//  ColorExtensions.swift
//  Transactions
//
//  Created by Olsen Gungor on 3/12/2022.
//

import SwiftUI

// Based on https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values
extension Color {
    init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0)
   }
}

extension Color {

    
    /// Background colours
    static let accountDetailsBackground = Color(red: 146, green: 176, blue: 176)
    static let greyBackground = Color(red: 246, green: 246, blue: 246)
    static let sectionBackground = Color(red: 255, green: 204, blue: 0)

    /// Text colours
    static let greyText = Color(red: 138, green: 138, blue: 138)
    static let accountText = Color(red: 35, green: 31, blue: 32)

    
}
