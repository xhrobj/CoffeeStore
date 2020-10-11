//
//  ProductDetail.swift
//  iCoffee
//

import SwiftUI

struct ProductDetail: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @State var isShowAlert = false
    
    var product: Product
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            ZStack(alignment: .bottom) {
                
                Image(product.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Rectangle()
                    .frame(height: 80)
                    .foregroundColor(.black)
                    .opacity(0.35)
                    .blur(radius: 10)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(product.name)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .padding(.leading)
                    .padding(.bottom)
                    Spacer()
                }
            }
            .listRowInsets(EdgeInsets())
            
            Text(product.description)
                .foregroundColor(.primary)
                .font(.body)
                .lineLimit(7)
                .padding()
            
            HStack {
                Spacer()
                OrderButton(isShowAlert: $isShowAlert, product: product)
                Spacer()
            }
            .padding(.top, 50)
        }
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $isShowAlert) {
            Alert(
                title: Text(authVM.isLogin ? "Товар добавлен в корзину!" : "Не добавлен! Выполните вход в корзину"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct OrderButton: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @ObservedObject var cartVM = CartViewModel()
    
    @Binding var isShowAlert: Bool
    
    var product: Product
    
    var body: some View {
        Button(action: {
            isShowAlert.toggle()
            if authVM.isLogin {
                cartVM.addToCart(product: product)
            }
        }) {
            Text("Добавить в корзину")
        }
        .frame(width: 200, height: 50)
        .font(.headline)
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(10)
    }
}

struct ProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetail(product: productData[0])
    }
}
