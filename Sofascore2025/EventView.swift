//
//  Styling.swift
//  Sofascore2025
//
//  Created by Ivan Dzanija on 16.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class EventView: BaseView {
	private let eventViewModel: EventViewModel
	private let homeTeamImageView = UIImageView()
	private let awayTeamImageView = UIImageView()
	private let homeTeamNameLabel = UILabel()
	private let awayTeamNameLabel = UILabel()
	private let homeTeamScoreLabel = UILabel()
	private let awayTeamScoreLabel = UILabel()
	private let startTimeLabel = UILabel()
	private let clockLabel = UILabel()
	private let splitView = UIView()

	init(eventViewModel: EventViewModel) {
		self.eventViewModel = eventViewModel
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

		homeTeamScoreLabel.text = String(eventViewModel.homeScore)
		awayTeamScoreLabel.text = String(eventViewModel.awayScore)

		if let urlHome = eventViewModel.homeTeam.logoUrl {
			ImageLoader.loadImage(from: urlHome) { (image) in
				DispatchQueue.main.async {
					self.homeTeamImageView.image = image
				}
			}
		}

		if let urlAway = eventViewModel.awayTeam.logoUrl {
			ImageLoader.loadImage(from: urlAway) { (image) in
				DispatchQueue.main.async {
					self.awayTeamImageView.image = image
				}
			}
		}

		let colors = eventViewModel.modelColors

		splitView.backgroundColor = .gray

		clockLabel.font = .micro
		clockLabel.textAlignment = .center
		clockLabel.text = eventViewModel.time
		clockLabel.textColor = colors.2

		startTimeLabel.text = eventViewModel.formattedStartTime
		startTimeLabel.font = .micro
		startTimeLabel.textColor = .gray
		startTimeLabel.textAlignment = .center

		homeTeamImageView.contentMode = .scaleAspectFit
		homeTeamImageView.clipsToBounds = true
		awayTeamImageView.contentMode = .scaleAspectFit
		awayTeamImageView.clipsToBounds = true

		homeTeamNameLabel.text = eventViewModel.homeTeam.name
		awayTeamNameLabel.text = eventViewModel.awayTeam.name
		homeTeamNameLabel.font = .small
		awayTeamNameLabel.font = .small
		homeTeamNameLabel.textColor = colors.0
		awayTeamNameLabel.textColor = colors.1

		homeTeamScoreLabel.font = .small
		awayTeamScoreLabel.font = .small
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
			$0.bottom.equalToSuperview()
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
			$0.bottom.equalToSuperview()
		}

		homeTeamNameLabel.snp.makeConstraints {
			$0.leading.equalTo(homeTeamImageView.snp.trailing).offset(8)
			$0.centerY.equalTo(homeTeamImageView)
		}

		awayTeamNameLabel.snp.makeConstraints {
			$0.leading.equalTo(awayTeamImageView.snp.trailing).offset(8)
			$0.centerY.equalTo(awayTeamImageView.snp.centerY)
			$0.bottom.equalToSuperview()
		}

		homeTeamScoreLabel.snp.makeConstraints {
			$0.trailing.equalToSuperview().inset(16)
			$0.centerY.equalTo(homeTeamNameLabel.snp.centerY)
		}

		awayTeamScoreLabel.snp.makeConstraints {
			$0.trailing.equalToSuperview().offset(-16)
			$0.centerY.equalTo(awayTeamNameLabel.snp.centerY)
			$0.bottom.equalToSuperview()
		}
	}
}
