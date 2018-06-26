package silverstar.order;

import java.util.Date;

import silverstar.utils.StringUtils;

public class CustomerOrder {
	private int orderNo;
	private int customerNo;
	private Date orderDate;
	private int point;
	private int addpoint;
	private int price;
	
	public CustomerOrder() {}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public int getCustomerNo() {
		return customerNo;
	}

	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public final int getPoint() {
		return point;
	}

	public final void setPoint(int point) {
		this.point = point;
	}

	public final int getAddpoint() {
		return addpoint;
	}

	public final void setAddpoint(int addpoint) {
		this.addpoint = addpoint;
	}

	public final int getPrice() {
		return price;
	}

	public final void setPrice(int price) {
		this.price = price;
	}
	
	public String getOrderDateFormat() {
		return StringUtils.dateToString(orderDate);
	}

	@Override
	public String toString() {
		return "CustomerOrder [orderNo=" + orderNo + ", customerNo=" + customerNo + ", orderDate=" + orderDate
				+ ", point=" + point + ", price=" + price + "]";
	}
	
	
	
}
