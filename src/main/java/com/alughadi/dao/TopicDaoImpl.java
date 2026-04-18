import com.alughadi.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.SQLException;

void main() throws SQLException {
    Connection conn = DatabaseConnection.getConnection();
}