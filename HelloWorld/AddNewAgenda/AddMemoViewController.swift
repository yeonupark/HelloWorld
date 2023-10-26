//
//  AddMemoViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/07.
//

import UIKit

class AddMemoViewController: BaseViewController {
    
    var memoText: String = ""
    
    let backgroundView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var textView = {
        let view = UITextView()
        view.backgroundColor = .white
        view.isEditable = true
        view.isScrollEnabled = true
        view.text = memoText
        
        return view
    }()
    
    let okButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "checkmark"), for: .normal)
        view.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
        view.tintColor = Constant.Color.subColor
        
        return view
    }()
    
    var completionHandler: ((String) -> Void)?
    
    @objc func okButtonClicked() {
        completionHandler?(textView.text)
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.becomeFirstResponder()
    }
    
    override func configure() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(okButton)
        backgroundView.addSubview(textView)
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(50)
            make.verticalEdges.equalToSuperview().inset(200)
        }
        okButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
            make.size.equalTo(25)
        }
        textView.snp.makeConstraints { make in
            make.top.equalTo(okButton.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
