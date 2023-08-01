package ch10_extends_interface.starcraft;

import java.util.ArrayList;

public class StarCraftMain {

	public static void main(String[] args) {
		Marine marine01 = new Marine("마린", 6, 50, 0);
		Marine marine02 = new Marine();
		marine01.move(100,200);
		marine01.stimpack();
		System.out.println(marine01);
		System.out.println(marine02);
		
		Zealot zealot01 = new Zealot();
		zealot01.move(10,5);
		System.out.println(zealot01);
		
		//다향성 (Polymorphism)
		//오버라이딩, 오버로딩, 앱캐스팅, 다운캐스팅
		//하나의 객체가 여러 타입을 가질 수 있음
		// 자식 객체에서 부모 객체로 형변환이 가능
		StarUnit highTemplar1 = new HighTemplar();
		HighTemplar highTemplar2 = new HighTemplar();
		
		//자식에서 부모 객체로 형변환이 가능함.
		StarUnit highTemplar3 = highTemplar2;
		System.out.println(highTemplar1);
		System.out.println(highTemplar2);
		System.out.println(highTemplar3);
		
		ArrayList<StarUnit> starList = new ArrayList<StarUnit>();
		starList.add(zealot01);
		starList.add(marine01);
		starList.add(marine02);
		starList.add(highTemplar1);
		starList.add(highTemplar2);
		
		for(int i=0; i <starList.size(); i++) {
			starList.get(i).move(100, 150);
		}
		// HighTemplar(자식) 이 StarUnit(부모)fh
		//형 변환이 되었기 때문에
		// 부모가 가지고 있지 않은 메소ㅓ드는 사용불가
		highTemplar2.tthunderStorm();
		//starList.get(4).tthumderStorm(); //형변환되어서 안됨 (원래라면 자식이었어야했는데 부모로 만들어서 자식꺼는 쓸수가없음
		// 부모 -> 자식 형변환후 자식의 메소드 사용
		// 다운케스팅은
		((HighTemplar)starList.get(4)).tthunderStorm();
		
		StarUnit scv = new StarUnit("SCV", 5, 60, 0);
		// 일반적으로 부모 객체는 자식 객체로 형변환 할 수 없다.
		//instanceof 형변환 가능 체크 true/false
		System.out.println(scv instanceof Zealot);
		//부모 객ㄱ체로 형변환 되었던 자식 객체는
		//다시 자식 타읍으로 형변환이 가능
		System.out.println(starList.get(0) instanceof Zealot);
	}

}
