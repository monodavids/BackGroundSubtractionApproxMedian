// David Monaghan DCU Insight May 2016
// This code is for a summer intern project with Anne Cleary and Denis Connolly
// and is for my intern student Mathew Sam to learn approximate median background modelling

// This is the main file setting up variables and the likes

// use the processing video library
import processing.video.*; 
Capture video;

// Declare the required variables
int frames_per_second = 30;  // video frames per second
// ok so in processing 3+ there is a new way of dealing with the size function. This needs to 
// be hard coded in or else a function like fullScreen(); should be used
// for this demo make sure the dimensions below match the size dimension in setup()
int capture_xsize = 800;  // capture size
int capture_ysize = 600;
int effect_selector = 1;

int text_on_screen_time = 3 * frames_per_second;
int show_text_foreground = 1; // just so this does show on start up
int show_text_alter_background_factor = 1;

float calculate_frame_rate; //This will calculate what the frame rate of the final image to screen will be, so this takes into account all the processing that needs to be done on one frame
float current_time = minute()*3600 + second()*60 + millis();
int leave_frame_rate_on_screen = 3 * frames_per_second;

// these are the image adjustment variables
float alter_background_factor = 1;  // How much to alter the BG by (normally the range is 0-255) keep as int for the moment, easier.
int background_adjustment_factor = 1; // only change BG if the 'difference' is more than this factor, again range 0-255, this allows for very minor light changes and compression artefacts to be ignored
int foreground_factor = 25; // the foreground must be more than this level, i'll put in a way to change this value with the keyboard
int bg_counter = 1;
int bg_limit = 1;

// We only need two image here, the background frame and the difference frame
PImage current_background = createImage(capture_xsize, capture_ysize, RGB); // create a bg model that will adapt in the programme
PImage difference_frame = createImage(capture_xsize, capture_ysize, RGB); // this is the difference between BG and current_frame

// initial processing setup
void setup() {
  // again with processing 3 just make sure these match the capture sizes listed above
  size(800, 600);

  //  create a new instance of video and give it the size and fps
  video = new Capture(this, capture_xsize, capture_ysize, frames_per_second);

  // the video start command is not always neccessary but I believe in processing 3 it is
  video.start();
}

void draw() {
  // the no cursor command does what is says... gets rid of the mouse cursor when the app is running
  noCursor();

  // this effect is the background effect
  background_code(difference_frame, current_background);

  // display the image to the screen
  // Flip the image around
  //store scale,translation,etc
  pushMatrix();
  //flip across x axis
  scale(-1, 1);
  //The x position is negative because we flipped
  image( difference_frame, -capture_xsize, 0);
  //restore previous translation,etc
  popMatrix();

  // this just displays the variables to the screen for debugging
  ShowBackgroundFactor();
  ShowFrameRate();
}

void keyPressed() {
  if (key == CODED) {

    // change the effects and Background variables
    if (keyCode == UP) {
      if (keyEvent.isShiftDown()) {
        alter_background_factor = alter_background_factor + 0.1;
        show_text_alter_background_factor = 1;
        println(alter_background_factor);
      } else {
        effect_selector = 1;
        println(effect_selector);
      }
    } else if (keyCode == DOWN) {
      if (keyEvent.isShiftDown()) {
        alter_background_factor = alter_background_factor - 0.1;
        show_text_alter_background_factor = 1;
        println(alter_background_factor);
      } else {
        effect_selector = 2;
        println(effect_selector);
      }
    } else if (keyCode == RIGHT) {
      if (keyEvent.isShiftDown()) {
        foreground_factor = foreground_factor + 1;
        if (foreground_factor > 255) {
          foreground_factor = 255;
        }
        show_text_foreground = 1;
        println(foreground_factor);
      }
    } else if (keyCode == LEFT) {
      if (keyEvent.isShiftDown()) {
        foreground_factor = foreground_factor - 1;
        if (foreground_factor < 1) {
          foreground_factor = 1;
        }
        show_text_foreground = 1;
        println(foreground_factor);
      }
    }
  }

  if (key == ' ') {
    video.loadPixels();
    arrayCopy(video.pixels, current_background.pixels);
  }
  if ((key == ENTER)||(key == RETURN)) {
    leave_frame_rate_on_screen = 50;
  }
}