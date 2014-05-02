/* JDBC CON BASES DE DATOS DE MICROSOFT ACCESS,
* LEYENDO DIRECTAMENTE UN ARCHIVO *.MDB
* SIN CONFIGURAR EL ORIGEN DE DATOS EN EL PANEL ODBC */

import java.sql.*;

// CLASE PRINCIPAL
public class Access_sin_odbc
{

   //METODO PRINCIPAL DE ENTRADA AL PROGRAMA
   public static void main(String[] args) 
   {
     try
     {
       System.out.println("\nJDBC Access");
       System.out.println("===========");


       // cadena de conexion con la ruta fisica a la BD
       String db = "/home/casep/Download/inventory_demo.mdb";
       // si la BD esta en la carpeta de la aplicacion Java
       //String db = "AccessBD_1.mdb";
       String url = "jdbc:odbc:MS Access Database;DBQ=" + db;

       // registrar el driver JDBC usando el cargador de clases Class.forName
       Class.forName ("sun.jdbc.odbc.JdbcOdbcDriver");
       System.out.println("\nEstableciendo conexion...");
       Connection con = DriverManager.getConnection (url, "", "");
       System.out.println("\nConexion establecida con: \"" + db + "\".");
       System.out.println("");


       // ejecutar una sentencia SQL SELECT
       Statement select = con.createStatement();
       ResultSet tablas = select.executeQuery("SELECT * FROM MSysObjects");
       System.out.println("Mostrar tablas");
       System.out.println("");
       System.out.println("\tTABLA");
       System.out.println("");
       int col = tablas.findColumn ("type");
       boolean seguir = tablas.next();
       while (seguir) {
         System.out.println ("\t" + tablas.getString(col));
       seguir = tablas.next(); }

       System.out.println("");

       // liberar recursos
       tablas.close();
       select.close();


       // obtener informacion acerca del gestor de BBDD y de las BBDD

       /* la interfaz ResultSet representa un conjunto de datos resultado de una consulta SQL
       * para acceder a los registros se emplea un cursor que inicialmente apunta antes del primer registro
       * para avanzar por los registros se emplea el metodo ResultSet.next() */
/*
       DatabaseMetaData dm = null;
       ResultSet rs = null;
       dm = con.getMetaData();
       rs = dm.getCatalogs();

       System.out.println("Informacion sobre el Driver:\n");
       System.out.println("\tDriver Name: "+ dm.getDriverName());
       System.out.println("\tDriver Version: "+ dm.getDriverVersion ());
       System.out.println("\nInformacion sobre el servidor de BD:\n");
       System.out.println("\tDatabase Name: "+ dm.getDatabaseProductName());
       System.out.println("\tDatabase Version: "+ dm.getDatabaseProductVersion());
       System.out.println("\nBases de datos en esta carpeta:\n");
       // entero para contar por el catAlogo de BD
       int n = 1;
       while(rs.next()){
         // ResultSet.getString() devuelve la ruta a las BD del catalogo,
         System.out.println("\t" + n + " - " + rs.getString(1));
         n+=1;
       }

       // liberar recursos
       rs.close();
*/
       con.close();

       System.out.println("\nConexion con: \"" + db + "\" cerrada.\n\n");   

     }
     catch (Exception pollo)
     {
       System.out.println("\nError al conectar con la BD: " + pollo.getMessage() + "\n");
       System.out.println("\nError al conectar con la BD: " + pollo + "\n");

       //System.out.println("\nError al realizar alguna accion del programa.\n\n");
     }
   }




}


