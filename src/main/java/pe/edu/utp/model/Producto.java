package pe.edu.utp.model;

import java.math.BigDecimal;

public class Producto {
    private final String codigo, nombre, categoria;
    private final BigDecimal precio;
    private final int stock;
    public Producto(String codigo, String nombre, String categoria, String precio, int stock) {
        this.codigo = codigo; this.nombre = nombre; this.categoria = categoria;
        this.precio = new BigDecimal(precio); this.stock = stock;
    }
    public String getCodigo() { return codigo; }
    public String getNombre() { return nombre; }
    public String getCategoria() { return categoria; }
    public BigDecimal getPrecio() { return precio; }
    public int getStock() { return stock; }
}
