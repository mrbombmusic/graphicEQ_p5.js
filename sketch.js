let fft; //variable for fft object
let aud; //variable for audioIn object
let w; //variable for width of each band
let band = 1024; //variable for number of bands

function setup() {
  createCanvas(windowWidth, windowHeight);
  fft = new p5.FFT(0.9, band); //store fft object in variable
  aud = new p5.AudioIn(); //store AudioIN object in variable
  aud.start();
  fft.setInput(aud); //set fft input for audioIn object
  w = width / band; // set size of each band
}

function draw() {
  background(220);
  let lev = aud.getLevel(); //store value of audio amplitude
  let spect = fft.analyze(); //create array for each band value 
  console.log(spect + ", " + lev);
  
  fill(lev * 10000, spect[333], spect[0]); //coloring using amplitude level and specific band values
  
  beginShape(); //creating graphic EQ by creating shape using each band level as a vertex
  vertex(0, height - 20); //starting point vertex
  for (let i = 0; i < spect.length; i++) {
    vertex(w * i, height - 20 - (spect[i] * 2));
  }
  vertex(width, height - 20); //ending point vertex
  endShape(CLOSE);

}
