//
//  HomeView.swift
//  SwiftUIScannerBLE
//
//  Created by Hiago Santos Martins Dias on 02/03/23.
//
import SwiftUI

//
//  HomeView.swift
//  SwiftUIScannerBLE
//
//  Created by Hiago Santos Martins Dias on 02/03/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Text("Scanner BLE")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 16)
            HStack {
                Spacer()
                Button(action: {
                    viewModel.startScanning()
                }) {
                    Text("Scan")
                }
                Spacer()
                Button(action: {
                    viewModel.stopScanning()
                }) {
                    Text("Stop")
                }
                Spacer()
                Button(action: {
                    viewModel.clearList()
                }) {
                    Text("Clear")
                }
                Spacer()
            }.padding(.vertical, 8)
            List(viewModel.discoveredDevices) { device in
                NavigationLink(destination: DetailView(viewModel: DetailViewModel(device: device))) {
                    Text(device.name)
                }
            }
        }
    }
}





