//
//  PokedexListViewController.swift
//  RxExamples
//
//  Created by james bouker on 5/21/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import UIKit
import RxCocoa

class PokedexListViewController: BaseViewController {
	@IBOutlet weak var tableView: UITableView!
	var viewModel = PokedexListViewModel()

	override func bindViewModel() {
		let output = viewModel.transform()

		output.pokedexList.bind(to: tableView.rx.items(cellIdentifier: "Pokedex", cellType: UITableViewCell.self)) { (_, pokedex, cell) in
			cell.textLabel?.text = pokedex.name
			cell.detailTextLabel?.text = pokedex.url
		}.disposed(by: bag)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let vc = segue.destination as? PokedexViewController,
		let row = tableView.indexPathForSelectedRow?.row else { return }
		vc.viewModel = PokedexViewModel(row + 1)
	}
}
