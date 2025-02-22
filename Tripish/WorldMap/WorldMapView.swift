//
//  WorldMapView.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/11.
//

import UIKit
import MapKit

class WorldMapView: BaseView {
    
    let mapView = {
        let view = MKMapView()
        
        return view
    }()
    
    override func configure() {
        addSubview(mapView)
    }
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
