package ch13_thread;

public class TreadMain {
public static void main(String[] args) {
	//printTest(20);
//	printTest(100);
	//쓰레드를 나눠주지 않으면
	//메인스레드 하나만 일을해서 위에서부터 차례대로 실행됨.
	//하나가 끝나야 다음껏도 시작함
	System.out.println("[메인 스레드] 카운터시작~");
	ExThread thread1 =new ExThread(20, "worker1");
	thread1.start(); // run에 정의되어있는 작업시작
	ExThread thread2 = new ExThread(100, "worker2");
	thread2.start();
	System.out.println("[메인 스레드] 종료 ~");
	
	// 2,runnable 구현 스레드 사용
	Thread run_thread = new Thread(new ExRunnable(200,"run_worker1"));
	run_thread.start();
	
	//람다식 사용
	Thread lamda_thread = new Thread(()->{
		for(int i =0; i< 5; i++) {
			System.out.println("lamda thread " +i );
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	});
	lamda_thread.start();
	
	//각각의 스레드는 언제 어떤것 부터 일이 끝날지 모름
	// 순서에 맞춰 작업을 수행하도록 하려면 제어가 필요함.
	
}
	public static void printTest(int num) {
		for(int i= num; i<=num+5 ; i++) {
			System.out.println(i);
			
			//Tread.sleep() // 현재 실행중인 스레드를 멈추는것
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}

