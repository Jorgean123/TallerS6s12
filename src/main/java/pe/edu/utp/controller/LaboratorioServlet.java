package pe.edu.utp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import pe.edu.utp.model.Producto;

@WebServlet(urlPatterns = {"/inicio", "/promedio", "/catalogo", "/acceso"})
public class LaboratorioServlet extends HttpServlet {
    private static final List<Producto> PRODUCTOS = List.of(
        new Producto("TEC-001", "Laptop Lenovo IdeaPad", "Computación", "2499.00", 8),
        new Producto("TEC-002", "Monitor LG de 24 pulgadas", "Pantallas", "649.90", 12),
        new Producto("TEC-003", "Teclado mecánico", "Periféricos", "189.00", 15),
        new Producto("TEC-004", "Mouse inalámbrico", "Periféricos", "79.90", 0),
        new Producto("TEC-005", "Audífonos con micrófono", "Audio", "129.00", 20),
        new Producto("TEC-006", "Disco SSD de 1 TB", "Almacenamiento", "299.00", 6)
    );

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        render(req, resp);
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            switch (req.getServletPath()) {
                case "/promedio":
                    BigDecimal n1 = nota(req, "nota1"), n2 = nota(req, "nota2"), n3 = nota(req, "nota3");
                    BigDecimal promedio = n1.multiply(new BigDecimal("0.30"))
                        .add(n2.multiply(new BigDecimal("0.30")))
                        .add(n3.multiply(new BigDecimal("0.40")));
                    req.setAttribute("promedio", promedio.setScale(2, RoundingMode.HALF_UP));
                    req.setAttribute("aprobado", promedio.compareTo(new BigDecimal("13")) >= 0);
                    break;
                case "/acceso":
                    String nombre = req.getParameter("nombre");
                    if (nombre == null || nombre.trim().isEmpty() || nombre.trim().length() > 80)
                        throw new IllegalArgumentException("Ingrese un nombre de entre 1 y 80 caracteres.");
                    int edad;
                    try { edad = Integer.parseInt(req.getParameter("edad")); }
                    catch (NumberFormatException ex) { throw new IllegalArgumentException("Ingrese una edad entera entre 0 y 120 años."); }
                    if (edad < 0 || edad > 120) throw new IllegalArgumentException("La edad debe estar entre 0 y 120 años.");
                    req.setAttribute("nombre", nombre.trim());
                    req.setAttribute("edad", edad);
                    req.setAttribute("matriculaActiva", "si".equals(req.getParameter("matricula")));
                    req.setAttribute("evaluado", true);
                    break;
                default: resp.sendError(405); return;
            }
        } catch (IllegalArgumentException ex) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            req.setAttribute("error", ex.getMessage());
        }
        render(req, resp);
    }

    private BigDecimal nota(HttpServletRequest req, String campo) {
        String valor = req.getParameter(campo);
        if (valor == null || !valor.matches("\\d{1,2}(?:\\.\\d{1,2})?"))
            throw new IllegalArgumentException("Complete las tres notas con números de 0 a 20 y hasta dos decimales.");
        BigDecimal nota = new BigDecimal(valor);
        if (nota.compareTo(new BigDecimal("20")) > 0)
            throw new IllegalArgumentException("Cada nota debe estar entre 0 y 20.");
        return nota;
    }

    private void render(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pagina = req.getServletPath().substring(1);
        req.setAttribute("pagina", pagina);
        if ("catalogo".equals(pagina)) {
            req.setAttribute("productos", PRODUCTOS);
            req.setAttribute("totalProductos", PRODUCTOS.size());
        }
        resp.setContentType("text/html;charset=UTF-8");
        req.getRequestDispatcher("/WEB-INF/views/" + pagina + ".jsp").forward(req, resp);
    }
}
