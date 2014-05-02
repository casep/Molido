import java.sql.*;
class Test


    {
    public static void main(String[] args)


        {


            try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            // set this to a MS Access DB you have on your machine
            String filename = "/home/casep/Download/inventory_demo.mdb";
            String database = "jdbc:odbc:Driver={MS Access Database};DBQ=";
//            String database = "jdbc:odbc:Driver={M360products};DBQ=";
            database+= filename.trim() + ";DriverID=22;READONLY=true}"; // add on to the end 
            // now we can get the connection from the DriverManager
            Connection con = DriverManager.getConnection( database ,"",""); 

        // try and create a java.sql.Statement so we can run queries
        Statement s = con.createStatement();
        s.execute("create table TEST12345 ( column_name integer )"); // create a table
        s.execute("insert into TEST12345 values(1)"); // insert some data into the table 
        s.execute("select column_name from TEST12345"); // select the data from the table
        ResultSet rs = s.getResultSet(); // get any ResultSet that came from our query
        if (rs != null) // if rs == null, then there is no ResultSet to view
        while ( rs.next() ) // this will step through our data row-by-row


            {
            /* the next line will get the first column in our current row's ResultSet 
            as a String ( getString( columnNumber) ) and output it to the screen */ 
            System.out.println("Data from column_name: " + rs.getString(1) );
        }

        s.execute("drop table TEST12345");
        s.close(); // close the Statement to let the database know we're done with it
        con.close(); // close the Connection to let the database know we're done with it

        }

            catch (Exception e) {
            System.out.println("Error: " + e);
        }

    }

}
