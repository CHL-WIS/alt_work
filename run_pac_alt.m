year = '2008';
mon = '03';
for jgrd = 1:4
	if jgrd == 3
		continue
	end
grdnum = jgrd;
if grdnum == 1
    coord = [110 300 -64 64];
    res = 0.5;
elseif grdnum == 2
    coord = [220.0 250.0 30.0 50.0];
    res = 0.25;
elseif grdnum == 3
    coord = [230.0 245.0 30.0 50.0];
    res = 0.0833;
else
    coord = [198.0 207.0 17.0 23.9];
    res = 0.15;
end

fdir = '/home/thesser1/Pacific/Production/Model/';
dd = [fdir,year,'-',mon,'/grd',num2str(grdnum)];

if ~exist(dd,'dir')
    mkdir(dd);
end

if str2num(mon) < 12
    mon2 = str2num(mon) + 1;
    year2 = year;
else
    mon2 = 1;
    year2 = num2str(str2num(year) + 1);
end
if mon2 < 10
    monc2 = ['0',num2str(mon2)];
else
    monc2 = num2str(mon2);
end
cd(dd)
%get_alt_daily([year,mon,'01',],[year,'06','01'],[110,300,-64,64],0.5);
%get_alt_daily([year,mon,'01',],[year,'06','01'],[198.0,207.0,17.0,23.9],0.15);
get_alt_daily([year,mon,'01',],[year2,monc2,'01'],coord,res);

system('bunzip2 *.bz2');

%sat = read_alt_daily([year,mon,'01000000'],[year,'04','01000000'],[110 300 -64 64],0.5);
sat = read_alt_daily([year,mon,'01000000'],[year2,monc2,'01000000'],coord,res);

system(['cp /mnt/CHL_WIS_1/Pacific/Production/Model_Old/',year,'-',mon, ...
    '/grd',num2str(grdnum),'/*hss.tgz .']);

ww3_alt(sat,['/home/thesser1/Pacific/Production/Model/',year,'-',mon, ...
    '/grd',num2str(grdnum),'/'],coord,res);
    end
