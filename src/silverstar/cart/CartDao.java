package silverstar.cart;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import silverstar.utils.IbatisUtil;

public class CartDao {
	
	public void insertCart(Cart cart) throws SQLException {
		
		IbatisUtil.getSqlMap().insert("insertCart",cart);
	}
	
	@SuppressWarnings("unchecked")
	public List<Cart> searchCartByCustomerNo(int no) throws SQLException {
		List<Cart> carts = IbatisUtil.getSqlMap().queryForList("searchCartByCustomerNo", no);
		
		return carts;
	}
	@SuppressWarnings("unchecked")
	public List<Cart> searchCartByCustomerNoAndOutStatusY(int no) throws SQLException {
		List<Cart> carts = IbatisUtil.getSqlMap().queryForList("searchCartByCustomerNoAndOutStatusY", no);
		
		return carts;
	}
	@SuppressWarnings("unchecked")
	public List<Cart> searchCartByCustomerNoAndOutStatusN(int no) throws SQLException {
		List<Cart> carts = IbatisUtil.getSqlMap().queryForList("searchCartByCustomerNoAndOutStatusN", no);
		
		return carts;
	}
	
	public Cart searchBookByCustomerNoAndOutStatusN(HashMap<String, Object> map) throws SQLException {
		return (Cart)IbatisUtil.getSqlMap().queryForObject("searchBookByCustomerNoAndOutStatusN", map);
	}
	
	public void deleteOneCartByNo(HashMap<String, Object> map) throws SQLException {
		IbatisUtil.getSqlMap().delete("deleteOneCartByNo",map);
		
	}
	
	public void updateCartBookQuantityByNo(HashMap<String, Object> map) throws SQLException {
		IbatisUtil.getSqlMap().update("updateCartBookQuantityByNo", map);
		
	}
	
	@SuppressWarnings("unchecked")
	public List<Cart> searchAllCart() throws SQLException {
		List<Cart> carts = IbatisUtil.getSqlMap().queryForList("searchAllCart");	
	
		return carts;
	}

}
