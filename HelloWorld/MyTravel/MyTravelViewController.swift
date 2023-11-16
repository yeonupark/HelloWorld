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
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.rowHeight = (UIScreen.main.bounds.width - 16) / 1.5
        mainView.tableView.separatorColor = .clear
        
        viewModel.myTravelAgendas.bind { _ in
            self.mainView.tableView.reloadData()
        }
        
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.myTravelAgendas.value = agendaRepository.fetch()
    }
    
    func setNavigationItem() {
        navigationItem.title = "나의 여행 계획"
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
        
        navigationItem.backButtonTitle = "취소"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyTravelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.myTravelAgendas.value.isEmpty ? 1 : viewModel.myTravelAgendas.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTravelTableViewCell", for: indexPath) as? MyTravelTableViewCell else { return UITableViewCell() }
        
        if viewModel.myTravelAgendas.value.isEmpty {
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if viewModel.myTravelAgendas.value.isEmpty {
            addButtonClicked()
            return
        }
        
        let table = viewModel.myTravelAgendas.value[indexPath.item]
        let vc = ShowAgendaViewController()
        
        vc.title = table.title
        vc.viewModel.travelAgendaTable = table
        vc.viewModel.savedImages = loadImageFromDocument(folderName: table._id.stringValue, numberOfImages: table.numberOfImages)
        
        navigationItem.backButtonTitle = "나의 여행 계획"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return viewModel.myTravelAgendas.value.isEmpty ? false : true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            deleteButtonClicked(indexPath: indexPath)
        }
    }
    
    func deleteButtonClicked(indexPath: IndexPath) {
        
        let id = viewModel.myTravelAgendas.value[indexPath.row]._id.stringValue
        let numberOfImages = viewModel.myTravelAgendas.value[indexPath.row].numberOfImages
        let agendaTable = self.viewModel.myTravelAgendas.value[indexPath.row]
        
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
