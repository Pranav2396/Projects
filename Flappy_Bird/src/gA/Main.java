package gA;

import java.util.ArrayList;
import java.util.HashSet;

import org.ejml.simple.SimpleMatrix;

import basicneuralnetwork.NeuralNetwork;
import processing.core.PApplet;
import processing.core.PFont;

public class Main extends PApplet
	{
		ArrayList<Bird> b;
		ArrayList<Bird> temp_b;
		ArrayList<Pipe> p;
		
		Pipe p1;
		PFont f;
		
		int frames=0;
		int cycles=100;
		int generations=0;
		static double avg_fitness=0;
		
	    int ind=0;
		
		int score=0;
		int found=0;// Finding best bird
		int pop_size=250;

		static int size=800;
		static int pipe_height=100;
		static int pipe_width=35;
	
		Bird best_bird;
		public void setup()
		{
			b=new ArrayList<Bird>();
			temp_b=new ArrayList<Bird>();
			best_bird=new Bird(800);
			
			for(int i=0;i<pop_size;i++) 
			    b.add(new Bird(size));
			
			p=new ArrayList<Pipe>();
			f = createFont("Arial",25,true);
		}
		
		//Parent selection (Roulette wheel)
		public Bird pick(ArrayList<Bird> temp_b)
		{
			int ind_=0;
			double r=random(1);
		
			while(r>0)
				{
					r=r-temp_b.get(ind_).fitness_score;
					ind_++;
				}
			
			ind_--;
			
			Bird new_=new Bird(size);
			new_.brain=temp_b.get(ind_).brain.copy();
            //new_.brain.mutate(0.1);
			return new_;
		}
		
		public void crossover()
		{
			//Normalizing all the scores to consider them as probabilities.
			double sum=0;
			for(int i=0;i<temp_b.size();i++)
				{
			     	sum+=temp_b.get(i).fitness_score;
				}
			for(int i=0;i<temp_b.size();i++)
				{
					temp_b.get(i).fitness_score=temp_b.get(i).fitness_score/sum;
				}
			
			ArrayList<Bird> cross_over_bird_prev=new ArrayList<Bird>();
			ArrayList<Bird> cross_over_bird_after=new ArrayList<Bird>();
			
			for(int i=0;i<30;i++)
			{
			   cross_over_bird_prev.add(pick(temp_b));
			}
			
			//Implementing cross-over (Merging 2 neural networks)
			for(int i=0;i<30;i++)
				{
					for(int j=i+1;j<30;j++)
						{
							NeuralNetwork brain1=cross_over_bird_prev.get(i).brain;
							NeuralNetwork brain2=cross_over_bird_prev.get(j).brain;
							NeuralNetwork new_brain=brain1.merge(brain2);
							
							Bird new_bird=new Bird(size);
							
							new_bird.brain=new_brain.copy();
							new_bird.brain.mutate(0.1);
							cross_over_bird_after.add(new_bird);
						}
				}
			
			b=new ArrayList<Bird>();
			for(int i=0;i<temp_b.size();i++)
				{
					b.add(cross_over_bird_after.get(i));
				}
		}
		
		public void next_gen()
		{
			crossover();
			temp_b=new ArrayList<Bird>();
		}
		
		public void draw()
		{	
			//All birds dead
			background(0);
		
		for(int n=0;n<cycles;n++)
		{
			if(b.size()==0)
			{
				p=new ArrayList<Pipe>();
				
				score=0;
				frames=0;
				generations++;
				if(found==0)
				  pop_size=250;
				else
				  pop_size=1;
				
				avg_fitness=0;
				
				next_gen();	
				//System.out.println("-------------------------------------------------------");
			}
			
			frames++;
			//Displaying Score and Generation
			fill(255);
			textFont(f); // Set the current text font
		    text("Average Fitness Score:"+((double)avg_fitness/pop_size), size-335, 30);
		    text("Game score:"+best_bird.score, size-335, 60); 
		    text("Generation:"+generations, size-335, 90);
		   
			for(int i=0;i<pop_size && found==0;i++)
				{
					b.get(i).process(p);
					b.get(i).update(size);
					
					//Choosing best bird
					if(b.get(i).score>=200)
						{
							best_bird.brain=b.get(i).brain.copy();
							found=1;
							cycles=1;
							avg_fitness=0;
							p=new ArrayList<Pipe>();
						}
					avg_fitness+=1;
				}
			
			//Resetting Game
			if(found==1)
				{
					best_bird.process(p);
					best_bird.update(size);
					b.clear();
					b.add(best_bird);
					pop_size=1;
					avg_fitness+=1;
				}

     		//Drawing Pipe
			if(frames%80==0)
				{
					p.add(new Pipe(size,pipe_width,pipe_height,ind));
					ind++;
				}
			
			for(int i=0;i<p.size();i++)
				{
					Pipe p1=p.get(i);
				    
	          	    p1.update();
				    
				    int pipe_flag=1;
				    for(int j=pop_size-1;j>=0;j--)
				    	{
						    if(b.get(j).collides(p1) || (b.get(j).y<=30 || b.get(j).y>=770) && p.size()>=2)
						    	{						    	
						    		temp_b.add(b.get(j));
						    		b.remove(j);
						    		pop_size--;
						    	}
						    else if(b.get(j).passes(p1))
						    	{
						    		b.get(j).score+=1;				    		
						    	}
						    if(p1.x<-(pipe_width+15))
						    	{
						    		//if(b.get(j).hm.contains(p1.index))
						    			//b.get(j).hm.remove(p1.index);
						    		if(pipe_flag==1)
							    		  {p.remove(i);i--;pipe_flag=0;}	
						    	}
				    	}				    
				}
		}
		
		
		  //Drawing logic for pipes and birds
			for(int i=0;i<p.size();i++)
			  {
				Pipe p1=p.get(i);
				rect(p1.x,0,pipe_width,p1.endpoint);
			    rect(p1.x,p1.endpoint+pipe_height,pipe_width,size-(p1.endpoint+pipe_height));
			  }
	
		  for(int i=0;i<pop_size;i++)
			  {
			   ellipse(b.get(i).x,b.get(i).y,30,30);
			  }
			
		}
		public void settings()
		{
			size(size,size);
		}
		
		public static void main(String[] args)
		{
	       PApplet.main("gA.Main");
		}
			
	}
