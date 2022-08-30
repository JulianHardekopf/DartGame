part of doodleJump;

class View {
  Field model;


  final player = querySelector("#field .player");
  final fireball = querySelector("#field .fireball");
  final startButton = querySelector("#menu .start");
  final currentScore = querySelector("#currentScore");
  final highscore = querySelector("#highscore");
  View(this.model);

  void updateHighscore() {
    currentScore.innerHtml = 'Current Score: ${score.toString()}';
    highscore.innerHtml = 'Highscore: ${record.toString()}';

  }

  void updatePlayer() {
    player?.style.left = "${model.player.x.toInt()}px";
    player?.style.top = "${model.player.y.toInt()}px";
    player?.style.height = "${model.player.diameter.toInt()}px";
    player?.style.width = "${model.player.diameter.toInt()}px";
  }

  void updateFireball() {
    fireball?.style.left = "${model.fireball.x.toInt()}px";
    fireball?.style.top = "${model.fireball.y.toInt()}px";
    fireball?.style.height = "${model.fireball.height.toInt()}px";
    fireball?.style.width = "${model.fireball.width.toInt()}px";
  }



  final field = querySelector("#field");
  void initPlatforms() {
    model.platforms.forEach((element) {
      element.createDiv();

    });

  }


}