//
//  WishEventCell.swift
//  adhamovPW2
//
//  Created by Alibek Adhamov on 09/02/24.
//

import UIKit

class WishEventCell: UICollectionViewCell{
    
    enum Constants{
        static let offset: CGFloat = 1
        static let cornerRadius: CGFloat = 10
        static let backgroundColor: UIColor = .white
        
        static let titleTop: CGFloat = 10
        static let titleFont: UIFont = .italicSystemFont(ofSize: 20)
        static let titleLeading: CGFloat = 10
        
        static let descriptionTop: CGFloat = 10
        static let descriptionLeading: CGFloat = 10
        static let descriptionFont: UIFont = .systemFont(ofSize: 12)
        static let descriptionTextColor: UIColor = .red
        
        static let startLabelBottom: CGFloat = 25
        static let startLabelRight: CGFloat = 7
        static let startLabelFont: UIFont = .systemFont(ofSize: 10)
        static let startLabelTextColor: UIColor = .black
        
        static let endLabelBottom: CGFloat = 10
        static let endLabelRight: CGFloat = 7
        static let endLabelFont: UIFont = .systemFont(ofSize: 10)
        static let endLabelTextColor: UIColor = .black
        
    }
    
    static let reuseIdentifier: String = "WishEventCell"
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.YYYY"
        startDateLabel.text = "Start: \(dateFormatter.string(from: event.startDate))"
        endDateLabel.text = "End: \(dateFormatter.string(from: event.endDate))"
    }
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        
        wrapView.pin(to: self, Constants.offset)
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
        
        let bottomSeparator = UIView()
        bottomSeparator.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        wrapView.addSubview(bottomSeparator)
        bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        bottomSeparator.setHeight( 1)
        bottomSeparator.pinRight(to: wrapView.trailingAnchor)
        bottomSeparator.pinLeft(to: wrapView.leadingAnchor)
    }
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.pinTop(to: wrapView, Constants.titleTop)
        titleLabel.font = Constants.titleFont
        titleLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
    
    private func configureDescriptionLabel(){
        addSubview(descriptionLabel)
        
        descriptionLabel.pinLeft(to: wrapView, Constants.descriptionLeading)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.descriptionTop)
        descriptionLabel.font = Constants.descriptionFont
        descriptionLabel.textColor = Constants.descriptionTextColor
    }
    
    private func configureStartDateLabel(){
        addSubview(startDateLabel)
        
        startDateLabel.pinRight(to: wrapView, Constants.startLabelRight)
        startDateLabel.pinBottom(to: wrapView, Constants.startLabelBottom)
        startDateLabel.font = Constants.startLabelFont
        startDateLabel.textColor = Constants.startLabelTextColor
    }
    
    private func configureEndDateLabel(){
        addSubview(endDateLabel)
        
        endDateLabel.pinRight(to: wrapView, Constants.endLabelRight)
        endDateLabel.pinBottom(to: wrapView, Constants.endLabelBottom)
        endDateLabel.font = Constants.endLabelFont
        endDateLabel.textColor = Constants.endLabelTextColor
    }
}
