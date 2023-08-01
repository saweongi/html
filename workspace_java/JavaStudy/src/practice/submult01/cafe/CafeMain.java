package practice.submult01.cafe;

import java.util.Scanner;

public class CafeMain {

	public static void main(String[] args) {
		while(true) {
		System.out.println("행동을 선택해주세요");
		
		System.out.println("1. 스타벅스 방문 | 2. 아카 방문 | 3. 사무실 복귀..");
		System.out.print(">>> ");
		Scanner scanner = new Scanner(System.in);
		
		int cafe_sc =Integer.parseInt(scanner.nextLine());

		if(cafe_sc == 1) {
			Cafe cafe = new Cafe("스타벅스");
			System.out.println("어서오세요 "+cafe.name+" 입니다.");
			cafe.showMenu();
			System.out.print("메뉴를 선택해주세요: ");
			int cafe_menu =Integer.parseInt(scanner.nextLine());
				cafe.buyCoffee(cafe_menu);
			
			
			
			
		}else if( cafe_sc ==2) {
			Cafe cafe = new Cafe("아카");
			System.out.println("어서오세요 "+cafe.name+" 입니다.");
			cafe.showMenu();
			System.out.print("메뉴를 선택해주세요: ");
			int cafe_menu =Integer.parseInt(scanner.nextLine());
			cafe.buyCoffee(cafe_menu);
			
		}else if (cafe_sc ==3) {
			System.out.println("사무실로 복귀합니다..");
			break;
		}
	}

}
}

