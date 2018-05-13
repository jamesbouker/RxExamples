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
        let output = viewModel.transform(input: .init())
        output.items.bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: UITableViewCell.self)) { row, element, cell in
            cell.textLabel?.text = "\(element) @ row \(row)"
        }.disposed(by: bag)

        Observable.of(tableView.rx.itemSelected, tableView.rx.itemAccessoryButtonTapped).merge()
            .subscribe(onNext: { [weak self] in
                self?.tableView.deselectRow(at: $0, animated: true)
                self?.alert("Selected Cell", message: "\($0.item)")
            }).disposed(by: bag)
    }
}
