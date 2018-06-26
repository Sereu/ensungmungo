package silverstar.customer;

public class CustomerGrade {
	private String customerGrade;
	private int minPrice;
	private int maxPrice;
	private int pointRate;
	private String image;
	
	public CustomerGrade() {}

	public String getCustomerGrade() {
		return customerGrade;
	}

	public void setCustomerGrade(String customerGrade) {
		this.customerGrade = customerGrade;
	}

	public int getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(int minPrice) {
		this.minPrice = minPrice;
	}

	public int getMaxPrice() {
		return maxPrice;
	}

	public void setMaxPrice(int maxPrice) {
		this.maxPrice = maxPrice;
	}

	public int getPointRate() {
		return pointRate;
	}

	public void setPointRate(int pointRate) {
		this.pointRate = pointRate;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	
}
