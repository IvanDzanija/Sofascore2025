//
//  ViewController.swift
//  Sofascore2025
//
//  Created by Ivan Dzanija on 03.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class ViewController: UIViewController {
	private var data = Homework2DataSource()
	private var leagueView: LeagueView!

	private var eventViewList = [EventView]()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		loadLeague()
		loadEvents()
		addViews()
		styleViews()
		setupConstraints()
	}

	private func addViews() {
		view.addSubview(leagueView)
		for eventView in eventViewList {
			self.view.addSubview(eventView)
		}
	}

	private func styleViews() {
		view.backgroundColor = .white
	}

	private func setupConstraints() {
		leagueView.snp.makeConstraints {
			$0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
			$0.leading.trailing.equalToSuperview()
		}

		let eventStackView = UIStackView()
		view.addSubview(eventStackView)
		eventStackView.axis = .vertical
		eventStackView.snp.makeConstraints {
			$0.top.equalTo(leagueView.snp.bottom)
			$0.leading.trailing.equalToSuperView()
		}
		for eventView in eventViewList {
			eventStackView.addArrangedSubview(eventView)
		}
	}

	private func loadLeague() {
		let league = data.laLigaLeague()
		leagueView = LeagueView(league: league)
	}

	private func loadEvents() {
		let events = data.laLigaEvents()
		for event in events {
			let eventViewModel = EventViewModel(event: event)
			let eventView = EventView(eventViewModel: eventViewModel)
			eventViewList.append(eventView)
		}
	}
}
