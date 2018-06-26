package silverstar.utils;

import java.io.IOException;
import java.io.Reader;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class IbatisUtil {
	public static SqlMapClient sqlMap;
	static {
		try {
			Reader reader = Resources.getResourceAsReader("silverstar/conf/SqlMapConfig.xml");
			sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static SqlMapClient getSqlMap() {
		return sqlMap;
	}
}
