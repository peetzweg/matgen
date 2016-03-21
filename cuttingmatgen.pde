// Colors
var backgroundColor = #424242;
var lineColor       = #555555;
var textColor       = #666666;


// Text
var fontSize = 28;
var font = "Meta-Bold.ttf";

// Environment
var Sd = 13.3;          // screen size
var Rw = 16;            // ratio width
var Rh = 10;            // ratio height
var ppi = 227;          // pixels per inch
var Srw = screen.width; // screen resolution width
var Srh = screen.height; // screen resolution height
var inchInCm = 2.54;    // factor between inch and centimeters

// How many pixel made up a centimeter on screen
// Step 1: natural screen width in inch
var Sw = (Sd / Math.sqrt(Math.pow(Rw, 2) + Math.pow(Rh, 2))) * Rw;

// Step 2: native screen resolution width
var Nrw = Sw * ppi;

// Step 3: scaled ppi
var ppis = (ppi / Nrw) * Srw;

// Step 4: pixels per centimeter
var ppcm = ppis / inchInCm; // pixel per centimeter
var PPCM = Math.round(ppcm); // round to whole number, cause there are no fractions of pixels


// How many horizontal and vertical lines
// Step 1: real number of lines
var rawNoOfVLines = Srw / ppcm;
var rawNoOfHlines = Srh / ppcm;

// Step 2: whole number of lines
var noOfVLines = Math.floor(rawNoOfVLines);
var noOfHLines = Math.floor(rawNoOfHlines);

// Step 3: offset from rest of real number
var xOffset = Math.round((Srw - (noOfVLines * PPCM)) / 2);
var yOffset = Math.round((Srh - (noOfHLines * PPCM)) / 2);


void setup()
{
    size(Srw, Srh);
    background(backgroundColor);
    noLoop();
    strokeCap(SQUARE);
}

void draw()
{
    // LINES
    stroke(lineColor);

    // vertical lines
    noOfVLines -= 2; // remove two lines for drawing numbers
    for (var vl = 0; vl <= noOfVLines; vl++) {
        var x = (vl*PPCM) + xOffset + PPCM ; // offset + 1 PPCM margin for numbers
        var y1 = yOffset + (PPCM * 0.6);
        var y2 = Srh - yOffset - (PPCM * 0.6);
        line(x, y1, x, y2);
    }

    // horizontal lines
    noOfHLines -= 2; // remove two lines for drawing numbers
    for (var hl = 0; hl <= noOfHLines; hl++) {
        var y = (hl*PPCM) + yOffset + PPCM;
        var x1 = xOffset + (PPCM * 0.6);
        var x2 = Srw - xOffset - (PPCM * 0.6);
        line(x1, y, x2, y);
    }


    // NUMBERS
    fill(textColor);
    PFont numbers = loadFont(font, fontSize);
    textFont(numbers);
    textMode(SCREEN);

    // horizontal numbers
    textAlign(CENTER);
    for (var hn = 0; hn <= noOfVLines; hn++) {
        var x = ((hn*PPCM) + xOffset + PPCM);
        var y = Srh - yOffset;
        text(hn, x, y);
    }

    // vertical numbers
    textAlign(RIGHT);
    for (var vn = 0; vn <= noOfHLines; vn++) {
        var y = (vn*PPCM) + yOffset + PPCM + (fontSize / 3);
        var x = xOffset + (PPCM * 0.5);
        text(noOfHLines - vn, x, y); // draw numbers descending
    }

    // applying canvas data to an image to make it savable
    document.getElementById('image').src = document.getElementById('canvas').toDataURL();
}