//
//  PinCodeView.swift
//  iCoffee
//

import SwiftUI

struct PinCodeView: View {
    
    enum Mode {
        case check, setup
    }
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    let mode: Mode
    
    var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 10) {
                Text(mode == .setup ? "создайте пинкод" : "введите пинкод")
                    .font(.title2)
                makeCircleResultsBlock()
                    .modifier(Shake(animatableData: CGFloat(authVM.wrongAttempts)))
            }
            makeDigitButtonsBlock()
            makeActionButtonsBlock()
            
        }
        .onAppear() {
            if mode == .check {
                authVM.authWithBiometry()
            }
        }
    }
    
    func makeCircleResultsBlock() -> some View {
        HStack(spacing: 10) {
            ForEach((0..<authVM.maxPinDigitCount)) {
                makeCircleResult(value: authVM.pinDigits[safeIndex: $0])
            }
        }
    }
    
    func makeDigitButtonsBlock() -> some View {
        VStack(spacing: 25) {
            HStack(spacing: 30) {
                makeDigitButton("1", "")
                makeDigitButton("2", "ABC")
                makeDigitButton("3", "DEF")
            }
            HStack(spacing: 30) {
                makeDigitButton("4", "GHI")
                makeDigitButton("5", "JKL")
                makeDigitButton("6", "MNO")
            }
            HStack(spacing: 30) {
                makeDigitButton("7", "PQRS")
                makeDigitButton("8", "TUV")
                makeDigitButton("9", "WXYZ")
            }
            makeDigitButton("0")
        }
    }
    
    func makeActionButtonsBlock() -> some View {
        HStack {
            if mode == .check {
                Button("TouchId") {
                    authVM.authWithBiometry()
                }
            }
            
            Spacer()
            
            Button("Удалить цифру") {
                authVM.removeLastPinDigit()
            }
        }
        .padding()
    }
    
    func makeCircleResult(value: String?) -> some View {
        let isEmpty = (value ?? "").isEmpty
        
        return ZStack {
            if !isEmpty {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray)
            }
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        }
        .frame(width: 20, height: 20)
    }
    
    func makeDigitButton(_ title: String, _ subtitle: String? = nil) -> some View {
        Button(action: {
            withAnimation(.default) {
                if mode == .check {
                    authVM.digitPressForCheck(value: title)
                } else {
                    authVM.appendDigitToPin(value: title)
                }
            }
        }) {
            VStack {
                Text(title)
                    .foregroundColor(.white)
                    .font(.title)
                if let subtitle = subtitle {
                    Text(subtitle)
                        .foregroundColor(.white)
                        .font(.caption)
                }
            }
            .frame(width: 70, height: 70)
            .background(Color.gray)
            .cornerRadius(35)
        }
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(
                translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                y: 0
            )
        )
    }
}
