package Modelo;

public class Asignatura {
    private int id_asig;
    private String nombre;
    private String carrera;
    private String curso;
    private int cuatrimestre;

    //Getters
    public int getId_asig() { return id_asig; }
    public String getNombre() { return nombre; }
    public String getCarrera() { return carrera; }
    public String getCurso() { return curso; }
    public int getCuatrimestre() { return cuatrimestre; }
    
    //Setters
    public void setId_asig(int id_asig) { this.id_asig = id_asig; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public void setCarrera(String carrera) { this.carrera = carrera; }
    public void setCurso(String curso) { this.curso = curso; }
    public void setCuatrimestre(int cuatrimestre) { this.cuatrimestre = cuatrimestre; }

}
