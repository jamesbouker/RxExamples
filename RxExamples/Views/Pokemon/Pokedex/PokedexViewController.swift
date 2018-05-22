//
//  PokedexViewController.swift
//  RxExamples
//
//  Created by james bouker on 5/22/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PokedexViewController: BaseViewController {
	@IBOutlet weak var tableView: UITableView!
	var viewModel: PokedexViewModel!

	override func bindViewModel() {
		let output = viewModel.transform()

		output.title.bind(to: navigationItem.rx.title).disposed(by: bag)

		output.species.bind(to: tableView.rx.items(cellIdentifier: "Pokemon", cellType: UITableViewCell.self)) { (index, model, cell) in
			cell.textLabel?.text = model.name
			cell.detailTextLabel?.text = "\(index+1)"
		}.disposed(by: bag)
	}
}
