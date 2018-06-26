package silverstar.bookstore;

import java.text.SimpleDateFormat;
import java.util.Date;

import silverstar.utils.StringUtils;

public class Book {
	private int no;
	private String title;
	private String author;
	private String publisher;
	private String mainCartegory;
	private String subCartegory;
	private int fixedPrice;
	private int discountRate;
	private int stock;
	private String publishDate;
	private String image;
	private String introduce;
	private String detailImage;
	private String outStatus;
	
	private int sellqty;
	
	public final int getSellqty() {
		return sellqty;
	}
	public final void setSellqty(int sellqty) {
		this.sellqty = sellqty;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
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
	public String getSubCartegory() {
		return subCartegory;
	}
	public void setSubCartegory(String subCartegory) {
		this.subCartegory = subCartegory;
	}
	public int getFixedPrice() {
		return fixedPrice;
	}
	public String getCommaFixedPrice() {
		return StringUtils.numberWithComma(fixedPrice);
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
		return getFixedPrice()-(getFixedPrice() * getDiscountRate() / 100);
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(String publishDate) {
		if(publishDate.length() == 10){ 
			this.publishDate = publishDate.substring(0, 4)+"년 "+publishDate.substring(5,7)+"월 "+publishDate.substring(8,10)+"일";
		} else {
			this.publishDate = publishDate;
		}
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getDetailImage() {
		return detailImage;
	}
	public void setDetailImage(String detailImage) {
		this.detailImage = detailImage;
	}
	public String getOutStatus() {
		return outStatus;
	}
	public void setOutStatus(String outStatus) {
		this.outStatus = outStatus;
	}
	
}
