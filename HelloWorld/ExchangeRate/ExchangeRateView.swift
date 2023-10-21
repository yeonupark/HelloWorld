//
//  ExchangeRateView.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/15.
//

import UIKit

class ExchangeRateView: BaseView {
    
    let backView = {
        let view = UIImageView()
        //view.image = UIImage(named: "WaterImage")
        view.layer.opacity = 0.7
        
        return view
    }()
    
    let chooseCurrencyField = {
        let view = UITextField()
        view.text = " 통화 선택하기 "
        view.textColor = .white
        view.backgroundColor = Constant.Color.subColor
        view.font = UIFont(name: Constant.FontName.bold, size: 15)
        view.tintColor = .clear
        view.layer.borderColor = Constant.Color.subColor?.cgColor
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let pickerView = {
        let view = UIPickerView()
        view.backgroundColor = UIColor(named: "MainColor")
        return view
    }()
    
    let clickLabel = {
        let view = UILabel()
        view.text = " Click!"
        view.font = UIFont(name: Constant.FontName.regular, size: 12)
        view.textColor = Constant.Color.subColor
        return view
    }()
    
    let arrowImage = {
        let view = UIImageView()
        view.image = UIImage(systemName: "dollarsign.arrow.circlepath")
        view.tintColor = Constant.Color.subColor
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
        view.font = UIFont(name: Constant.FontName.bold, size: 15)
        return view
    }()
    
    let convertedLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: Constant.FontName.bold, size: 15)
        return view
    }()
    
    let resultView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = Constant.Color.subColor
        
        return view
    }()
    
//    let resultArrowImage = {
//        let view = UIImageView()
//        view.image = UIImage(systemName: "arrow.forward.circle")
//        view.tintColor = Constant.Color.subColor
//        return view
//    }()
    
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
        view.textColor = .white
        return view
    }()
    
    let resultLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .white
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
    
    let exchangeRateLabel = {
        let view = UILabel()
        
        return view
    }()
    
    override func configure() {
        chooseCurrencyField.inputView = pickerView
        
        addSubview(backView)
        
        for item in [chooseCurrencyField, arrowImage, clickLabel, convertButton, originalLabel, convertedLabel, resultView, exchangeRateLabel] {
            addSubview(item)
        }
        
        for item in [inputTextField, inputLabel, resultLabel, originalFlag, convertedFlag] {
            resultView.addSubview(item)
        }
    }
    
    override func setConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
        clickLabel.snp.makeConstraints { make in
            make.bottom.equalTo(arrowImage.snp.top)
            make.horizontalEdges.equalTo(arrowImage)
            make.height.equalTo(20)
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
        
//        resultArrowImage.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.size.equalTo(40)
//        }
        inputTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalTo(resultView.snp.centerX)
            make.height.equalTo(40)
        }
        inputLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalTo(resultView.snp.centerX)
        }
        resultLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(resultView.snp.centerX)
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
        exchangeRateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(resultView.snp.top)
            make.leading.equalTo(resultView).inset(4)
            make.height.equalTo(20)
        }
    }
}
