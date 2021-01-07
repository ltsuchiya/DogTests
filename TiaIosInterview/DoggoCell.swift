//
//  DoggoCell.swift
//  TiaIosInterview
//
//  Created by Leo Tsuchiya on 1/4/21.
//

import Foundation
import UIKit
import Kingfisher

class DoggoCell: UITableViewCell {

    let dogImageView = UIImageView()
    let starButton = UIButton()

    var starButtonSelected: Bool = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8)
        ])

        stackView.addArrangedSubview(dogImageView)
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        dogImageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            dogImageView.heightAnchor.constraint(equalToConstant: 250),
        ])

        stackView.addArrangedSubview(starButton)
        self.starButton.setImage(#imageLiteral(resourceName: "star_icon_empty"), for: .normal)
        starButton.translatesAutoresizingMaskIntoConstraints = false
        starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            starButton.widthAnchor.constraint(equalToConstant: 48),
            starButton.heightAnchor.constraint(equalToConstant: 48),
        ])

    }

    @objc private func starButtonTapped() {
        starButtonSelected.toggle()
        switch starButtonSelected {
        case true:
            self.starButton.setImage(#imageLiteral(resourceName: "star_icon_filled").withTintColor(.yellow), for: .normal)
        case false:
            self.starButton.setImage(#imageLiteral(resourceName: "star_icon_empty"), for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dogImageView.image = nil
    }

    func configure(imageUrl: URL) {
        dogImageView.kf.setImage(with: imageUrl)
    }
}
