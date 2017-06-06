// David Monaghan DCU Insight May 2016
// This code is for a summer intern project with Anne Cleary and Denis Connolly
// and is for my intern student Mathew Sam to learn approximate median background modelling

// This is to show the backbround factor

void ShowBackgroundFactor() {
  //show text on the screen
  if (show_text_foreground < text_on_screen_time) {
    fill(0, 255, 0);
    textSize(45);
    text("Foreground difference = " + foreground_factor, 15, 70);
    show_text_foreground = show_text_foreground + 1;
  }

  if (show_text_alter_background_factor < text_on_screen_time) {
    fill(0, 255, 0);
    textSize(45);
    text("Background Factor = " + alter_background_factor, 15, 140);
    show_text_alter_background_factor = show_text_alter_background_factor + 1;
  }
}