//
//  DetailView.swift
//  SwiftUIScannerBLE
//
//  Created by Hiago Santos Martins Dias on 02/03/23.
//
import SwiftUI

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        VStack {
            if viewModel.isConnecting {
                ProgressView("Connecting...")
            } else {
                Text("Manufacturer Name: \(viewModel.manufacturerName)")
                Text("Model Name: \(viewModel.modelName)")
            }
        }
        .onAppear {
            viewModel.connectToDevice(peripheral: viewModel.selectedPeripheral)
        }

        .navigationBarTitle(Text(viewModel.device.name), displayMode: .inline)
    }
}




