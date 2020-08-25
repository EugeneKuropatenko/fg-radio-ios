import SwiftUI
import MediaPlayer

struct PlayerView: View {
    @ObservedObject var model: PlayerViewModel
    @State var showAbout = false
    
    var playerButton: some View {
        Button(action: {
            self.model.playTapped()
        }) {
            Image(self.model.buttonImage)
                .renderingMode(.original)
                .resizable()
                .frame(width: 100, height: 100)
        }.disabled(!self.model.isButtonEnabled)
    }
    
    var links: some View {
        HStack(alignment: .center, spacing: 20) {
            Image("instagram-dark").onTapGesture {
                self.model.openLink(type: .instagram)
            }
            Image("facebook-dark").onTapGesture {
                self.model.openLink(type: .fb)
            }
            Image("youtube-dark").onTapGesture {
                self.model.openLink(type: .youTube)
            }
            Image("site-dark").onTapGesture {
                self.model.openLink(type: .site)
            }
            
            Image("about-dark").onTapGesture {
                self.showAbout = true
            }
        }
    }
    
    var content: some View {
        VStack {
            self.links
                .padding(.bottom, 42)
            
            Text("FIRSTGEAR")
                .foregroundColor(Color.white)
            Text("RADIO")
                .foregroundColor(Color.white)
                .bold()
            
            Image("logo-dark")
                .resizable()
                .frame(width: 177, height: 177)
            
            if model.showError {
                Text("Не удалось загрузить стрим. Подождите немного или позвоните нам.")
                    .foregroundColor(Color.errorText)
                    .multilineTextAlignment(.center)
            }
            
            VStack {
                Text(self.model.trackTitle.title)
                    .font(.system(size: 24))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundColor(self.model.trackTitle.titleColor)
                
                Text(self.model.trackTitle.subtitle)
                    .font(.system(size: 24))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundColor(self.model.trackTitle.sublitleColor)
            }
            .frame(height: 90)
            .padding(.top, 10)
            
            if self.model.buttonState == .preparing {
                Spacer()
                ActivityIndicator(isAnimating: .constant(true), style: .large, color: .gray)
            } else {
                VolumeSlider()
                    .frame(height: 40)
                    .padding(.horizontal)
                    .padding(.top, 10)
                 
                HStack {
                    VStack {
                        Image("phone-call")
                        Text("Позвонить")
                            .foregroundColor(self.model.trackTitle.sublitleColor)
                    }
                    .padding(.leading, 10)
                    .onTapGesture {
                        self.model.callStudio()
                    }
                    
                    Spacer()
                    
                    VStack {
                        self.playerButton
                            .padding(.top, 10)
                        
                        MusicIndicator(state: self.$model.indicatorState)
                            .frame(width: 24, height: 24)
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
                
            }
            
            Spacer()
        }
        .padding(.top, 7)
        .padding(.horizontal, 24)
    }
    
    var body: some View {
        ZStack {
            Color.mainBackground.edgesIgnoringSafeArea(.vertical)
            self.content
        }.sheet(isPresented: $showAbout) {
            AboutView(isVisible: self.$showAbout)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let model = PlayerViewModel(player: Player())
    
    static var previews: some View {
        PlayerView(model: model)
    }
}
