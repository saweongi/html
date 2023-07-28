package practice.submult01;

public class Account {

 String account_Member;
 String name;
 int first_Money;
	Account(String account_Member, String name,int first_Money ){
		this.account_Member=account_Member;
		this.name =  name;
		this.first_Money=first_Money;
		
	}
	public void printAccount() {
		System.out.println(account_Member+name +first_Money);
	}
	
	
}
