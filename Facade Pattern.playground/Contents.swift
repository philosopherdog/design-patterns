import UIKit

/*:
 # Facade Pattern
 - Related to the Adapter Pattern, but the intent of the pattern is different.
 - The Adapter's intent is to alter an interface so taht it matches what the client is expecting.
 - The intent of the Facade Patterns is to provide a simplified interface to a subsystem.
 - Computing employs the Facade Pattern everywhere by hiding complexity and exposing functionality through a simplified interface. Consider Finder on MacOS. It hides complex operatons behind a simplified interface.
 - Let's look at HeadFirst's example.
 
 ![](mess.png)
 
 - Without the Facade our client code would have to have a lot of knowledge of the underlying subsystems to play a movie or listen to music.
 - HeadFirst lists the following steps to take for playing a movie:
 
 ![](steps.png)
 
 ![](steps_incode.png)
 
 - To shut down our home theatre this way we would have expose our client to the nitty gritty of our home theatre.
 - If our theatre system changes in any way this will cause us to open this code for modification.
 - Playing music may be equally complex.
 - The Facade Pattern puts this whole subsystem behind a simplified interface.
 
 ![](facade.png)
 
 - Notice how the remote is now the client of the Facade. It is the consumer of the Facade and doesn't need to have any knowledge about the subsystems.
 
 ![](client.png)
 
 - The Facade does not prevent classes from accessing the complex underlying subsytems if they need to.
 - The Facade can also add its own extra functionality. For instance, it could handle popping the popcorn.
 - Because the client of the Facade has no dependency on the concrete subsystem we could easily plug in another subsystem without changing our code. Indeed, if we make the Facade itself implement an interface then we can easily pass a concrete Facade into the client and route all of the client calls through the reference to the Facade.
 */

class Amp {
  var volume = 5
  func on() {
    print(#line, "amp", #function)
  }
  func toDVDMode() {
    print(#line, "amp", #function)
  }
  func surroundSoundMode() {
    print(#line, "amp", #function)
  }
  func off() {
    print(#line, "amp", #function)
  }

}

class Tuner {}
class DVDPlayer {
  func on() {
    print(#line, "tuner", #function)
  }
  func play(movie title:String) {
    print(#line, "tuner", #function, title)
  }
  func stop() {
    print(#line, "tuner", #function)
  }
  func eject() {
    print(#line, "tuner", #function)
  }
  func off() {
    print(#line, "tuner", #function)
  }
}
class MP3Player {}

class Projector {
  func on() {
    print(#line, "projector", #function)
  }
  func widescreenMode() {
    print(#line, "projector", #function)
  }
  func off() {
    print(#line, "projector", #function)
  }
}
class TheaterLights {
  func dim(_ byAmount: Int) {
    print(#line, "lights", #function, byAmount)
  }
  func on() {
    print(#line, "lights", #function)
  }

}
class Screen {
  func down() {
    print(#line, "screen", #function)
  }
  func up() {
    print(#line, "screen", #function)
  }
}
class PopCornPopper {
  func on() {
    print(#line, "popcornpopper", #function)
  }
  func pop() {
    print(#line, "popcornpopper", #function)
  }
  func off() {
    print(#line, "popcornpopper", #function)
  }
}

class HomeTheatreFacade {
  let amp: Amp
  let tuner: Tuner
  let dvdPlayer: DVDPlayer
  let mp3: MP3Player
  let projector: Projector
  let theaterLights: TheaterLights
  let screen: Screen
  let popcornPopper: PopCornPopper
  init(amp: Amp, tuner: Tuner, dvdPlayer: DVDPlayer, mp3: MP3Player, projector: Projector, theaterLights: TheaterLights, screen: Screen, popcornPopper: PopCornPopper) {
    self.amp = amp
    self.tuner = tuner
    self.dvdPlayer = dvdPlayer
    self.mp3 = mp3
    self.projector = projector
    self.theaterLights = theaterLights
    self.screen = screen
    self.popcornPopper = popcornPopper
  }
  
  func watchMovie(with title: String) {
    print(#line, "Getting ready to watch \(title)")
    
    popcornPopper.on()
    popcornPopper.pop()
    theaterLights.dim(10)
    screen.down()
    projector.on()
    projector.widescreenMode()
    amp.on()
    amp.toDVDMode()
    amp.surroundSoundMode()
    amp.volume = 10
    dvdPlayer.on()
    dvdPlayer.play(movie:title)
  }
  
  func endMovie() {
    print(#line, "Shutting movie theater down...")
    popcornPopper.off()
    theaterLights.on()
    screen.up()
    projector.off()
    amp.off()
    dvdPlayer.stop()
    dvdPlayer.eject()
    dvdPlayer.off()
  }
}

class Convertor {
  let facade: HomeTheatreFacade
  init(with facade: HomeTheatreFacade) {
    self.facade = facade
  }
  
  func watchMovied(with title: String) {
    facade.watchMovie(with: title)
  }
  
  func endMovie() {
    facade.endMovie()
  }
}
let facade = HomeTheatreFacade(amp: Amp(), tuner: Tuner(), dvdPlayer: DVDPlayer(), mp3: MP3Player(), projector: Projector(), theaterLights: TheaterLights(), screen: Screen(), popcornPopper: PopCornPopper())
let convertor = Convertor(with: facade)
convertor.watchMovied(with: "Vanilla Sky")
convertor.endMovie()

/*:
![](def.png)

![](uml.png)
*/


/*:
![](pr.png)

- By creating a single simple dependency between our client (the Convertor) and the Facade instead of making the Convertor dependent on all of the classes involved executing its commands our Convertor has minimal knowledge of the subsystems. 
- This insulates the Convertor against change.
- The Convertor is dependent on an abstraction and not the implementation details that it doesn't need to know about to function.

*/















