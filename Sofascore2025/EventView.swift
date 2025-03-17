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
	private let splitImageView = UIImageView()
	
	init(event: Event) {
		self.event = event
		super.init()
	}
	
	override func addViews() {
		addSubview(clockLabel)
		addSubview(startTimeLabel)
		addSubview(splitImageView)
		addSubview(homeTeamImageView)
		addSubview(awayTeamImageView)
		addSubview(homeTeamNameLabel)
		addSubview(awayTeamNameLabel)
		addSubview(homeTeamScoreLabel)
		addSubview(awayTeamScoreLabel)
	}

	override func styleViews() {
		backgroundColor = .white
		
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm"

		startTimeLabel.text = formatter.string(from : Date(timeIntervalSince1970: TimeInterval(event.startTimestamp)))
		
		homeTeamNameLabel.text = event.homeTeam.name
		awayTeamNameLabel.text =  event.awayTeam.name
		
		if let homeScore = event.homeScore {
			homeTeamScoreLabel.text = String(homeScore)
		}
		if let awayScore = event.awayScore {
			awayTeamScoreLabel.text = String(awayScore)
		}
		
		if let urlHome = event.homeTeam.logoUrl, let url = URL(string: urlHome) {
			loadImage(from: url, isHome: true)
		}
		if let urlAway = event.awayTeam.logoUrl, let url = URL(string: urlAway) {
			loadImage(from: url, isHome: false)
		}
		
		clockLabel.font = UIFont(name: "Roboto-Regular", size: 12)
		clockLabel.textAlignment = .center
	
		startTimeLabel.font = UIFont(name: "Roboto-Regular", size: 12)
		startTimeLabel.textColor = .gray
		startTimeLabel.textAlignment = .center
		
		splitImageView.image = UIImage(named: "Divider Horizontal")
		splitImageView.contentMode = .scaleAspectFit
		splitImageView.clipsToBounds = true
		
		homeTeamImageView.contentMode = .scaleAspectFit
		homeTeamImageView.clipsToBounds = true
		
		awayTeamImageView.contentMode = .scaleAspectFit
		awayTeamImageView.clipsToBounds = true
		
		awayTeamNameLabel.font = UIFont(name: "Roboto-Regular", size: 14)
		
		homeTeamScoreLabel.font = UIFont(name: "Roboto-Regular", size: 14)
		awayTeamScoreLabel.font = UIFont(name: "Roboto-Regular", size: 14)
		
		if (self.event.status == .notStarted) {
			setupUpcomingStyle()
		}
		else if (self.event.status == .inProgress) {
			let timer = (Int(Date().timeIntervalSince1970) - self.event.startTimestamp) / 60
			clockLabel.text = String(timer) + "'"
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
		
		startTimeLabel.snp.makeConstraints {
			$0.top.equalToSuperview().inset(10)
			$0.width.equalTo(56)
			$0.leading.equalToSuperview().inset(4)
		}
		
		clockLabel.snp.makeConstraints {
			$0.centerX.equalTo(startTimeLabel.snp.centerX)
			$0.top.equalToSuperview().inset(30)
			$0.leading.equalToSuperview().inset(4)
			$0.height.equalTo(16)
			$0.width.equalTo(56)
		}
		
		splitImageView.snp.makeConstraints {
			$0.top.equalToSuperview().inset(8)
			$0.leading.equalToSuperview().inset(63)
			$0.height.equalTo(40)
			$0.width.equalTo(1)
		}
		
		homeTeamImageView.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(80)
			$0.top.equalToSuperview().inset(10)
			$0.width.height.equalTo(16)
		}
		
		awayTeamImageView.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(80)
			$0.top.equalToSuperview().inset(30)
			$0.size.equalTo(16)
		}
			
		homeTeamNameLabel.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(104)
			$0.centerY.equalTo(homeTeamImageView.snp.centerY)
			$0.height.equalTo(16)
			$0.width.equalTo(192)
		}
		
		awayTeamNameLabel.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(104)
			$0.centerY.equalTo(awayTeamImageView.snp.centerY)
			$0.height.equalTo(16)
			$0.width.equalTo(192)
		}
		
		homeTeamScoreLabel.snp.makeConstraints {
			$0.trailing.equalToSuperview().inset(16)
			$0.centerY.equalTo(homeTeamNameLabel.snp.centerY)
			$0.height.equalTo(16)
			$0.width.equalTo(32)
		}
		
		awayTeamScoreLabel.snp.makeConstraints {
			$0.trailing.equalToSuperview().inset(16)
			$0.centerY.equalTo(awayTeamNameLabel.snp.centerY)
			$0.height.equalTo(16)
			$0.width.equalTo(32)
		}
	}
	
	private func setupUpcomingStyle() {
		homeTeamScoreLabel.isHidden = true
		awayTeamScoreLabel.isHidden = true
		
		clockLabel.textColor = .gray
		clockLabel.text = "-"
		
		homeTeamNameLabel.textColor = .black
		
		awayTeamNameLabel.textColor = .black
	}
	
	private func setupInProgressStyle() {
		homeTeamScoreLabel.isHidden = false
		awayTeamScoreLabel.isHidden = false
		
		clockLabel.textColor = .red
		
		homeTeamNameLabel.textColor = .black
		
		awayTeamNameLabel.textColor = .black
		
		homeTeamScoreLabel.textColor = .red

		awayTeamScoreLabel.textColor = .red
	}
	
	private func setupHalftimeStyle() {
		homeTeamScoreLabel.isHidden = false
		awayTeamScoreLabel.isHidden = false
		
		clockLabel.textColor = .red
		clockLabel.text = "HT"
		
		homeTeamNameLabel.textColor = .black
		
		awayTeamNameLabel.textColor = .black
		
		homeTeamScoreLabel.textColor = .red
		
		awayTeamScoreLabel.textColor = .red
	}
	
	private func setupFinishedStyle() {
		homeTeamScoreLabel.isHidden = false
		awayTeamScoreLabel.isHidden = false
		
		clockLabel.textColor = .gray
		clockLabel.text = "FT"
		
		let homeScore = event.homeScore ?? 0
		let awayScore = event.awayScore ?? 0
		let homeTeamColor: UIColor = homeScore > awayScore ? .black : .gray
		let awayTeamColor: UIColor = awayScore > homeScore ? .black : .gray
	
		
		homeTeamNameLabel.textColor = homeTeamColor
		homeTeamScoreLabel.textColor = homeTeamColor
		awayTeamNameLabel.textColor = awayTeamColor
		awayTeamScoreLabel.textColor = awayTeamColor
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
