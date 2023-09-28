//
//  MyTravelCollectionViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/27.
//

import UIKit

class MyTravelCollectionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "my travel list"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addButtonClicked))
        
        
    }
    
    @objc func addButtonClicked() {
        
        let alert = UIAlertController(title: "다음 목적지는 어디인가요?", message: "새로운 여행 계획을 추가해보세요", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "계획 제목 입력"
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            if let text = alert.textFields?.first?.text {
                if text.isEmpty { return }
                self.addNewAgenda(agendaTitle: text)
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func addNewAgenda(agendaTitle: String) {
        let vc = AddNewAgendaCollectionViewController()
        vc.title = agendaTitle
        navigationController?.pushViewController(vc, animated: true)
    }
}
