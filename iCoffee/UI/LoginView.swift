//
//  LoginView.swift
//  iCoffee
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var isShowSignup = false
    @State var isShowFinishRegistration = false
    @State var isShowAlert = false
    
    var body: some View {
        VStack {
            Text(isShowSignup ? "Регистрация" : "Вход")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding(.top, 40)
                .padding(.bottom, 20)
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color(.label))
                        .opacity(0.75)
                    TextField("Введите ваш email", text: $authVM.email)
                    Divider()
                    Text("Пароль")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color(.label))
                        .opacity(0.75)
                    SecureField("Введите пароль", text: $authVM.password)
                    Divider()
                    
                    if isShowSignup {
                        Text("Повтор пароля")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(Color(.label))
                            .opacity(0.75)
                        SecureField("Повторите введенный пароль", text: $authVM.repeatPassword)
                        Divider()
                    }
                }
                .padding(.bottom, 15)
                .animation(.easeInOut(duration: 0.2))
                
                HStack {
                    Spacer()
                    Button(action: {
                        authVM.resetPassword()
                    }, label: {
                        Text("Если забыли пароль")
                            .foregroundColor(Color.gray.opacity(0.5))
                    })
                }
            }
            .padding(.horizontal, 6)
            
            Button(action: {
                isShowSignup ? authVM.signup() : authVM.loginWithPassword()
            }, label: {
                Text(isShowSignup ? "Зарегистрироваться" : "Войти")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 120)
                    .padding()
            })
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.top, 45)
            
            SignupView(isShowSignup: $isShowSignup)
        }
        .onChange(of: authVM.message, perform: { (message) in
            if !message.isEmpty {
                isShowAlert.toggle()
            }
        })
        .onChange(of: authVM.signupFinishMessage, perform: { (signupFinishMessage) in
            if !signupFinishMessage.isEmpty {
                isShowAlert.toggle()
            }
        })
        .alert(isPresented: $isShowAlert) {
            if !authVM.signupFinishMessage.isEmpty {
               return Alert(title: Text(authVM.signupFinishMessage), dismissButton: .default(Text("OK"), action: {
                    authVM.signupFinishMessage = ""
                    presentationMode.wrappedValue.dismiss()
                }))
            } else {
                return Alert(title: Text(authVM.message), dismissButton: .default(Text("OK"), action: {
                    authVM.message = ""
                }))
            }
        }
        .sheet(isPresented: $isShowFinishRegistration) {
            FinishRegistrationView()
        }
    }
}

struct SignupView: View {
    
    @Binding var isShowSignup: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 8) {
                Text(isShowSignup ? "Уже зарегистрированы" : "Нет аккаунта")
                    .foregroundColor(Color.gray.opacity(0.5))
                Button(action: {
                    isShowSignup.toggle()
                }, label: {
                    Text(isShowSignup ? "Вход" : "Регистрация")
                        .foregroundColor(.blue)
                })
            }
            .padding(.top, 25)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
