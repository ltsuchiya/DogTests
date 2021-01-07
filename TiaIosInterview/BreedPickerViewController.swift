//
//  BreedPickerViewController.swift
//  TiaIosInterview
//
//  Created by Leo Tsuchiya on 1/4/21.
//

import Foundation
import UIKit

class BreedPickerViewController: UIViewController {

    let pickerView = UIPickerView()
    var breeds = [String]()

    var indexSelected: ((Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(pickerView)
        pickerView.backgroundColor = .white
        pickerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pickerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            pickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            pickerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            pickerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])

        pickerView.dataSource = self
        pickerView.delegate = self
    }
}

extension BreedPickerViewController: UIPickerViewDataSource,UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        indexSelected?(row)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
}
