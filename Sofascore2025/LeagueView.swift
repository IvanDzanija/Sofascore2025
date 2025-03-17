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
//		addSubview(logoLabel)
		addSubview(countryLabel)
//		addSubview(splitLabel)
//		addSubview(nameLabel)
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
		nameLabel.font = UIFont(name: "Roboto-Regular",size: 14)
		nameLabel.textColor = .gray
		
			
		if let logoUrl = self.league.logoUrl, let url = URL(string: logoUrl) {
				loadImage(from: url)
		}
		if let countryName = self.league.country?.name {
			countryLabel.text = countryName
			print(countryLabel.text)
		}
		nameLabel.text = league.name

	}

	override func setupConstraints() {
		super.setupConstraints()
		
//		 logoLabel constraints
//		logoLabel.snp.makeConstraints { current in
//			current.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
//			current.width.height.equalTo(32)
//			current.leading.equalToSuperview().inset(16)
//		}
		
//		 countryLabel constraints
		countryLabel.snp.makeConstraints { current in
//			current.centerY.equalTo(logoLabel)
//			current.leading.equalTo(logoLabel.snp.right).offset(32)
			current.leading.equalToSuperview().inset(16)
			current.height.equalTo(24)
			current.width.equalTo(36)
		}
		
//		 splitLabel constraints
//		splitLabel.snp.makeConstraints { current in
//			current.centerY.equalTo(countryLabel)
//			current.leading.equalTo(countryLabel.snp.right).offset(16)
//			current.width.height.equalTo(16)
//		}
		
//		 nameLabel constraints
//		nameLabel.snp.makeConstraints { current in
//			current.centerY.equalTo(countryLabel)
//			current.leading.equalTo(splitLabel.snp.right).offset(10)
//			current.height.equalTo(countryLabel)
//			current.width.equalTo(90)
//		}
		
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
