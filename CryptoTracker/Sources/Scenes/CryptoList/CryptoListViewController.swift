//
//  CryptoListViewController.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import UIKit

class CryptoListViewController: BaseViewController, NavigationBarHiding {
    // MARK: - UI Elements
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let settingsButton = SettingsButton()
    private let affiliateLabel = UILabel()
    private let learnMoreButton = UIButton()
    private let backgroundImage = UIImageView()
    private let containerView = UIView()
    private let trendingLabel = UILabel()
    private let filterButton = UIButton()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
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
    
    // MARK: - Setup
    private func setup() {
        setupHeaderView()
        setupContainerView()
        setupTableHeaderView()
        setupTableView()
    }
    
    private func setupHeaderView() {
        view.addSubview(headerView)
        headerView.backgroundColor = UIColor.accentPink
        headerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        headerView.addSubview(titleLabel)
        titleLabel.text = "Home"
        titleLabel.font = UIFont(name: "Poppins-Bold", size: 32)
        titleLabel.textColor = .baseWhite
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().inset(20)
        }
        
        // У вас плохая картинка в фигме
        headerView.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(48)
        }
        
        headerView.addSubview(affiliateLabel)
        affiliateLabel.text = "Affiliate program"
        affiliateLabel.font = UIFont(name: "Poppins-Regular", size: 20)
        affiliateLabel.textColor = .white
        affiliateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(38)
            make.leading.equalToSuperview().inset(20)
        }
        
        headerView.addSubview(learnMoreButton)
        learnMoreButton.backgroundColor = .baseWhite
        learnMoreButton.layer.cornerRadius = 35 / 2
        learnMoreButton.layer.masksToBounds = false
        learnMoreButton.setTitle("Learn more", for: .normal)
        learnMoreButton.setTitleColor(.baseBlack, for: .normal)
        learnMoreButton.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 14)
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(affiliateLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(127)
            make.height.equalTo(35)
        }
        
        headerView.addSubview(backgroundImage)
        backgroundImage.image = UIImage.backgroundIcon
        backgroundImage.contentMode = .scaleAspectFit
        backgroundImage.clipsToBounds = true
        backgroundImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(-30)
            make.bottom.equalToSuperview().inset(-52)
            make.width.height.equalTo(242)
        }
    }
    
    private func setupContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .baseWhite
        containerView.layer.cornerRadius = 30
        containerView.layer.masksToBounds = true
        containerView.addShadow()
        containerView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(-30)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTableHeaderView() {
        containerView.addSubview(trendingLabel)
        trendingLabel.text = "Trending"
        trendingLabel.font = UIFont(name: "Poppins-Regular", size: 20)
        trendingLabel.textColor = .baseBlack
        trendingLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        
        containerView.addSubview(filterButton)
        let image = UIImage.filterBtnIcon.withRenderingMode(.alwaysTemplate)
        filterButton.setImage(image, for: .normal)
        filterButton.tintColor = .darkGray
        filterButton.snp.makeConstraints { make in
            make.centerY.equalTo(trendingLabel)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupTableView() {
        containerView.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 70
        tableView.register(CryptoCell.self, forCellReuseIdentifier: CryptoCell.reuseIdentifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(trendingLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        dataSource.setup(tableView: tableView, viewModel: viewModel)
    }
    
    // MARK: - Bindable
    private func bindToViewModel() {
        viewModel.onNeedsToUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
