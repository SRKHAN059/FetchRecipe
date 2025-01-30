//
//  DropdownStyleView.swift
//  FetchRecipe
//
//  Created by Shifath Khan on 1/27/25.
//

import SwiftUI

struct DropdownStyleView<Header: View, DisclosedContent: View>: View {
    @State private var expanded: Bool = false
    @Binding var isExpanded: Bool
    
    var header: Header
    var content: DisclosedContent
    
    init(expanded: Binding<Bool>, @ViewBuilder header: () -> Header, @ViewBuilder content: () -> DisclosedContent) {
        self._isExpanded = expanded
        self.header = header()
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            self.header
            
            if self.expanded {
                self.content
            }
        }
        .onChange(of: self.isExpanded) { newValue in
            withAnimation(.default) {
                self.expanded = newValue
            }
        }
    }
}
