//
//  Login side.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 29/11/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct LoginSide: View {
    
    //User Details
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    // View Properties
    @State var createAccount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    //User Defaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    var body: some View {
        VStack(spacing: 10){
            Text("Log Ind")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
            /*Text("Velkommen Tilbage")
                .font(.title3)
                .hAlign(.leading)*/
            
            VStack(spacing: 12){
                TextField("Email", text: $emailID)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                
                SecureField("Kodeord", text: $password)
                    .textContentType(.password)
                    .border(1, .gray.opacity(0.5))
                
                Button("Nulstil Kodeord?", action: resetPassword)
                    .font(.callout)
                    .tint(.black)
                    .hAlign(.trailing)
                
                Button(action: loginUser)  {
                    //Login-knap
                    Text("Log Ind")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .fillView(.black)
                }
                .disableWithOpacity(emailID == "" || password == "")
                .padding(.top, 10)
                
            }
            
            // Register button
            HStack{
                Text("Har du ikke en profil?")
                    .foregroundColor(.gray)
                
                Button("Opret Profil"){
                    createAccount.toggle()
                    
                    
                }
                .foregroundColor(.black)
                
            }
            .font(.callout)
            .vAlign(.bottom)
            
        }
        .vAlign(.top)
        .padding(15)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        //Register View VIA Sheets
        .fullScreenCover(isPresented: $createAccount) {
            RegisterView()
        }
        
        // Displaying Alert
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    func loginUser(){
        isLoading = true
        closeKeyboard()
        Task{
            do{
                try await Auth.auth().signIn(withEmail: emailID, password: password)
                print("User Found")
                try await fetchUser()
            }catch{
                await setError(error)
            }
        }
        
    }
    //If User is found then fetching user data from firestore
    func fetchUser()async throws {
        guard let userID = Auth.auth().currentUser?.uid else{return}
        let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
        // Mark: UI Updating Must be run on main thread
        await MainActor.run(body: {
            // Setting UserDefaults data and changing App's Auth Status
            userUID = userID
            userNameStored = user.username
            //profileURL = user.userProfileURL
            logStatus = true
        })
        
    }
    
    
    func resetPassword(){
        Task{
            do{
                try await Auth.auth().sendPasswordReset(withEmail: emailID)
                print("Link Sendt")
            }catch{
                await setError(error)
            }
        }
        
    }
    
    // Displaying Errors VIA Alert
    func setError(_ error: Error)async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
}

// Register View
struct RegisterView: View {
    //User Details
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    // View Properties
    @Environment(\.dismiss) var dismiss
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    //User defaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    var body: some View {
        VStack(spacing: 10){
            Text("Opret Profil")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
           /* Text("Velkommen Tilbage")
                .font(.title3)
                .hAlign(.leading) */
            
            VStack(spacing: 12){
              /*  TextField("Brugernavn", text: $userName)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25) */
                
                TextField("Email", text: $emailID)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                
                SecureField("Kodeord", text: $password)
                    .textContentType(.password)
                    .border(1, .gray.opacity(0.5))
                
                
                
                Button(action: registerUser)  {
                    //Login-knap
                    Text("Opret profil")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .fillView(.black)
                }
                .disableWithOpacity(emailID == "" || password == "")
                .padding(.top, 10)
                
            }
            
            
            
        
            
           
            
            
            // Register button
            HStack{
                Text("Har du allerede en profil?")
                    .foregroundColor(.gray)
                
                Button("Log ind nu"){
                    dismiss()
                    
                    
                }
                .foregroundColor(.black)
                
            }
            .font(.callout)
            .vAlign(.bottom)
            
        }
        .vAlign(.top)
        .padding(15)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        //Displaying alert
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    func registerUser(){
        isLoading = true
        closeKeyboard()
        Task{
            do{
                //Step 1: Creating Firebase Account
                try await Auth.auth().createUser(withEmail: emailID, password: password)
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                // Creating a User Firestore Object
                let user = User(username: userName, userUID: userUID, userEmail: emailID)
                // Saving User Doc into Firestore Database
                let _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user, completion: {
                    error in
                    if error == nil{
                        print("Gemt")
                        userNameStored = userName
                        self.userUID = userUID
                     // profileURL = user.profileURL
                        logStatus = true
                    }
                })
            }catch{
                // Deleting Created Account In case of faliure
              //  try await Auth.auth().currentUser?.delete()
                await setError(error)
            }
        }
        
    }
    
    // Displaying Errors VIA Alert
    func setError(_ error: Error)async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
    
}



struct LoginSide_Previews: PreviewProvider {
    static var previews: some View {
        LoginSide()
        
    }
}
// View extensions for UI building
extension View{
    //Closing all active keyboards
    func closeKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // Disabling with Opacity
    func disableWithOpacity(_ condition: Bool)->some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
    
    func hAlign(_ alignment: Alignment)-> some View{
        self
            .frame(maxWidth: . infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment)-> some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    //Custom Border View med padding
    func border(_ width: CGFloat, _ color: Color) -> some View{
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }
    
    //Custom Fill View with padding
    func fillView(_ color: Color) -> some View{
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color)
            }
    }
    
}
