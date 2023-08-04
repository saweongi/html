package practice.submult01.cafe1;

public class Coffee1 {
	private String name;
	private int price;
	
	
	public Coffee1(String name, int price) {
		super();
		this.name = name;
		this.price = price;
	}

	public String toString() {
		return "Coffee1 [name=" + name + ", price=" + price + "]";
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
}
