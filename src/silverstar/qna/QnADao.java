package silverstar.qna;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import silverstar.utils.IbatisUtil;

public class QnADao {

	public void insertQnA(QnA qna) throws SQLException {
		IbatisUtil.getSqlMap().insert("insertQnA", qna);
	}
	
	public List<QnA> getAllQnAs() throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getAllQnAs");
	}
	
	public int getAllCounts() throws SQLException {
		return (int) IbatisUtil.getSqlMap().queryForObject("getAllCountsQnA");
	}
	
	public int getAllCountsQnAByCust(int customerNo) throws SQLException {
		return (int) IbatisUtil.getSqlMap().queryForObject("getAllCountsQnAByCust", customerNo);
	}
	
	public List<QnA> getQnAsByRange(HashMap<String, Object> param) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getQnAsByRange", param);
	}
	
	public QnA getQnAByNo(int qnaNo) throws SQLException {
		return (QnA) IbatisUtil.getSqlMap().queryForObject("getQnAByNo", qnaNo);
	}
	
	public void updateQnA(HashMap<String, Object> param) throws SQLException {
		IbatisUtil.getSqlMap().update("updateQnA", param);
	}
	
	public void insertQnaAnswer(QnaAsk qnaAsk, int qnaNo) throws SQLException {
		IbatisUtil.getSqlMap().update("insertQnaAsk", qnaAsk);
		IbatisUtil.getSqlMap().update("notReadQna", qnaNo);
	}
	
	public QnaAsk getQnaAskByNo(int qnaNo) throws SQLException {
		return (QnaAsk) IbatisUtil.getSqlMap().queryForObject("getQnaAskByNo", qnaNo);
	}
	public QnaAsk getQnaAskByNoCust(int qnaNo) throws SQLException {
		IbatisUtil.getSqlMap().update("readQna", qnaNo);
		return (QnaAsk) IbatisUtil.getSqlMap().queryForObject("getQnaAskByNo", qnaNo);
	}
	
	public void updateQnaAskByNo(QnaAsk qnaAsk) throws SQLException {
		IbatisUtil.getSqlMap().update("updateQnaAskByNo", qnaAsk);
	}
	public void deleteQnA(int qnaNo) throws SQLException {
		IbatisUtil.getSqlMap().delete("deleteQnA", qnaNo);
	}
	public List<QnA> getQnAsByRangeByCustNo(HashMap<String, Object> param) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getQnAsByRangeByCustNo", param);
	}
	public List<QnA> getQnAByCustNo(int custNo) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getQnAByCustNo", custNo);
	}
	public List<QnaAsk> getQnaAskByCustNoNotRead(int custNo) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getQnaAskByCustNoNotRead", custNo);
	}
	public int countNotReadAnswer(int custNo) throws SQLException {
		return (int)IbatisUtil.getSqlMap().queryForObject("countNotReadAnswer", custNo);
	}
	public List<QnaAsk> getQnaAskByCustNo(int custNo) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getQnaAskByCustNo",custNo);
	}
	
}
