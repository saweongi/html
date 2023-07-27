package ch09_class.commons;

public class UtilClass {

	/**
	 * @프로젝트 :JavaStudy
	 * 작성일 :2023. 7. 27.
	 * 작성자 :SA
	 */
	
	public static double weRound(double num, int n) {
	
		int ten =1;
		for(int i =0; i< n; i++) {
			ten *= 10;
		}
		num *= ten;
		long temp = Math.round(num);
		double result = (double) temp /ten;
		return result;
		

	}
	public static void main(String[] args) {
		System.out.println(weRound(75.12345678, 3));
	}

}

