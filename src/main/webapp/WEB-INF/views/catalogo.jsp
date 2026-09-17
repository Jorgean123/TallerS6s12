<%@ include file="header.jspf" %>
<fmt:setLocale value="es_PE"/>
<div class="eyebrow">EJERCICIO 02 · JSTL CORE</div><h1>Catálogo dinámico</h1><p class="lead-copy">Una colección en Java, una tabla generada con c:forEach.</p>
<section class="card shadow-sm panel catalog-panel"><div class="section-heading"><div><h2>Productos de tecnología</h2><p class="muted mb-0">Datos de demostración enviados por el Servlet.</p></div><span class="pill">${totalProductos} productos</span></div><div class="table-responsive"><table class="table table-striped table-hover align-middle"><thead><tr><th scope="col">Código</th><th scope="col">Producto</th><th scope="col">Precio</th><th scope="col">Stock</th><th scope="col">Estado</th></tr></thead><tbody>
<c:forEach var="producto" items="${productos}">
  <tr>
    <td class="product-code"><c:out value="${producto.codigo}"/></td>
    <td><strong><c:out value="${producto.nombre}"/></strong><small class="d-block muted"><c:out value="${producto.categoria}"/></small></td>
    <td class="text-nowrap">S/ <fmt:formatNumber value="${producto.precio}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td>${producto.stock}</td>
    <td><c:choose><c:when test="${producto.stock gt 0}"><span class="badge rounded-pill text-bg-success">Disponible</span></c:when><c:otherwise><span class="badge rounded-pill text-bg-danger">Agotado</span></c:otherwise></c:choose></td>
  </tr>
</c:forEach>
<c:if test="${empty productos}"><tr><td colspan="5">No hay productos registrados.</td></tr></c:if>
</tbody></table></div><div class="table-foot">Moneda: soles peruanos (PEN) <span>Lista generada en el servidor</span></div></section>
<%@ include file="footer.jspf" %>
