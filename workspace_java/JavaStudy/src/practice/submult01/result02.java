package practice.submult01;

public class result02 {

	public static void main(String[] args) {
		String enigma ="너오구늘리뭐너먹구지리";
		String enigma1=enigma.replace("너","");
		System.out.println("1차 암호 해독[너 제거]:" +enigma1);
		String enigma2=enigma1.replace("구","");
		System.out.println("2차 암호 해독[구 제거]:" + enigma2);
		String enigma3=enigma2.replace("리","");
		System.out.println("3차 암호 해독[리 제거]:" + enigma3);
		System.out.println("해독완료!! ->" +enigma3);
		System.out.println(enigma3);
		
		
	}

}
