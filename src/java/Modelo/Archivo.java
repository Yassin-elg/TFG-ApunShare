package Modelo;

public class Archivo {
    private int id;
    private String nombre;
    private int asig;
    private String enlace;
    private boolean examen;
    
    //Getters
    public int getId() { return id; }
    public String getNombre() { return nombre; }
    public int getAsig() { return asig; }
    public String getEnlace() { return enlace; }
    public boolean isExamen() { return examen; }

    //Setters
    public void setId(int id) { this.id = id; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public void setAsig(int asig) { this.asig = asig; }
    public void setEnlace(String enlace) { this.enlace = enlace; } 
    public void setExamen(boolean examen) { this.examen = examen; } 
    
}
