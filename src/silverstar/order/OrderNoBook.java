package silverstar.order;

import java.util.Date;

import silverstar.utils.StringUtils;

public class OrderNoBook {
	private int orderNo;
	private int bookNo;
	private String title;
	private String author;
	private String publisher;
	private String mainCartegory;
	private String subCartergory;
	private int price;
	private int discount;
	private String image;
	private Date orderDate;
	private int totalPrice;
	
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
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
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
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getOrderDateFormat() {
		return StringUtils.dateToString(orderDate);
	}
	@Override
	public String toString() {
		return "OrderNoBook [orderNo=" + orderNo + ", bookNo=" + bookNo + ", title=" + title + ", author=" + author
				+ ", publisher=" + publisher + ", mainCartegory=" + mainCartegory + ", subCartergory=" + subCartergory
				+ ", price=" + price + ", discount=" + discount + ", image=" + image + ", orderDate=" + orderDate
				+ ", totalPrice=" + totalPrice + "]";
	}
	
	
	
	}
