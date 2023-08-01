package practice.submult01.cafe;

import java.util.ArrayList;

public class Cafe {
	String name;
	ArrayList menuList = new ArrayList();

	public Cafe(String name) {
		this.name = name;
	}

	public void showMenu() {
		if (this.name.equals("스타벅스")) {
			Coffee coffee = new Coffee("아메리카노", 5000);
			Coffee coffee1 = new Coffee("카푸치노", 6000);
			Coffee coffee2 = new Coffee("오곡라떼", 7000);
			System.out.println("1. [" + coffee.name + ": " + coffee.price + "]");
			System.out.println("2. [" + coffee1.name + ": " + coffee1.price + "]");
			System.out.println("3. [" + coffee2.name + ": " + coffee2.price + "]");
		} else if (this.name.equals("아카")) {
			Coffee coffee = new Coffee("아메리카노", 2500);
			Coffee coffee1 = new Coffee("바닐라라떼", 3000);
			Coffee coffee2 = new Coffee("아이스티", 3500);
			System.out.println("1. [" + coffee.name + ": " + coffee.price + "]");
			System.out.println("2. [" + coffee1.name + ": " + coffee1.price + "]");
			System.out.println("3. [" + coffee2.name + ": " + coffee2.price + "]");
		}
	}

	public void addCoffee() {

	}

	public Cafe(String name, ArrayList menList) {
		this.name = name;
		this.menuList = menuList;
	}

	public void buyCoffee(int cafe_menu) {
		
		if(this.name.equals("스타벅스")) {
			if (cafe_menu ==1) {
				System.out.println("아메리카노를 5000원에 구매했습니다.");
			}else if (cafe_menu ==2) {
				System.out.println("카푸치노를 6000원에 구매했습니다.");
			}else if (cafe_menu ==3) {
				System.out.println("오곡라떼를 7000원에 구매했습니다.");
			
				
			
	}
		}else if (this.name.equals("아카")) {
			if (cafe_menu ==1) {
				System.out.println("아메리카노를 2500원에 구매했습니다.");
			}else if (cafe_menu ==2) {
				System.out.println("바닐라라떼를 3000원에 구매했습니다.");
			}else if (cafe_menu ==3) {
				System.out.println("아이스티를 3500원에 구매했습니다.");
		}
	}
}
}



