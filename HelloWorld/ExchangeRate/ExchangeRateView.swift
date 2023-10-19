//
//  ExchangeRateView.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/15.
//

import UIKit

class ExchangeRateView: BaseView {
    
    let chooseCurrencyField = {
        let view = UITextField()
        view.text = "통화 선택하기"
        view.textColor = .systemBlue
        view.font = UIFont(name: Constant.FontName.regular, size: 16)
        view.tintColor = .clear
        
        return view
    }()
    
    let pickerView = {
        let view = UIPickerView()
        view.backgroundColor = UIColor(named: "MainColor")
        return view
    }()
    
    let arrowImage = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrow.forward.circle")
        return view
    }()
    
    let convertButton = {
        let view = UIButton()
        view.tintColor = .clear
        
        return view
    }()
    
    let originalLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    let convertedLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    let resultView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(named: "SkyBlue")
        
        return view
    }()
    
    let resultArrowImage = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrow.forward.circle")
        view.tintColor = .white
        return view
    }()
    
    let inputTextField = {
        let view = UITextField()
        view.placeholder = "금액 입력"
        view.keyboardType = .numberPad
        view.font = UIFont(name: Constant.FontName.regular, size: 15)
        view.tintColor = .clear
        view.textColor = .clear
        return view
    }()
    
    let inputLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    let resultLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    let originalFlag = {
        let view = UIImageView()
        
        return view
    }()
    
    let convertedFlag = {
        let view = UIImageView()
        
        return view
    }()
    
    override func configure() {
        chooseCurrencyField.inputView = pickerView
        
        for item in [chooseCurrencyField, arrowImage, convertButton, originalLabel, convertedLabel, resultView] {
            addSubview(item)
        }
        
        for item in [resultArrowImage, inputTextField, inputLabel, resultLabel, originalFlag, convertedFlag] {
            resultView.addSubview(item)
        }
    }
    
    override func setConstraints() {
        chooseCurrencyField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        arrowImage.snp.makeConstraints { make in
            make.top.equalTo(chooseCurrencyField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(40)
        }
        convertButton.snp.makeConstraints { make in
            make.top.equalTo(chooseCurrencyField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(40)
        }
        originalLabel.snp.makeConstraints { make in
            make.top.equalTo(chooseCurrencyField.snp.bottom).offset(40)
            make.trailingMargin.equalTo(arrowImage).inset(60)
            make.height.equalTo(40)
        }
        convertedLabel.snp.makeConstraints { make in
            make.top.equalTo(chooseCurrencyField.snp.bottom).offset(40)
            make.leading.equalTo(arrowImage.snp.trailing).offset(20)
            make.height.equalTo(40)
        }
        
        resultView.snp.makeConstraints { make in
            make.top.equalTo(arrowImage.snp.bottom).offset(80)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(150)
        }
        
        resultArrowImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
        }
        inputTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
            make.trailingMargin.equalTo(resultArrowImage).inset(60)
            make.height.equalTo(40)
        }
        inputLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
            make.trailingMargin.equalTo(resultArrowImage).inset(60)
        }
        resultLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(resultArrowImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(12)
        }
        
        originalFlag.snp.makeConstraints { make in
            make.top.equalTo(resultView.snp.top).inset(20)
            make.leading.equalTo(inputLabel.snp.leading).inset(4)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        convertedFlag.snp.makeConstraints { make in
            make.top.equalTo(resultView.snp.top).inset(20)
            make.leading.equalTo(resultLabel.snp.leading)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
    }
}
