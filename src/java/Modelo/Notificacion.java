package Modelo;

public class Notificacion {
    private int id_notif;
    private int usuario;
    private int asignatura;
    private boolean leida;

    //Getters
    public int getId_notif() { return id_notif; }
    public int getUsuario() { return usuario; }
    public int getAsignatura() { return asignatura; }
    public boolean isLeida() { return leida; }

    //Setters
    public void setId_notif(int id_notif) { this.id_notif = id_notif; }
    public void setUsuario(int usuario) { this.usuario = usuario; }
    public void setAsignatura(int asignatura) { this.asignatura = asignatura; }
    public void setLeida(boolean leida) { this.leida = leida; }
    
}
