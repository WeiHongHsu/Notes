SET NOCOUNT ON  
  declare
  @parameter  varchar(255) = 'storer',  
   @case char(1) = 'S'  

IF object_id('tempdb..#search') IS NOT NULL 
BEGIN 
	DROP TABLE #search
END 
IF object_id('tempdb..#found_objects') IS NOT NULL 
BEGIN 
	DROP TABLE #found_objects
END   

IF object_id('tempdb..#result') IS NOT NULL 
BEGIN 
	DROP TABLE #result
END   

IF object_id('tempdb..#dist_objects') IS NOT NULL 
BEGIN 
	DROP TABLE #dist_objects
END   
IF object_id('tempdb..#dist_result') IS NOT NULL 
BEGIN 
	DROP TABLE #dist_result
END   

declare @str_no        tinyint,  
      @msg_str_no      varchar(3),  
      @operation       char(1),  
      @string          varchar(80),  
      @oper_pos        smallint,  
      @context         varchar(255),  
      @i               tinyint,  
      @longest         tinyint,  
      @msg             varchar(255)  
  
if @parameter is null /* provide instructions */  
begin  
   print 'Execute sp_grep "{string1}operation1{string2}operation2{string3}...", [case]'  
   print '- stringN is a string of characters up to 80 characters long, '  
   print '  enclosed in curly brackets. Brackets may be omitted if stringN '  
   print '  does not contain leading and trailing spaces or characters: +,-,&.'  
   print '- operationN is one of the characters: +,-,&. Interpreted as or,minus,and.'  
   print '  Operations are executed from left to right with no priorities.'  
   print '- case: specify "i" for case insensitive comparison.'  
   print 'E.g. sp_grep "alpha+{beta gamma}-{delta}&{+++}"'  
   print '     will search for all objects that have an occurence of string "alpha"'  
   print '     or string "beta gamma", do not have string "delta", '  
   print '     and have string "+++".'  
   return  
end  
  
/* Check for <CarriageReturn> or <LineFeed> characters */  
if charindex( char(10), @parameter ) > 0 or charindex( char(13), @parameter ) > 0  
begin  
   print 'Parameter string may not contain <CarriageReturn> or <LineFeed> characters.'  
   return  
end  
  
if lower( @case ) = 'i'  
select  @parameter = lower( ltrim( rtrim( @parameter ) ) )  
else  
   select  @parameter = ltrim( rtrim( @parameter ) )  
  
   create table #search ( str_no tinyint, operation char(1), string varchar(80), last_obj int )  
   create table #found_objects ( id int, str_no tinyint )  
   create table #result ( id int )  
  
   /* Parse the parameter string */  
   select @str_no = 0  
   while datalength( @parameter ) > 0  
   begin  
      /* Get operation */  
      select @str_no = @str_no + 1, @msg_str_no = rtrim( convert( char(3), @str_no + 1 ) )  
      if @str_no = 1  
      select  @operation = '+'  
   else  
      begin  
         if substring( @parameter, 1, 1 ) in ( '+', '-', '&' )  
         select  @operation = substring( @parameter, 1, 1 ),  
         @parameter = ltrim( right( @parameter, datalength( @parameter ) - 1 ) )  
      else  
         begin  
            select @context = rtrim( substring(  
            @parameter + space( 255 - datalength( @parameter) ), 1, 20 ) )  
            select @msg = 'Incorrect or missing operation sign before "' + @context + '".'  
            print  @msg  
            select @msg = 'Search string ' + @msg_str_no + '.'  
            print  @msg  
            return  
         end  
      end  
  
      /* Get string */  
      if datalength( @parameter ) = 0  
      begin  
         print 'Missing search string at the end of the parameter.'  
         select @msg = 'Search string ' + @msg_str_no + '.'  
         print  @msg  
         return  
      end  
      if substring( @parameter, 1, 1 ) = '{'  
      begin  
         if charindex( '}', @parameter ) = 0  
         begin  
            select @context = rtrim( substring(  
            @parameter + space( 255 - datalength( @parameter) ), 1, 200 ) )  
            select @msg = 'Bracket not closed after "' + @context + '".'  
            print  @msg  
            select @msg = 'Search string ' + @msg_str_no + '.'  
            print  @msg  
            return  
         end  
         if charindex( '}', @parameter ) > 82  
         begin  
            select @context = rtrim( substring(  
            @parameter + space( 255 - datalength( @parameter) ), 2, 20 ) )  
            select @msg = 'Search string ' + @msg_str_no + ' is longer than 80 characters.'  
            print  @msg  
            select @msg = 'String begins with "' + @context + '".'  
            print  @msg  
            return  
         end  
         select  @string    = substring( @parameter, 2, charindex( '}', @parameter ) - 2 ),  
         @parameter = ltrim( right( @parameter,  
         datalength( @parameter ) - charindex( '}', @parameter ) ) )  
      end  
      else  
      begin  
         /* Find the first operation sign */  
         select @oper_pos = datalength( @parameter ) + 1  
         if charindex( '+', @parameter ) between 1 and @oper_pos  
         select @oper_pos = charindex( '+', @parameter )  
         if charindex( '&', @parameter ) between 1 and @oper_pos  
         select @oper_pos = charindex( '&', @parameter )  
  
         if @oper_pos = 1  
         begin  
            select @context = rtrim( substring(  
            @parameter + space( 255 - datalength( @parameter) ), 1, 20 ) )  
            select @msg = 'Search string ' + @msg_str_no +  
            ' is missing, before "' + @context + '".'  
            print  @msg  
            return  
         end  
         if @oper_pos > 81  
         begin  
            select @context = rtrim( substring(  
            @parameter + space( 255 - datalength( @parameter) ), 1, 20 ) )  
            select @msg = 'Search string ' + @msg_str_no + ' is longer than 80 characters.'  
            print  @msg  
            select @msg = 'String begins with "' + @context + '".'  
            print  @msg  
            return  
         end  
  
         select  @string    = substring( @parameter, 1, @oper_pos - 1 ),  
         @parameter = ltrim( right( @parameter,  
         datalength( @parameter ) - @oper_pos + 1 ) )  
      end  
      insert #search values ( @str_no, @operation, @string, 0 )  
  
   end  
   select @longest = max( datalength( string ) ) - 1  
   from   #search  
  
   /* ------------------------------------------------------------------ */  
   /* Search for strings */  
   if @case = 'i'  
   begin  
      insert #found_objects  
      select a.id, c.str_no  
      from   syscomments a, #search c  
      where  charindex( c.string, lower( a.text ) ) > 0  
  
      insert #found_objects  
      select a.id, c.str_no  
      from   syscomments a, syscomments b, #search c  
      where  a.id        = b.id  
      and    a.number    = b.number  
      and    a.colid + 1 = b.colid  
      and    charindex( c.string,  
      lower( right( a.text, @longest ) +  
      substring( b.text, 1, @longest ) ) ) > 0  
   end  
else  
   begin  
      insert #found_objects  
      select a.id, c.str_no  
      from   syscomments a, #search c  
      where  charindex( c.string, a.text ) > 0  
  
      insert #found_objects  
      select a.id, c.str_no  
      from   syscomments a, syscomments b, #search c  
      where  a.id        = b.id  
      and    a.number    = b.number  
      and    a.colid + 1 = b.colid  
      and    charindex( c.string,  
      right( a.text, @longest ) +  
      substring( b.text, 1, @longest ) ) > 0  
   end  
   /* ------------------------------------------------------------------ */  
   select distinct str_no, id into #dist_objects from #found_objects  
   create unique clustered index obj on #dist_objects  ( str_no, id )  
  
   /* Apply one operation at a time */  
   select @i = 0  
   while @i < @str_no  
   begin  
      select @i = @i + 1  
      select @operation = operation from #search where str_no = @i  
  
      if @operation = '+'  
      insert #result  
      select id  
      from   #dist_objects  
      where  str_no = @i  
   else if @operation = '-'  
      delete #result  
      from   #result a, #dist_objects b  
      where  b.str_no = @i  
      and    a.id = b.id  
   else if @operation = '&'  
      delete #result  
      where  not exists  
      ( select 1  
      from   #dist_objects b  
      where  b.str_no = @i  
  
      and    b.id = #result.id )  
   end  
  
   /* Select results */  
   select distinct id into #dist_result from #result  
  
   /* The following select has been borrowed from the sp_help  
   ** system stored procedure, and modified. */  
   select  Distinct  
   Name        = convert(char(50), o.name),  
   /* Remove 'convert(char(15)' in the following line  
   ** if user names on your server are longer. */  
   Owner       = convert( char(10), user_name(uid) ),  
   Object_type = substring(v.name, 1, 16)  
   from    #dist_result           d,  
   sysobjects             o ,  
   master.dbo.spt_values  v  
   where   d.id = o.id  
   and     o.sysstat & ( 7 + 8 * sign( charindex( '6.', @@version ) ) ) = v.number  
   and     v.type = 'O'   
   and     o.type IN ('P', 'TR', 'FN')    -- tlting01  
   order by  Object_type desc, Name asc  