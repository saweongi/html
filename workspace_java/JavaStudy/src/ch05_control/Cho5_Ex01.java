package ch05_control;

import java.util.Scanner;
public class Cho5_Ex01 {
	public static void main(String[] args) {
	Scanner scanner =new Scanner(System.in);
	System.out.println("숫자를 입력하세요");
	System.out.println(">>>");
	
	int data = scanner.nextInt();
	
	if(data%2 == 0) {
		System.out.println("짝수입니다");
	}
	else {
		System.out.println("홀수입니다.");
	}
	
	scanner.close();
	
	}
}
