import UIKit
import SnapKit
import SofaAcademic


class EventView: BaseView {
	private let event : Event
	private let homeTeamImageView = UIImageView()
	private let awayTeamImageView = UIImageView()
	private let homeTeamNameLabel = UILabel()
	private let awayTeamNameLabel = UILabel()
	private let Label = UILabel()
	private let awayTeamScore = UILabel()
	private let startTime = UILabel()
	private let clock = UILabel()
	private let splitLabel = UIImageView()
	
	init(event: Event) {
		self.event = event
		super.init()
	}
	
	override func addViews() {
		super.addViews()
		addSubview(clock)
		addSubview(startTime)
		addSubview(splitLabel)
		addSubview(homeTeamImageView)
		addSubview(awayTeamImageView)
		addSubview(homeTeamNameLabel)
		addSubview(awayTeamNameLabel)
		addSubview(Label)
		addSubview(awayTeamScore)
	}

	override func styleViews() {
		super.styleViews()
		backgroundColor = .white
		
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm"

		startTime.text = formatter.string(from : Date(timeIntervalSince1970: TimeInterval(event.startTimestamp)))
		
		homeTeamNameLabel.text = event.homeTeam.name
		awayTeamNameLabel.text =  event.awayTeam.name
		
		if let homeScore = event.homeScore {
			Label.text = String(homeScore)
		}
		if let awayScore = event.awayScore {
			awayTeamScore.text = String(awayScore)
		}
		
		if let urlHome = event.homeTeam.logoUrl, let url = URL(string: urlHome) {
			loadImage(from: url, isHome: true)
		}
		if let urlAway = event.awayTeam.logoUrl, let url = URL(string: urlAway) {
			loadImage(from: url, isHome: false)
		}
		
//		clock styling
		clock.font = UIFont(name: "Roboto-Regular", size: 12)
		clock.textAlignment = .center
	
//		startTime styling
		startTime.font = UIFont(name: "Roboto-Regular", size: 12)
		startTime.textColor = .gray
		startTime.textAlignment = .center
		
//		splitLabel styling
		splitLabel.image = UIImage(named: "Divider Horizontal")
		splitLabel.contentMode = .scaleAspectFit
		splitLabel.clipsToBounds = true
		
//		homeTeamImage styling
		homeTeamImageView.contentMode = .scaleAspectFit
		homeTeamImageView.clipsToBounds = true
		
//		awayTeamImage styling
		awayTeamImageView.contentMode = .scaleAspectFit
		awayTeamImageView.clipsToBounds = true
		
//		teamName styling
		homeTeamNameLabel.font = UIFont(name: "Roboto-Regular", size: 14)
		awayTeamNameLabel.font = UIFont(name: "Roboto-Regular", size: 14)
		
//		score styling
		Label.font = UIFont(name: "Roboto-Regular", size: 14)
		awayTeamScore.font = UIFont(name: "Roboto-Regular", size: 14)
		
//		match didn't start yet
		if (self.event.status == .notStarted) {
			setupUpcomingStyle()
		}
		else if (self.event.status == .inProgress) {
			let timer = (Int(Date().timeIntervalSince1970) - self.event.startTimestamp) / 60
			clock.text = String(timer) + "'"
			setupInProgressStyle()
		}
		else if (self.event.status == .halftime) {
			setupHalftimeStyle()
		}
			
		else if (self.event.status == .finished) {
			setupFinishedStyle()
		}
	}

	override func setupConstraints() {
		super.setupConstraints()
		
//		startTime constraints
		startTime.snp.makeConstraints { current in
			current.top.equalToSuperview().inset(10)
			current.width.equalTo(56)
			current.leading.equalToSuperview().inset(4)
		}
		
//		clock constraints
		clock.snp.makeConstraints { current in
			current.centerX.equalTo(startTime.snp.centerX)
			current.top.equalToSuperview().inset(30)
			current.leading.equalToSuperview().inset(4)
			current.height.equalTo(16)
			current.width.equalTo(56)
		}
		
//		splitLabel constraints
		splitLabel.snp.makeConstraints { current in
			current.top.equalToSuperview().inset(8)
			current.leading.equalToSuperview().inset(63)
			current.height.equalTo(40)
			current.width.equalTo(1)
		}
		
//		homeTeamImage constraints
		homeTeamImageView.snp.makeConstraints { current in
			current.leading.equalToSuperview().inset(80)
			current.top.equalToSuperview().inset(10)
			current.width.height.equalTo(16)
		}
		
//		awayTeamImage constraints
		awayTeamImageView.snp.makeConstraints { current in
			current.leading.equalToSuperview().inset(80)
			current.top.equalToSuperview().inset(30)
			current.size.equalTo(16)
		}
			
//		homeTeamName constraints
		homeTeamNameLabel.snp.makeConstraints { current in
			current.leading.equalToSuperview().inset(104)
			current.centerY.equalTo(homeTeamImageView.snp.centerY)
			current.height.equalTo(16)
			current.width.equalTo(192)
		}
		
//		awayTeamName constraints
		awayTeamNameLabel.snp.makeConstraints { current in
			current.leading.equalToSuperview().inset(104)
			current.centerY.equalTo(awayTeamImageView.snp.centerY)
			current.height.equalTo(16)
			current.width.equalTo(192)
		}
		
//		homeTeamScore constraints
		Label.snp.makeConstraints { current in
			current.trailing.equalToSuperview().inset(16)
			current.centerY.equalTo(homeTeamNameLabel.snp.centerY)
			current.height.equalTo(16)
			current.width.equalTo(32)
		}
		
//		awayTeamScore constraints
		awayTeamScore.snp.makeConstraints { current in
			current.trailing.equalToSuperview().inset(16)
			current.centerY.equalTo(awayTeamNameLabel.snp.centerY)
			current.height.equalTo(16)
			current.width.equalTo(32)
		}
	}
	
	private func setupUpcomingStyle() {
		Label.isHidden = true
		awayTeamScore.isHidden = true
		
//		clock styling
		clock.textColor = .gray
		clock.text = "-"
		
//		homeTeamName styling
		homeTeamNameLabel.textColor = .black
		
//		awayTeamName styling
		awayTeamNameLabel.textColor = .black
	}
	
	private func setupInProgressStyle() {
		Label.isHidden = false
		awayTeamScore.isHidden = false
		
//		clock styling
		clock.textColor = .red
		
//		homeTeamName styling
		homeTeamNameLabel.textColor = .black
		
//		awayTeamName styling
		awayTeamNameLabel.textColor = .black
		
//		homeTeamScore styling
		Label.textColor = .red

//		awayTeamScore styling
		awayTeamScore.textColor = .red
	}
	
	private func setupHalftimeStyle() {
		Label.isHidden = false
		awayTeamScore.isHidden = false
		
//		clock styling
		clock.textColor = .red
		clock.text = "HT"
		
//		homeTeamName styling
		homeTeamNameLabel.textColor = .black
		
//		awayTeamName styling
		awayTeamNameLabel.textColor = .black
		
//		homeTeamScore styling
		Label.textColor = .red
		
//		awayTeamScore styling
		awayTeamScore.textColor = .red
	}
	
	private func setupFinishedStyle() {
		Label.isHidden = false
		awayTeamScore.isHidden = false
		
//		clock styling
		clock.textColor = .gray
		clock.text = "FT"
	
//		teamName && teamScore styling
		if (event.homeScore! > event.awayScore!) {
			homeTeamNameLabel.textColor = .black
			Label.textColor = .black
			awayTeamNameLabel.textColor = .gray
			awayTeamScore.textColor = .gray
			
		}
		else if (event.homeScore! < event.awayScore!) {
			homeTeamNameLabel.textColor = .gray
			Label.textColor = .gray
			awayTeamNameLabel.textColor = .black
			awayTeamScore.textColor = .black
		}
		else {
			homeTeamNameLabel.textColor = .black
			Label.textColor = .black
			awayTeamNameLabel.textColor = .black
			awayTeamScore.textColor = .black
		}
	}
	
	private func loadImage(from url: URL, isHome: Bool) {
			URLSession.shared.dataTask(with: url) { data, response, error in
				if let data = data, let image = UIImage(data: data) {
					DispatchQueue.main.async {
						if (isHome) {
							self.homeTeamImageView.image = image
						}
						else {
							self.awayTeamImageView.image = image
						}
						
					}
				}
			}.resume()
		}
		
}
