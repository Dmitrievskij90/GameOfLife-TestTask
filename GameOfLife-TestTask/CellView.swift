//
//  CellView.swift
//  GameOfLife-TestTask
//
//  Created by Konstantin Dmitrievskiy on 07.07.2022.
//

import UIKit

class CellView: UIView {
    var state: State = .alive
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
