//
//  Styling.swift
//  Sofascore2025
//
//  Created by Ivan Dzanija on 17.03.2025..
//

import Foundation
import SnapKit
import UIKit

extension UIFont {
	static func custom(name: String, size: CGFloat) -> UIFont {
		UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
	}
	static let micro = custom(name: "Roboto-Regular", size: 12)
	static let small = custom(name: "Roboto-Regular", size: 14)
	static let medium = custom(name: "Roboto-Regular", size: 16)
	static let large = custom(name: "Roboto-Regular", size: 18)

	static let microBold = custom(name: "Roboto-Bold", size: 12)
	static let smallBold = custom(name: "Roboto-Bold", size: 14)
	static let mediumBold = custom(name: "Roboto-Bold", size: 16)
	static let largeBold = custom(name: "Roboto-Bold", size: 18)
}
