INSERT INTO tipos_prestamo (id, nombre, tasa_anual) VALUES
  ('11111111-1111-1111-1111-111111111111', 'Consumo', 24.50),
  ('22222222-2222-2222-2222-222222222222', 'Libre inversión', 28.90),
  ('33333333-3333-3333-3333-333333333333', 'Educativo', 18.75)
ON DUPLICATE KEY UPDATE
  nombre = VALUES(nombre),
  tasa_anual = VALUES(tasa_anual),
  updated_at = CURRENT_TIMESTAMP;
