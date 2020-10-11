//
//  ProductRow.swift
//  iCoffee
//

import SwiftUI

struct ProductRow: View {
    var categoryName: String
    var products: [Product]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(products) {drink in
                        NavigationLink(destination: ProductDetail(product: drink)) {
                            ProductItem(product: drink)
                                .frame(width: 300)
                                .padding(.trailing, 30)
                        }
                    }
                }
            }
        }
    }
}

struct DrinkRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(categoryName: "HOT", products: productData)
    }
}
