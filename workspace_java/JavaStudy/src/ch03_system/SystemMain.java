package ch03_system;

import java.util.Scanner;

public class SystemMain {
	public static void main(String[] args) {
		System.out.println("start");
		System.out.println();
		System.out.println("end");
		
		System.out.print("줄바꿈 안됨");
		System.out.print("보기 불편...");
		
		System.out.print("println 처럼\n");
		System.out.println("중간에 \n을 넣어보세요");
		
		System.out.println("월\t화\t수\t목\t금");
		System.out.println("오늘은 \"금요일\" ^^");
	
		System.out.printf("원주율은 %.2f \n" ,3.141592);
		System.out.printf("%d명이 수업을 듣고있습니다.\n", 23);
		System.out.printf("%d명이 %s를 듣고있습니다. \n", 24,"수업");
		
		Scanner scan = new Scanner(System.in);
		System.out.println("이름을 입력해주세요");
		System.out.print(">>>");
		
		String name = scan.nextLine();
		System.out.println(name + "님 환영합니다. ^^");
		
		System.out.println("에어컨 희망 온도를 입력해주세요.");
		System.out.print(">>>");
		int temper = Integer.parseInt(scan.nextLine()); // 같은거는 scan.nextInt();
		System.out.printf("희망온도 %d 이군요.\n", temper);
		System.out.println("취미입력해주세요");
		System.out.print(">>>");
		String c = scan.nextLine();
		System.out.println("취미는: " + c);
		
		
		scan.close();
		
	}

}
