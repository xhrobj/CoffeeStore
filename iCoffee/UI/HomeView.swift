//
//  ContentView.swift
//  iCoffee

//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @ObservedObject var productVM = ProductViewModel()
    
    @State var isShowCart = false
    @State var isShowAlert = false
    
    private var categories: [String: [Product]] {
        .init(grouping: productVM.products, by: { $0.category.description })
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(categories.keys.sorted(), id: \String.self) { key in
                        ProductRow(categoryName: key.uppercased(), products: categories[key] ?? [])
                            .frame(height: 320)
                            .padding(.top)
                            .padding(.bottom)
                    }
                }
            }
            .padding(.leading)
            .navigationBarTitle(Text("iCoffee"))
            .navigationBarItems(
                leading: Button(action: {
                    authVM.logout()
                }, label: {
                    Text("Выйти")
                }),
                trailing: Button(action: {
                    isShowCart.toggle()
                }, label: {
                    Image(systemName: "cart")
                        .resizable()
                        .frame(width: 24.0, height: 24.0)
                })
                .onChange(of: authVM.message, perform: { (message) in
                    if !message.isEmpty {
                        isShowAlert.toggle()
                    }
                })
                .alert(isPresented: $isShowAlert) {
                    Alert(title: Text(authVM.message), dismissButton: .default(Text("OK"), action: {
                        authVM.message = ""
                    }))
                }
                .sheet(isPresented: $isShowCart) {
                    if authVM.isLogin {
                        if !authVM.hasPin {
                            PinCodeView(mode: .setup)
                                .environmentObject(authVM)
                        } else if authVM.currentUser?.isCompleteFilled ?? false {
                            CartView()
                        } else {
                            FinishRegistrationView()
                        }
                    } else if authVM.hasPin {
                        PinCodeView(mode: .check)
                            .environmentObject(authVM)
                    } else {
                        LoginView()
                    }
                }
            )
        }
    }
}
