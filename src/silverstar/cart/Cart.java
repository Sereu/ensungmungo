package silverstar.cart;

public class Cart {
	private int no;
	private int bookNo;
	private int custNo;
	private int bookQuantity;
	private String bookTitle;
	private String bookImage;
	private int fixedPrice;
	private int discountRate;
	private int bookStock;
	private String bookOutStatus;
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getBookNo() {
		return bookNo;
	}
	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}
	public int getCustNo() {
		return custNo;
	}
	public void setCustNo(int custNo) {
		this.custNo = custNo;
	}
	public int getBookQuantity() {
		return bookQuantity;
	}
	public void setBookQuantity(int bookQuantity) {
		this.bookQuantity = bookQuantity;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public String getBookImage() {
		return bookImage;
	}
	public void setBookImage(String bookImage) {
		this.bookImage = bookImage;
	}
	public int getFixedPrice() {
		return fixedPrice;
	}
	public void setFixedPrice(int fixedPrice) {
		this.fixedPrice = fixedPrice;
	}
	public int getDiscountRate() {
		return discountRate;
	}
	public void setDiscountRate(int discountRate) {
		this.discountRate = discountRate;
	}
	public int getSalePrice() {
		return (getFixedPrice()-(getFixedPrice() * getDiscountRate() / 100));
	}
	public int getBookStock() {
		return bookStock;
	}
	public void setBookStock(int bookStock) {
		this.bookStock = bookStock;
	}
	public String getBookOutStatus() {
		return bookOutStatus;
	}
	public void setBookOutStatus(String bookOutStatus) {
		this.bookOutStatus = bookOutStatus;
	}
	
}
