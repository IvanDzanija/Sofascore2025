//
//  ViewController.swift
//  Sofascore2025
//
//  Created by Ivan Dzanija on 03.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController{
	private var data = Homework2DataSource()
	private var leagueView : LeagueView!
	private var eventViewList = [EventView]()
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		self.view.backgroundColor = .white
		LoadLeague()
		LoadEvents()
		addViews()
		styleViews()
		setupConstraints()
	}
	
	private func addViews() {
		self.view.addSubview(leagueView)
		for eventView in eventViewList {
			self.view.addSubview(eventView)
		}
	}
	
	private func styleViews(){
		self.view.backgroundColor = .white
	}
	
	private func setupConstraints(){
		
		leagueView.snp.makeConstraints {
			$0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
			$0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
			$0.height.equalTo(56)
		}
		
//		probao sam prebaciti ovako, ali dalje moram hardcodat visinu 
		for (index, eventView) in eventViewList.enumerated() {
			if index == 0{
				eventView.snp.makeConstraints {
					$0.top.equalTo(leagueView.snp.bottom)
					$0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
					$0.height.equalTo(56)
				}
			}
			else{
				eventView.snp.makeConstraints {
					$0.top.equalTo(eventViewList[index - 1].snp.bottom)
					$0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
					$0.height.equalTo(56)
				}
				
			}
		}
	}
	
	private func LoadLeague(){
		let league = data.laLigaLeague()
		leagueView = LeagueView(league: league)
	}
	
	private func LoadEvents(){
		let events = data.laLigaEvents()
		for event in events {
			let eventView = EventView(event: event)
			eventViewList.append(eventView)
		}
	}
	
	
}

