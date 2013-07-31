color BG_COLOR = color(160, 160, 160);
color BLACK = color(0);
color WHITE = color(255);


PImage _vignette;
PImage _drawing;
PImage _gradient;

PGraphics _graphics;
PGraphics _copy;

int _x = 0;


void setup()
{
	size(1280, 360, P3D);
	background(BG_COLOR);

	_drawing = loadImage("paterson-drawing.png");
	_vignette = loadImage("dirty-vignette.png");
	_gradient = loadImage("gradient.png");

	_graphics = createGraphics(640, height);
	_copy = createGraphics(640, height);
}


void draw()
{
	background(BG_COLOR);

	_graphics.beginDraw();
	_graphics.image(_gradient, 0, 0, _gradient.width, _gradient.height);
	_graphics.image(_drawing, 0, 0, _drawing.width, _drawing.height);
	_graphics.endDraw();

	_copy.beginDraw();
	_copy.image(_graphics, 0, 0, _graphics.width, _graphics.height);
	_copy.endDraw();

	_graphics.loadPixels();
	int numPixels = _graphics.pixels.length;
	color newColor;
	for(int i = 0; i < numPixels; i++)
	{
		// _graphics.pixels[i] = getDarkenColor(_graphics.pixels[i], _vignette.pixels[i]);
		// _graphics.pixels[i] = getLightenedColor(_graphics.pixels[i], _vignette.pixels[i]);
		_graphics.pixels[i] = getMultipliedColor(_graphics.pixels[i], _vignette.pixels[i]);
		// _graphics.pixels[i] = getScreenedColor(_graphics.pixels[i], _vignette.pixels[i]);
	}
	_graphics.updatePixels();

	image(_graphics, 0, 0, _graphics.width, _graphics.height);
	image(_copy, 640, 0, _copy.width * 0.5, _copy.height * 0.5);

	_x++;
}


color getDarkenedColor(color a, color b)
{
	return color	(
						(red(a) < red(b)) ? red(a) : red(b), 
						(green(a) < green(b)) ? green(a) : green(b), 
						(blue(a) < blue(b)) ? blue(a) : blue(b) 
					);
}


color getLightenedColor(color a, color b)
{
	return color	(
						(red(a) > red(b)) ? red(a) : red(b), 
						(green(a) > green(b)) ? green(a) : green(b), 
						(blue(a) > blue(b)) ? blue(a) : blue(b) 
					);
}


color getMultipliedColor(color a, color b)
{
	return color	(
						(red(a) * red(b)) / 255, 
						(green(a) * green(b)) / 255, 
						(blue(a) * blue(b)) / 255 
					);
}


color getScreenedColor(color a, color b)
{
	// http://en.wikipedia.org/wiki/Blend_modes#Screen
	return color	(
						255 - ((255 - red(a)) * (255 - red(b))), 
						255 - ((255 - green(a)) * (255 - green(b))), 
						255 - ((255 - blue(a)) * (255 - blue(b)))
					);
}


color getInvertedColor(color a, color b)
{
	return color	(
						255 - red(a), 
						255 - green(a), 
						255 - blue(a)
					);
}