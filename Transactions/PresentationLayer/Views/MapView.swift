//
//  MapView.swift
//  Transactions
//
//  Created by Oguzhan Gungor on 5/12/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    private let viewModel: AtmMapViewItem!
    
    init(viewModel: AtmMapViewItem?) {
        self.viewModel = viewModel
    }
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -25.2744, longitude: 133.7751), span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30))

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [viewModel]) { location in
            MapMarker(coordinate: location.coordinate)
        }
    }
}
