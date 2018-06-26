package silverstar.qna;

import java.util.Date;

import silverstar.utils.StringUtils;

public class QnaAsk {

	private int qnaNo;
	private String qnaAskTitle;
	private String qnaAskContents;
	private Date qnaAskDate;
	
	public QnaAsk() {
		super();
	}

	public int getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}

	public String getQnaAskTitle() {
		return qnaAskTitle;
	}

	public void setQnaAskTitle(String qnaAskTitle) {
		this.qnaAskTitle = qnaAskTitle;
	}

	public String getQnaAskContents() {
		return qnaAskContents;
	}

	public void setQnaAskContents(String qnaAskContents) {
		this.qnaAskContents = qnaAskContents;
	}

	public Date getQnaAskDate() {
		return qnaAskDate;
	}

	public void setQnaAskDate(Date qnaAskDate) {
		this.qnaAskDate = qnaAskDate;
	}
	
	public String getStringQnaAskDate() {
		return StringUtils.dateToString(qnaAskDate);
	}
}
