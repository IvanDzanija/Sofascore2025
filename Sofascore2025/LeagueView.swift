import UIKit
import SnapKit
import SofaAcademic

class LeagueView: BaseView {
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
		super.addViews()
		addSubview(logoImageView)
		addSubview(countryLabel)
		addSubview(splitImageView)
		addSubview(nameLabel)
	}

	override func styleViews() {
		super.styleViews()
		backgroundColor = .white
		
//		logoLabel styling
		logoImageView.contentMode = .scaleAspectFit
		logoImageView.clipsToBounds = true

//		countryLabel styling
		countryLabel.font = UIFont(name: "Roboto-Regular", size: 14)
//		countryLabel.adjustsFontSizeToFitWidth = true
		countryLabel.textColor = .black
		
//		splitLabel styling
		splitImageView.contentMode = .scaleAspectFit
		splitImageView.clipsToBounds = true
		splitImageView.image = UIImage(named: "ic_pointer_right")
		
//		nameLabel styling
		nameLabel.font = UIFont(name: "Roboto-Regular", size: 14)
//		countryLabel.adjustsFontSizeToFitWidth = true
		nameLabel.textColor = .gray
		
			
		if let logoUrl = self.league.logoUrl, let url = URL(string: logoUrl) {
				loadImage(from: url)
		}
		if let countryName = self.league.country?.name {
			countryLabel.text = countryName
		}
		nameLabel.text = league.name

	}

	override func setupConstraints() {
		super.setupConstraints()
		
//		 logoLabel constraints
		logoImageView.snp.makeConstraints { current in
			current.top.equalToSuperview().inset(12)
			current.width.height.equalTo(32)
			current.leading.equalToSuperview().inset(16)
		}
		
//		 countryLabel constraints
		countryLabel.snp.makeConstraints { current in
			current.centerY.equalTo(logoImageView)
			current.leading.equalToSuperview().inset(80)
			current.height.equalTo(24)
		}
		
//		 splitLabel constraints
		splitImageView.snp.makeConstraints { current in
			current.centerY.equalTo(countryLabel)
			current.leading.equalTo(countryLabel.snp.trailing)
			current.height.equalTo(countryLabel)
		}
		
//		 nameLabel constraints
		nameLabel.snp.makeConstraints { current in
			current.centerY.equalTo(countryLabel)
			current.leading.equalTo(splitImageView.snp.trailing)
			current.height.equalTo(countryLabel)
		}
		
	}
	private func loadImage(from url: URL) {
			URLSession.shared.dataTask(with: url) { data, response, error in
				if let data = data, let image = UIImage(data: data) {
					DispatchQueue.main.async {
						self.logoImageView.image = image
					}
				}
			}.resume()
		}

	
}
