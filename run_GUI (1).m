function run_GUI()
% GDM2000 Map Projection Transformation System (RSO & Cassini-Soldner)

% --- Cipta figure utama ---
fig = figure('Name', 'GDM2000 Map Projection System', ...
    'NumberTitle', 'off', ...
    'MenuBar', 'none', ...
    'ToolBar', 'none', ...
    'Position', [300, 300, 450, 350]);

% --- Label Transformasi ---
uicontrol('Style', 'text', ...
    'String', 'Select Transformation:', ...
    'Position', [50, 280, 150, 20], ...
    'FontWeight', 'bold');

% --- Dropdown Transformasi ---
transDrop = uicontrol('Style', 'popupmenu', ...
    'String', {'GDM2000 - RSO', 'RSO - GDM2000', 'GDM2000 - Cassini-Soldner'}, ...
    'Position', [200, 280, 180, 22]);

% --- Label & Edit Field: Latitude ---
uicontrol('Style', 'text', 'String', 'Latitude:', 'Position', [50, 230, 100, 20]);
latEdit = uicontrol('Style', 'edit', 'Position', [150, 230, 100, 22]);

% --- Label & Edit Field: Longitude ---
uicontrol('Style', 'text', 'String', 'Longitude:', 'Position', [50, 200, 100, 20]);
lonEdit = uicontrol('Style', 'edit', 'Position', [150, 200, 100, 22]);

% --- Label & Edit Field: Easting ---
uicontrol('Style', 'text', 'String', 'Easting:', 'Position', [50, 170, 100, 20]);
eastEdit = uicontrol('Style', 'edit', 'Position', [150, 170, 100, 22]);

% --- Label & Edit Field: Northing ---
uicontrol('Style', 'text', 'String', 'Northing:', 'Position', [50, 140, 100, 20]);
northEdit = uicontrol('Style', 'edit', 'Position', [150, 140, 100, 22]);

% --- Label & Dropdown: State/Zone ---
uicontrol('Style', 'text', 'String', 'State / Zone:', 'Position', [50, 110, 100, 20]);
stateDrop = uicontrol('Style', 'popupmenu', ...
    'String', {'JOHOR', 'KEDAH', 'SELANGOR', 'PAHANG', 'PERAK'}, ...
    'Position', [150, 110, 100, 22]);

% --- Butang Run ---
uicontrol('Style', 'pushbutton', ...
    'String', 'Run', ...
    'Position', [150, 50, 80, 30], ...
    'Callback', @(~,~) runTransform(transDrop, latEdit, lonEdit, eastEdit, northEdit, stateDrop));

% --- Label Output (untuk papar hasil) ---
outputLabel = uicontrol('Style', 'text', ...
    'String', 'Hasil: ', ...
    'Position', [50, 20, 350, 20], ...
    'HorizontalAlignment', 'left');

% --- Fungsi Callback untuk Run ---
    function runTransform(transDrop, latEdit, lonEdit, eastEdit, northEdit, stateDrop)
        % Baca nilai dari UI
        transVal = transDrop.String{transDrop.Value};
        latStr = latEdit.String;
        lonStr = lonEdit.String;
        eastStr = eastEdit.String;
        northStr = northEdit.String;
        stateVal = stateDrop.String{stateDrop.Value};

        % Tukar ke nombor (jika ada)
        lat = str2double(latStr);
        lon = str2double(lonStr);
        east = str2double(eastStr);
        north = str2double(northStr);

        % --- Logik transformasi (contoh) ---
        if isnan(lat) || isnan(lon)
            set(outputLabel, 'String', 'Sila masukkan Latitude dan Longitude yang sah.');
            return;
        end

        % Transformasi contoh: RSO
        if contains(transVal, 'RSO')
            % Formula contoh (gantikan dengan formula sebenar)
            easting_out = lat * 1.1 + lon * 0.9;
            northing_out = lat * 0.8 + lon * 1.2;
            set(outputLabel, 'String', sprintf('Hasil RSO: Easting = %.2f, Northing = %.2f (Zon: %s)', easting_out, northing_out, stateVal));

        elseif contains(transVal, 'Cassini')
            % Formula contoh untuk Cassini-Soldner
            easting_out = lat * 1.05 + lon * 0.95;
            northing_out = lat * 0.85 + lon * 1.15;
            set(outputLabel, 'String', sprintf('Hasil Cassini: Easting = %.2f, Northing = %.2f (Zon: %s)', easting_out, northing_out, stateVal));
        else
            set(outputLabel, 'String', 'Transformasi tidak dikenali.');
        end
    end

end