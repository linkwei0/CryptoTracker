//
//  CryptoDetailsViewController.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import UIKit

class CryptoDetailsViewController: BaseViewController {
    // MARK: - Properties
    private let backButton = UIButton()
    private let titleLabel = Label(textStyle: .body)
    private let settingsButton = SettingsButton()
    private let priceLabel = Label(textStyle: .header1)
    private let percentageChangeLabel = Label(textStyle: .body)
    private let dynamicsIcon = UIImageView()
    private let segmentedControl = SegmentedControlView(options: [.day, .week, .year, .all, .point])
    private let marketStatsContainer = UIView()
    private let marketStatsTitle = Label(textStyle: .callout)
    private let marketCapLabel = Label(textStyle: .body)
    private let marketCapValue = Label(textStyle: .bodyBold)
    private let circulatingSupplyLabel = Label(textStyle: .body)
    private let circulatingSupplyValue = Label(textStyle: .bodyBold)
    
    private weak var popupMenu: PopupMenuView?
    
    private let viewModel: CryptoDetailsViewModel
    
    // MARK: - Init
    init(viewModel: CryptoDetailsViewModel) {
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
                make.top.equalTo(settingsButton.snp.bottom).offset(8)
                make.trailing.equalTo(settingsButton)
            }
            
            menu.alpha = 0
            UIView.animate(withDuration: 0.3) {
                menu.alpha = 1
            }
            popupMenu = menu
            popupMenu?.delegate = self
        }
    }
    
    @objc private func didTapBack() {
        viewModel.didTapBack()
    }
    
    // MARK: - Setup
    private func setup() {
        setupNavigation()
        setupPriceSection()
        setupTimeFilter()
        setupMarketStats()
    }
    
    private func setupNavigation() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(settingsButton)
        
        let image = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(image, for: .normal)
        backButton.tintColor = .baseBlack

        backButton.backgroundColor = .baseWhite
        backButton.layer.cornerRadius = 24
        backButton.layer.masksToBounds = true

        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalToSuperview()
        }
        
        settingsButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        settingsButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(48)
        }
    }
    
    private func setupPriceSection() {
        view.addSubview(priceLabel)
        view.addSubview(percentageChangeLabel)
        view.addSubview(dynamicsIcon)

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        percentageChangeLabel.textColor = .textSecondary
        percentageChangeLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        dynamicsIcon.contentMode = .scaleAspectFit
        dynamicsIcon.snp.makeConstraints { make in
            make.trailing.equalTo(percentageChangeLabel.snp.leading).offset(-5)
            make.centerY.equalTo(percentageChangeLabel)
            make.width.height.equalTo(12)
        }
    }
    
    private func setupTimeFilter() {
        view.addSubview(segmentedControl)
        segmentedControl.delegate = self
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(percentageChangeLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    
    private func setupMarketStats() {
        view.addSubview(marketStatsContainer)
        marketStatsContainer.backgroundColor = .secondaryBackground
        marketStatsContainer.layer.cornerRadius = 20
        marketStatsContainer.layer.masksToBounds = true
        
        marketStatsContainer.addSubview(marketStatsTitle)
        marketStatsContainer.addSubview(marketCapLabel)
        marketStatsContainer.addSubview(marketCapValue)
        marketStatsContainer.addSubview(circulatingSupplyLabel)
        marketStatsContainer.addSubview(circulatingSupplyValue)
        
        marketStatsContainer.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(62)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(190)
        }
        
        marketStatsTitle.text = "Market Statistic"
        marketStatsTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(20)
        }
        
        marketCapLabel.textColor = .textSecondary
        marketCapLabel.text = "Market capitalization"
        marketCapLabel.snp.makeConstraints { make in
            make.top.equalTo(marketStatsTitle.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        
        marketCapValue.snp.makeConstraints { make in
            make.centerY.equalTo(marketCapLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        circulatingSupplyLabel.textColor = .textSecondary
        circulatingSupplyLabel.text = "Circulating Supply"
        circulatingSupplyLabel.snp.makeConstraints { make in
            make.top.equalTo(marketCapLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        
        circulatingSupplyValue.snp.makeConstraints { make in
            make.centerY.equalTo(circulatingSupplyLabel)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Binadble
    private func bindToViewModel() {
        viewModel.onNeedsToUpdate = { [weak self] title, price, percentageChange, marketCap, circulatingSupplyValue, isIncreased in
            self?.titleLabel.text = title
            self?.priceLabel.text = price
            self?.percentageChangeLabel.text = percentageChange
            self?.marketCapValue.text = marketCap
            self?.circulatingSupplyValue.text = circulatingSupplyValue
            self?.dynamicsIcon.image = isIncreased ? .arrowUp : .arrowDown
        }
    }
}

// MARK: - SegmentedControlViewDelegate
extension CryptoDetailsViewController: SegmentedControlViewDelegate {
    func segmentedControlView(_ view: SegmentedControlView, didSelect type: SegmentedControlType) {
        viewModel.didSelectType(type)
    }
}

// MARK: - PopupMenuViewDelegate
extension CryptoDetailsViewController: PopupMenuViewDelegate {
    func popupMenuDidTapSignOut(_ popupMenuView: PopupMenuView) {
        viewModel.signOut()
    }
}
