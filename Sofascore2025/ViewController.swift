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
	private var leagueView = LeagueView()
	private var eventStackView = UIStackView()
	private let scrollView = UIScrollView()
	private let contentView = UIView()
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
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		contentView.addSubview(leagueView)
		contentView.addSubview(eventStackView)
		for eventView in eventViewList {
			eventStackView.addArrangedSubview(eventView)
		}
	}

	private func styleViews() {
		view.backgroundColor = .white
		scrollView.showsVerticalScrollIndicator = false
		eventStackView.axis = .vertical
	}

	private func setupConstraints() {
		scrollView.snp.makeConstraints {
			$0.edges.equalTo(view.safeAreaLayoutGuide)
		}

		contentView.snp.makeConstraints {
			$0.edges.equalToSuperview()
			$0.width.equalToSuperview()
		}

		leagueView.snp.makeConstraints {
			$0.top.equalToSuperview()
			$0.leading.trailing.equalToSuperview()
		}

		eventStackView.snp.makeConstraints {
			$0.top.equalTo(leagueView.snp.bottom)
			$0.leading.trailing.equalToSuperview()
			$0.bottom.equalToSuperview()
		}
	}

	private func loadLeague() {
		let league = data.laLigaLeague()
		leagueView.loadData(league: league)
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
