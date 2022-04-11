//
//  ErrorView.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/11.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, World!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
        .cornerRadius(16)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case errorRequired
    }
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired, guidance: "You can safely ignore this this error.")
    }
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
    
   
}
