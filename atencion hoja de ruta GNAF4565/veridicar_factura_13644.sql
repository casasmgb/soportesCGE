
--perpre_codigo =20181010_XIIDLW
--fac_codigo =417247

-- seguimiento_capacitacion ADDED
 select * from seguimiento_capacitacion.evaluacion_docente_personas_inscritas where perpre_codigo='20181010_XIIDLW';					--delete
-- seguimineto_capacitacion
 SELECT * FROM seguimiento_capacitacion.facturas_persona_inscripcion f WHERE f.perpre_codigo IN ('20181010_XIIDLW' ); 			    -- delete
 select * from seguimiento_capacitacion.facturas where fac_codigo = 417247; 														-- update
 SELECT * FROM seguimiento_capacitacion.personas_inscripcion pe WHERE pe.perpre_codigo IN ( '20181010_XIIDLW' );		 			-- delete	
--      acceso exteno
 SELECT * from acceso_externo.cuenta_persona_inscripcion cpi WHERE cpi.perpre_codigo IN ( '20181010_XIIDLW' ) 					    -- delete
 select * from acceso_externo.persona_preinscripcion pe WHERE pe.perpre_codigo IN   ('20181010_XIIDLW') and pe.perpre_estado = 2;   -- update
 

 select * from seguimiento_capacitacion.historico_participantes
 select * from acceso_externo.historico_participantes
 