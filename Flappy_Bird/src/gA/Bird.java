package gA;

import java.util.ArrayList;
import java.util.HashSet;

import org.ejml.simple.SimpleMatrix;

import basicneuralnetwork.NeuralNetwork;
import processing.core.PApplet;
import processing.core.PFont;


//Bird Class
class Bird extends PApplet
{
	int x;
	int y;	
	double gravity;
	double speed;
	double lift;
	double fitness_score;
	int score;
	HashSet<Integer> hm;
	NeuralNetwork brain;

	public Bird(int size)
	{
		this.x=25;
		this.y=size/2;
		this.brain=new NeuralNetwork(5,10,1);
		this.fitness_score=0;
		this.gravity=1.1;
		this.lift=-14;
		this.score=0;
		this.speed=0;
		hm=new HashSet<Integer>(); //Set of pipes bird has processed.
	}
	
	public void update(int size)
	{
		this.fitness_score+=1;
		
		if(this.y>=((double)size-15))
			{
					this.gravity=1.1;
					this.speed=0;
			}
		else
			{
				if(this.y<=0)
				{
							this.gravity=1.1;
							this.speed=0;
				}
				this.speed+=this.gravity;
				this.y+=this.speed;
			}
	}
	
	public void moveUp()
	{
		if(this.y>=30)
			{
	        	this.speed+=this.lift;
		        this.y+=this.speed;
			}
	}
	
	public void process(ArrayList<Pipe> pipes) 
	{
		 if(pipes.size()==0) return;
		 
	     double[] input=new double[5];
		 double[] output;
		 int closest_index=0;
		 double closest_distance=Double.MAX_VALUE;
		 
		 //Determining closest Pipe
		 for(int i=0;i<pipes.size();i++)
			 {
				 int dist=(pipes.get(i).x+pipes.get(i).pipe_width)-this.x;
				 if(dist<closest_distance && dist>0)
					 {
						 closest_distance=dist;
						 closest_index=i;
					 }
			 }
		 
		 input[0]=closest_distance;
		 input[1]=pipes.get(closest_index).endpoint;
		 input[2]=(pipes.get(closest_index).endpoint+pipes.get(closest_index).pipe_height);
		 input[3]=this.speed;
		 input[4]=this.y;
		 
		 output=this.brain.predict(input);
		 if(output[0]>0.5)
			  this.moveUp();
	}
		
	public boolean collides(Pipe p)
	{
			int b_x=this.x;
			int b_y=this.y;
			
			if((b_x>=p.x && b_x<=(p.x+p.pipe_width)) && ((b_y>=p.y && b_y<=p.endpoint) || ((b_y>=(p.endpoint+p.pipe_height)))))
					return true;
			return false;
	}
	
	public boolean passes(Pipe p)
	{
				int b_x=this.x;
				int b_y=this.y;
				
				if(b_x>(p.x+p.pipe_width))
					{
						if(!this.hm.contains(p.index))
							{this.hm.add(p.index);return true;}
					}
				return false;
	}
}

