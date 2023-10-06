//
//  MyTravelViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/27.
//

import UIKit

class MyTravelViewController: BaseViewController {
    
    let mainView = MyTravelView()
    
    override func loadView() {
        self.view = mainView
    }
    
    let viewModel = MyTravelViewModel()
    let repository = TravelAgendaTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        viewModel.myTravelAgendas.bind { _ in
            self.mainView.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.myTravelAgendas.value = repository.fetch()
    }
    
    func setNavigationItem() {
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
        let vc = AddNewAgendaViewController()
        vc.title = agendaTitle
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyTravelViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.myTravelAgendas.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: "MyTravelCollectionViewCell", for: indexPath) as? MyTravelCollectionViewCell else { return UICollectionViewCell() }
        
        let startDate = viewModel.dateFormat(date: viewModel.myTravelAgendas.value[indexPath.row].startDate)
        cell.dateLabel.text = startDate
        
        if viewModel.myTravelAgendas.value[indexPath.row].endDate != viewModel.myTravelAgendas.value[indexPath.row].startDate {
            let endDate = viewModel.dateFormat(date: viewModel.myTravelAgendas.value[indexPath.row].endDate)
            cell.dateLabel.text = "\(startDate) - \(endDate)"
        }
        
        cell.titleLabel.text = viewModel.myTravelAgendas.value[indexPath.row].title
        return cell
    }
    
    
}
