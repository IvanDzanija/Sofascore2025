//
//  Styling.swift
//  Sofascore2025
//
//  Created by Ivan Dzanija on 16.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

final class LeagueView: BaseView {
	private let league: League
	private let logoImageView = UIImageView()
	private let countryLabel = UILabel()
	private let splitImageView = UIImageView()
	private let nameLabel = UILabel()

	init(league: League) {
		self.league = league
		super.init()
	}

	override func addViews() {
		addSubview(logoImageView)
		addSubview(countryLabel)
		addSubview(splitImageView)
		addSubview(nameLabel)
	}

	override func styleViews() {
		backgroundColor = .white

		logoImageView.contentMode = .scaleAspectFit
		logoImageView.clipsToBounds = true

		countryLabel.font = .smallBold
		countryLabel.textColor = .black

		splitImageView.contentMode = .scaleAspectFit
		splitImageView.clipsToBounds = true
		splitImageView.image = UIImage(named: "ic_pointer_right")

		nameLabel.font = .small
		nameLabel.textColor = .gray

		if let urlLogo = league.logoUrl {
			ImageLoader.loadImage(from: urlLogo) { (image) in
				DispatchQueue.main.async {
					self.logoImageView.image = image
				}
			}
		}
		if let countryName = league.country?.name {
			countryLabel.text = countryName
		}
		nameLabel.text = league.name
	}

	override func setupConstraints() {
		super.setupConstraints()

		logoImageView.snp.makeConstraints {
			$0.top.bottom.equalToSuperview().inset(12)
			$0.leading.equalToSuperview().inset(16)
			$0.size.equalTo(32)
		}

		countryLabel.snp.makeConstraints {
			$0.centerY.equalTo(logoImageView)
			$0.leading.equalTo(logoImageView.snp.trailing).offset(32)
		}

		splitImageView.snp.makeConstraints {
			$0.centerY.equalTo(countryLabel)
			$0.leading.equalTo(countryLabel.snp.trailing)
			$0.size.equalTo(16)
		}

		nameLabel.snp.makeConstraints {
			$0.centerY.equalTo(countryLabel)
			$0.leading.equalTo(splitImageView.snp.trailing)
		}
	}
}
