package ch02_variable;

public class VariableMain {
	public static void main(String[] args) {
		/* 객체 : 데이터(속성) + 데이터를 조작(메서드)
		 *차  --> 바퀴, 핸들, 시트 ,거울 등등(이렇게 가지고 있는 데이터(속성)의 구조)
		 *  --> 가속,정지 ,방향전환 등등(동작 할수있게 하는게 메서드)
		 * 클래스 = 객체를 사용하기 위한 틀을 만드는거  -->기본틀(설계도) --> 자동차 찍어내는거 생각하면됨
		
		 * 객체 지향 프로그래밍의 핵심적인 장점은 코드의 재사용성과 확장성을 증가시키는 것.
		 * 잘 설계하면 동일한 유형의 새로운 객체를 쉽게 생성하고, 기존 객체를 재사용 하거나
		 * 확장하여 프로그램의 복잡성을 관리 할 수 있음.
		 */
		
		System.out.println("====== String 내장 메소드 =======");
		String fruits = "Apple, Banana, Cherry";
		int len = fruits.length(); // fruits에 대하여 문자열의 개수
		System.out.println("fruits 길이는:"+ len);
		
		char alpha = fruits.charAt(3); //3번째위치한 문자의 인덱스 찾는거
		System.out.println(alpha);
		
		System.out.println(fruits.indexOf("Banana") ); //바나나라는 문자열의 인덱스를 찾는거 없을시 -1 리턴
		
		System.out.println(fruits.substring(7, 13)); //시작인덱스부터 끝 인덱스 전까지 짜름 7~12까지가져옴
		
		System.out.println(fruits.substring(15)); //이 위치부터 끝까지 가져옴
		
		System.out.println(fruits.replace("Cherry","pizza")); // 체리를 피자로 변경함
		
		String name = "Sam Kim";
		int num = name.indexOf(" ");
		
		String last = name.substring(0,num);
		System.out.println(last);
		String fisrt = name.substring(num+1);
		System.out.println(fisrt);
		
		
		
		
}
}
