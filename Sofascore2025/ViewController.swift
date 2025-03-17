//
//  ViewController.swift
//  Sofascore2025
//
//  Created by Ivan Dzanija on 03.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class MainViewController: UIViewController {
	
	private var data = Homework2DataSource()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		
//		load league
		let league = data.laLigaLeague()
		let leagueView = LeagueView(league: league)
		self.view.addSubview(leagueView)
		leagueView.snp.makeConstraints { current in
			current.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(8)
			current.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
			current.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
			current.height.equalTo(64)
		}
		
//		load events
		let events = data.laLigaEvents()
		let eventViewList = UIStackView()
		eventViewList.axis = .vertical
		
		for event in events {
			let eventView = EventView(match: event)
			eventViewList.addArrangedSubview(eventView)
			eventView.snp.makeConstraints { make in
				make.height.equalTo(56)
			}
		}
		
	}
	

}

