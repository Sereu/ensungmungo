package silverstar.qna;

import java.util.Date;

import silverstar.utils.StringUtils;

public class QnA {

	private int qnaNo;
	private int customerNo;
	private String qnaTitle;
	private String qnaContents;
	private Date qnaDate;
	
	public QnA() {
		super();
	}
	
	public int getQnaNo() {
		return qnaNo;
	}
	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}
	public int getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public String getQnaTitle() {
		return qnaTitle;
	}
	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}
	public String getQnaContents() {
		return qnaContents;
	}
	public void setQnaContents(String qnaContents) {
		this.qnaContents = qnaContents;
	}
	public Date getQnaDate() {
		return qnaDate;
	}
	public void setQnaDate(Date qnaDate) {
		this.qnaDate = qnaDate;
	}
	
	
	public String getStringQnaDate() {
		return StringUtils.dateToString(qnaDate);
	}

	@Override
	public String toString() {
		return "QnA [qnaNo=" + qnaNo + ", customerNo=" + customerNo + ", qnaTitle=" + qnaTitle + ", qnaContents="
				+ qnaContents + ", qnaDate=" + StringUtils.dateToString(qnaDate) + "]";
	}
	
	
}
