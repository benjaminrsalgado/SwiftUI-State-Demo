//
//  ContentView.swift
//  SwiftUI-State-Demo
//
//  Created by Benjamin Rojo on 11/07/25.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        VistaLikes()
    }
}

class LikeModel: ObservableObject {
    @Published var likes = 0
    
    func sumar() {
        likes += 1
    }
}

struct VistaLikes: View {
    @StateObject var keep = LikeModel()
    @State var mostrarMensaje = false
    var body: some View {
        VStack(spacing: 24) {
            Text("Cantidad de likes: \(keep.likes)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.top, 30)
            
            Text("Total de likes: \(keep.likes)")
                .font(.headline)
                .foregroundColor(.gray)
            
            if mostrarMensaje {
                Text("¡Gracias por tu like!")
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.green.opacity(0.15))
                    )
            } else {
                Text("Aún no has dado like")
                    .foregroundColor(.secondary)
            }
            
            SwitchMensaje(mostrarMensaje: $mostrarMensaje)
                .padding(.horizontal, 40)
            
            BotonLike(keep: keep)
                .padding(.top, 20)
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
        .padding()
    }
}

struct BotonLike: View {
    @ObservedObject var keep: LikeModel
    var body: some View {
        VStack {
            Button(action: {
                keep.sumar()
            }) {
                Text("¡Dale like!")
                    .font(.headline)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 32)
                    .background(
                        Capsule()
                            .fill(Color.red.opacity(0.8))
                    )
                    .foregroundColor(.white)
                    .shadow(radius: 4)
            }
        }
    }
}

struct SwitchMensaje: View {
    @Binding var mostrarMensaje: Bool
    var body: some View {
        Toggle("Mostrar mensaje de agradecimiento", isOn: $mostrarMensaje)
            .toggleStyle(SwitchToggleStyle(tint: .blue))
            .font(.body)
    }
}

#Preview {
    ContentView()
}
