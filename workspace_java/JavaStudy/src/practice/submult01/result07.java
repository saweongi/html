package practice.submult01;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Random;
import java.util.Scanner;

public class result07 {

	public static void main(String[] args) {
		
	ArrayList<Integer> weekLotto = null;

	weekLotto = makeLotto();
	System.out.println(weekLotto.toString());
	String [] numArr = {"1", "5"};
	weekLotto = makeLotto(numArr);
	System.out.println(weekLotto.toString());
	
	System.out.println("=============================================");
	System.out.println("행운의 로또 번호 생성기 입니다.");
	System.out.println("입력 값이 있으면 'y', 전체 자동으로 선택하려면 'n'를 선택하세요>>>");
	Scanner scanner = new Scanner(System.in);
	String ny = scanner.nextLine();
	if(ny.equals("n")) {
		weekLotto = makeLotto();
		System.out.println("이번주 행운의 번호는♥");
		System.out.println(weekLotto.toString());
		System.out.println("GOOD LUCK♥");
		
	}else {
		System.out.println("번호를 한칸씩 띄워서 입력해주세요 최대 6개");
		Scanner input = new Scanner(System.in);

		//https://danmilife.tistory.com/11
		weekLotto = makeLotto();
		System.out.println("이번주 행운의 번호는♥");
		System.out.println(weekLotto.toString());
		System.out.println("GOOD LUCK♥");
	}
	
	}
	
	public static ArrayList<Integer> makeLotto() {
		Random rd = new Random();
		ArrayList<Integer>lotto = new ArrayList<Integer>();
		for(int i=0; i<6; i++){
			
			 lotto.add(rd.nextInt(45)+1);
		}
		for(int i=0; i<lotto.size(); i++) {
			for(int j=5; j>i; j--) {
				if (lotto.get(i) == lotto.get(j)){
					System.out.println("엿");
					lotto.set(j, rd.nextInt(45)+1);
					i=0;
					j=5;
						}
						
				
			}
		}
		Collections.sort(lotto);
		
		
	
			return lotto;
	}

	public static ArrayList<Integer> makeLotto(String [] strArr) {
		Random rd = new Random();
		ArrayList<Integer>lotto = new ArrayList<Integer>();
		for (String str : strArr) {
            int number = Integer.parseInt(str);
           
            
            lotto.add(number);
           
        }
		
		
		for(int i=0; lotto.size()<6; i++){
			
			 lotto.add(rd.nextInt(45)+1);
		}
		for(int i=0; i<lotto.size(); i++) {
			for(int j=5; j>i; j--) {
				if (lotto.get(i) == lotto.get(j)){
					System.out.println("엿");
					lotto.set(j, rd.nextInt(45)+1);
					i=0;
					j=5;
						}
						
				
			}
		}
		Collections.sort(lotto);
		
		
	
			return lotto;
	}
	


}
	



