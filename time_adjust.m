function [sat_grid] = time_adjust(time1,time2,tint,time,lon,lat,Hs,long,latg)

timenum1 = [str2double(time1(1:4)),str2double(time1(5:6)),str2double(time1(7:8)), ...
    str2double(time1(9:10))+tint/60,str2double(time1(11:12)),str2double(time1(13:14))];
timenum2 = [str2double(time2(1:4)),str2double(time2(5:6)),str2double(time2(7:8)), ...
    str2double(time2(9:10)),str2double(time2(11:12)),str2double(time2(13:14))];
timenum05= [str2double(time1(1:4)),str2double(time1(5:6)),str2double(time1(7:8)), ...
    str2double(time1(9:10))+2*tint/60,str2double(time1(11:12)),str2double(time1(13:14))];
tstep = datenum(timenum05) - datenum(timenum1);
tt = datenum(timenum1):tstep:datenum(timenum2);
thalf = datenum(timenum1)-tstep/2:tstep:datenum(timenum2)+tstep/2;

[nt nd] = size(time);

% long = 110.0:0.5:300.0;
% latg = -64.0:0.5:64.0;
for zz = 1:length(thalf)-1
    pp = 1;
    for jj = 1:nd
        for ii = 1:nt
            qq = find(time{ii,jj} > thalf(zz) & time{ii,jj} <= thalf(zz+1));
            if size(qq,1) > 0
                lont{pp} = lon{ii,jj}(qq); %#ok<*AGROW>
                latt{pp} = lat{ii,jj}(qq);
                %                 zilon{pp} = kNearestNeighbors(long',lon{ii,jj}(qq),1);
                %                 zilat{pp} = kNearestNeighbors(latg',lat{ii,jj}(qq),1);
                Hsnew{pp} = Hs{ii,jj}(qq);
                pp = pp + 1;
            elseif pp > 1
                break
            end
        end
        if pp > 1 && size(qq,1) == 0
            break
        end
    end
    
    Hsgrid = NaN(length(latg),length(long));
    Hstemp = repmat({NaN},[length(latg) length(long)]);
    Hsgridtest = NaN(length(latg),length(long));
    Hstemptest = repmat({NaN},[length(latg) length(long)]);
    if exist('Hsnew','var')
        if pp > 2
            lon2 = [lont{1};lont{2}];
            lat2 = [latt{1};latt{2}];
            %               zilon2 = [zilon{1};zilon{2}];
            %               zilat2 = [zilat{1};zilat{2}];
            Hsnew2 = [Hsnew{1};Hsnew{2}];
            
        else
            lon2 = lont{1};
            lat2 = latt{1};
            %              zilon2 = [zilon{1}];
            %              zilat2 = [zilat{1}];
            Hsnew2 = Hsnew{1};
        end
        
        %         Hsgrid = bin2mat(lon2,lat2,Hsnew2,X,Y);
        
        %              lonn = long(zilon2);
        %              latn = latg(zilat2);
        [~, xind] = histc(lon2,long);
        [~, yind] = histc(lat2,latg);
        % %         Hsn = Hsnew2(1);
        % %         Hsgrid(zilon2(1,:),zilat2(1,:)) = Hsn;
        for ii = 1:size(xind,1)
            % for qq = 1:1
            xx = xind(ii);
            yy = yind(ii);
            ppx = xx;
            ppy = yy;
            %ppx = [xx-1,xx,xx+1,xx-1,xx,xx+1,xx-1,xx,xx+1,xx-1,xx,xx+1,xx-1,xx,xx+1];
            %ppy = [yy+1,yy+1,yy+1,yy+1,yy+1,yy,yy,yy,yy,yy,yy-1,yy-1,yy-1,yy-1,yy-1];
            %ppx = [xx-2,xx-1,xx,xx+1,xx+2,xx-2,xx-1,xx,xx+1,xx+2,xx-2,xx-1,xx, ...
            %       xx+1,xx+2,xx-2,xx-1,xx,xx+1,xx+2,xx-2,xx-1,xx,xx+1,xx+2];
            %ppy = [yy+2,yy+2,yy+2,yy+2,yy+2,yy+1,yy+1,yy+1,yy+1,yy+1,yy,yy,yy, ...
            %       yy,yy,yy-1,yy-1,yy-1,yy-1,yy-1,yy-2,yy-2,yy-2,yy-2,yy-2];
            for istep = 1:1
                %     for pp = 1:1
                if ppx(istep) < 1 | ppx(istep) > length(long) | ppy(istep) < ...
                        1 | ppy(istep) > length(latg)
                    continue
                end
                if ~isnan(Hstemp{ppy(istep),ppx(istep)})
                    Hstemp{ppy(istep),ppx(istep)} = [Hstemp{ppy(istep),ppx(istep)}; ...
                        Hsnew2(ii)];
                    Hstemptest{ppy(istep),ppx(istep)} = [Hstemptest{ppy(istep),ppx(istep)}; ...
                        Hsnew2(ii)];
                else
                    Hstemp{ppy(istep),ppx(istep)} = Hsnew2(ii);
                    Hstemptest{ppy(istep),ppx(istep)} = Hsnew2(ii);
                end
               % if ~isnan(Hsgrid(ppy(istep),ppx(istep)))
               %     Hsn = (Hsnew2(ii) + Hsgrid(ppy(istep),ppx(istep)))/2.;
                    % if ~isnan(Hsgrid(yind(ii),xind(ii)))
                    %if zilon2(ii,1) == zilon2(ii-1,1) && ...
                    %        zilat2(ii,1) == zilat2(ii-1,1)
                    %         Hsn = (Hsnew2(ii)+ Hsgrid(yind(ii),xind(ii)))/2.;
               % else
               %     Hsn = Hsnew2(ii);
               % end
                %Hsgrid(ppy(istep),ppx(istep)) = Hsn;
                %Hsgrid(yind(ii),xind(ii)) = Hsn;
                %     end
            end
        end
        for jj = 1:length(latg)
            for ii = 1:length(long)
                if ~isnan(Hstemp{jj,ii}(1));
                    Hsgrid(jj,ii) = mean(Hstemp{jj,ii}(:));
                end
            end
        end
        clear zilon zilat Hsnew
    else
        lon2 = -999.00;lat2 = -999.00;
    end
    
    sat_grid(zz) = struct('stime',datestr(tt(zz)),'mtime',tt(zz),'Hs_grid',Hsgrid,'lon',lon2,'lat',lat2,'long',long,'latg',latg);         %#ok<AGROW>
end
% for jj = 1:length(latg)
%             for ii = 1:length(long)
%                 if ~isnan(Hstemp{jj,ii}(1));
%                     Hsgridtest(jj,ii) = mean(Hstemptest{jj,ii}(:));
%                 end
%             end
% end
%        1