//
//  PokemonViewController.swift
//  RxExamples
//
//  Created by james bouker on 5/21/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import UIKit
import RxCocoa

class PokemonViewController: BaseViewController {
	@IBOutlet var ui: PokemonUI!
	var viewModel = PokemonViewModel()

	override func bindViewModel() {
		let output = viewModel.transform(input: .init())

		output.pokedexList.bind(to: ui.tableView.rx.items(cellIdentifier: "Pokemon", cellType: UITableViewCell.self)) { (index, pokemon, cell) in
			cell.textLabel?.text = pokemon["name"]
			cell.detailTextLabel?.text = pokemon["url"]
		}.disposed(by: bag)
	}
}
