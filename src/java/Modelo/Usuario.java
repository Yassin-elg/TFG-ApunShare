package Modelo;

public class Usuario {
    private int id;
    private String nombre;
    private String correo;
    private String clave;
    private boolean admin;

    //Getters
    public int getId() { return id; }
    public String getNombre() { return nombre; }
    public String getCorreo() { return correo; }        
    public String getClave() { return clave; }
    public boolean isAdmin() { return admin; }
    
    //Setters
    public void setId(int id) { this.id = id; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public void setCorreo(String correo) { this.correo = correo; }
    public void setClave(String clave) { this.clave = clave; }
    public void setAdmin(boolean admin) { this.admin = admin; }

}
