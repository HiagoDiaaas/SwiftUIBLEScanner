//
//  SwiftUIScannerBLEApp.swift
//  SwiftUIScannerBLE
//
//  Created by Hiago Santos Martins Dias on 02/03/23.
//

import SwiftUI

@main
struct ScannerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView(viewModel: HomeViewModel())
            }
        }
    }
}

