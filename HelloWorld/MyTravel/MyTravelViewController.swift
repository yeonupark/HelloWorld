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
    let agendaRepository = TravelAgendaTableRepository()
    let todoRepository = ToDoTableRepository()
    let costRepository = CostTableRepository()
    let linkRepository = LinkTableRepository()
    let locationRepository = LocationTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        viewModel.myTravelAgendas.bind { _ in
            self.mainView.collectionView.reloadData()
        }
        viewModel.isEditable.bind { _ in
            self.mainView.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.myTravelAgendas.value = agendaRepository.fetch()
    }
    
    func setNavigationItem() {
        view.backgroundColor = .white
        
        navigationItem.title = "나의 여행 계획"
        
        let editButton = UIBarButtonItem(image: .remove, style: .plain, target: self, action: #selector(editButtonClicked(sender: )))
        let addButton = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addButtonClicked))
        
        navigationItem.setLeftBarButton(editButton, animated: true)
        navigationItem.setRightBarButton(addButton, animated: true)
    }
    
    @objc func editButtonClicked(sender: UIBarButtonItem) {
        if viewModel.isEditable.value {
            sender.image = .remove
            viewModel.isEditable.value = false
        } else {
            sender.image = UIImage(systemName: "checkmark.circle.fill")
            viewModel.isEditable.value = true
        }
    }
    
    @objc func addButtonClicked() {
        
        let alert = UIAlertController(title: "새로운 여행 계획을 추가해보세요", message: "다음 목적지는 어디인가요?", preferredStyle: .alert)
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
        vc.viewModel.isUpdatingView = false
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyTravelViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.myTravelAgendas.value.isEmpty ? 1 : viewModel.myTravelAgendas.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: "MyTravelCollectionViewCell", for: indexPath) as? MyTravelCollectionViewCell else { return UICollectionViewCell() }
        
        cell.deleteButton.isHidden = !(viewModel.isEditable.value)
        
        if viewModel.myTravelAgendas.value.isEmpty {
            cell.deleteButton.isHidden = true
            cell.dateLabel.text?.removeAll()
            cell.titleLabel.text = "아직 여행 계획이 없습니다. \n계획을 추가해보세요! 🪂 "
            cell.titleLabel.font = UIFont(name: Constant.FontName.regular, size: 18)
            return cell
        }
        
        let startDate = viewModel.dateFormat(date: viewModel.myTravelAgendas.value[indexPath.row].startDate)
        cell.dateLabel.text = startDate
        
        if viewModel.myTravelAgendas.value[indexPath.row].endDate != viewModel.myTravelAgendas.value[indexPath.row].startDate {
            let endDate = viewModel.dateFormat(date: viewModel.myTravelAgendas.value[indexPath.row].endDate)
            cell.dateLabel.text = "\(startDate) - \(endDate)"
        }
        
        cell.titleLabel.text = viewModel.myTravelAgendas.value[indexPath.row].title
        cell.titleLabel.font = UIFont(name: Constant.FontName.bold, size: 34)
        
        if viewModel.isEditable.value {
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(sender: )), for: .touchUpInside)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if viewModel.myTravelAgendas.value.isEmpty {
            return
        }
        
        let table = viewModel.myTravelAgendas.value[indexPath.item]
        let vc = ShowAgendaViewController()
        
        vc.title = table.title
        vc.viewModel.travelAgendaTable = table
        vc.viewModel.savedImages = loadImageFromDocument(folderName: table._id.stringValue, numberOfImages: table.numberOfImages)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func deleteButtonClicked(sender: UIButton) {
        
        let id = viewModel.myTravelAgendas.value[sender.tag]._id.stringValue
        let numberOfImages = viewModel.myTravelAgendas.value[sender.tag].numberOfImages
        let agendaTable = self.viewModel.myTravelAgendas.value[sender.tag]
        
        let alert = UIAlertController(title: "여행 계획 삭제", message: "선택하신 여행 계획을 삭제하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            
            self.removeImagesFromDocument(folderName: id, numberOfImages: numberOfImages)
            self.removeFolder(folderName: id)
            self.agendaRepository.deleteItem(agendaTable)
            self.todoRepository.deleteItemFromID(id)
            self.costRepository.deleteItemFromID(id)
            self.linkRepository.deleteItemFromID(id)
            self.locationRepository.deleteItemFromID(id)
            
            self.viewModel.myTravelAgendas.value = self.agendaRepository.fetch()
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
        
    }
    
}
