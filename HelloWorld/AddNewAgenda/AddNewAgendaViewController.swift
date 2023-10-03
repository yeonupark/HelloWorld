//
//  AddNewAgendaViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/28.
//

import UIKit
import SnapKit

class AddNewAgendaViewController: BaseViewController {
    
    var viewModel = AddNewAgendaViewModel()

    let mainView = AddNewAgendaView()
    override func loadView() {
        view.self = mainView
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        configureDataSource()
        
        viewModel.checkList.bind { _ in
            self.updateSnapshot()
        }
        viewModel.memoText.bind { _ in
            self.updateSnapshot()
        }
        viewModel.costList.bind { _ in
            self.updateSnapshot()
        }
        viewModel.linkList.bind { _ in
            self.updateSnapshot()
        }
        viewModel.dateList.bind { dateList in
            if !dateList.isEmpty {
                let result = self.viewModel.dateFormat(date: dateList[0])
                self.mainView.startDatetextField.text = result
                self.mainView.endDateLabel.text?.removeAll()
            }
            if dateList.count > 1 {
                let result = self.viewModel.dateFormat(date: dateList[1])
                self.mainView.endDateLabel.text = "-    \(result)"
            }
        }

        mainView.collectionView.delegate = self
        mainView.datePickerView.addTarget(self, action: #selector(getDate(sender: )), for: .valueChanged)
    }
    
    func setNavigationBar() {
        let archiveButton = UIBarButtonItem(image: UIImage(systemName: "archivebox"), style: .plain, target: self, action: #selector(archiveButtonClicked))
        
        let saveButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        navigationItem.setRightBarButtonItems([archiveButton, saveButton], animated: true)
    }
    
    @objc func saveButtonClicked() {
        // realm에 저장
    }
    
    @objc func archiveButtonClicked() {
        navigationController?.pushViewController(AddPhotoViewController(), animated: true)
    }
    
    @objc func getDate(sender: UIDatePicker) {
        let date = sender.date
        
        // 1. 아예 처음 선택한 경우
        // 2. 두번째 잘 선택한 경우
        // 3. 첫번째보다 먼저 날짜의 두번째를 선택한 경우 -> 리셋
        // 4. 두개 이미 잘 들어가 있는데 다시 날짜 선택하는 경우
        
        if viewModel.dateList.value.isEmpty {
            viewModel.dateList.value.append(date)
        } else if viewModel.dateList.value.count == 1 && viewModel.dateList.value[0] < date {
            viewModel.dateList.value.append(date)
        } else if viewModel.dateList.value.count == 1 && viewModel.dateList.value[0] > date {
            viewModel.dateList.value[0] = date
        } else if viewModel.dateList.value.count > 1 {
            viewModel.dateList.value.removeAll()
            viewModel.dateList.value.append(date)
        }
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        
        snapshot.appendSections([.MemoText, .CheckList, .CostList, .LinkList])
        
        snapshot.appendItems(viewModel.checkList.value, toSection: .CheckList)
        snapshot.appendItems([viewModel.memoText.value], toSection: .MemoText)
        snapshot.appendItems(viewModel.costList.value, toSection: .CostList)
        snapshot.appendItems(viewModel.linkList.value, toSection: .LinkList)
        
        dataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        
        mainView.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()

            content.text = itemIdentifier
            content.textProperties.font = .boldSystemFont(ofSize: 15)
                
            if indexPath.section == 1 {
                content.image = UIImage(systemName: "checkmark.square")
                content.imageProperties.tintColor = .systemPink
            }
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .white
            //backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 1
            backgroundConfig.strokeColor = .systemPink
            cell.backgroundConfiguration = backgroundConfig
            
            
        })
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            if indexPath.section == 0 {

                let textView = UITextView()
                textView.backgroundColor = .white
                textView.isEditable = true
                textView.font = UIFont.systemFont(ofSize: 17)
                textView.textContainer.maximumNumberOfLines = 0
                
                textView.text = self.viewModel.memoText.value
                
                cell.contentView.addSubview(textView)
                textView.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(8)
                }
            }
            
            return cell
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                
                let headerView = self.mainView.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath)
                headerView.backgroundColor = .systemPink
                
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                let label = UILabel()
                label.text = "\(section.rawValue)"
                label.font = UIFont.boldSystemFont(ofSize: 17)
                label.textColor = UIColor.white
                //label.translatesAutoresizingMaskIntoConstraints = false
                
                let addButton = UIButton()
                addButton.setImage(UIImage(systemName: "plus"), for: .normal)
                addButton.tag = indexPath.section
                addButton.tintColor = .white
                addButton.addTarget(self, action: #selector(self.addButtonClicked(sender: )), for: .touchUpInside)
                
                headerView.addSubview(label)
                headerView.addSubview(addButton)
                
                label.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(10)
                }
                addButton.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.size.equalTo(headerView.snp.height)
                }
                if indexPath.section == 0 {
                    addButton.isHidden = true
                }
                return headerView
            }
            
            return UICollectionReusableView()
        }
        
    }
    
    @objc func addButtonClicked(sender: UIButton) {
        mainView.endEditing(true)
        let alert = UIAlertController(title: "새로운 항목을 추가하세요", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "새로운 항목 입력"
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            if let text = alert.textFields?.first?.text {
                if text.isEmpty { return }
                
                switch sender.tag {
                case 1 : self.viewModel.checkList.value.append(text)
                case 2: self.viewModel.costList.value.append(text)
                case 3: self.viewModel.linkList.value.append(text)
                default: print("error")
                }
                self.updateSnapshot()
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
        
        
    }
    
}

extension AddNewAgendaViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        mainView.endEditing(true)
        
    }
    
}
