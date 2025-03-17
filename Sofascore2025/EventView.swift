//
//  Styling.swift
//  Sofascore2025
//
//  Created by Ivan Dzanija on 16.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic


class EventView: BaseView {
	private let event : Event
	private let homeTeamImageView = UIImageView()
	private let awayTeamImageView = UIImageView()
	private let homeTeamNameLabel = UILabel()
	private let awayTeamNameLabel = UILabel()
	private let homeTeamScoreLabel = UILabel()
	private let awayTeamScoreLabel = UILabel()
	private let startTimeLabel = UILabel()
	private let clockLabel = UILabel()
	private let splitView = UIView()
	
	init(event: Event) {
		self.event = event
		super.init()
	}
	
	override func addViews() {
		addSubview(clockLabel)
		addSubview(startTimeLabel)
		addSubview(splitView)
		addSubview(homeTeamImageView)
		addSubview(awayTeamImageView)
		addSubview(homeTeamNameLabel)
		addSubview(awayTeamNameLabel)
		addSubview(homeTeamScoreLabel)
		addSubview(awayTeamScoreLabel)
	}

	override func styleViews() {
		backgroundColor = .white
		
		if let homeScore = event.homeScore {
			homeTeamScoreLabel.text = String(homeScore)
		}
		if let awayScore = event.awayScore {
			awayTeamScoreLabel.text = String(awayScore)
		}
		
		if let urlHome = event.homeTeam.logoUrl {
			ImageLoader.loadImage(from: urlHome){
				self.homeTeamImageView.image = $0
			}
		}
		if let urlAway = event.homeTeam.logoUrl {
			ImageLoader.loadImage(from: urlAway){
				self.awayTeamImageView.image = $0
			}
		}
		
		let colors = event.findColors()
		
		splitView.backgroundColor = .gray
		
		clockLabel.font = FontStyle.micro
		clockLabel.textAlignment = .center
		clockLabel.text = event.time
		clockLabel.textColor = colors.2
	
		startTimeLabel.text = event.formattedStartTime
		startTimeLabel.font = FontStyle.micro
		startTimeLabel.textColor = .gray
		startTimeLabel.textAlignment = .center
		
		homeTeamImageView.contentMode = .scaleAspectFit
		homeTeamImageView.clipsToBounds = true
		awayTeamImageView.contentMode = .scaleAspectFit
		awayTeamImageView.clipsToBounds = true
		
		homeTeamNameLabel.text = event.homeTeam.name
		awayTeamNameLabel.text =  event.awayTeam.name
		homeTeamNameLabel.font = FontStyle.small
		awayTeamNameLabel.font = FontStyle.small
		homeTeamNameLabel.textColor = colors.0
		awayTeamNameLabel.textColor = colors.1
		
		
		homeTeamScoreLabel.font = FontStyle.small
		awayTeamScoreLabel.font = FontStyle.small
		homeTeamScoreLabel.textColor = colors.0
		awayTeamScoreLabel.textColor = colors.1

	}

	override func setupConstraints() {
		startTimeLabel.snp.makeConstraints {
			$0.top.equalToSuperview().inset(10)
			$0.leading.equalToSuperview().inset(16)
		}
		
		clockLabel.snp.makeConstraints {
			$0.centerX.equalTo(startTimeLabel.snp.centerX)
			$0.top.equalTo(startTimeLabel.snp.bottom).offset(4)
		}
		
		splitView.snp.makeConstraints {
			$0.top.equalToSuperview().inset(8)
			$0.leading.equalTo(startTimeLabel.snp.trailing).offset(16)
			$0.height.equalTo(40)
			$0.width.equalTo(1)
		}
		
		homeTeamImageView.snp.makeConstraints {
			$0.leading.equalTo(splitView.snp.trailing).offset(16)
			$0.centerY.equalTo(startTimeLabel.snp.centerY)
			$0.size.equalTo(16)
		}
	
		awayTeamImageView.snp.makeConstraints {
			$0.leading.equalTo(splitView.snp.trailing).offset(16)
			$0.centerY.equalTo(clockLabel.snp.centerY)
			$0.size.equalTo(16)
		}
		
		homeTeamNameLabel.snp.makeConstraints {
			$0.leading.equalTo(homeTeamImageView.snp.trailing).offset(8)
			$0.centerY.equalTo(homeTeamImageView.snp.centerY)
		}
		
		awayTeamNameLabel.snp.makeConstraints {
			$0.leading.equalTo(awayTeamImageView.snp.trailing).offset(8)
			$0.centerY.equalTo(awayTeamImageView.snp.centerY)
		}
		
		homeTeamScoreLabel.snp.makeConstraints {
			$0.trailing.equalToSuperview().offset(-16)
			$0.centerY.equalTo(homeTeamNameLabel.snp.centerY)
		}
		
		awayTeamScoreLabel.snp.makeConstraints {
			$0.trailing.equalToSuperview().offset(-16)
			$0.centerY.equalTo(awayTeamNameLabel.snp.centerY)
		}
	}
}
