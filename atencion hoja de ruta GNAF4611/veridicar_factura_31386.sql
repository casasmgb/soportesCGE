--perpre_codigo =20181011_GAODSL
--fac_codigo = 435300
-- para verificar:

-- seguimineto_capacitacion
 SELECT * FROM seguimiento_capacitacion.facturas_persona_inscripcion f WHERE f.perpre_codigo IN ('20181011_GAODSL' ); 			    -- delete
 select * from seguimiento_capacitacion.facturas where fac_codigo = 435300; 														-- update
 SELECT * FROM seguimiento_capacitacion.personas_inscripcion pe WHERE pe.perpre_codigo IN ( '20181011_GAODSL' );		 			-- delete	
--      acceso exteno
 SELECT * from acceso_externo.cuenta_persona_inscripcion cpi WHERE cpi.perpre_codigo IN ( '20181011_GAODSL' ); 					    -- delete
 select * from acceso_externo.persona_preinscripcion pe WHERE pe.perpre_codigo IN   ('20181011_GAODSL') and pe.perpre_estado = 2;   -- update

 select * from seguimiento_capacitacion.historico_participantes;
 select * from acceso_externo.historico_participantes;
 
 
 