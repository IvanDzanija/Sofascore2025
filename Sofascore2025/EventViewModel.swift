//
//  LeagueViewModel.swift
//  Sofascore2025
//
//  Created by Ivan Dzanija on 17.03.2025..
//

import Foundation
import SofaAcademic
import UIKit

protocol EventViewModelProtocol {
	var title: String { get }
	var subtitle: String { get }
	var imageURL: String { get }
	func fetchData()
}

public extension Event {
	var time : String {
		if self.status == .notStarted{
			return "-"
		}
		else if self.status == .finished{
			return "FT"
		}
		else if self.status == .halftime{
			return "HT"
		}
		else{
			let timer = (Int(Date().timeIntervalSince1970) - self.startTimestamp) / 60
			return String(timer) + "'"
		}
		
	}
	
	var formattedStartTime: String {
		let date = Date(timeIntervalSince1970: TimeInterval(startTimestamp))
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm"
		return formatter.string(from: date)
	}
	
	func findColors() -> (UIColor, UIColor, UIColor) {
		if self.status == .finished{
			let homeTeamScore = self.homeScore ?? 0
			let awayTeamScore = self.awayScore ?? 0
			if homeTeamScore > awayTeamScore{
				return (.black, .gray, .gray)
			}
			else if homeTeamScore < awayTeamScore{
				return (.gray, .black, .gray)
			}
			else{
				return (.black, .black, .gray)
			}
		}else if self.status == .notStarted{
			return (.gray, .gray, .gray)
		}
		else{
			return (.red, .red, .red)
		}
	}
		
			
	
		
	
	
}
	
	
