// David Monaghan DCU Insight May 2016
// This code is for a summer intern project with Anne Cleary and Denis Connolly
// and is for my intern student Mathew Sam to learn approximate median background modelling

// This is the background subtraction code

void background_code(PImage difference_frame, PImage current_background)
{
  video.read(); // Read a new video frame
  video.loadPixels(); // Make the pixels of video available
  difference_frame.loadPixels();
  current_background.loadPixels();
  float r, g, b, bg_r, bg_g, bg_b, diff_r, diff_g, diff_b;

  for (int x = 0; x < capture_xsize; x++) {
    for (int y = 0; y < capture_ysize; y++) {
      int loc = x + (y * capture_xsize);
      
      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      r = red(video.pixels[loc]);
      g = green(video.pixels[loc]);
      b = blue(video.pixels[loc]);

      bg_r = red(current_background.pixels[loc]);
      bg_g = green(current_background.pixels[loc]);
      bg_b = blue(current_background.pixels[loc]);

      diff_r = r - bg_r;
      diff_g = g - bg_g;
      diff_b = b - bg_b;

      if (bg_counter > bg_limit) {

        //This if statement updates the BG model.. this is where the magic happens
        if (diff_r > background_adjustment_factor) {
          bg_r += alter_background_factor;
        } else if (diff_r < -background_adjustment_factor) {
          bg_r -= alter_background_factor;
        } 

        if (diff_g > background_adjustment_factor) {
          bg_g += alter_background_factor;
        } else if (diff_g < -background_adjustment_factor) {
          bg_g -= alter_background_factor;
        }

        if (diff_b > background_adjustment_factor) {
          bg_b += alter_background_factor;
        } else if (diff_b < -background_adjustment_factor) {
          bg_b -= alter_background_factor;
        }
      }

      if (effect_selector == 1) {
        // Now that we have an updated background model with can go about changing the displayed image
        if ( ((diff_r > foreground_factor)||(diff_r < -foreground_factor))||((diff_g > foreground_factor)||(diff_g < -foreground_factor))||((diff_b > foreground_factor)||(diff_b < -foreground_factor)) ) {

          diff_r = 255;
          diff_g = 255;
          diff_b = 255;
        } else {       

          diff_r = 0;
          diff_g = 0;
          diff_b = 0;
        }
      } else if (effect_selector == 2) {
        diff_r = bg_r;
        diff_g = bg_g;
        diff_b = bg_b;
      }

      // Set the display pixel to the image pixel
      difference_frame.pixels[loc] =  color(diff_r, diff_g, diff_b); 
      current_background.pixels[loc] =  color(bg_r, bg_g, bg_b);
    }
  }

  if (bg_counter > bg_limit) {
    bg_counter = 0;
  }
  bg_counter++;

  difference_frame.updatePixels();
}