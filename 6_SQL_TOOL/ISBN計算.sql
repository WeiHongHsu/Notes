DECLARE
@isbn10 VARCHAR(10) = '8175257660',
@isbn13 VARCHAR(13) 

DECLARE @checksum INT;
DECLARE @checksum2 VARCHAR(13);
SET @checksum = (10 * CONVERT(INT, SUBSTRING(@isbn10, 1, 1)) +
				 9 * CONVERT(INT, SUBSTRING(@isbn10, 2, 1)) +
				 8 * CONVERT(INT, SUBSTRING(@isbn10, 3, 1)) +
				 7 * CONVERT(INT, SUBSTRING(@isbn10, 4, 1)) +
				 6 * CONVERT(INT, SUBSTRING(@isbn10, 5, 1)) +
				 5 * CONVERT(INT, SUBSTRING(@isbn10, 6, 1)) +
				 4 * CONVERT(INT, SUBSTRING(@isbn10, 7, 1)) +
				 3 * CONVERT(INT, SUBSTRING(@isbn10, 8, 1)) +
				 2 * CONVERT(INT, SUBSTRING(@isbn10, 9, 1)))

--select @checksum ,@checksum % 11 ,@isbn10
select case when 11 - (@checksum % 11) = 10 then 'X'
when 11 - (@checksum % 11) = 11 then '0'
else 11 - (@checksum % 11) end

SET @checksum2 = '978' + LEFT(@isbn10, 9)
set @isbn13 = '978' + LEFT(@isbn10, 9)

--select @checksum2
SET @checksum2 = (1 * CONVERT(INT, SUBSTRING(@checksum2, 1, 1)) +
			   3 * CONVERT(INT, SUBSTRING(@checksum2, 2, 1)) +
			   1 * CONVERT(INT, SUBSTRING(@checksum2, 3, 1)) +
			   3 * CONVERT(INT, SUBSTRING(@checksum2, 4, 1)) +
			   1 * CONVERT(INT, SUBSTRING(@checksum2, 5, 1)) +
			   3 * CONVERT(INT, SUBSTRING(@checksum2, 6, 1)) +
			   1 * CONVERT(INT, SUBSTRING(@checksum2, 7, 1)) +
			   3 * CONVERT(INT, SUBSTRING(@checksum2, 8, 1)) +
			   1 * CONVERT(INT, SUBSTRING(@checksum2, 9, 1)) +
			   3 * CONVERT(INT, SUBSTRING(@checksum2, 10, 1)) +
			   1 * CONVERT(INT, SUBSTRING(@checksum2, 11, 1)) +
			   3 * CONVERT(INT, SUBSTRING(@checksum2, 12, 1)))

select @checksum2

--select @checksum2 % 10
select case when 10 - (@checksum2 % 10) = 10 then '0'
else (@checksum2 % 10) end


------ 计算并追加校验位
select @isbn13 +
CAST(case when 10 - (@checksum2 % 10) = 10 
then '0' else (@checksum2 % 10) end  AS VARCHAR(1))



--select @isbn13
--select (11 - @checksum) % 11

--select @isbn13
