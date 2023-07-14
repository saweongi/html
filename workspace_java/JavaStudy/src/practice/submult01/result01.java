package practice.submult01;

public class result01 {
	public static void main(String[] args) {
		String name = "사원기";
		int age = 29;
		float height = 177.9f;
		String phone = "010-2918-7547";
		String email = "wwdnjsrl2@naver.com";
		
		
		System.out.println("이름 : "+name);
		System.out.println("나이 : "+age);
		System.out.println("키 : "+height);
		System.out.println("연락처 : "+phone);
		System.out.println("이메일 : "+email);
		
		String enigma ="너오구늘리뭐너먹구지리";
		String enigma1=enigma.replace("너","");
		System.out.println("1차 암호 해독[너 제거]:" +enigma1);
		String enigma2=enigma1.replace("구","");
		System.out.println("2차 암호 해독[구 제거]:" + enigma2);
		String enigma3=enigma2.replace("리","");
		System.out.println("3차 암호 해독[리 제거]:" + enigma3);
		System.out.println("해독완료!! ->" +enigma3);
		System.out.println(enigma3);
		
		int example = 278;
		int i= example /100;
		int i1 = (example /10) %10;
		int i2 = example%10;
		int sum = i +i1 + i2;
		System.out.println("결과는 :" +sum);
		
	}
}
