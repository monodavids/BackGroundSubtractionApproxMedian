// David Monaghan DCU Insight May 2016
// This code is for a summer intern project with Anne Cleary and Denis Connolly
// and is for my intern student Mathew Sam to learn approximate median background modelling

// This is to show the frame rate

void ShowFrameRate() {
  // This is to figure out the current frame rate for each effect
  if (leave_frame_rate_on_screen > 1) {
    calculate_frame_rate = 1 / (((minute()*3600 + second()*60 + millis()) - current_time) / 1000);
    current_time = minute()*3600 + second()*60 + millis();  
    fill(255, 0, 0);
    textSize(45);
    text("Frames per Second = " + calculate_frame_rate, 15, 400);
    leave_frame_rate_on_screen = leave_frame_rate_on_screen - 1;
  }
}