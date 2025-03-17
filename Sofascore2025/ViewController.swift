//
//  ViewController.swift
//  Sofascore2025
//
//  Created by Ivan Dzanija on 03.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {
	
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
			current.width.equalTo(self.view.safeAreaLayoutGuide.snp.width)
			current.height.equalTo(64)
		}
		
//		load events
		let events = data.laLigaEvents()
		let eventViewList = UIStackView()
		self.view.addSubview(eventViewList)
		eventViewList.axis = .vertical
		eventViewList.snp.makeConstraints { current in
			current.top.equalTo(leagueView.snp.bottom).offset(16)
			current.width.equalTo(self.view.safeAreaLayoutGuide.snp.width)
			current.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
		}
		for event in events {
			let eventView = EventView(match: event)
			eventViewList.addArrangedSubview(eventView)
			eventView.snp.makeConstraints { current in
				current.height.equalTo(56)
				current.width.equalTo(eventViewList.snp.width)
			}
		}
		
	}
	

}

