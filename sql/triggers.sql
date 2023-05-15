DROP TRIGGER
IF
	EXISTS emp_limit_tri;
DROP TRIGGER
IF
	EXISTS water_limit_tri;
DROP TRIGGER
IF
	EXISTS insert_in_water_tri;
DROP TRIGGER
IF
	EXISTS update_in_water_tri;
DROP TRIGGER
IF
	EXISTS del_in_water_tri;
DROP TRIGGER
IF
	EXISTS insert_out_water_tri;
DROP TRIGGER
IF
	EXISTS update_out_water_tri;
DROP TRIGGER
IF
	EXISTS del_out_water_tri;
	
CREATE TRIGGER emp_limit_tri BEFORE INSERT ON Employee FOR EACH ROW
BEGIN
	IF
		( NEW.age < 18 OR NEW.age > 65 ) THEN
		DELETE 
		FROM
			Employee 
		WHERE
			eno = NEW.age;
		
	END IF;
	
END;
CREATE TRIGGER water_limit_tri BEFORE INSERT ON Water FOR EACH ROW
BEGIN
	IF
		( NEW.price <= 0.01 OR NEW.price >= 99 ) THEN
		DELETE 
		FROM
			Employee 
		WHERE
			wno = NEW.wno;
		
	END IF;
	
END;
CREATE TRIGGER insert_in_water_tri AFTER INSERT ON IOrderDetail FOR EACH ROW
BEGIN
	IF
		( NEW.num >= 0 ) THEN
			UPDATE Water 
			SET store = store + NEW.num 
		WHERE
			wno = NEW.wno;
		
	END IF;
	
END;
CREATE TRIGGER update_in_water_tri AFTER UPDATE ON IOrderDetail FOR EACH ROW
BEGIN
	IF
		( NEW.num >= 0 ) THEN
			UPDATE Water 
			SET store = store - OLD.num + NEW.NUM 
		WHERE
			wno = NEW.wno;
		
	END IF;
	
END;
CREATE TRIGGER del_in_water_tri AFTER DELETE ON IOrderDetail FOR EACH ROW
BEGIN
	IF
		( OLD.num >= 0 ) THEN
			UPDATE Water 
			SET store = store - OLD.num 
		WHERE
			wno = OLD.wno;
		
	END IF;
	
END;
CREATE TRIGGER insert_out_water_tri AFTER INSERT ON Task FOR EACH ROW
BEGIN
	IF
		( NEW.num >= 0 AND NEW.status = "1" ) THEN
			UPDATE Water 
			SET store = store - NEW.num 
		WHERE
			wno = NEW.wno;
		UPDATE COrder 
		SET leav = leav - NEW.num 
		WHERE
			cono = NEW.cono;
		
	END IF;
	
END;
CREATE TRIGGER update_out_water_tri AFTER UPDATE ON Task FOR EACH ROW
BEGIN
	IF
		( NEW.num >= 0 AND NEW.status = "1" AND OLD.status = "1" ) THEN
			UPDATE Water 
			SET store = store + OLD.num - NEW.num 
		WHERE
			wno = NEW.wno;
		UPDATE COrder 
		SET leav = leav + OLD.num - NEW.num 
		WHERE
			cono = OLD.cono;
		
		ELSEIF ( NEW.num >= 0 AND NEW.status = "1" AND OLD.status = "0" ) THEN
		UPDATE Water 
		SET store = store - NEW.num 
		WHERE wno = NEW.wno;
		UPDATE COrder 
		SET leav = leav - NEW.num 
		WHERE cono = OLD.cono;
			
		ELSEIF ( NEW.num >= 0 AND NEW.status = "0" AND OLD.status = "1" ) THEN
		UPDATE Water 
		SET store = store + OLD.num 
		WHERE
			wno = NEW.wno;
		UPDATE COrder 
		SET leav = leav + OLD.num 
		WHERE
			cono = OLD.cono;
		
	END IF;
	
END;
CREATE TRIGGER del_out_water_tri AFTER DELETE ON Task FOR EACH ROW
BEGIN
	IF
		( OLD.num >= 0 AND OLD.status = "1" ) THEN
			UPDATE Water 
			SET store = store + OLD.num 
		WHERE
			wno = OLD.wno;
		UPDATE COrder 
		SET leav = leav + OLD.num 
		WHERE
			cono = OLD.cono;
		
	END IF;
END;