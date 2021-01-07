//
//  ViewController.swift
//  TiaIosInterview
//
//  Created by Leo Tsuchiya on 1/4/21.
//

import UIKit
import Combine

class DoggosViewController: UIViewController {

    let tableView = UITableView()
    let getButton = UIButton()
    let breedButton = UIButton()
    let clearButton = UIButton()

    @Published var selectedIndex: Int?

    var urls = [URL]()
    var breeds = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupLayout()
        setupTable()
        setupButtons()
        loadBreeds()
        setupSubscribers()
    }

    private func setupLayout() {

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        let buttonStack = UIStackView()
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .vertical
        buttonStack.distribution = .fillEqually
        buttonStack.alignment = .fill
        buttonStack.spacing = 8

        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(getButton)
        buttonStack.addArrangedSubview(breedButton)
        buttonStack.addArrangedSubview(clearButton)
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -16),
            buttonStack.heightAnchor.constraint(equalToConstant: 120),
            buttonStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            buttonStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupTable() {
        tableView.register(DoggoCell.self, forCellReuseIdentifier: "DoggoCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
    }

    private func setupButtons() {
        getButton.setTitle("Get doggo", for: .normal)
        getButton.layer.cornerRadius = 8
        getButton.layer.borderWidth = 1
        getButton.layer.borderColor = UIColor.lightGray.cgColor
        getButton.setTitleColor(.black, for: .normal)
        getButton.addTarget(self, action: #selector(getButtonTapped), for: .touchUpInside)

        breedButton.setTitle("Select Breed", for: .normal)
        breedButton.layer.cornerRadius = 8
        breedButton.layer.borderWidth = 1
        breedButton.layer.borderColor = UIColor.lightGray.cgColor
        breedButton.setTitleColor(.black, for: .normal)
        breedButton.addTarget(self, action: #selector(selectBreedButtonTapped), for: .touchUpInside)

        clearButton.setTitle("Clear doggos", for: .normal)
        clearButton.layer.cornerRadius = 8
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = UIColor.lightGray.cgColor
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }

    private func loadBreeds() {
        NetworkProvider.getBreedList { breeds in
            self.breeds = breeds
        }
    }

    private func setupSubscribers() {
        $selectedIndex
            .receive(on: DispatchQueue.main)
            .sink { selectedIndex in
                var breed: String = "random"
                if let selectedIndex = selectedIndex {
                    breed = self.breeds[selectedIndex]
                }
                self.breedButton.setTitle("\(breed) selected", for: .normal)
            }
    }

    @objc private func getButtonTapped() {
        print(#function)
        var breed: String?
        if let selectedIndex = selectedIndex {
            breed = breeds[selectedIndex]
        }
        NetworkProvider.getRandomDogUrl(breed: breed) { url in
            self.urls.append(url)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @objc private func selectBreedButtonTapped() {

        let breedPicker = BreedPickerViewController()
        breedPicker.breeds = self.breeds.sorted()
        breedPicker.indexSelected = { index in
            self.selectedIndex = index
        }
        breedPicker.modalPresentationStyle = .pageSheet
        present(breedPicker, animated: true, completion: nil)
    }

    @objc private func clearButtonTapped() {

        urls.removeAll()
        tableView.reloadData()
    }
}

extension DoggosViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoggoCell", for: indexPath) as! DoggoCell
        cell.configure(imageUrl: urls[indexPath.row])
        return cell
    }
}

extension DoggosViewController: UITableViewDelegate {

}

