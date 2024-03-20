	DECLARE
	@isbn13 VARCHAR(13) = '9789576941436',
    @isbn10 VARCHAR(10) 
	
    -- 移除前缀 "978"
	set @isbn10 =  SUBSTRING(@isbn13, 4, 10);


    -- 计算校验位
    DECLARE @checksum INT;
    SET @checksum =  11 - 
					((10 * CONVERT(INT, SUBSTRING(@isbn10, 1, 1)) +
					   9 * CONVERT(INT, SUBSTRING(@isbn10, 2, 1)) +
					   8 * CONVERT(INT, SUBSTRING(@isbn10, 3, 1)) +
					   7 * CONVERT(INT, SUBSTRING(@isbn10, 4, 1)) +
					   6 * CONVERT(INT, SUBSTRING(@isbn10, 5, 1)) +
					   5 * CONVERT(INT, SUBSTRING(@isbn10, 6, 1)) +
					   4 * CONVERT(INT, SUBSTRING(@isbn10, 7, 1)) +
					   3 * CONVERT(INT, SUBSTRING(@isbn10, 8, 1)) +
					   2 * CONVERT(INT, SUBSTRING(@isbn10, 9, 1))
					   ) % 11)

    -- 计算并追加校验位
	--select @checksum
    select  left(@isbn10,9) + CAST(case when @checksum = '10' then '0' else @checksum end  AS VARCHAR(1));


	