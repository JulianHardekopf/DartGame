part of doodleJump;

// Parameter to define the amount of platforms to be spawned
int platformsCount = 6;

// To control if game rules should be applied
bool gameHasStarted = false;
// score for the database
int score = 0;
// String for the current record
String record = "0";

/* Fireball class which is spawned randomly on the horizontal axis
 has own collision with the player and gets spawned by the start of the game
falls at the speed of dy vector
*/

class Fireball {
  double x, y;
  double dy = -4;
  double width = 80;
  double height = 120;
  Field field;

  Fireball(this.field) {
    x =  Random().nextDouble() * (field.width - width);
    y = 0 - height;

  }

  void fall() {
    y -= dy;
    if(y + height > field.height) {
      y = 0;
    }
  }

  bool collisionFireball(Player p) {
    if(p.x + p.diameter / 2 > x  && p.x + p.diameter / 2  < x +width && (p.y - y).abs() < p.diameter) {
      return true;
    } else {
      return false;
    }
  }
}
/*
Field defines the area where the game takes place
Movement of the platforms is applied and is
connectedd to the player, fireball and platforms
*/
class Field {
  double width;
  double height;

  Player player;
  Fireball fireball;
  double playerDiameter = 80;
  var platforms = <Platform>[];
  View view;
  bool gameOver() {
    return player.dead();
  }

  Field(this.width, this.height) {
    player = Player(this, playerDiameter);
    fireball = Fireball(this);

  }

  void jumpPlayer() => player.jump(platforms);
  void movePlayer() => player.move(platforms);
  void moveFireball() => fireball.fall();
  bool fireballCollision() => fireball.collisionFireball(player);


  void createPlatforms() {

    for(var i = 0; i < platformsCount; i++) {
      var platGap = 600/platformsCount;
      platforms.add(Platform
        (field: this,
          x: Random().nextDouble() * (this.width - 67),
          y: 100 + i * platGap));
    }
  }
  void movePlatforms() {
    if(player.y < 550 ) {
      platforms.forEach((platform) {
        if(player.isjumping) {
          platform.y += 3;
          platform.deleteDiv();
          platform.createDiv();
        }
        if(!player.isjumping) {
          platform.y += 1;
          platform.deleteDiv();
          platform.createDiv();
        }

        if(platform.y + 20 > height) {
          platform.x = Random().nextDouble() * (this.width - 67);
          platform.y = 0;
          platform.deleteDiv();
          platform.createDiv();
        }
      });
    }
  }

}

/*
Platform class defines the platforms.
checks for collision with the player
create and deletes the platforms.
 */
class Platform{
  DivElement divElement;
  Field field;
  double x;
  double y;
  double get height => this.field.height;
  double get width => 67;

  Platform({this.field, this.x, this.y});

  bool collision(Player p) {
    if(p.x + p.diameter / 2 > x - width && p.x + p.diameter / 2  < x+width && (p.y - y).abs() < p.diameter) {
      return true;
    } else {
      return false;
    }
  }
  void createDiv() {
    final field = querySelector("#field");
    this.divElement = new DivElement();
    divElement.className = "platform";
    field.append(divElement);

    this.divElement.style.left = "${x.toInt()}px";
    this.divElement.style.top = "${this.y.toInt()}px";
    this.divElement.style.width = "${this.width.toInt()}px";
  }
  void deleteDiv() {
    divElement.remove();
  }

}

/*
In the Player class checks whether hes dead by a collision
with the ground or with a fireball.
Moves the Player according to the movement status Key-A and Key-D
Player jumps are calculated in the player class aswell.
 */
class Player {
  double x;
  double y;
  double diameter;
  double dx;
  double dy;
  double velocity = -9;
  bool isjumping = false;
  Field field;
  bool right = false;
  bool left = false;

  bool dead() {
    return (gameHasStarted == true && this.y + this.diameter >= this.field.height || field.fireballCollision());
  }

  Player(this.field, this.diameter) {
    x = field.width / 2;
    y = 700;
    dx = 0;
    dy = Random().nextDouble() * 10;
  }

  void jump(List<Platform> p) {
    if(dy < 0) {
      isjumping = true;
    } if(dy > 0) {
      isjumping = false;
    }
    dy += 0.2;
    y += dy;


    if (y + diameter > field.height && gameHasStarted == false) {
      isjumping = true;
      dy = velocity;
    }

    p.forEach((platform) {
      if(platform.collision(this) && !isjumping) {
        score++;
        gameHasStarted = true;
        isjumping = true;

        if(this.y < 350) {
          dy = velocity/1.5;
        } else {
          dy = velocity;
        }
        platform.x = Random().nextDouble() * (field.width - platform.width);
        platform.y += 10;
        platform.deleteDiv();
        platform.createDiv();
      }
    });
  }

  void move(List<Platform> p) {
    window.onKeyDown.listen((KeyboardEvent ev) {
      if (ev.keyCode == KeyCode.A) {
        left = true;
      }
      if (ev.keyCode == KeyCode.D) {
        right = true;
      }
    });


    if (left == true) {
      if(x < 0) {
        x = field.width - diameter;
      }
      x -= 5;
    }
    if (right == true) {
      if(x + diameter > field.width) {
        x = 0;
      }
      x += 5;
    }

    window.onKeyUp.listen((KeyboardEvent ev) {
      if (ev.keyCode == KeyCode.A) {
        left = false;
      }
      if (ev.keyCode == KeyCode.D) {
        right = false;
      }
    });
  }
}