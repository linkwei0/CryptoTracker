//
//  CryptoListViewController.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import UIKit

class CryptoListViewController: BaseViewController {
    // MARK: - UI Elements
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .accentPink
        return indicator
    }()
    
    private let headerView = HeaderView()
    private let containerView = UIView()
    private let trendingLabel = Label(textStyle: .callout)
    private let filterButton = UIButton()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private weak var popupMenu: PopupMenuView?
    
    private let viewModel: CryptoListViewModel
    private let dataSource = TableViewDataSource()
    
    // MARK: - Init
    init(viewModel: CryptoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindToViewModel()
        viewModel.viewIsReady()
    }
    
    // MARK: - Actions
    @objc private func didTapSettings() {
        if let existingMenu = popupMenu {
            UIView.animate(withDuration: 0.2, animations: {
                existingMenu.alpha = 0
            }) { _ in
                existingMenu.removeFromSuperview()
                self.popupMenu = nil
            }
        } else {
            let menu = PopupMenuView()
            view.addSubview(menu)
            menu.snp.makeConstraints { make in
                make.top.equalTo(headerView.settingsButton.snp.bottom).offset(8)
                make.trailing.equalTo(headerView.settingsButton)
            }
            
            menu.alpha = 0
            UIView.animate(withDuration: 0.3) {
                menu.alpha = 1
            }
            popupMenu = menu
            popupMenu?.delegate = self
        }
    }
    
    @objc private func didTapFilter() {
        let ascendingAction = UIAction(title: "По возрастанию", image: nil) { [weak self] _ in
            self?.viewModel.didTapFilter(option: .ascending)
        }
        
        let descendingAction = UIAction(title: "По убыванию", image: nil) { [weak self] _ in
            self?.viewModel.didTapFilter(option: .descending)
        }
        
        let menu = UIMenu(title: "Сортировка", children: [ascendingAction, descendingAction])
        
        filterButton.menu = menu
        filterButton.showsMenuAsPrimaryAction = true
    }
    
    
    @objc private func didTapLearnMore() {
        print("Did select LearnMore button")
    }
    
    // MARK: - Setup
    private func setup() {
        setupHeaderView()
        setupContainerView()
        setupTableHeaderView()
        setupTableView()
    }
    
    private func setupHeaderView() {
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        headerView.setSettingsAction(target: self, action: #selector(didTapSettings))
        headerView.setLearnMoreAction(target: self, action: #selector(didTapLearnMore))
    }
    
    private func setupContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .mainBackground
        containerView.layer.cornerRadius = 30
        containerView.layer.masksToBounds = true
        containerView.addShadow()
        containerView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(-30)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        containerView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
    }
    
    private func setupTableHeaderView() {
        containerView.addSubview(trendingLabel)
        trendingLabel.text = "Trending"
        trendingLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        
        containerView.addSubview(filterButton)
        filterButton.setImage(.filterBtnIcon, for: .normal)
        filterButton.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)
        filterButton.snp.makeConstraints { make in
            make.centerY.equalTo(trendingLabel)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupTableView() {
        containerView.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 70
        tableView.register(CryptoCell.self, forCellReuseIdentifier: CryptoCell.reuseIdentifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(trendingLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        dataSource.setup(tableView: tableView, viewModel: viewModel)
    }
    
    // MARK: - Private methods
    private func configureView(withState state: CryptoViewState) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
            tableView.isHidden = true
        case .populated:
            activityIndicator.stopAnimating()
            tableView.isHidden = false
        }
    }
    
    // MARK: - Bindable
    private func bindToViewModel() {
        viewModel.viewState.bind { [weak self] state in
            DispatchQueue.main.async {
                self?.configureView(withState: state)
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - PopupMenuViewDelegate
extension CryptoListViewController: PopupMenuViewDelegate {
    func popupMenuDidTapSignOut(_ popupMenuView: PopupMenuView) {
        viewModel.signOut()
    }
}
