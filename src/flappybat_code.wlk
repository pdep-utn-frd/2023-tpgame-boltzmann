import wollok.game.*
object flappy {
var gameover = false
	method config () {
		game.width(18)
		game.height(12)
		game.title("Flappy Bat")
		game.addVisual(bat)
		game.addVisual(obstacle1)
		game.addVisual(obstacle2)
		game.addVisual(obstacle3)
		game.addVisual(obstacle4)
		game.addVisual(obstacle5)
		game.addVisual(obstacle6)
		game.addVisual(obstacle7)
		game.boardGround('background.png')
		game.cellSize(60)
		game.onCollideDo(bat, {obs => obs.collide()})
		game.addVisual(candy1)
		game.addVisual(candy2)
		game.addVisual(candy3)
		game.addVisual(candy4)
		game.addVisual(candy_counter)
		keyboard.space().onPressDo{self.play()}

	}
	
	
	method play() {
		
		if (bat.alive()) {
			if (game.hasVisual(game_over)) {
				game.removeVisual(game_over)
			}
			bat.jump()
		}
			
		else {
			if (game.hasVisual(game_over)) {
				game.removeVisual(game_over)
			}
			self.setup()
		}
		

	}
	
	method setup () {

			bat.start()
			obstacle1.start()
			obstacle2.start()
			obstacle3.start()
			obstacle4.start()
			obstacle5.start()
			obstacle6.start()
			obstacle7.start()
			candy1.iniciar()
			candy2.iniciar()
			candy3.iniciar()
			candy4.iniciar()
		
	}
	
	method gameOver() {
		game.addVisual(game_over)
		game_over.finish_all()
	}
}


object candy_counter { 
	var candy = 0;
	method text() = "Caramelos: "+candy.toString()
	method position() = game.at(1, 0)
	
	method add_candy() {
		candy += 1
	}
	
	method reset() {
		candy = 0
	}
}

object candy1 {
	var position = game.at(18, 10)
	method image () = "candy.png"
	method position () = position
	method iniciar() {
		game.onTick(120, "MovingCandy", {self.move()})
	}
	
	method move() {
		if (position.x() == -10) {
			position = game.at(100,2.randomUpTo(10).truncate(0))
		} else {
			position = position.left(1)
		}
	}
	
	method collide() {
		position = game.at(-10, position.y())
		candy_counter.add_candy()
	}
	
	method stop() {
		game.removeTickEvent("MovingCandy")
	}
}
object candy2 {
	var position = game.at(23, 10)
	method image () = "candy.png"
	method position () = position
	method iniciar() {
		game.onTick(120, "MovingCandy", {self.move()})
	}
	
	method move() {
		if (position.x() == -10) {
			position = game.at(100,2.randomUpTo(10).truncate(0))
		} else {
			position = position.left(1)
		}
	}
	
	method collide() {
		position = game.at(-10, position.y())
		candy_counter.add_candy()
	}
	
	method stop() {
		game.removeTickEvent("MovingCandy")
	}
}
object candy3 {
	var position = game.at(28, 10)
	method image () = "candy.png"
	method position () = position
	method iniciar() {
		game.onTick(120, "MovingCandy", {self.move()})
	}
	
	method move() {
		if (position.x() == -10) {
			position = game.at(100,2.randomUpTo(10).truncate(0))
		} else {
			position = position.left(1)
		}
	}
	
	method collide() {
		position = game.at(-10, position.y())
		candy_counter.add_candy()
	}
	
	method stop() {
		game.removeTickEvent("MovingCandy")
	}
}
object candy4 {
	var position = game.at(33, 10)
	method image () = "candy.png"
	method position () = position
	method iniciar() {
		game.onTick(100, "MovingCandy", {self.move()})
	}
	
	method move() {
		if (position.x() == -10) {
			position = game.at(100,2.randomUpTo(10).truncate(0))
		} else {
			position = position.left(1)
		}
	}
	
	method collide() {
		position = game.at(-10, position.y())
		candy_counter.add_candy()
	}
	
	method stop() {
		game.removeTickEvent("MovingCandy")
	}
}

object bat {
	var property alive = true
	var x = 0
	var y = 0
	var property total_pos
	var image = "bat0.png"
	
	method position() = total_pos
	method image() = image
	
	method stop() {
		total_pos = game.at(1, 20)
		self.morir()
		game.removeTickEvent("FallingBat")
		game.removeTickEvent("MovingBat")
	}
	
	method moving() {
		y = x % 3
		image = "bat"+y+".png"
		x+=1
	}
	
	method start() {
		alive = true
		total_pos = game.at(2, 6) 
		game.onTick(200, "FallingBat", {self.falling()})
		game.onTick(100, "MovingBat", {self.moving()})
	}
	
	method jump() {
		if (total_pos.y() < 12) {
			total_pos = total_pos.up(1)	
		}
	}
	
	method falling() {
		if (total_pos.y() > -1 && self.alive()) {
			total_pos = total_pos.down(1)
		} else {
			floor.collide()
			alive = false
		}
	}

	method morir() {
		game.say(bat, ":(")
		alive = false	
	}
	
}

object obstacle1 {
	var property position
	method position() = position
	method image() = "brick.png"
	method move() {
		if (position.x() == -10) {
			position = game.at(18, 3.randomUpTo(11).truncate(0))
			var pos = game.getObjectsIn(position)
			if (!pos.isEmpty()) {
			position = game.at(29, 3.randomUpTo(11).truncate(0))
			}
		}
		position = position.left(1)
	}
	
	method start() {
		position = game.at(30, 5.randomUpTo(35).truncate(0) )
		game.onTick(120, "movingObstacle", {self.move() })
	}
	
	method collide(){
		flappy.gameOver()
	}

	method stop() {
		game.removeTickEvent("movingObstacle")
	}
	
}
object obstacle2 {
	var property position
	method position() = position
	method image() = "brick.png"
	method move() {
		if (position.x() == -10) {
			position = game.at(18, 3.randomUpTo(11).truncate(0))
			var pos = game.getObjectsIn(position)
			if (!pos.isEmpty()) {
			position = game.at(29, 3.randomUpTo(11).truncate(0))
			}
		}
		position = position.left(1)
	}
	
	method start() {
		position = game.at(40, 5.randomUpTo(35).truncate(0) )
		game.onTick(120, "movingObstacle", {self.move() })
	}
	
	method collide(){
		flappy.gameOver()
	}

	method stop() {
		game.removeTickEvent("movingObstacle")
	}
	
}
object obstacle3 {
	var property position
	method position() = position
	method image() = "brick.png"
	method move() {
		if (position.x() == -10) {
			position = game.at(18, 3.randomUpTo(11).truncate(0))
			var pos = game.getObjectsIn(position)
			if (!pos.isEmpty()) {
			position = game.at(29, 3.randomUpTo(11).truncate(0))
			}
		}
		position = position.left(1)
	}
	
	method start() {
		position = game.at(50, 5.randomUpTo(35).truncate(0) )
		game.onTick(120, "movingObstacle", {self.move() })
	}
	
	method collide(){
		flappy.gameOver()
	}

	method stop() {
		game.removeTickEvent("movingObstacle")
	}
	
}
object obstacle4 {
	var property position
	method position() = position
	method image() = "brick.png"
	method move() {
		if (position.x() == -10) {
			position = game.at(18, 3.randomUpTo(11).truncate(0))
			var pos = game.getObjectsIn(position)
			if (!pos.isEmpty()) {
			position = game.at(29, 3.randomUpTo(11).truncate(0))
			}
		}
		position = position.left(1)
	}
	
	method start() {
		position = game.at(60, 5.randomUpTo(35).truncate(0) )
		game.onTick(120, "movingObstacle", {self.move() })
	}
	
	method collide(){
		flappy.gameOver()
	}

	method stop() {
		game.removeTickEvent("movingObstacle")
	}
	
}
object obstacle5 {
	var property position
	method position() = position
	method image() = "brick.png"
	method move() {
		if (position.x() == -10) {
			position = game.at(18, 3.randomUpTo(11).truncate(0))
			var pos = game.getObjectsIn(position)
			if (!pos.isEmpty()) {
			position = game.at(29, 3.randomUpTo(11).truncate(0))
			}
		}
		position = position.left(1)
	}
	
	method start() {
		position = game.at(35, 5.randomUpTo(35).truncate(0) )
		game.onTick(120, "movingObstacle", {self.move() })
	}
	
	method collide(){
		flappy.gameOver()
	}

	method stop() {
		game.removeTickEvent("movingObstacle")
	}
	
}
object obstacle6 {
	var property position
	method position() = position
	method image() = "brick.png"
	method move() {
		if (position.x() == -10) {
			position = game.at(18, 3.randomUpTo(11).truncate(0))
			var pos = game.getObjectsIn(position)
			if (!pos.isEmpty()) {
			position = game.at(29, 3.randomUpTo(11).truncate(0))
			}
		}
		position = position.left(1)
	}
	
	method start() {
		position = game.at(45, 5.randomUpTo(35).truncate(0) )
		game.onTick(120, "movingObstacle", {self.move() })
	}
	
	method collide(){
		flappy.gameOver()
	}

	method stop() {
		game.removeTickEvent("movingObstacle")
	}
	
}
object obstacle7 {
	var property position
	method position() = position
	method image() = "brick.png"
	method move() {
		if (position.x() == -10) {
			position = game.at(18, 3.randomUpTo(11).truncate(0))
			var pos = game.getObjectsIn(position)
			if (!pos.isEmpty()) {
			position = game.at(29, 3.randomUpTo(11).truncate(0))
			}
		}
		position = position.left(1)
	}
	
	method start() {
		position = game.at(55, 5.randomUpTo(35).truncate(0) )
		game.onTick(120, "movingObstacle", {self.move() })
	}
	
	method collide(){
		flappy.gameOver()
	}

	method stop() {
		game.removeTickEvent("movingObstacle")
	}
	
}

object floor {
	
	method position() = game.at(6,1)
	
	method collide() {
		flappy.gameOver()
	}
}

object game_over {
	method text() = 'Haz perdido, apreta espacio para continuar'
	method position() = game.center()
	
	method finish_all () {
		candy_counter.reset()
		bat.stop()
		obstacle1.stop()
		obstacle2.stop()
		obstacle3.stop()
		obstacle4.stop()
		obstacle5.stop()
		obstacle6.stop()
		obstacle7.stop()
		candy1.stop()
		candy2.stop()
		candy3.stop()
		candy4.stop()
	}

}




