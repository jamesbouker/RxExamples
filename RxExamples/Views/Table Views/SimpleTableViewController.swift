//
//  SimpleTableViewController.swift
//  RxExamples
//
//  Created by james bouker on 5/13/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

let cellId = "SimpleCell"

class SimpleTableViewController: BaseViewController {
    @IBOutlet var tableView: UITableView!
    var viewModel = SimpleTableViewModel()

    override func bindViewModel() {
		let input = SimpleTableViewModel.Input(itemSelected: tableView.rx.itemSelected,
											   accessorySelected: tableView.rx.itemAccessoryButtonTapped)
        let output = viewModel.transform(input: input)

        output.items.bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: UITableViewCell.self)) { row, element, cell in
            cell.textLabel?.text = "\(element) @ row \(row)"
        }.disposed(by: bag)

		output.tapped.subscribe(onNext: { [weak self] in
			self?.tableView.deselectRow(at: $0.0, animated: true)
			self?.alert("Selected Cell", message: "\($0.1)")
		}).disposed(by: bag)
    }
}
