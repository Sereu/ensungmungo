package silverstar.order;

import java.util.Date;

import silverstar.utils.StringUtils;

public class SearchMyorder {
	private int orderNo;
	private int bookNo;
	private String title;
	private String mainCartegory;
	private String subCartergory;
	private int price;
	private int discount;
	private String image;
	private String orderStatus;
	private Date orderDate;
	private int qty;
	
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public int getBookNo() {
		return bookNo;
	}
	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMainCartegory() {
		return mainCartegory;
	}
	public void setMainCartegory(String mainCartegory) {
		this.mainCartegory = mainCartegory;
	}
	public String getSubCartergory() {
		return subCartergory;
	}
	public void setSubCartergory(String subCartergory) {
		this.subCartergory = subCartergory;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public String getOrderDateFormat() {
		return StringUtils.dateToString(orderDate);
	}
	@Override
	public String toString() {
		return "SearchMyorder [orderNo=" + orderNo + ", bookNo=" + bookNo + ", title=" + title + ", mainCartegory="
				+ mainCartegory + ", subCartergory=" + subCartergory + ", price=" + price + ", discount=" + discount
				+ ", image=" + image + ", orderStatus=" + orderStatus + ", orderDate=" + orderDate + ", qty=" + qty
				+ "]";
	}
	
}
