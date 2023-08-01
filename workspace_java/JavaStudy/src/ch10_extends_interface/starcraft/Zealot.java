package ch10_extends_interface.starcraft;

public class Zealot extends StarUnit{
	private int shieId;
	
	public Zealot() {
		this("질럿", 16, 100, 1, 60); 
	}

	public Zealot(String name, int damage, int hp, int armor, int shieId) {
		
		//자식 생성자 맨위에 부모 생성자가 와야함
		super(name, damage, hp, armor);
		this.shieId = shieId;
	}

	@Override
	public String toString() {
		return "Zealot [shieId=" + shieId + ", getName()=" + getName() + ", getDamage()=" + getDamage() + ", getHp()="
				+ getHp() + ", getArmor()=" + getArmor() + "]";
	}

	public int getShieId() {
		return shieId;
	}
	
	

}
