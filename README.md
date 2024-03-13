# TRIPISH

<img src = "https://github.com/yeonupark/MessengerProject/assets/130972950/1a559549-5162-4b8f-8bd3-71eec9419701" width="15%" height="17%">
 <img src = "https://github.com/yeonupark/MessengerProject/assets/130972950/0bb0b35f-e022-48c7-8355-6872d9a5d7dc" width="15%" height="17%">
 <img src = "https://github.com/yeonupark/MessengerProject/assets/130972950/ccb4c033-6748-4b84-ac1c-e9361af7c469" width="15%" height="17%">
 <img src = "https://github.com/yeonupark/MessengerProject/assets/130972950/ba5d0c94-5e21-4cf7-b6a8-a31b6ed689d7" width="15%" height=17%">
 <img src = "https://github.com/yeonupark/MessengerProject/assets/130972950/3e012d5a-5238-45f7-8af6-b6976816fbd3" width="15%" height="17%">
  <img src = "https://github.com/yeonupark/MessengerProject/assets/130972950/0eeff9af-639d-44c0-b748-0c51decf6d94" width="15%" height="17%">

https://apps.apple.com/kr/app/tripish-travel-planner/id6470174798?l=en-GB

## 한 줄 소개
Tripish는 여행에 필요한 요소들을 한 곳에 모아 여행 계획을 간편하고 쉽게 만들어주는 애플리케이션으로, Tripish를 통해 여행 계획을 저장할 수 있으며 현지 날씨 및 실시간 환율을 확인할 수 있습니다.

## 핵심 기능
- Realm DB를 사용하여 메모, 체크리스트, 예상 비용, 웹사이트 링크, 위치 등을 한 곳에서 효율적으로 관리 (저장, 수정, 삭제 기능)
- PhotosUI를 통해 불러온 이미지를 Realm을 통해 저장할 수 있으며, MapKit을 활용하여 지도에서 여행지 확인 가능
- WeatherKit을 활용해 여행지의 날씨와 현지 시간 정보 제공
- Alamofire + Router 패턴을 통해 실시간 환율 정보를 불러오고, 환율을 기반으로 계산된 금액을 제공
- Localization을 통해 사용자 맞춤 언어 제공 (영어, 한국어)
  
## 개발 기간
2024.09.27 ~ 2024.10.25 (4주)

## 기술 스택 및 라이브러리
- UIKit
- MapKit, WeatherKit
- PhotosUI
- MVVM, MVC
- CodebaseUI
- Compositional Layout & Diffable Datasource
- SnapKit
- Realm
- Alamofire
- Firebase Analytics/ Crashtics

## 트러블 슈팅
diffable datasource를 통해 구성된 컬렉션뷰에 저장된 체크리스트, 비용, 링크를 삭제했을 때 index out of range 오류나, 해당 셀이 아닌 다른 셀이 삭제되는 등의 오류에 부딪혔다. 
처음에는 버튼의 태그를 사용하여 셀을 식별하고 삭제했으나, 이 방식은 셀이 삭제된 후에 다시 새로운 셀이 추가되면 index가 변경되어 오류가 발생하는 문제가 있었다. 

이 문제를 해결하기 위해 button.tag 대신에 itemIdentifier를 사용하여 셀을 삭제하는 방식으로 수정했다. 이로써 해당 아이템에 직접 접근하여 적절한 셀이 삭제되고 올바르게 동작했다. 다만 배열의 remove 함수를 사용했을 때와 달리 반복문을 통한 삭제가 이루어져 효율성 측면에서 좋은 방법은 아닐지 모른다는 생각이 들었다. 그러나 오류를 막을 수 있어 다행이었고, 나아가 더 나은 방법에 대해 연구해보고 적용해보는 것이 필요하다고 생각했다.
```swift
dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            if indexPath.section != 0 {
                
                let deleteButton = UIButton()
                deleteButton.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
                deleteButton.tintColor = .red
                deleteButton.tag = indexPath.row
                
                deleteButton.addAction(UIAction(handler: { _ in
                    
                    switch indexPath.section {
                    case 1: self.viewModel.deleteFromToDoList(item: itemIdentifier)
                    case 2: self.viewModel.deleteFromCostList(item: itemIdentifier)
                    case 3: self.viewModel.deleteFromLinkList(item: itemIdentifier)
                    default: print("셀에서 삭제버튼 클릭시 오류")
                    }
                }), for: .touchUpInside)
                
                cell.contentView.addSubview(deleteButton)
                deleteButton.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.trailing.equalToSuperview().inset(10)
                    make.size.equalTo(20)
                }
            }
            
            return cell
        })
```

## 회고
이번 프로젝트는 내가 직접 만든 앱이 처음으로 앱스토어에 등록되었다는 점에서 매우 뿌듯하고 뜻 깊었다. 첫 구상 때 부터 출시가 완료되기 까지 프로젝트를 진행하며 기획부터 개발, 테스트, 배포까지의 과정 중 어느 하나 빠짐없이 중요하다는 것을 실감할 수 있었다. 

출시 직전에 내부테스트를 해본 결과 여행 계획을 만들지 않은 상태에서 안내문구가 떠 있는 셀을 클릭하면 index out of range 에러가 발생해서 앱이 꺼지는 문제 상황이 발견됐다. 다행히 피드백을 받아 오류를 해결하는 과정을 거친 뒤 배포가 이루어져 현재까지 충돌 수 0을 유지하고 있다. 앱을 출시하기 전에 피드백을 통해 오류가 발견되어서 정말 다행이었다. 내가 발견하지 못한 부분에 대해 사용자들의 피드백을 받아 기능을 개선하고 버그를 수정하는 과정에서 실제 서비스를 운영하는 것에서 피드백이 얼마나 중요한지 깨달을 수 있었다. 

서비스 출시 이후에도 UI 업데이트나 기능을 조금씩 추가하며 지속적인 업데이트를 하고 있다. 앞으로도 다양한 기능들을 추가하고, 메모리와 성능 측면에서도 보다 효율적으로 운영할 수 있도록 공부하며 서비스를 계속해서 발전시키고자 한다. 앱스토어에 등록된 첫 어플인 만큼 애정과 책임감을 가지고 꾸준히 운영해나가고 싶다!
