//
//  Styling.swift
//  Sofascore2025
//
//  Created by Ivan Dzanija on 16.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class LeagueView: BaseView {

	private var logoImageView: UIImageView = UIImageView()
	private var countryLabel: UILabel = UILabel()
	private var splitImageView: UIImageView = UIImageView()
	private var nameLabel: UILabel = UILabel()
	private var league: League?

	public func loadData(league: League) {
		self.league = league
		configure()
	}

	private func configure() {
		splitImageView.image = UIImage(named: "ic_pointer_right")

		guard let league = league else { return }
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

		nameLabel.font = .small
		nameLabel.textColor = .gray
	}

	override func setupConstraints() {
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
			$0.trailing.lessThanOrEqualToSuperview().inset(16)
		}
	}
}
