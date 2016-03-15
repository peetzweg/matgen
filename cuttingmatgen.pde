
var Sd = 13.3;          // screen size
var Rw = 16;            // ratio width
var Rh = 10;            // ratio height
var ppi = 227;          // pixels per inch
var Srw = screen.width; // screen resolution width
var inchInCm = 2.54;    // factor between inch and centimeters

// How many pixel made up a centimeter on screen
// Step 1: natural screen width in inch
var Sw = (Sd / Math.sqrt(Math.pow(Rw, 2) + Math.pow(Rh, 2))) * Rw;

// Step 2: native screen resolution width
var Nrw = Sw * ppi;

// Step 3: scaled ppi
var ppis = (ppi / Nrw) * Srw;

// Step 4: pixels per centimeter
var ppcm = ppis / inchInCm;


// How many horizontal and vertical lines
// Step 1: real number of lines
var rawNoOfVLines = Srw/ppcm;

// Step 2: whole number of lines
var noOfVLines = Math.floor(rawNoOfVLines);

// Step 3: offset from rest of real number
var xOffset = (Srw - (noOfVLines * Math.round(ppcm)))/2;


var PPCM = Math.round(ppcm); // pixel per centimeter
var cWidth = screen.width;
var cHeight = screen.height;


void setup()
{
    println("PPCM: "+ xOffset)
    size(cWidth,cHeight);
    background(225);
    noLoop();
    strokeCap(SQUARE);
}

void draw()
{
    var noOfLines = noOfVLines;
    // vertical lines
    for (var v = 0; v <= noOfLines; v++) {
        var x = (v*PPCM) + xOffset;
        var y1 = PPCM;
        var y2 = cHeight - PPCM;
        line(x, y1, x, y2);
    }

    // horizontal lines
    for (var h = 0; h < noOfLines; h++) {
        var y = (h*PPCM) + PPCM;
        var x1 = PPCM;
        var x2 = cWidth - PPCM;
        line(x1, y, x2, y);
    }
}