//
//  MapView.swift
//  MyMap
//
//  Created by YutaNoguchi on 2023/05/27.
//

import SwiftUI
import MapKit

enum MapType {
    case standard
    
    case satellite
    
    case hybrid
}

struct MapView: UIViewRepresentable {
    let searchkey: String
    let mapType: MapType
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("検索キーワード : \(searchkey)")
        
        switch mapType {
        case .standard:
            uiView.preferredConfiguration = MKStandardMapConfiguration(elevationStyle: .flat)
        case .satellite:
            uiView.preferredConfiguration = MKImageryMapConfiguration()
        case .hybrid:
            uiView.preferredConfiguration = MKHybridMapConfiguration()
        }
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(
            searchkey,
            completionHandler: {(placemarks, error) in
                if let placemarks,
                   let firstPlacemark = placemarks.first,
                   let location = firstPlacemark.location {
                    
                    let targetCoordinate = location.coordinate
                    print("検索キーワード : \(targetCoordinate)")
                    
                    let pin = MKPointAnnotation()
                    
                    pin.coordinate = targetCoordinate
                    
                    pin.title = searchkey
                    
                    uiView.addAnnotation(pin)
                    
                    uiView.region = MKCoordinateRegion(
                    center: targetCoordinate,
                    latitudinalMeters: 500.0,
                    longitudinalMeters: 500.0
                    )
                }
            }
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(searchkey: "羽田空港", mapType: .standard)
    }
}
