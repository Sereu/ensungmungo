package silverstar.review;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import silverstar.utils.IbatisUtil;

public class ReviewDao {
	public List<ReviewCustomer> getReviewBno(int no) throws SQLException{
		return (List<ReviewCustomer>) IbatisUtil.getSqlMap().queryForList("getReviewBno", no);
	}
	public void insertReview(Review review) throws SQLException{
		IbatisUtil.getSqlMap().insert("insertReview", review);
	}
	public List<ReviewLike> getReviewStarBno(int no) throws SQLException{
		return (List<ReviewLike>) IbatisUtil.getSqlMap().queryForList("getReviewStarBno", no);
	}
	//도서별 총 레코드 개수 조회하는 기능
	public int getReviewCnt(int no) throws SQLException{
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getReviewCnt",no);
	}
	@SuppressWarnings("unchecked")
	public List<ReviewCustomer> getReviewRange(Map<String, Object> param) throws SQLException{
		return (List<ReviewCustomer>)IbatisUtil.getSqlMap().queryForList("getReviewRange",param);
	}
	public void delReview(int no) throws SQLException{
		IbatisUtil.getSqlMap().delete("delReview",no);
	}
	public int getAllReviewCnt() throws SQLException{
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getAllReviewCnt");
	}
	public List<ReviewCustomer> getAllReviewRange(HashMap<String, Object> param) throws SQLException{
		return (List<ReviewCustomer>)IbatisUtil.getSqlMap().queryForList("getAllReviewRange",param);
	}
	public int getReviewCustNo(int no) throws SQLException{
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getReviewCustNo",no);
	}
	public List<ReviewCustomer> getReviewRangeByCustNo(HashMap<String, Object> param) throws SQLException{
		return (List<ReviewCustomer>)IbatisUtil.getSqlMap().queryForList("getReviewRangeByCustNo",param);
	}
	//책별 고객 리뷰 등록여부
	public int getBookByCustomerNo(HashMap<String, Object> param) throws SQLException{
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getBookByCustomerNo", param);
	}
	//리뷰 공감 추가
	public void addreviewlike(int no) throws SQLException{
		IbatisUtil.getSqlMap().update("addreviewlike", no);
	}
	//리뷰 공감 수 조회
	public int likecount(int no) throws SQLException{
		return (Integer)IbatisUtil.getSqlMap().queryForObject("likecount",no);
	}
	//고객 본인이 등록한 리뷰 여부
	public int custReviewNo(HashMap<String, Object> param) throws SQLException{
		return (Integer)IbatisUtil.getSqlMap().queryForObject("custReviewNo", param);
	}
	public int getAvgStarByBookNo(int bookNo) throws SQLException {
		return (int)IbatisUtil.getSqlMap().queryForObject("getAvgStarByBookNo", bookNo);
	}
	
	public double avgStarByBookNo(int bookNo) throws SQLException {
		return (double)IbatisUtil.getSqlMap().queryForObject("avgStarByBookNo", bookNo);
	}
	public int getReviewByBookNo(int bookNo) throws SQLException {
		return (int)IbatisUtil.getSqlMap().queryForObject("getReviewByBookNo", bookNo);
	}
	
}
