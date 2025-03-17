import UIKit
import SnapKit
import SofaAcademic

class LeagueView: BaseView {
	private var league: League
	private var logoLabel = UIImageView()
	private var countryLabel = UILabel()
	private var splitLabel = UIImageView()
	private var nameLabel = UILabel()
	
	init(league: League) {
		self.league = league
		super.init()
	}
	override func addViews() {
		super.addViews()
		addSubview(logoLabel)
		addSubview(countryLabel)
		addSubview(splitLabel)
		addSubview(nameLabel)
	}

	override func styleViews() {
		super.styleViews()
		backgroundColor = .white
		
//		logoLabel styling
		logoLabel.contentMode = .scaleAspectFit
		logoLabel.clipsToBounds = true

//		countryLabel styling
//		countryLabel.font = UIFont(name: "Roboto-Regular", size: 14)
		countryLabel.textColor = .black
		
//		splitLabel styling
		splitLabel.contentMode = .scaleAspectFit
		splitLabel.clipsToBounds = true
		splitLabel.image = UIImage(named: "ic_pointer_right")
		
//		nameLabel styling
//		nameLabel.font = UIFont(name: "Roboto-Regular",size: 14)
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
		logoLabel.snp.makeConstraints { current in
			current.top.equalToSuperview().inset(16)
			current.width.height.equalTo(32)
			current.leading.equalToSuperview().inset(20)
		}
		
//		 countryLabel constraints
		countryLabel.snp.makeConstraints { current in
			current.centerY.equalTo(logoLabel)
			current.leading.equalToSuperview().inset(60)
			current.height.equalTo(24)
		}
		
//		 splitLabel constraints
		splitLabel.snp.makeConstraints { current in
			current.centerY.equalTo(countryLabel)
			current.leading.equalToSuperview().offset(100)
			current.height.equalTo(24)
		}
		
//		 nameLabel constraints
		nameLabel.snp.makeConstraints { current in
			current.centerY.equalTo(countryLabel)
			current.leading.equalToSuperview().inset(130)
			current.height.equalTo(countryLabel)
		}
		
	}
	private func loadImage(from url: URL) {
			URLSession.shared.dataTask(with: url) { data, response, error in
				if let data = data, let image = UIImage(data: data) {
					DispatchQueue.main.async {
						self.logoLabel.image = image
					}
				}
			}.resume()
		}

	
}
