package ch10_extends_interface.simple;

public class Parent {
	private String name;
	private int age;
	public Parent() {
		
	}
	public Parent(String name, int age) {
		super();
		this.name = name;
		this.age = age;
	}public void sayHello() {
		System.out.println("부모입니다.");
	}
	@Override
	public String toString() {
		return "Parent [name=" + name + ", age=" + age + "]";
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}

	
}
