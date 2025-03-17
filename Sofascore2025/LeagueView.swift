import UIKit
import SnapKit
import SofaAcademic

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

		countryLabel.font = UIFont(name: "Roboto-Regular", size: 14)
		countryLabel.textColor = .black
		
		splitImageView.contentMode = .scaleAspectFit
		splitImageView.clipsToBounds = true
		splitImageView.image = UIImage(named: "ic_pointer_right")
		
		nameLabel.font = UIFont(name: "Roboto-Regular", size: 14)
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
		
		logoImageView.snp.makeConstraints {
			$0.top.equalToSuperview().inset(12)
			$0.width.height.equalTo(32)
			$0.leading.equalToSuperview().inset(16)
		}
		
		countryLabel.snp.makeConstraints {
			$0.centerY.equalTo(logoImageView)
			$0.leading.equalToSuperview().inset(80)
			$0.height.equalTo(24)
		}
		
		splitImageView.snp.makeConstraints {
			$0.centerY.equalTo(countryLabel)
			$0.leading.equalTo(countryLabel.snp.trailing)
			$0.height.equalTo(countryLabel)
		}
		
		nameLabel.snp.makeConstraints { 
			$0.centerY.equalTo(countryLabel)
			$0.leading.equalTo(splitImageView.snp.trailing)
			$0.height.equalTo(countryLabel)
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
