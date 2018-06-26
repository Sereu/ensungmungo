package silverstar.customer;

import java.util.Date;

import silverstar.utils.StringUtils;

public class Customer {

	private int customerNo;
	private String customerId;
	private String customerPw;
	private String customerName;
	private String customerEmail;
	private String gender;
	private String customerTel;
	private String customerAddress;
	private Date customerBirth;
	private int customerPoint;
	private String customerStatus;
	private int totalPay;
	private String admin;
	//등급 테스트
	
	public Customer() {
		super();
	}
	
	@Override
	public String toString() {
		return "Customer [customerNo=" + customerNo + ", customerId=" + customerId + ", customerPw=" + customerPw
				+ ", customerName=" + customerName + ", customerEmail=" + customerEmail + ", gender=" + gender
				+ ", customerTel=" + customerTel + ", customerAddress=" + customerAddress + ", customerBirth="
				+ customerBirth + ", customerPoint=" + customerPoint + ", customerStatus=" + customerStatus
				+ ", totalPay=" + totalPay + "]";
	}

	public int getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getCustomerPw() {
		return customerPw;
	}
	public void setCustomerPw(String customerPw) {
		this.customerPw = customerPw;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerEmail() {
		return customerEmail;
	}
	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getCustomerTel() {
		return customerTel;
	}
	public void setCustomerTel(String customerTel) {
		this.customerTel = customerTel;
	}
	public String getCustomerAddress() {
		return customerAddress;
	}
	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}
	public Date getCustomerBirth() {
		return customerBirth;
	}
	public void setCustomerBirth(Date customerBirth) {
		this.customerBirth = customerBirth;
	}
	public int getCustomerPoint() {
		return customerPoint;
	}
	public void setCustomerPoint(int customerPoint) {
		this.customerPoint = customerPoint;
	}
	public String getCustomerStatus() {
		return customerStatus;
	}
	public void setCustomerStatus(String customerStatus) {
		this.customerStatus = customerStatus;
	}

	public final int getTotalPay() {
		return totalPay;
	}

	public final void setTotalPay(int totalPay) {
		this.totalPay = totalPay;
	}

	public String getCustomerGrade() {
		if(0 <= totalPay && totalPay <=100000)
			customerStatus ="E";
		else if(100000 < totalPay && totalPay <= 500000)
			customerStatus ="B";
		else if(500000 < totalPay && totalPay <=1000000)
			customerStatus ="S";
		else if(1000000 < totalPay)
			customerStatus ="G";
		return customerStatus;		
	}
	
	public String getStringCustomerBirth() {
		return StringUtils.dateToString(customerBirth);
	}

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

}
