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
	static let micro =
		UIFont(name: "Roboto-Regular", size: 12)
		?? UIFont.systemFont(ofSize: 12)
	static let small =
		UIFont(name: "Roboto-Regular", size: 14)
		?? UIFont.systemFont(ofSize: 14)
	static let medium =
		UIFont(name: "Roboto-Regular", size: 16)
		?? UIFont.systemFont(ofSize: 16)
	static let large =
		UIFont(name: "Roboto-Regular", size: 18)
		?? UIFont.systemFont(ofSize: 18)

	static let microBold =
		UIFont(name: "Roboto-Bold", size: 12) ?? UIFont.systemFont(ofSize: 12)
	static let smallBold =
		UIFont(name: "Roboto-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14)
	static let mediumBold =
		UIFont(name: "Roboto-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16)
	static let largeBold =
		UIFont(name: "Roboto-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18)

}
