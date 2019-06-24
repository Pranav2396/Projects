package gA;

import java.util.ArrayList;
import java.util.HashSet;

import org.ejml.simple.SimpleMatrix;

import basicneuralnetwork.NeuralNetwork;
import processing.core.PApplet;
import processing.core.PFont;

//Pipe class
class Pipe extends PApplet
{
	int x;
	int y;
	int endpoint;
	int pipe_width;
	int pipe_height;
	int index;
	
	int shift=-5;

	public Pipe(int size,int w,int h,int ind)
	{
		this.x=size;
		this.y=0;
		this.pipe_width=w;
		this.pipe_height=h;
		this.endpoint=(int) Math.floor(random(13,size/2));
		this.index=ind;
	}
	
	public void update()
	{
		this.x+=this.shift;
	}
}

