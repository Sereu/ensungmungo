package silverstar.bookstore;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import silverstar.utils.IbatisUtil;

public class SearchDao {
	
	public List<Book> famousBooklists() throws SQLException{
		return (List<Book>)IbatisUtil.getSqlMap().queryForList("famousBooklists");
	}
	public List<Book> famousCategorylists(String mainCategory) throws SQLException{
		return (List<Book>)IbatisUtil.getSqlMap().queryForList("famousCategorylists",mainCategory);
	}
	public List<Book> newCategorylists(String mainCategory) throws SQLException{
		return (List<Book>)IbatisUtil.getSqlMap().queryForList("newCategorylists",mainCategory);
	}

	
	public int countBookByTitle(String keyword) throws SQLException{
		return (Integer)IbatisUtil.getSqlMap().queryForObject("countBookByTitle", keyword);
	}
	
	public int countBookByAuthor(String keyword) throws SQLException{
		return (Integer)IbatisUtil.getSqlMap().queryForObject("countBookByAuthor", keyword);
	}
	
	public int countBookByPublisher(String keyword) throws SQLException{
		return (Integer)IbatisUtil.getSqlMap().queryForObject("countBookByPublisher", keyword);
	}
	
	
	public List<Book> getBookByTitle(Map<String, Object> objects) throws SQLException{
		return (List<Book>)IbatisUtil.getSqlMap().queryForList("getBookByTitle", objects);
	}
	
	public List<Book> getBookByPublisher(Map<String, Object> objects) throws SQLException{
		return (List<Book>)IbatisUtil.getSqlMap().queryForList("getBookByPublisher", objects);
	}	
	
	public List<Book> getBookByAuthor(Map<String, Object> objects) throws SQLException{
		return (List<Book>)IbatisUtil.getSqlMap().queryForList("getBookByAuthor", objects);
	}	
}
