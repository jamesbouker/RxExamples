//
//  BaseViewController.swift
//  RxExamples
//
//  Created by james bouker on 5/10/18.
//  Copyright © 2018 Jimmy Bouker. All rights reserved.
//

import RxSwift
import UIKit

class BaseViewController: UIViewController {
    @IBOutlet var fields: [UITextField]!
    @IBInspectable var tapScreenToHideKeyboard: Bool = false

    var bag = DisposeBag()
    func bindViewModel() {}

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()

        if tapScreenToHideKeyboard {
            let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tap)
        }

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: .UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: .UIKeyboardWillHide, object: nil)
    }

    deinit {
        print("Dealloc: \(self)")
    }

    // MARK: - Alert

    func alert(_ title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            completion?()
            alert.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Keyboard Magic

    @objc func keyboardWillShow(sender: NSNotification) {
        guard
            let textfield = fields.first(where: { $0.isFirstResponder }),
            let frame = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }

        let rect = textfield.convert(textfield.bounds, to: view)
        let deltaY = rect.maxY - frame.minY + 20
        if deltaY > 0 {
            view.frame.origin.y = -deltaY
        } else {
            view.frame.origin.y = 0
        }
    }

    @objc func keyboardWillHide(sender _: NSNotification) {
        view.frame.origin.y = 0
    }

    @IBAction func hideKeyboard() {
        fields.forEach { $0.resignFirstResponder() }
    }
}
