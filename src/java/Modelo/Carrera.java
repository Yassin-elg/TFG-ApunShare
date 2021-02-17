package Modelo;


public class Carrera {
    private int id_carrera;
    private String nombre;
    private String facultad;
    private String tipo;

    //Getters
    public int getId_carrera() { return id_carrera; }
    public String getNombre() { return nombre; }
    public String getFacultad() { return facultad; }
    public String getTipo() { return tipo; }

    //Setters
    public void setId_carrera(int id_carrera) { this.id_carrera = id_carrera; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public void setFacultad(String facultad) { this.facultad = facultad; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    
}
