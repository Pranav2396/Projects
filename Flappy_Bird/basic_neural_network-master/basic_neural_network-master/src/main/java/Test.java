import java.util.Random;

import org.ejml.simple.SimpleMatrix;

public class Test 
	{
	    public static void main(String[] args)
		{
		   SimpleMatrix[] weights=new SimpleMatrix[2];
		   weights[0]=SimpleMatrix.random64(2,2, -1, 1, new Random());
		   weights[0].print();
		   System.out.println();
		   weights[1]=SimpleMatrix.random64(3,3, -1, 1, new Random());
		   weights[1].print();
		   
		}		
	}