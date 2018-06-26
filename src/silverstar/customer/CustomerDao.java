package silverstar.customer;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import silverstar.customer.Customer;
import silverstar.utils.IbatisUtil;

public class CustomerDao {
	//고객 전체 조회
	public List<Customer> getAllCustomer() throws SQLException{
		return (List<Customer>)IbatisUtil.getSqlMap().queryForList("getAllCustomer");
	}
	
	public Customer getCustomerById(String id) throws SQLException{
		return (Customer) IbatisUtil.getSqlMap().queryForObject("getCustomerById", id); 
	}
	public void insertCustomer(Customer customer) throws SQLException {
		IbatisUtil.getSqlMap().insert("insertCustomer", customer);
	}
	public Customer getCustomerByNo(int no) throws SQLException{
		return (Customer) IbatisUtil.getSqlMap().queryForObject("getCustomerByNo", no); 
	}
	public CustomerGrade getCustomerGrade(String grade) throws SQLException{
		return (CustomerGrade) IbatisUtil.getSqlMap().queryForObject("getCustomerGrade", grade);
	}
	public void updateCustomer(Customer customer) throws SQLException {
		IbatisUtil.getSqlMap().update("updateCustomer", customer);
	}
	public int getAllCountsCustomer() throws SQLException {
		return (int) IbatisUtil.getSqlMap().queryForObject("getAllCountsCustomer");
	}
	public List<Customer> getCustomersByRange(HashMap<String, Object> param) throws SQLException {
		return (List<Customer>)IbatisUtil.getSqlMap().queryForList("getCustomersByRange", param);
	}
	public void deleteCustomer(int customerNo) throws SQLException {
		IbatisUtil.getSqlMap().update("deleteCustomer", customerNo);
	}
	public void canacelDeleteCustomer(int customerNo) throws SQLException {
		IbatisUtil.getSqlMap().update("canacelDeleteCustomer", customerNo);
	}
	public Customer getAdminById(String id) throws SQLException{
		return (Customer) IbatisUtil.getSqlMap().queryForObject("getAdminById", id); 
	}
	//탈퇴회원 고객상태 변경
	public void deleteCustomerByNo(int no) throws SQLException{
		IbatisUtil.getSqlMap().update("deleteCustomerByNo", no);
	}
}
