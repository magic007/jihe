import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var agreePolicy: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        ZStack {
            // 渐变背景
            LinearGradient(gradient: Gradient(colors: [Color("AccentColor"), Color(.systemGray6)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                Spacer()
                // App Logo 或标题
                VStack(spacing: 8) {
                    Image(systemName: "bolt.car")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color("AccentColor"))
                    Text("智能电动车登录")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                
                // 输入框卡片
                VStack(spacing: 20) {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                        TextField("请输入账号", text: $username)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        SecureField("请输入密码", text: $password)
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal, 32)
                
                // 登录按钮
                Button(action: {
                    if username.isEmpty || password.isEmpty {
                        alertMessage = "请输入账号和密码"
                        showAlert = true
                    } else if !agreePolicy {
                        alertMessage = "请先同意用户隐私"
                        showAlert = true
                    } else {
                        // 登录逻辑
                        alertMessage = "登录成功（此处可接入后端）"
                        showAlert = true
                    }
                }) {
                    Text("登录")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(agreePolicy ? 1 : 0.5))
                        .cornerRadius(12)
                        .shadow(color: Color.blue.opacity(agreePolicy ? 0.2 : 0.1), radius: 6, x: 0, y: 3)
                }
                .padding(.horizontal, 32)
                .disabled(!agreePolicy)
                
                // 同意隐私政策
                HStack(spacing: 8) {
                    Button(action: { agreePolicy.toggle() }) {
                        Image(systemName: agreePolicy ? "checkmark.square.fill" : "square")
                            .foregroundColor(agreePolicy ? Color.blue : .gray)
                            .font(.title3)
                    }
                    Text("我已同意")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Button(action: {
                        // 跳转到用户隐私页面（可替换为实际链接）
                        if let url = URL(string: "https://www.example.com/privacy") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("《用户隐私》")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                            .underline()
                    }
                    Spacer()
                }
                .padding(.horizontal, 36)
                
                Spacer()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("提示"), message: Text(alertMessage), dismissButton: .default(Text("确定")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
} 