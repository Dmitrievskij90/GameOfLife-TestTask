//
//  BaseButton.swift
//  GameOfLife-TestTask
//
//  Created by Konstantin Dmitrievskiy on 07.07.2022.
//

import UIKit

class BaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .center
        backgroundColor = .purple
        layer.borderWidth = 0.5
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: 10)
        layer.shadowColor = UIColor.darkGray.cgColor
        setTitleColor(.white, for: .normal)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = layer.frame.height / 3
    }
}
