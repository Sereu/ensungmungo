package silverstar.order;

public class OrderDetail {
	private int orderno;
	private int bookno;
	private String image;
	private String name;
	private int qty;
	
	private String address;
	private String payment;
	
	private int point;
	private int price;
	private int cancelpoint;


	public final int getOrderno() {
		return orderno;
	}

	public final void setOrderno(int orderno) {
		this.orderno = orderno;
	}

	public final int getBookno() {
		return bookno;
	}

	public final void setBookno(int bookno) {
		this.bookno = bookno;
	}

	public final String getImage() {
		return image;
	}

	public final void setImage(String image) {
		this.image = image;
	}

	public final String getName() {
		return name;
	}

	public final void setName(String name) {
		this.name = name;
	}

	public final int getQty() {
		return qty;
	}

	public final void setQty(int qty) {
		this.qty = qty;
	}

	public final String getAddress() {
		return address;
	}

	public final void setAddress(String address) {
		this.address = address;
	}

	public final String getPayment() {
		return payment;
	}

	public final void setPayment(String payment) {
		this.payment = payment;
	}

	public final int getPoint() {
		return point;
	}

	public final void setPoint(int point) {
		this.point = point;
	}

	public final int getCancelpoint() {
		return cancelpoint;
	}

	public final void setCancelpoint(int cancelpoint) {
		this.cancelpoint = cancelpoint;
	}

	public final int getPrice() {
		return price;
	}

	public final void setPrice(int price) {
		this.price = price;
	}

}
