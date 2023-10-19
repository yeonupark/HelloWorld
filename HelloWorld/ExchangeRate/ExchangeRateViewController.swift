//
//  ExchangeRateViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/15.
//

import UIKit
import Kingfisher

class ExchangeRateViewController: BaseViewController {
    
    let mainView = ExchangeRateView()
    override func loadView() {
        view.self = mainView
    }
    
    let viewModel = ExchangeRateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.originalNation.bind { value in
            guard let value = value else { return }
            self.mainView.originalLabel.text = "\(value.nation) \(value.currency)"
            
            let url = URL(string: "https://flagcdn.com/w80/\(value.code).jpg")
            self.mainView.originalFlag.kf.setImage(with: url)
        }
        viewModel.convertedNation.bind { value in
            guard let value = value else { return }
            self.mainView.convertedLabel.text = "\(value.nation) \(value.currency)"
            
            let url = URL(string: "https://flagcdn.com/w80/\(value.code).jpg")
            self.mainView.convertedFlag.kf.setImage(with: url)
        }
        
        viewModel.originalMoney.bind { money in
            guard let num = money else {
                return
            }
            guard let unit = self.viewModel.originalNation.value?.unit else { return }
            self.mainView.inputLabel.text = "\(self.viewModel.format(for: Double(num))) \(unit)"
            self.viewModel.convertedMoney.value = self.viewModel.exchange(originalMoney: Double(num))
        }
        viewModel.convertedMoney.bind { money in
            if let num = money {
                guard let unit = self.viewModel.convertedNation.value?.unit else { return }
                self.mainView.resultLabel.text = "\(self.viewModel.format(for: num)) \(unit)"
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
        
        guard let original = viewModel.originalNation.value?.currency else {
            return
        }
        guard let convert = viewModel.convertedNation.value?.nation else {
            return
        }
        
//        ExchangeRateAPIManager.shared.callRequest(from: String(original), to: String(convert)) { result in
//            guard let result = result else {
//                print("API 호출 결과 오류")
//                return
//            }
//            self.viewModel.exchangeRate = result.exchange_rate
//            print("환율: ", self.viewModel.exchangeRate)
//        }
        self.mainView.inputTextField.text = ""
        self.mainView.inputLabel.text = ""
        self.mainView.resultLabel.text = ""
        mainView.resultView.isHidden = false
    }
    
    func uploadImage(countryCode: String) {
        let url = URL(string: "")
        mainView.originalFlag.kf.setImage(with: url)
    }
}

extension ExchangeRateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return viewModel.nationList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return viewModel.nationList[row].nation
        //return viewModel.currencyList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            viewModel.originalNation.value = viewModel.nationList[row]
        } else {
            viewModel.convertedNation.value = viewModel.nationList[row]
        }
    }
}

extension ExchangeRateViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        if text == "" {
            self.mainView.inputLabel.text = nil
            self.mainView.resultLabel.text = nil
        }
        if let number = Int(text) {
            viewModel.originalMoney.value = number
        }
    }
}
