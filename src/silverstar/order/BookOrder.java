package silverstar.order;

public class BookOrder {
	int orderNo;
	int bookNo;
	int orderQuantity;
	String status;

	public final int getOrderNo() {
		return orderNo;
	}

	public final void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public final int getBookNo() {
		return bookNo;
	}

	public final void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}

	public final int getOrderQuantity() {
		return orderQuantity;
	}

	public final void setOrderQuantity(int orderQuantity) {
		this.orderQuantity = orderQuantity;
	}

	public final String getStatus() {
		return status;
	}

	public final void setStatus(String status) {
		this.status = status;
	}
	
	
}
