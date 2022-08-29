part of doodleJump;



class DoodleGameController {
  Field field;
  View view;
  bool left = false;
  bool right = false;
  bool gamestart = false;

  DoodleGameController() {
    double width = (querySelector("#field")?.getBoundingClientRect().width ?? 0.0) as double;
    double height = (querySelector("#field")?.getBoundingClientRect().height ?? 0.0) as double;
    Field model = Field(width, height);
    View view = View(model);
    view.updateHighscore();
    model.createPlatforms();
    view.initPlatforms();

    view.startButton.onClick.listen((_) {
      gamestart = true;
      if(gamestart) startGame(model, view);

      if(model.gameOver()) {
        gamestart = true;
        window.location.reload();
      }
    });
  }

  void startGame(Field model, View view) {
    Timer.periodic(Duration(milliseconds: 20), (timer) {
        model.jumpPlayer();
        model.movePlayer();
        model.movePlatforms();
        model.moveFireball();
        view.updateFireball();
        view.updatePlayer();
        view.updateHighscore();

      if (model.gameOver()) timer.cancel();
    });
  }

}

