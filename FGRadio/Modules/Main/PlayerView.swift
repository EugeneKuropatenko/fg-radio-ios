import SwiftUI

struct PlayerView: View {
    @ObservedObject var model: PlayerViewModel
    
    var playerButton: some View {
        Button(action: {
            self.model.playTapped()
        }) {
            Image(self.model.buttonState)
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
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.vertical)
            
            VStack {
                self.links
                    .padding(.bottom, 42)
                
                Text("FIRSTGEAR")
                    .foregroundColor(Color.white)
                Text("РАДИО")
                    .foregroundColor(Color.white)
                    .bold()
                
                Image("logo-dark")
                    .resizable()
                    .frame(width: 177, height: 177)
                
                VStack {
                    Text(self.model.trackTitle.title)
                        .font(.system(size: 24))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .foregroundColor(Color.white)
                    
                    Text(self.model.trackTitle.subtitle)
                        .font(.system(size: 24))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .foregroundColor(Color.secondaryTextDark)
                }.padding()
                
                Spacer()
                
                self.playerButton
                    .padding(.bottom, 10)
                
                MusicIndicator(state: self.$model.indicatorState)
                    .frame(width: 18, height: 18)
                    .padding(.bottom, 140)
            }.padding()
        }
    }
}
