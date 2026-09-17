<%@ include file="header.jspf" %>
<div class="eyebrow">EJERCICIO 03 · CONDICIONES CON JSTL</div><h1>Validación de acceso</h1><p class="lead-copy">Comprueba si cumples las condiciones de ingreso al laboratorio.</p>
<div class="row g-4"><div class="col-lg-7"><section class="panel"><h2>Datos del participante</h2><p class="muted">Simulación académica de una regla de acceso.</p><form method="post" action="${pageContext.request.contextPath}/acceso">
<label for="nombre" class="form-label">Nombre completo</label><input class="form-control" id="nombre" name="nombre" maxlength="80" required placeholder="Escribe tu nombre" value="<c:out value='${param.nombre}'/>">
<label for="edad" class="form-label">Edad</label><input class="form-control" type="number" id="edad" name="edad" min="0" max="120" step="1" required placeholder="Ej. 22" value="<c:out value='${param.edad}'/>">
<div class="form-check mt-4"><input class="form-check-input" type="checkbox" id="matricula" name="matricula" value="si" ${param.matricula eq 'si' ? 'checked' : ''}><label class="form-check-label" for="matricula">Tengo matrícula activa</label></div><button class="btn btn-primary w-100 mt-4" type="submit">Validar acceso &rarr;</button></form></section></div>
<div class="col-lg-5"><section class="result-panel"><div class="eyebrow">ESTADO DE ACCESO</div>
<c:if test="${not evaluado}"><h2 class="mt-4">Pendiente de validación</h2><p>Ingresa tus datos para consultar el resultado.</p></c:if>
<c:if test="${evaluado}">
  <c:choose>
    <c:when test="${edad ge 18 and matriculaActiva}"><div class="access-icon">✓</div><h2>Acceso permitido</h2><p>Bienvenido/a, <strong><c:out value="${nombre}"/></strong>. Cumples las condiciones de ingreso.</p><span class="status good">Participante habilitado</span></c:when>
    <c:otherwise><div class="access-icon denied">×</div><h2>Acceso denegado</h2><p><c:out value="${nombre}"/>, revisa las condiciones pendientes:</p><ul><c:if test="${edad lt 18}"><li>Debes tener al menos 18 años.</li></c:if><c:if test="${not matriculaActiva}"><li>Debes contar con matrícula activa.</li></c:if></ul><span class="status bad">Condiciones no cumplidas</span></c:otherwise>
  </c:choose>
</c:if>
<hr><h3>Condiciones de este ejercicio</h3><p class="mb-0">Tener 18 años o más y matrícula activa. Es una demostración condicional, no un sistema de autenticación.</p></section></div></div>
<%@ include file="footer.jspf" %>
