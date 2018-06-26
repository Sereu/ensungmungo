package silverstar.order;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import silverstar.utils.IbatisUtil;

public class OrderDao {
	public int seq() throws SQLException {
		return (int)IbatisUtil.getSqlMap().queryForObject("seq");
	}
	
	public void addAddress(Map<String, Object> map) throws SQLException {
		IbatisUtil.getSqlMap().insert("addAddress", map);
	}
	public void addPayment(Map<String, Object> map) throws SQLException {
		IbatisUtil.getSqlMap().insert("addPayment", map);
	}
	
	//customer_order book_order에 각각 집어넣기
	public void addCustomerOrder(CustomerOrder customerOrder) throws SQLException {
		IbatisUtil.getSqlMap().insert("addCustomerOrder", customerOrder);
	}
	public void addBookOrder(BookOrder bookOrder) throws SQLException {
		IbatisUtil.getSqlMap().insert("addBookOrder", bookOrder);
	}
	
	//customer에서 마일리지 더함 또 총 구매액 더함
	public void addPoint(Map<String, Object> point) throws SQLException {
		IbatisUtil.getSqlMap().update("addPoint", point);
	}	
	public void addPrice(Map<String, Object> price) throws SQLException {
		IbatisUtil.getSqlMap().update("addPrice", price);
	}	
	
	//cart에서 일부만 뺴기
	public void deleteCart(Map<String, Object> book)  throws SQLException {
		IbatisUtil.getSqlMap().delete("deleteCartpart", book);
	}	
		
	//cart에서 뺴기
	public void deleteCart(int no)  throws SQLException {
		IbatisUtil.getSqlMap().delete("deleteCart", no);
	}	
	
	//book에서 재고 빼기
	public void reduceBook(Map<String, Object> count) throws SQLException {
		IbatisUtil.getSqlMap().update("reduceBook", count);
	}
	
	//취소 처리
	public void cancelOrder(int no) throws SQLException {
		IbatisUtil.getSqlMap().update("cancelOrder", no);
	}
	
	public void cancelBookStock(Map<String, Object> amount) throws SQLException {
		IbatisUtil.getSqlMap().update("cancelBookStock", amount);
	}
	
	public void cancelCustomerOrder(Map<String,Object> map) throws SQLException {
		IbatisUtil.getSqlMap().update("cancelCustomerOrder", map);
	}
	
	public List<BookOrder> getOrderBook(int no) throws SQLException {
		return (List<BookOrder>)IbatisUtil.getSqlMap().queryForList("getOrderBook", no);
	}
	
	//정해진 기간의 주문리스트 조회
	public List<MyOrder> getOrderlistByMonth(HashMap<String, Object> param) throws SQLException{
		return (List<MyOrder>) IbatisUtil.getSqlMap().queryForList("getOrderlistByMonth", param);
	}
	//주소 가져오기
	public String getRecentAddress(int no) throws SQLException {
		return (String)IbatisUtil.getSqlMap().queryForObject("getRecentAddress",no);
	}
	//고객번호 기간별 주문리스트 조회
	public List<SearchMyorder> getCustByDate(HashMap<String, Object> param) throws SQLException{
		return (List<SearchMyorder>) IbatisUtil.getSqlMap().queryForList("getCustByDate", param);
	}
	//주문번호 주문도서 리스트 조회
	public List<OrderNoBook> getOrderNoBooklist(int no) throws SQLException{
		return (List<OrderNoBook>) IbatisUtil.getSqlMap().queryForList("getOrderNoBooklist", no);
	}
	//고객번호 기간별 총 페이지 조회
	public int getMyorderCnt(HashMap<String, Object> param) throws SQLException{
		return (Integer) IbatisUtil.getSqlMap().queryForObject("getMyorderCnt", param);
	}
	//최근주문(1개월) 리스트 수 조회
	public int getOneMonthOrders(int custNo) throws SQLException{
		return (Integer) IbatisUtil.getSqlMap().queryForObject("getOneMonthOrders", custNo);
	}
	//최근주문(1개월) 리스트 조회
	public List<MyOrder> getOneMonthRange(HashMap<String, Object> param) throws SQLException{
		return (List<MyOrder>) IbatisUtil.getSqlMap().queryForList("getOneMonthRange", param);
	}
	//주문 자세히 조회
	public OrderDetail getOrderDetail(int no) throws SQLException {
		return(OrderDetail)IbatisUtil.getSqlMap().queryForObject("getOrderDetail", no);
	}
}
