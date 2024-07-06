//
//  RMSettingsView.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 6.07.2024.
//

//        List(viewModel.cellViewModels) { viewModel in
//            HStack {
////                if let image = viewModel.title {
////                    Image(uiImage: image)
////                        .resizable()
////                        .frame(width: 20, height: 20)
////                        .padding(8)
////                        .background(Color(cellViewModel.iconBackgroundColor))
////                        .cornerRadius(8)
////                }
//                Text(viewModel.title)
//                    .padding(.leading, 10)
//            }
//            .padding(8)
//        }
//    }
//}
//
//#Preview {
//    RMSettingsView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({
//        RMSettingsCellViewModel(type: $0)
//    })))
//}

import SwiftUI

struct RMSettingsView: View {
    let viewModel: RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack {
                if let image = viewModel.image{
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .background(Color(viewModel.iconConteinerColor))
                        .cornerRadius(8)
                }
                Text(viewModel.title)
                    .padding(.leading, 10)
            }
            .padding(.bottom, 3)
        }
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({
            RMSettingsCellViewModel(type: $0)
        })))
    }
}
