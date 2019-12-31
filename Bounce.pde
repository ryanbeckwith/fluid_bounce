boolean space, spaceReleased, connected, canBounce, aPressed, dPressed;
float gravity, gravity2, direction, x, xSpeed, y, y2, eHeight, eWidth, originalGravity, originalGravity2, reflectionOpacity, numCircles, circleDirection;

void setup()
{
  background(0);
  size(1400, 950);
  stroke(255);
  fill(255);
  frameRate(80);
  eHeight = 100;
  eWidth = 100;
  xSpeed = 0;
  direction = 1;
  x = width/2;
  reflectionOpacity = 50;
  numCircles = 30;
  circleDirection = 1;
}

void draw()
{
  background(0);
  //if (xSpeed > 25)
  //  background(23, 43, 234);
  //else
  //  background(0);
  stroke(255);
  fill(255);
  strokeWeight(2);
  stroke(255, reflectionOpacity - 10);
  line(x - 150, height/2 + 50, x + 150, height/2 + 50);
  noStroke();
  ellipse(x, height/2 + y, eWidth, eHeight);
  for (int i = 0; i < numCircles; i++)
  {
    fill(255, numCircles/2 - random(1, 1.1) * i/2.0);
    ellipse(x, height/2 + y, 100 + i * 2, eHeight + i * 2);
  }
  reflectionOpacity = 20 - y2/5;
  fill(255, reflectionOpacity);
  ellipse(x, height/2 + 100 + y2, eWidth, eHeight);
  x += xSpeed;
  if (aPressed)
  {
    xSpeed -= 0.2;
  }
  if (dPressed)
  {
    xSpeed += 0.2;
  }
  if (!dPressed && xSpeed > 0 && connected)
  {
    xSpeed -= 0.1;
  }
  if (!aPressed && xSpeed < 0 && connected)
  {
    xSpeed += 0.1;
  }
  if (!dPressed && xSpeed > 0 && !connected)
  {
    xSpeed -= 0.02;
  }
  if (!aPressed && xSpeed < 0 && !connected)
  {
    xSpeed += 0.02;
  }
  if (x - 50 < 0 && xSpeed < 0)
  {
    xSpeed = -xSpeed;
    x = 50;
    if (xSpeed < -25)
    {
      eHeight += abs(-25 * 0.8);
      eWidth -= abs(-25 * 0.8);
    }
    else
    {
      eHeight += abs(xSpeed * 0.8);
      eWidth -= abs(xSpeed * 0.8);
    }
  }
  if (x + 50 > width && xSpeed > 0)
  {
    xSpeed = -xSpeed;
    x = width - 50;
    if (xSpeed > 25)
    {
      eHeight += abs(25 * 0.5);
      eWidth -= abs(25 * 0.5);
    }
    else
    {
      eHeight += abs(xSpeed * 0.5);
      eWidth -= abs(xSpeed * 0.5);
    }
  }
  if (eHeight > 100)
  {
    eHeight -= 2;
  }
  if (eWidth < 100)
  {
    eWidth += 2;
  }
  if (numCircles < random(25, 29))
  {
    circleDirection = random(0.05, random(0.2, 0.3));
  }
  if (numCircles > random(31, 60))
  {
    circleDirection = -random(0.05, random(0.1, 0.2));
  }
  numCircles += circleDirection;
  jump();
}

void keyPressed()
{
  if (keyCode == ' ' && connected)
  {
    space = true;
    spaceReleased = false;
  }
  if (key == 'a')
  {
    aPressed = true;
  }
  if (key == 'd')
  {
    dPressed = true;
  }
}

void keyReleased()
{
  if (keyCode == ' ' && connected)
  {
    space = false;
    spaceReleased = true;
  }
  if (key == 'a')
  {
    aPressed = false;
  }
  if (key == 'd')
  {
    dPressed = false;
  }
}

void jump()
{
  if (connected && space && eHeight > 50)
  {
    eHeight -= 2;
//    eWidth += 1;
    y += 1;
    y2 -= 1;
  }
  if (spaceReleased && connected)
  {
    gravity = ((100 - eHeight) / 70.0) * -16;
    originalGravity = gravity;
    connected = false;
    spaceReleased = false;
    canBounce = true;
  }
  y += gravity;
  y2 -= gravity;
  if (!connected)
  {
    gravity += 0.2;
    if (eHeight < 100)
    {
      eHeight += 5;
    }
    if (eWidth > 100)
    {
      eWidth -= 5;
    }
  }
  if (canBounce && connected)
  {
    eHeight += originalGravity * 4;
    eWidth -= originalGravity * 4;
    gravity = originalGravity * (3.0 / 4.0);
    originalGravity = gravity;
    connected = false;
  }
  if (originalGravity > -1 && originalGravity < 0)
  {
    gravity = 0;
    connected = true;
    canBounce = false;
  }
  if (y > 0 && gravity > 0)
  {
    y = 0;
    y2 = 0;
    gravity = 0;
    connected = true;
  }
}
