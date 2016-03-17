// Colors

color backgroundColor = #424242;
color lineColor       = #EEEEEE;
color textColor       = #EEEEEE;


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
    println("PPCM: "+ PPCM);
    println("screenheight: "+ Srh);
    println("yoffset: "+ yOffset);

    size(Srw, Srh);
    background(backgroundColor);
    noLoop();
    strokeCap(SQUARE);
}

void draw()
{
    stroke(lineColor);
    // vertical lines
    for (var v = 0; v <= noOfVLines; v++) {
        var x = (v*PPCM) + xOffset;
        var y1 = yOffset;
        var y2 = Srh - yOffset;
        line(x, y1, x, y2);
    }

    // horizontal lines
    for (var h = 0; h <= noOfHLines; h++) {
        var y = (h*PPCM) + yOffset;
        var x1 = xOffset;
        var x2 = Srw - xOffset;
        line(x1, y, x2, y);
    }
}