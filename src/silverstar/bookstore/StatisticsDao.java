package silverstar.bookstore;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import silverstar.utils.IbatisUtil;

public class StatisticsDao {

	public int getSellingPrice(int day) throws SQLException {
		return (int)IbatisUtil.getSqlMap().queryForObject("getSellingPrice",day);
	}
	public int getSellingQty(int day) throws SQLException {
		return (int)IbatisUtil.getSqlMap().queryForObject("getSellingQty",day);
	}
	public int getPopularBookNoByGender(String gender) throws SQLException {
		return (int)IbatisUtil.getSqlMap().queryForObject("getPopularBookNoByGender",gender);
	}
	public List<Book> getRowStockBook() throws SQLException {
		return (List<Book>)IbatisUtil.getSqlMap().queryForList("getRowStockBook");
	}
	//성별 선호 책
	public Book getStatusByGender(Map<String,Object> map) throws SQLException{
		return (Book)IbatisUtil.getSqlMap().queryForObject("getStatusByGender",map);
	}
	public int getStatusByAge(int age) throws SQLException{
		return (int)IbatisUtil.getSqlMap().queryForObject("getStatusByAge",age);
	}
	public Book getStatusByBook(int rn) throws SQLException{
		return (Book)IbatisUtil.getSqlMap().queryForObject("getStatusByBook",rn);
	}
	public double getRankByBookNo(int bookNo) throws SQLException {
		return (Double)IbatisUtil.getSqlMap().queryForObject("getRankByBookNo",bookNo);
	}
	public List<Integer> getBookNoByCartegory(HashMap<String, Object> param) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getBookNoByCartegory", param);
	}
}
