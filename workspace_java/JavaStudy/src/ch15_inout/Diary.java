package ch15_inout;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.util.Date;
import java.util.Scanner;

public class Diary {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		
		//파일경로
		String filePath = "diary.txt";
		File file = new File(filePath);
		Date now = new Date();
		
		try {
			FileOutputStream fos = new FileOutputStream(file, true);
			fos.write((now + "\n").getBytes());
			while(true) {
				System.out.println("오늘의 일기를 작성하세요. 'exit' 를 입력하면 종료됩니다.");
				String msg = sc.nextLine();
				if("exit".equalsIgnoreCase(msg)) {
					break;
				}
				
				fos.write(( msg + "\n").getBytes());
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e){
			e.printStackTrace();
		} finally {
			sc.close();
		}
		
		

	}

}
