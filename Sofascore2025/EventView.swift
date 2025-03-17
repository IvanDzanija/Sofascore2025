import UIKit
import SnapKit
import SofaAcademic


class EventView: BaseView {
	private var _match : Event
	private var homeTeamImage = UIImageView()
	private var awayTeamImage = UIImageView()
	private var homeTeamName = UILabel()
	private var awayTeamName = UILabel()
	private var homeTeamScore = UILabel()
	private var awayTeamScore = UILabel()
	private var startTime = UILabel()
	private var clock = UILabel()
	private var splitLabel = UIImageView()
	
	init(match: Event) {
		self._match = match
		super.init()
	}
	override func addViews() {
		super.addViews()
		addSubview(clock)
		addSubview(startTime)
		addSubview(splitLabel)
		addSubview(homeTeamImage)
		addSubview(awayTeamImage)
		addSubview(homeTeamName)
		addSubview(awayTeamName)
		addSubview(homeTeamScore)
		addSubview(awayTeamScore)
	}

	override func styleViews() {
		super.styleViews()
		backgroundColor = .white
		
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm"

		startTime.text = formatter.string(from : Date(timeIntervalSince1970: TimeInterval(_match.startTimestamp)))
		
		homeTeamName.text = _match.homeTeam.name
		awayTeamName.text =  _match.awayTeam.name
		
		if let homeScore = _match.homeScore {
			homeTeamScore.text = String(homeScore)
		}
		if let awayScore = _match.awayScore {
			awayTeamScore.text = String(awayScore)
		}

		
		if let urlHome = _match.homeTeam.logoUrl, let url = URL(string: urlHome) {
			loadImage(from: url, isHome: true)
		}
		if let urlAway = _match.awayTeam.logoUrl, let url = URL(string: urlAway) {
			loadImage(from: url, isHome: false)
		}
		
		
//		clock styling -> only font is constant
//		clock.font = UIFont(name: "Roboto-Regular", size: 12)
		clock.textAlignment = .center
	
//		startTime styling
//		startTime.font = UIFont(name: "Roboto-Regular", size: 12)
		startTime.textColor = .gray
		startTime.textAlignment = .center
		
//		splitLabel styling
		splitLabel.image = UIImage(named: "Divider Horizontal")
		splitLabel.contentMode = .scaleAspectFit
		splitLabel.clipsToBounds = true
		
//		homeTeamImage styling
		homeTeamImage.contentMode = .scaleAspectFit
		homeTeamImage.clipsToBounds = true
		
//		awayTeamImage styling
		awayTeamImage.contentMode = .scaleAspectFit
		awayTeamImage.clipsToBounds = true
		
//		teamName styling -> only font is constant
//		homeTeamName.font = UIFont(name: "Roboto-Regular", size: 14)
//		awayTeamName.font = UIFont(name: "Roboto-Regular", size: 14)
		
//		score styling -> only font is constant
		homeTeamScore.font = UIFont(name: "Roboto-Regular", size: 14)
		awayTeamScore.font = UIFont(name: "Roboto-Regular", size: 14)
		
//		match didn't start yet
		if (self._match.status == .notStarted) {
			setupUpcomingStyle()
		}
		else if (self._match.status == .inProgress) {
			let elapsedTime = Int(Date().timeIntervalSince1970) - self._match.startTimestamp
			let minutes = elapsedTime / 60
			clock.text = String(minutes) + "'"
			setupInProgressStyle()
		}
		else if (self._match.status == .halftime) {
			setupHalftimeStyle()
		}
			
		else if (self._match.status == .finished) {
			setupFinishedStyle()
		}
		
	}

	override func setupConstraints() {
		super.setupConstraints()
		
//		startTime constraints
		startTime.snp.makeConstraints { current in
			current.top.equalToSuperview()
			current.width.equalTo(56)
//			current.leading.equalToSuperview().offset(8)
		}
		
//		clock constraints
		clock.snp.makeConstraints { current in
			current.centerX.equalTo(startTime.snp.centerX)
			current.top.equalTo(startTime.snp.bottom).offset(8)
//			current.leading.equalTo(startTime.snp.trailing).offset(8)
//			current.height.equalTo(16)
			current.width.equalTo(56)
		}
		
//		splitLabel constraints
		splitLabel.snp.makeConstraints { current in
			current.top.equalToSuperview().inset(8)
			current.leading.equalTo(startTime.snp.trailing).offset(4)
			current.height.equalTo(40)
			current.width.equalTo(1)
		}
		
//		homeTeamImage constraints
		homeTeamImage.snp.makeConstraints { current in
			current.leading.equalTo(clock.snp.trailing).offset(16)
			current.top.equalToSuperview().offset(8)
			current.width.height.equalTo(16)
		}
		
//		awayTeamImage constraints
		awayTeamImage.snp.makeConstraints { current in
			current.leading.equalTo(clock.snp.trailing).offset(16)
			current.top.equalTo(homeTeamImage.snp.bottom).offset(8)
			current.width.height.equalTo(16)
		}
			
//		homeTeamName constraints
		homeTeamName.snp.makeConstraints { current in
			current.leading.equalTo(homeTeamImage.snp.trailing).offset(8)
			current.centerY.equalTo(homeTeamImage.snp.centerY)
			current.height.equalTo(16)
			current.width.equalTo(128)
		}
		
//		awayTeamName constraints
		awayTeamName.snp.makeConstraints { current in
			current.leading.equalTo(awayTeamImage.snp.trailing).offset(8)
			current.centerY.equalTo(awayTeamImage.snp.centerY)
			current.height.equalTo(16)
			current.width.equalTo(128)
		}
		
//		homeTeamScore constraints
		homeTeamScore.snp.makeConstraints { current in
			current.leading.equalTo(homeTeamName.snp.trailing).offset(32)
			current.centerY.equalTo(homeTeamName.snp.centerY)
			current.height.equalTo(16)
			current.width.equalTo(32)
		}
		
//		awayTeamScore constraints
		awayTeamScore.snp.makeConstraints { current in
			current.leading.equalTo(awayTeamName.snp.trailing).offset(32)
			current.centerY.equalTo(awayTeamName.snp.centerY)
			current.height.equalTo(16)
			current.width.equalTo(32)
		}
		
		
	}
	
	private func setupUpcomingStyle() {
		homeTeamScore.isHidden = true
		awayTeamScore.isHidden = true
		
//		clock styling
		clock.textColor = .gray
		clock.text = "-"
		
//		homeTeamName styling
		homeTeamName.textColor = .black
		
//		awayTeamName styling
		awayTeamName.textColor = .black
	}
	
	private func setupInProgressStyle() {
		homeTeamScore.isHidden = false
		awayTeamScore.isHidden = false
		
//		clock styling
		clock.textColor = .red
		
//		homeTeamName styling
		homeTeamName.textColor = .black
		
//		awayTeamName styling
		awayTeamName.textColor = .black
		
//		homeTeamScore styling
		homeTeamScore.textColor = .red

//		awayTeamScore styling
		awayTeamScore.textColor = .red
	}
	
	private func setupHalftimeStyle() {
		homeTeamScore.isHidden = false
		awayTeamScore.isHidden = false
		
//		clock styling
		clock.textColor = .red
		clock.text = "HT"
		
//		homeTeamName styling
		homeTeamName.textColor = .black
		
//		awayTeamName styling
		awayTeamName.textColor = .black
		
//		homeTeamScore styling
		homeTeamScore.textColor = .red
		
//		awayTeamScore styling
		awayTeamScore.textColor = .red
	}
	
	private func setupFinishedStyle() {
		homeTeamScore.isHidden = false
		awayTeamScore.isHidden = false
		
//		clock styling
		clock.textColor = .gray
		clock.text = "FT"
	
//		teamName && teamScore styling
		if (_match.homeScore! > _match.awayScore!) {
			homeTeamName.textColor = .black
			homeTeamScore.textColor = .black
			awayTeamName.textColor = .gray
			awayTeamScore.textColor = .gray
			
		}
		else if (_match.homeScore! < _match.awayScore!) {
			homeTeamName.textColor = .gray
			homeTeamScore.textColor = .gray
			awayTeamName.textColor = .black
			awayTeamScore.textColor = .black
		}
		else {
			homeTeamName.textColor = .black
			homeTeamScore.textColor = .black
			awayTeamName.textColor = .black
			awayTeamScore.textColor = .black
		}
	}
	
	private func loadImage(from url: URL, isHome: Bool) {
			URLSession.shared.dataTask(with: url) { data, response, error in
				if let data = data, let image = UIImage(data: data) {
					DispatchQueue.main.async {
						if (isHome) {
							self.homeTeamImage.image = image
						}
						else {
							self.awayTeamImage.image = image
						}
						
					}
				}
			}.resume()
		}
		
}
