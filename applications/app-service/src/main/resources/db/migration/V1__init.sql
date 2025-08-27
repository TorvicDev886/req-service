-- Tipos de préstamo
CREATE TABLE IF NOT EXISTS tipos_prestamo (
  id CHAR(36) PRIMARY KEY,
  nombre VARCHAR(80) NOT NULL,
  tasa_anual DECIMAL(5,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT uq_tipos_nombre UNIQUE (nombre)
);

-- Solicitudes
CREATE TABLE IF NOT EXISTS solicitudes (
  id CHAR(36) PRIMARY KEY,
  documento_identidad VARCHAR(20) NOT NULL,
  monto DECIMAL(15,2) NOT NULL,
  plazo_meses INT NOT NULL,
  tipo_prestamo_id CHAR(36) NOT NULL,
  estado VARCHAR(30) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_solicitud_tipo FOREIGN KEY (tipo_prestamo_id) REFERENCES tipos_prestamo(id)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);

-- Índices para acelerar validaciones y consultas por documento y tipo
CREATE INDEX IF NOT EXISTS idx_solicitudes_doc ON solicitudes (documento_identidad);
CREATE INDEX IF NOT EXISTS idx_solicitudes_tipo ON solicitudes (tipo_prestamo_id);

-- (Opcional) Restringir valores de estado (MySQL 8.0.16+)
-- Si tu versión no soporta CHECK, comenta la siguiente línea.
ALTER TABLE solicitudes
  ADD CONSTRAINT chk_solicitudes_estado
  CHECK (estado IN ('Pendiente de revisión', 'Aprobado', 'Rechazado'));
