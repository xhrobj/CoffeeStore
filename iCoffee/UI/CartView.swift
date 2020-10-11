//
//  CartView.swift
//  iCoffee
//

import SwiftUI

struct CartView: View {
    
    @ObservedObject var cartVM = CartViewModel()
    
    var body: some View {
        NavigationView {
            List {
                
                Section {
                    ForEach(cartVM.cart?.items ?? []) { product in
                        HStack {
                            Text(product.name)
                            Spacer()
                            Text("\(product.price.clean)")
                        }
                    }
                    .onDelete { indexSet in
                        removeItem(at: indexSet)
                    }
                }
                
                Section {
                    NavigationLink(destination: CheckoutView()) {
                            Text("Сделать заказ")
                        }
                }
                .disabled(cartVM.cart?.items.isEmpty ?? true)
                
            }
            .navigationTitle("Корзина")
            .listStyle(GroupedListStyle())
        }
    }
    
    private func removeItem(at offsets: IndexSet) {
        guard let offset = offsets.first else { return }
        cartVM.cart?.items.remove(at: offset)
        cartVM.saveCartToFirestore()
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
