//
//  WishEventCreationView.swift
//  adhamovPW2
//
//  Created by Alibek Adhamov on 09/02/24.
//

import UIKit

class WishEventCreationView: UIViewController{
    private enum Constants{
        static let labelFont: UIFont = .boldSystemFont(ofSize: 25)
        static let textViewFont: UIFont = .systemFont(ofSize: 15)
        static let textViewCornerRadius: CGFloat = 12
        static let textViewWidthDelta: CGFloat = 30

        static let nameTextViewHeight: CGFloat = 40

        static let descriptionTextViewHeight: CGFloat = 60

        static let buttonFont: UIFont = .boldSystemFont(ofSize: 15)
        static let buttonTextColor: UIColor = .systemPink
        static let buttonFontSize: CGFloat = 12
        static let buttonConerRadius: CGFloat = 25
        static let buttonHeight: CGFloat = 70
        static let buttonWidth: CGFloat = 150

        static let stackSpacing: CGFloat = 8
        static let stackPin: CGFloat = 15

        static let errorLabelFont: UIFont = .systemFont(ofSize: 10)
    }

    private var nameLabel: UILabel = UILabel()
    private var nameTextView = UITextView()
    private var descriptionLabel: UILabel = UILabel()
    private  var descriptionTextView = UITextView()
    private var startDateLabel = UILabel()
    private var startDateTextView = UITextView()
    private var endDateLabel = UILabel()
    private var endDateTextView = UITextView()
    private var addEventButton = UIButton()
    private var errorDateLabel: UILabel = UILabel()
    private var emptyFieldsLabel: UILabel = UILabel()

    var addEvent: ((WishEventModel) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView(){
        view.backgroundColor = .green
        configureLabels()
        configureTextViews()
        configureButton()

        let stackView = UIStackView(arrangedSubviews: [
            nameLabel, nameTextView,
            descriptionLabel, descriptionTextView,
            startDateLabel, startDateTextView,
            endDateLabel, endDateTextView,
            addEventButton,
            errorDateLabel, emptyFieldsLabel])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        stackView.distribution = .fill
        stackView.alignment = .center
        view.addSubview(stackView)
        stackView.pinTop(to: view, Constants.stackPin)
        stackView.pinCenterX(to: view)
    }

    private func configureLabels(){
        nameLabel.text = "The event name"
        nameLabel.font = Constants.labelFont
        nameLabel.textColor = .white

        descriptionLabel.text = "The describe event"
        descriptionLabel.font = Constants.labelFont
        descriptionLabel.textColor = .white

        startDateLabel.text = "Start date"
        startDateLabel.font = Constants.labelFont
        startDateLabel.textColor = .white

        endDateLabel.text = "End date"
        endDateLabel.font = Constants.labelFont
        endDateLabel.textColor = .white

        errorDateLabel.text = "Date should look like: MM.DD.YYYY"
        errorDateLabel.font = Constants.errorLabelFont
        errorDateLabel.isHidden = true
        errorDateLabel.textColor = .red

        emptyFieldsLabel.text = "All fields are required!"
        emptyFieldsLabel.font = Constants.errorLabelFont
        emptyFieldsLabel.isHidden = true
        emptyFieldsLabel.textColor = .red
    }

    private func configureTextViews(){
        nameTextView.font = Constants.textViewFont
        nameTextView.backgroundColor = .white
        nameTextView.setHeight(Constants.nameTextViewHeight)
        nameTextView.layer.cornerRadius = Constants.textViewCornerRadius
        nameTextView.setWidth(view.frame.width - Constants.textViewWidthDelta)

        descriptionTextView.font = Constants.textViewFont
        descriptionTextView.backgroundColor = .white
        descriptionTextView.setHeight(Constants.descriptionTextViewHeight)
        descriptionTextView.layer.cornerRadius = Constants.textViewCornerRadius
        descriptionTextView.setWidth(view.frame.width - Constants.textViewWidthDelta)

        startDateTextView.font = Constants.textViewFont
        startDateTextView.backgroundColor = .white
        startDateTextView.setHeight(Constants.nameTextViewHeight)
        startDateTextView.layer.cornerRadius = Constants.textViewCornerRadius
        startDateTextView.setWidth(view.frame.width - Constants.textViewWidthDelta)

        endDateTextView.font = Constants.textViewFont
        endDateTextView.backgroundColor = .white
        endDateTextView.setHeight(Constants.nameTextViewHeight)
        endDateTextView.layer.cornerRadius = Constants.textViewCornerRadius
        endDateTextView.setWidth(view.frame.width - Constants.textViewWidthDelta)
    }

    private func configureButton(){
        addEventButton.setTitle("Add new event", for: .normal)
        addEventButton.titleLabel?.font = Constants.buttonFont
        addEventButton.setTitleColor(Constants.buttonTextColor, for: .normal)
        addEventButton.backgroundColor = .white
        addEventButton.layer.cornerRadius = Constants.buttonConerRadius
        addEventButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addEventButton.isEnabled = true
        addEventButton.translatesAutoresizingMaskIntoConstraints = false
        addEventButton.setHeight(Constants.buttonHeight)
        addEventButton.setWidth(Constants.buttonWidth)
    }

    @objc
    private func addButtonTapped(_ sender: UIButton) {
        let name = nameTextView.text!
        let description = descriptionTextView.text!
        let startDate = startDateTextView.text!
        let endDate = endDateTextView.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"

        if name.isEmpty || description.isEmpty || startDate.isEmpty || endDate.isEmpty {
            showEmptyFieldsError()
            return
        }

        emptyFieldsLabel.isHidden = true

        if let startDate = dateFormatter.date(from: startDate), let endDate = dateFormatter.date(from: endDate) {
            addEvent?(WishEventModel(title: name, description: description, startDate: startDate, endDate: endDate))
            dismiss(animated: true, completion: nil)
        } else {
            showErrorDate()
            return
        }

        nameTextView.text = ""
        descriptionTextView.text = ""
        startDateTextView.text = ""
        endDateTextView.text = ""
        errorDateLabel.isHidden = true
        emptyFieldsLabel.isHidden = true
    }

    private func showErrorDate(){
        errorDateLabel.isHidden = false
    }

    private func showEmptyFieldsError(){
        emptyFieldsLabel.isHidden = false
    }
}
