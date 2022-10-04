alter proc sp_updateInsert_f_DayAhead_indeksi
@f_dat datetime,
@f_egsi bit,
@f_cegh_vtp decimal(12,9),
@f_cz_vtp decimal(12,9),
@f_etf decimal(12,9),
@f_gpl decimal(12,9),
@f_ncg decimal(12,9),
@f_pegNord decimal(12,9),
@f_trs decimal(12,9),
@f_ttf decimal(12,9),
@f_ztp decimal(12,9)
as

begin

declare @NarediLogZapis bit = 0
declare @text nvarchar(1000)=''
declare @DovoljenaSprememba decimal (4,2) = 0.5

-- ce ne najdem zapisa datuma, naredim nov zapis in  grem ven iz procedure

if ((select top 1 f_dat from f_DayAhead_Indeksi where f_dat=@f_dat and f_EGSI = @f_egsi) is null)
begin
	insert into f_DayAhead_Indeksi (f_dat,f_EGSI,f_cegh_vtp,f_cz_vtp,f_etf,f_gpl,f_ncg,f_pegNord,f_trs,f_ttf,f_ztp,f_modifiedAt) 
	values (@f_dat, @f_egsi, @f_cegh_vtp, @f_cz_vtp,@f_etf,@f_gpl,@f_ncg,@f_pegNord,@f_trs,@f_ttf,@f_ztp,getdate())
	return
end


-- preveri koliko odstopajo prejšnje/zdajšnje vrednosti @f_cegh_vtp 
if  (@f_cegh_vtp -  (select top 1 f_cegh_vtp from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi) > @DovoljenaSprememba)
begin
	set @NarediLogZapis= 1
	set @text = @text+ ' CEGH indeks za dan ' + cast(cast(@f_dat as date) as nvarchar(50)) + ' odstopa za ' 
	+ cast(cast((@f_cegh_vtp -  (select top 1 f_cegh_vtp from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi)) as decimal(4,2)) as nvarchar(50)) + ' EUR/MWh. '
end
else if ((select top 1 f_dat from f_DayAhead_Indeksi where f_dat=@f_dat and f_EGSI = @f_egsi) is not null)
begin
	update f_DayAhead_Indeksi set f_cegh_vtp = @f_cegh_vtp, f_modifiedAt = getdate() where f_dat=@f_dat and f_EGSI=@f_egsi
end

-- preveri koliko odstopajo prejšnje/zdajšnje vrednosti @f_cz_vtp 
if  (@f_cz_vtp -  (select top 1 f_cz_vtp from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi) > @DovoljenaSprememba)
begin
	set @NarediLogZapis= 1
	set @text = @text+ ' CZ VTP indeks za dan ' + cast(cast(@f_dat as date) as nvarchar(50)) + ' odstopa za ' 
	+ cast(cast((@f_cz_vtp -  (select top 1 f_cz_vtp from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi)) as decimal(4,2)) as nvarchar(50)) + ' EUR/MWh. '
end
else if ((select top 1 f_dat from f_DayAhead_Indeksi where f_dat=@f_dat and f_EGSI = @f_egsi) is not null)
begin
	update f_DayAhead_Indeksi set f_cz_vtp = @f_cz_vtp, f_modifiedAt = getdate() where f_dat=@f_dat and f_EGSI=@f_egsi
end

-- preveri koliko odstopajo prejšnje/zdajšnje vrednosti @f_etf 
if  (@f_etf -  (select top 1 f_etf from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi) > @DovoljenaSprememba)
begin
	set @NarediLogZapis= 1
	set @text = @text+ ' ETF indeks za dan ' + cast(cast(@f_dat as date) as nvarchar(50)) + ' odstopa za ' 
	+ cast(cast((@f_etf -  (select top 1 f_etf from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi)) as decimal(4,2)) as nvarchar(50)) + ' EUR/MWh. '
end
else if ((select top 1 f_dat from f_DayAhead_Indeksi where f_dat=@f_dat and f_EGSI = @f_egsi) is not null)
begin
	update f_DayAhead_Indeksi set f_etf = @f_etf, f_modifiedAt = getdate() where f_dat=@f_dat and f_EGSI=@f_egsi
end

-- preveri koliko odstopajo prejšnje/zdajšnje vrednosti @f_gpl 
if  (@f_gpl  -  (select top 1 f_gpl  from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi) > @DovoljenaSprememba)
begin
	set @NarediLogZapis= 1
	set @text = @text+ ' GPL indeks za dan ' + cast(cast(@f_dat as date) as nvarchar(50)) + ' odstopa za ' 
	+ cast(cast((@f_gpl  -  (select top 1 f_gpl  from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi)) as decimal(4,2)) as nvarchar(50)) + ' EUR/MWh. '
end
else if ((select top 1 f_dat from f_DayAhead_Indeksi where f_dat=@f_dat and f_EGSI = @f_egsi) is not null)
begin
	update f_DayAhead_Indeksi set f_gpl = @f_gpl, f_modifiedAt = getdate() where f_dat=@f_dat and f_EGSI=@f_egsi
end

-- preveri koliko odstopajo prejšnje/zdajšnje vrednosti @f_ncg 
if  (@f_ncg  -  (select top 1 f_ncg  from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi) > @DovoljenaSprememba)
begin
	set @NarediLogZapis= 1
	set @text = @text+ ' NCG indeks za dan ' + cast(cast(@f_dat as date) as nvarchar(50)) + ' odstopa za ' 
	+ cast(cast((@f_ncg  -  (select top 1 f_ncg  from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi)) as decimal(4,2)) as nvarchar(50)) + ' EUR/MWh. '
end
else if ((select top 1 f_dat from f_DayAhead_Indeksi where f_dat=@f_dat and f_EGSI = @f_egsi) is not null)
begin
	update f_DayAhead_Indeksi set f_ncg = @f_ncg, f_modifiedAt = getdate() where f_dat=@f_dat and f_EGSI=@f_egsi
end

-- preveri koliko odstopajo prejšnje/zdajšnje vrednosti @f_pegNord 
if  (@f_pegNord  -  (select top 1 f_pegNord  from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi) > @DovoljenaSprememba)
begin
	set @NarediLogZapis= 1
	set @text = @text+ ' Peg nord indeks za dan ' + cast(cast(@f_dat as date) as nvarchar(50)) + ' odstopa za ' 
	+ cast(cast((@f_pegNord  -  (select top 1 f_pegNord  from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi)) as decimal(4,2)) as nvarchar(50)) + ' EUR/MWh. '
end
else if ((select top 1 f_dat from f_DayAhead_Indeksi where f_dat=@f_dat and f_EGSI = @f_egsi) is not null)
begin
	update f_DayAhead_Indeksi set f_pegNord = @f_pegNord, f_modifiedAt = getdate() where f_dat=@f_dat and f_EGSI=@f_egsi
end

-- preveri koliko odstopajo prejšnje/zdajšnje vrednosti @f_trs  
if  (@f_trs   -  (select top 1 f_trs   from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi) > @DovoljenaSprememba)
begin
	set @NarediLogZapis= 1
	set @text = @text+ ' TRS  indeks za dan ' + cast(cast(@f_dat as date) as nvarchar(50)) + ' odstopa za ' 
	+ cast(cast((@f_trs  -  (select top 1 f_trs  from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi)) as decimal(4,2)) as nvarchar(50)) + ' EUR/MWh. '
end
else if ((select top 1 f_dat from f_DayAhead_Indeksi where f_dat=@f_dat and f_EGSI = @f_egsi) is not null)
begin
	update f_DayAhead_Indeksi set f_trs = @f_trs, f_modifiedAt = getdate() where f_dat=@f_dat and f_EGSI=@f_egsi
end

-- preveri koliko odstopajo prejšnje/zdajšnje vrednosti @f_ttf  
if  (@f_ttf   -  (select top 1 f_ttf   from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi) > @DovoljenaSprememba)
begin
	set @NarediLogZapis= 1
	set @text = @text+ ' TTF  indeks za dan ' + cast(cast(@f_dat as date) as nvarchar(50)) + ' odstopa za ' 
	+ cast(cast((@f_ttf  -  (select top 1 f_ttf  from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi)) as decimal(4,2)) as nvarchar(50)) + ' EUR/MWh. '
end
else if ((select top 1 f_dat from f_DayAhead_Indeksi where f_dat=@f_dat and f_EGSI = @f_egsi) is not null)
begin
	update f_DayAhead_Indeksi set f_ttf = @f_ttf, f_modifiedAt = getdate() where f_dat=@f_dat and f_EGSI=@f_egsi
end

-- preveri koliko odstopajo prejšnje/zdajšnje vrednosti @f_ztp   
if  (@f_ztp  -  (select top 1 f_ztp    from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi) > @DovoljenaSprememba)
begin
	set @NarediLogZapis= 1
	set @text = @text+ ' ZTP  indeks za dan ' +cast(cast(@f_dat as date) as nvarchar(50)) + ' odstopa za ' 
	+ cast(cast((@f_ztp  -  (select top 1 f_ztp  from f_DayAhead_Indeksi where f_dat = @f_dat and f_EGSI = @f_egsi)) as decimal(4,2)) as nvarchar(50)) + ' EUR/MWh. '
end
else if ((select top 1 f_dat from f_DayAhead_Indeksi where f_dat=@f_dat and f_EGSI = @f_egsi) is not null)
begin
	update f_DayAhead_Indeksi set f_ztp = @f_ztp, f_modifiedAt = getdate() where f_dat=@f_dat and f_EGSI=@f_egsi
end

if (@NarediLogZapis = 1)
begin 
	insert into [STAGE].[dbo].[AvtomatskeProcedureLogiranjeNapak] values
	(getdate(),'Branje PEGAS Indeksov (SSIS PreberiTujeIndeksePEGAS + SQL Procedura na DWH bazi sp_updateInsert_f_DayAhead_indeksi', @text)
end

end

exec 