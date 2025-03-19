//
//  LeagueViewModel.swift
//  Sofascore2025
//
//  Created by Ivan Dzanija on 17.03.2025..
//

import Foundation
import SofaAcademic
import UIKit

struct EventViewModel {
	public let homeTeam: Team
	public let awayTeam: Team
	public let status: EventStatus
	public let startTimestamp: Int
	public let homeScore: Int
	public let awayScore: Int
	public var homeColor: UIColor {
		switch status {
		case .finished:
			return homeScore >= awayScore ? UIColor.black : UIColor.gray
		case .notStarted:
			return .gray
		default:
			return .red
		}
	}

	public var awayColor: UIColor {
		switch status {
		case .finished:
			return awayScore >= homeScore ? UIColor.black : UIColor.gray
		case .notStarted:
			return .gray
		default:
			return .red
		}
	}

	public var clockAndScoreColor: UIColor {
		switch status {
		case .inProgress:
			return .red
		case .halftime:
			return .red
		default:
			return .gray
		}
	}

	public var time: String {
		switch self.status {
		case .notStarted:
			return "-"
		case .finished:
			return "FT"
		case .halftime:
			return "HT"
		default:
			let time = (Int(Date().timeIntervalSince1970) - startTimestamp) / 60
			return String(time) + "'"
		}
	}

	public var formattedStartTime: String {
		let date = Date(timeIntervalSince1970: TimeInterval(startTimestamp))
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm"
		return formatter.string(from: date)
	}

	init(event: Event) {
		self.homeTeam = event.homeTeam
		self.awayTeam = event.awayTeam
		self.status = event.status
		self.startTimestamp = event.startTimestamp
		self.homeScore = event.homeScore ?? 0
		self.awayScore = event.awayScore ?? 0
	}
}
