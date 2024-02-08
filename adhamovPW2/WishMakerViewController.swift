//
//  WishMakerViewController.swift
//  adhamovPW2
//
//  Created by Alibek Adhamov on 28.09.2023.
//

import UIKit

class WishMakerViewController: UIViewController, UIColorPickerViewControllerDelegate {
    // - MARK: Constants
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let alpha: CGFloat = 1
        
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = 15
        static let stackHorizontal: CGFloat = 20
        
        static let titleTop: CGFloat = 20
        static let titleText: String = "WishMaker"
        static let titleFontSize: CGFloat = 32
        
        static let descriptionTop: CGFloat = 20
        static let descriptionHorizontal: CGFloat = 20
        static let descriptionText: String = "This app will bring your joy and will fulfill three of your wishes!\n\t- The first is to change the background color."
        static let descriptionFontSize: CGFloat = 16
        
        static let switchBottom: CGFloat = 20
        static let switchTitleText: String = "Sliders"
        static let switchTitleBottom: CGFloat = 5
        
        static let randomButtonText: String = "Get random color"
        static let randomButtonBottom: CGFloat = 20
        static let randomButtonWidth: CGFloat = 170
        static let randomButtonHeight: CGFloat = 45
        
        static let colorPickerText: String = "Select color"
        static let colorPickerBottom: CGFloat = 20
        static let colorPickerWidth: CGFloat = 170
        static let colorPickerHeight: CGFloat = 45
        
        static let numberOfLines = 0
        
        static let rectangle: CGFloat = 0
        
        static let stackBottom2: CGFloat = -1
        
    }
    
    // - MARK: Fields
    private var myTitle = UILabel()
    private let stack = UIStackView()
    private let titleSwitchView = UILabel()
    private let grantWishButton = UIButton(type: .system)
    let randomColorButton = UIButton(frame:CGRect(x: Constants.rectangle, y: Constants.rectangle, width: Constants.rectangle, height: Constants.rectangle))
    private var buttons: [UIButton] = []


        private var color: UIColor = .black{
            didSet{
                changeColor()
            }
        }

    
    // - MARK: Main
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // - MARK: ConfigureUI
    private func configureUI() {
        view.backgroundColor = color
        configureTitle()
        configureDescription()
        configureSliders()
        configureSwitch()
        configureRandomButton()
        configureColorPickerButton()
        configureGrantWishButton()
        getAllButtons(from: view, into: &buttons)
    }
    
    // - MARK: Configure Grant Wish Button
    private func configureGrantWishButton() {
        grantWishButton.translatesAutoresizingMaskIntoConstraints = false
        randomColorButton.setTitleColor(.black, for: .normal)
        grantWishButton.setTitle("Grant Wish", for: .normal)
        grantWishButton.addTarget(self, action: #selector(grantWishButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(grantWishButton)
        grantWishButton.backgroundColor = .white
        grantWishButton.layer.cornerRadius = 20
        
        grantWishButton.pinCenterX(to: view)
        grantWishButton.pinTop(to: stack.bottomAnchor, Constants.stackBottom2)
        grantWishButton.setWidth(Constants.randomButtonWidth)
        grantWishButton.setHeight(Constants.randomButtonHeight)
    }
    
    @objc private func grantWishButtonTapped(_ sender: UIButton) {
        let vc = WishCalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // - MARK: Configure Title
    private func configureTitle() {
        myTitle.translatesAutoresizingMaskIntoConstraints = false
        myTitle.text = Constants.titleText
        myTitle.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        myTitle.textColor = color
        
        view.addSubview(myTitle)
        myTitle.pinCenterX(to: view)
        myTitle.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
    }
    
    // - MARK: Configure Description
    private func configureDescription() {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.text = Constants.descriptionText
        description.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        description.lineBreakMode = .byWordWrapping
        description.numberOfLines = Constants.numberOfLines
        description.textColor = .white
        view.addSubview(description)
        
        description.pinCenterX(to: view)
        description.pinHorizontal(to: view, Constants.descriptionHorizontal)
        description.pinTop(to: myTitle.bottomAnchor, Constants.descriptionTop)
    }
    
    // - MARK: Configure Sliders
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        stack.isHidden = true
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }
        
        stack.pinCenterX(to: view)
        stack.pinHorizontal(to: view, Constants.stackHorizontal)
        stack.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.stackBottom)
        
        for sliderColor in [sliderRed, sliderBlue, sliderGreen] {
            sliderColor.valueChanged = { [weak self] value in
                self?.color = UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: Constants.alpha)
            }
        }
    }
    
    // - MARK: Configure Sliders Switch
    private func configureSwitch() {
        let sliderSwitch = UISwitch(frame:CGRect(x: Constants.rectangle, y: Constants.rectangle, width: Constants.rectangle, height: Constants.rectangle))
        sliderSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        view.addSubview(sliderSwitch)
        sliderSwitch.isOn = false
        sliderSwitch.translatesAutoresizingMaskIntoConstraints = false
        sliderSwitch.pinCenterX(to: view)
        sliderSwitch.pinBottom(to: stack.topAnchor, Constants.switchBottom)
        
        view.addSubview(titleSwitchView)
        titleSwitchView.translatesAutoresizingMaskIntoConstraints = false
        titleSwitchView.textColor = .white
        titleSwitchView.text = Constants.switchTitleText
        titleSwitchView.pinCenterX(to: view)
        titleSwitchView.pinBottom(to: sliderSwitch.topAnchor, Constants.switchTitleBottom)
    }
    
    @objc
    private func switchValueChanged(_ sender:UISwitch!) {
        stack.isHidden = !sender.isOn
    }
    
    // - MARK: Configure Random Color
    private func configureRandomButton() {
        randomColorButton.translatesAutoresizingMaskIntoConstraints = false
        randomColorButton.backgroundColor = .white
        randomColorButton.setTitle(Constants.randomButtonText, for: .normal)
        randomColorButton.setTitleColor(.black, for: .normal)
        randomColorButton.addTarget(self, action: #selector(randomButtonTouched(_:)), for: .touchUpInside)
        
        view.addSubview(randomColorButton)
        randomColorButton.pinBottom(to: titleSwitchView.topAnchor, Constants.randomButtonBottom)
        randomColorButton.setWidth(Constants.randomButtonWidth)
        randomColorButton.setHeight(Constants.randomButtonHeight)
        randomColorButton.pinCenter(to: view)
    }
    
    @objc
    private func randomButtonTouched(_ sender:UIButton!) {
        view.backgroundColor = UIColor.getRandomColor()
    }
    
    // - MARK: Configure Color Picker
    private func configureColorPickerButton() {
        let colorPickerButton = UIButton(frame:CGRect(x: Constants.rectangle, y: Constants.rectangle, width: Constants.rectangle, height: Constants.rectangle))
        colorPickerButton.translatesAutoresizingMaskIntoConstraints = false
        colorPickerButton.backgroundColor = .white
        colorPickerButton.setTitle(Constants.colorPickerText, for: .normal)
        colorPickerButton.setTitleColor(.black, for: .normal)
        view.addSubview(colorPickerButton)
        colorPickerButton.pinBottom(to: randomColorButton.topAnchor, Constants.colorPickerBottom)
        colorPickerButton.setWidth(Constants.colorPickerWidth)
        colorPickerButton.setHeight(Constants.colorPickerHeight)
        colorPickerButton.pinCenter(to: view)
        if #available(iOS 14.0, *) {
            colorPickerButton.addTarget(self, action: #selector(colorPickerButtonTouched(_:)), for: .touchUpInside)
        } else {
            colorPickerButton.backgroundColor = .gray
        }
    }
    
    @available(iOS 14.0, *)
    @objc
    private func colorPickerButtonTouched(_ sender:UIButton!) {
        let colorPickerViewController = UIColorPickerViewController()
        colorPickerViewController.delegate = self
        present(colorPickerViewController, animated: true)
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        view.backgroundColor = viewController.selectedColor
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
    }
    
    private func changeColor(){
            view.backgroundColor = color
            for button in buttons {
                button.setTitleColor(color, for: .normal)
            }
        }

        private func getAllButtons(from: UIView, into arr: inout [UIButton]){
            for subview in from.subviews {
                if subview.subviews.count > 0 {
                    getAllButtons(from: subview, into: &arr)
                }
                else if subview is UIButton {
                    let button = subview as! UIButton
                    arr.append(button)
                }
            }
        }
}
