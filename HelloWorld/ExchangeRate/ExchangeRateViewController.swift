//
//  ExchangeRateViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/15.
//

import UIKit

class ExchangeRateViewController: BaseViewController {
    
    let mainView = ExchangeRateView()
    override func loadView() {
        view.self = mainView
    }
    
    let viewModel = ExchangeRateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.originalCurrency.bind { value in
            self.mainView.originalLabel.text = value
        }
        viewModel.convertedCurrency.bind { value in
            self.mainView.convertedLabel.text = value
        }
        
        viewModel.originalMoney.bind { money in
            guard let num = money else {
                return
            }
            self.mainView.inputLabel.text = self.format(for: Double(num))
            self.viewModel.convertedMoney.value = self.exchange(originalMoney: Double(num))
        }
        viewModel.convertedMoney.bind { money in
            if let num = money {
                self.mainView.resultLabel.text = self.format(for: num)
            }
        }
        
        mainView.pickerView.delegate = self
        mainView.pickerView.dataSource = self
        mainView.convertButton.addTarget(self, action: #selector(convertButtonClicked), for: .touchUpInside)
        mainView.inputTextField.delegate = self
        mainView.resultView.isHidden = true
        
    }
    
    @objc func convertButtonClicked() {
        mainView.endEditing(true)
        
        guard let original = viewModel.originalCurrency.value?.prefix(3) else {
            return
        }
        guard let convert = viewModel.convertedCurrency.value?.prefix(3) else {
            return
        }
        
        ExchangeRateAPIManager.shared.callRequest(from: String(original), to: String(convert)) { result in
            guard let result = result else {
                print("API 호출 결과 오류")
                return
            }
            self.viewModel.exchangeRate = result.exchange_rate
            print("환율: ", self.viewModel.exchangeRate)
        }
        self.mainView.inputTextField.text = ""
        self.mainView.resultLabel.text = ""
        mainView.resultView.isHidden = false
    }
    
    func exchange(originalMoney: Double) -> Double {
        let convertedMoney = originalMoney * viewModel.exchangeRate
        
        return convertedMoney
    }
    
    func format(for number: Double) -> String {
            let numberFormat = NumberFormatter()
            numberFormat.numberStyle = .decimal
            return numberFormat.string(for: number)!
        }
}

extension ExchangeRateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return viewModel.currencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return viewModel.currencyList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            viewModel.originalCurrency.value = viewModel.currencyList[row]
        } else {
            viewModel.convertedCurrency.value = viewModel.currencyList[row]
        }
    }
}

extension ExchangeRateViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        if text == "" {
            print("오예")
            self.mainView.inputLabel.text = nil
            self.mainView.resultLabel.text = nil
        }
        if let number = Int(text) {
            viewModel.originalMoney.value = number
        }
    }
}
