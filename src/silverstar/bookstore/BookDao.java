package silverstar.bookstore;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import silverstar.utils.IbatisUtil;

public class BookDao {

	/*지선*/
	public Book bookSearchDetailByNo(int no) throws SQLException {
		Book book = (Book) IbatisUtil.getSqlMap().queryForObject("bookSearchDetailByNo", no);
		
		return book;
		
	}

	public void updateBookOutStatusByNo(int no) throws SQLException {
		IbatisUtil.getSqlMap().update("updateBookOutStatusByNo",no);
	}
	
	public void insertBook(Book book) throws SQLException {
		
		IbatisUtil.getSqlMap().insert("insertBook",book);
	}
	
	public void updateBook(Book book) throws SQLException {
		IbatisUtil.getSqlMap().update("updateBook",book);
	}
	
	@SuppressWarnings("unchecked")
	public List<Book>getAllBookOrderByTitleAsc() throws SQLException {
		List<Book> books = IbatisUtil.getSqlMap().queryForList("getAllBookOrderByTitleAsc");
		return books;
	}

	public int getBooksStatusCount(Map<String, Object> map) throws SQLException {
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getBooksStatusCount", map);
	}

	@SuppressWarnings("unchecked")
	public List<Book> getArrayBooks(Map<String, Object> map) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getArrayBooks", map);
	}
	
	
	
	/*희진*/
	public int getAllBooksCount() throws SQLException {
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getAllBooksCount");
	}
	
	public int getBooksCount(String category) throws SQLException {
		return (Integer)IbatisUtil.getSqlMap().queryForObject("getBooksCount", category);
	}
	
	@SuppressWarnings("unchecked")
	public List<Book> getAllBookByRange(Map<String, Object> map) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getAllBookByRange", map);
	}	
	@SuppressWarnings("unchecked")
	public List<Book> getBookByRangeWithCategory(Map<String, Object> map) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getBookByRangeWithCategory", map);
	}
	@SuppressWarnings("unchecked")
	public List<Book> getFamousBookSearch(Map<String, Object> map) throws SQLException {
		return IbatisUtil.getSqlMap().queryForList("getFamousBookSearch", map);
	}
	
	
}

