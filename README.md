# Laboratorio de Semana 6 · Sesión 12

Jorge Eduardo Acosta Loyola · U22205593 · 17/09/2026

## Ejecutar

Aplicación: http://localhost:8081/TallerS6s12/

Compilar y desplegar usando el JDK 11 y Tomcat instalados (no requiere Maven):

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build.ps1 -Deploy
```

Alternativa con Maven instalado: `mvn clean package`. Copiar `target/TallerS6s12.war` a `webapps` de Tomcat 10.1.

## Ejercicios

1. `/promedio`: APF1 (Avance de Proyecto Final 1) 30 %, APF2 (Avance de Proyecto Final 2) 30 %, PROY (Proyecto Final) 40 %. Notas de 0 a 20 con hasta dos decimales. Aprobación desde 13, evaluada antes del redondeo de presentación. Ejemplo: 16, 15 y 18 → 16.50.
2. `/catalogo`: seis productos de ejemplo suministrados por el Servlet, renderizados mediante `c:forEach items="${productos}"`. No necesita base de datos.
3. `/acceso`: regla didáctica, edad ≥ 18 y matrícula activa. No constituye autenticación. El Servlet valida entradas y publica atributos; `c:if` y `c:choose` seleccionan el mensaje.

Las reglas de ponderación, aprobación y acceso son supuestos explícitos porque la ficha no las especifica.

## Estructura MVC

La interfaz utiliza Bootstrap 5.3.3, incluido localmente: rejilla responsive (`row`, `col-md-*`, `col-lg-*`), navegación (`nav`, `nav-pills`, `nav-link`), tarjetas (`card`, `shadow-sm`), formularios (`form-control`, `form-check`), botones (`btn`), alertas (`alert`), estados (`badge`, `text-bg-success`, `text-bg-danger`) y tabla adaptable (`table-responsive`, `table-striped`, `table-hover`). `styles.css` personaliza colores y espaciado. Estos componentes son de CSS y no requieren JavaScript de Bootstrap.

- `src/main/java/pe/edu/utp/model/Producto.java`: modelo con getters para EL.
- `src/main/java/pe/edu/utp/controller/LaboratorioServlet.java`: controlador, validaciones y atributos del request.
- `src/main/webapp/WEB-INF/views/`: JSP privados y fragmentos compartidos.
- `src/main/webapp/WEB-INF/web.xml`: bienvenida y prohibición de scriptlets mediante `scripting-invalid`.
- `src/main/webapp/assets/`: Bootstrap 5.3.3 local y estilos; la interfaz no necesita Internet después de compilar.
- `entregables/Ficha_S6_S12.html`: ficha editable e imprimible; permite cargar capturas desde tu equipo y guardar una copia completa.

Las directivas `<%@ ... %>` declaran bibliotecas/inclusiones JSP; no son scriptlets. No hay bloques Java ni expresiones Java en las vistas. Las entradas del usuario se escapan con `c:out`.

## Compatibilidad y referencias

Java 11, Jakarta Servlet 6.0 y JSTL 3.0 para Tomcat 10.1. No mezclar bibliotecas antiguas `javax.servlet` con `jakarta.servlet`.

- [Documentación oficial de Tomcat 10.1](https://tomcat.apache.org/migration-10.1.html)
- [Especificación oficial Jakarta Tags 3.0](https://jakarta.ee/specifications/tags/3.0/jakarta-tags-spec-3.0.pdf)

## Capturas sugeridas

1. Cálculo: 16, 15, 18 → 16.50, Aprobado.
2. Catálogo: tabla completa con seis productos y estados Disponible/Agotado.
3. Acceso: nombre Jorge Eduardo Acosta Loyola, edad 22, matrícula activa → Acceso permitido. Opcional: edad 17 sin matrícula para mostrar ambos motivos de denegación.

La autoevaluación queda para que el estudiante marque sus logros personales. Las capturas las incorpora el estudiante.
