//
//  PaginatorView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 22/12/24.
//

import SwiftUI

struct PaginatorView: View {
    
    weak var delegate: PageDelegate?
    
    var body: some View { HStack {
        
        PreviousButton{
            delegate?.previousPage()
        }
        
        NextButton {
            delegate?.nextPage()
            
        }
    }
    .foregroundColor(AppTheme.AppColors.buttonBackground)
    .padding()
    .background(AppTheme.AppColors.background)
    }
}

#Preview {
    PaginatorView()
}
