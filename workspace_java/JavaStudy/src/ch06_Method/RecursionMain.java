package ch06_Method;



public class RecursionMain {

	public static void main(String[] args) {
		func(5);;
		recFactorial(5);
		System.out.println();
	
	}

	public static void func(int num) {
		if (num == 0) {
			return;

		} else

		{
			System.out.println("hi" + num);
			func(num);
		}
		
	}
	public static long recFactorial(int num) {
		if(num==1) {
			return 1;
		}
		return num * recFactorial(num -1);
		
	}
	public static long factorial(int num) {
		long sum =1;
		for(int i =1; i<=num; i++) {
			sum *=i;
		}
		return sum;
	
	
	}
	}


