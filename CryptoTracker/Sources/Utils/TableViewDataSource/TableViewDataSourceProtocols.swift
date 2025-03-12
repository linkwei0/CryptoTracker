//
//  TableViewDataSourceProtocols.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

protocol TableCellViewModel {
    var tableReuseIdentifier: String { get }
    func select()
}

extension TableCellViewModel {
    func select() {}
}

protocol TableHeaderFooterViewModel {
    var tableReuseIdentifier: String { get }
}

protocol TableCell {
    func configure(with viewModel: TableCellViewModel)
}

protocol TableHeaderFooterView {
    func configure(with viewModel: TableHeaderFooterViewModel)
}

protocol TableViewModel {
    var sectionViewModels: [TableSectionViewModel] { get }
}
